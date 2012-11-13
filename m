From: Junio C Hamano <gitster@pobox.com>
Subject: Re: checkout from neighbour branch  undeletes a path?
Date: Tue, 13 Nov 2012 08:43:31 -0800
Message-ID: <7v8va5fo7g.fsf@alter.siamese.dyndns.org>
References: <20121113152341.GC6561@external.screwed.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter Vereshagin <peter@vereshagin.org>
X-From: git-owner@vger.kernel.org Tue Nov 13 17:43:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYJaZ-0002Od-T3
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 17:43:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755169Ab2KMQnh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 11:43:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62893 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755161Ab2KMQnf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 11:43:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7ABE2AB1D;
	Tue, 13 Nov 2012 11:43:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DAqBaZqKZczMYJWoWnEgE0lISjk=; b=MfXbHm
	WV4afU2Q4Qcmvbco7VdBgi7ymyRdr5bPIfq5UPShkv+fl4Oo1+v1C9n34wajykdk
	+lCX1pRGcEe0Roxy9K9shTzXheF7kqOgDF5P5ijrH57HZBYPwzH3jqacLjFRzWj0
	49JDbXl2jRImgEh88mgeOaQJsYN/lq9oAeBA8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=au7Grq+od9zMixX0G4CsDy5Iy/Fl1sDC
	nhfay8no+WR4sbavINs28tquVMzkftOBd10l7Bizy+wkCr8XElghu9Q8SYHWz3G2
	5owTSpCG99R5+rY+ftJP6jWwFWcsRQlCEKf5wpjq1KJdO+UKFJk04E5JM5FBZdeM
	zs9vmoxPWJw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 12A90AB1A;
	Tue, 13 Nov 2012 11:43:34 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 261F8AB16; Tue, 13 Nov 2012
 11:43:33 -0500 (EST)
In-Reply-To: <20121113152341.GC6561@external.screwed.box> (Peter Vereshagin's
 message of "Tue, 13 Nov 2012 19:23:41 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4322ECA4-2DB1-11E2-A929-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209631>

Peter Vereshagin <peter@vereshagin.org> writes:

> Am wondering if 'checkout branch path' undeletes the files?

"git checkout branch path" (by the way, "branch" does not have to be
a branch name; any commit object name would do, like "git checkout
HEAD^^ hello.c") is a way to check out named path(s) out of the
named commit.

If the commit "branch" has "path" in it, its contents are checked
out to "path" in your current working tree (and the entry in the
index updated to match it).

If you happen to have removed "path" in your current working tree
before running that command, it might look as if there is some
undelete going on, but that is a wrong way to look at things.  The
version of "path" in the "branch" may or may not be similar to what
you have removed earlier.
