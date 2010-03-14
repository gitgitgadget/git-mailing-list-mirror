From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Improvement?] How do you switch branches in a bare repo?
Date: Sat, 13 Mar 2010 22:52:51 -0800
Message-ID: <7v7hpfs8cc.fsf@alter.siamese.dyndns.org>
References: <4B99DEA2.6050104@uq.edu.au>
 <b4087cc51003120009o7bd99609w996de02b732fbbd9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 14 07:53:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqhhO-0004gy-LY
	for gcvg-git-2@lo.gmane.org; Sun, 14 Mar 2010 07:53:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753961Ab0CNGxF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Mar 2010 01:53:05 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:65180 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753472Ab0CNGxB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Mar 2010 01:53:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B61ACA15EF;
	Sun, 14 Mar 2010 01:52:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=705DyAyg5EbopsTmc1t7U//nVxc=; b=D92yN9
	vTp7diLaNmBC+G5Q6H22l0j19uHyTpv/xYzVGrvSvy9Seyj6IYH/DbAJNBaIO0d3
	9Oss1+gadCOkryQUMKBs0Qgwl0xKtjHVaZrke+iHYrvEdN43V4BZIzosyYS0+3ue
	foJ0ycaTf2BWu9i38wYyrZAS8me0q5FVrJkGw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YKqFKrDzcyShtD9VxVqUlj5eRVmZIPIY
	mXTauOHCzGwxfPZ+uOEVhPY43wpkawGouSDvR0tMJrWCcY83OoytGGBd6DKWQIYl
	loA4J2dp05XGLw4zW5/pQCMi5CgDNd1JP51s44QL0zoPTVk/gYMXTB4SLhTNft2V
	pYwyrmeX6oA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 94145A15EE;
	Sun, 14 Mar 2010 01:52:55 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0AFA4A15ED; Sun, 14 Mar
 2010 01:52:52 -0500 (EST)
In-Reply-To: <b4087cc51003120009o7bd99609w996de02b732fbbd9@mail.gmail.com>
 (Michael Witten's message of "Fri\, 12 Mar 2010 02\:09\:53 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 37D3EE42-2F36-11DF-A4A1-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142128>

Michael Witten <mfwitten@gmail.com> writes:

> The "git checkout" command in a bare repository should serve to select
> on which branch other commands (like "git reset") operate, etc.

I am not so sure about the "should" part.

The verb "checkout" is to move/copy something that is stored in somewhere
to some other place, and in the context of git, you are copying out the
contents that is stored in the repository (either the index or the tree of
a commit) to the working tree.  It is true that "git checkout branch" also
switches HEAD while doing so, but that is done primarily so that the
result of further working on the checked out files in the working tree
will be recorded in that branch, but I tend to see that as secondary.
"git checkout file" and "git checkout branch file" do not even touch the
HEAD.

I am more interested in the reason why you need to switch HEAD in a bare
repository to begin with, though.  If it is a one-shot thing, then I don't
think it is too unreasonable to ask for people to learn symbolic-ref; if
some valid workflow requires to flip the HEAD regularly, on the other
hand, we might want to give the command to do so a shorter-to-type name
than symbolic-ref, and that short name could be "checkout".
