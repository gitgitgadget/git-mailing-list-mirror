From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Unmodified submodules shows up as dirty with 1.6.6.443.gd7346
Date: Mon, 18 Jan 2010 09:22:25 -0800
Message-ID: <7vr5pnqqem.fsf@alter.siamese.dyndns.org>
References: <4B547EA6.5070203@isy.liu.se>
 <8c9a061001180802t5ec0d389j2cae9f1771130c36@mail.gmail.com>
 <4B549254.5090206@isy.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org,
	Jens.Lehmann@web.de
To: Gustaf Hendeby <hendeby@isy.liu.se>
X-From: git-owner@vger.kernel.org Mon Jan 18 18:27:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWvNv-0002xS-K6
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jan 2010 18:27:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755544Ab0ARRZ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2010 12:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755610Ab0ARRZ5
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jan 2010 12:25:57 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49734 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755422Ab0ARRWj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2010 12:22:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B197491399;
	Mon, 18 Jan 2010 12:22:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XnpBj6Rrr5s90Zdkf1oMbjlkAVU=; b=NSWHWV
	9eBsXp32rBBrH9EIHyV65mlNrOSB957OtLId5F3GU6BNxlsQ861PCeQipFB3F2a4
	NP6vfr1BnTfVHJySZuSVYAaI6gDX+bkygudhcG7lGNgOBkNQg8rqKTSc9lGCv77U
	RqJguFBd1E1GWCZ5/yZQjN+3xnBOEBdentFnI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f59pHrD2VJGRakalfMqsUZng7twSX0Y2
	K3I+ZqbcSja38zYBPj/j94ZARbPq8gs1X/uJY+Oj93v3nw1Wgq2wnL3JXkOU106V
	7RIy64V9wNk4xy/6UmLkfT4j+MgXmSXeTg3qGFKvn+1j0L/ODSAS+5BoKGesGyvA
	QGyfrubgHG8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6850391394;
	Mon, 18 Jan 2010 12:22:32 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6CD7291393; Mon, 18 Jan
 2010 12:22:27 -0500 (EST)
In-Reply-To: <4B549254.5090206@isy.liu.se> (Gustaf Hendeby's message of
 "Mon\, 18 Jan 2010 17\:54\:44 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0FD90F54-0456-11DF-B89C-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137392>

Gustaf Hendeby <hendeby@isy.liu.se> writes:

> ....  I don't want to include
> these files in a .gitignore as they are named differently on different
> systems.  Hence, I include them in my .git/info/exclude file,...

I don't have a strong opinion on the submodules part of your issue, but
the above part applies to projects with or without submodules, which I
have an opinion, and because it is different from what I used to teach
people, I think it is worth mentioning..

I used to say "Never place *~ (or *.swp) in .gitignore because they are
only useful to you who use Emacs (or vim); and do have *.o in .gitignore,
because everybody who compile your checkout would see it".

But I don't think the former is a right attitude.  My thinking these days
is that keeping these in .gitignore should not just be tolerated but
should be actively encouraged, unless the project may need to track paths
that match *~ or *.swp in the future,

If it is very unlikely that the project will ever track them, there is no
harm done [*1*], and it will help other people because they don't have to
add the same and common entries in their own .git/info/excludes file.

I am suspecting that your "these files ... are named differently on
different systems" may fall into the same category.  Your build may not
produce "frotz.linux" when compiled on a FreeBSD box (and "frotz.fbsd" on
a Linux box), but would it hurt more than it helps to list them in the
same .gitignore to cover both?


[Footnote]

*1* Once it starts doing so, un-ignoring a special case can be done
at that point in the history
