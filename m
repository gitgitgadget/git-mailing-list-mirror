From: Junio C Hamano <gitster@pobox.com>
Subject: Re: ancestor and descendant ~ clarification needed
Date: Thu, 22 Oct 2015 13:22:04 -0700
Message-ID: <xmqqfv12r6vn.fsf@gitster.mtv.corp.google.com>
References: <CAAF+z6HEeFEYD9R+6Uz3ebRYNMpy5Gh0Fo9EjpaTYwSbqyDLgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>
To: Xue Fuqiao <xfq.free@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 22 22:22:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZpMNJ-0001sN-5t
	for gcvg-git-2@plane.gmane.org; Thu, 22 Oct 2015 22:22:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965670AbbJVUWI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2015 16:22:08 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63635 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965200AbbJVUWH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2015 16:22:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C6CC124D7D;
	Thu, 22 Oct 2015 16:22:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NVUaYanaZXRvRV4gC88CGw7SFXA=; b=COsIKf
	VsuxUOln7eBH9sXwQwbCcpx3YfyNmqxQrn23mroj3sD5JOdL7VJw1ouGqmnUSuxR
	XtD3HKUFY8stAsFoaqyZT+B6RLaVuXlGwt+/G2U4kdWjcCgStTzBjM0HYe1Jdg5A
	dnww+E+8t5czKhAqR6eDM3nxuxcodoulY/yiw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SIyVNj2548lLr7/vfJUUSUm+5uBJwSnq
	s98PZKQWG1iQUTu+qRxPOuHYVRIq8w870STMF63nyf7kxqygYJqPMKi+wHb63kUl
	osPYdskX9dVUhXBrMy484OQjD/V1IbUBynBO6sf8Ho66r8DO2m6Rs6NvXDlkP57j
	lpIcxB0qwug=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BF35224D7C;
	Thu, 22 Oct 2015 16:22:05 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 46B4424D7B;
	Thu, 22 Oct 2015 16:22:05 -0400 (EDT)
In-Reply-To: <CAAF+z6HEeFEYD9R+6Uz3ebRYNMpy5Gh0Fo9EjpaTYwSbqyDLgQ@mail.gmail.com>
	(Xue Fuqiao's message of "Thu, 22 Oct 2015 17:06:03 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8FB82196-78FA-11E5-A647-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280074>

Xue Fuqiao <xfq.free@gmail.com> writes:

> In Documentation/user-manual.txt:
>
>    In the following, we say that commit X is "reachable" from commit Y
>    if commit X is an ancestor of commit Y.  Equivalently, you could say
>    that Y is a descendant of X, or that there is a chain of parents
>    leading from commit Y to commit X.
> [...]
>    However, if the current branch is a descendant of the other--so every
>    commit present in the one is already contained in the other--then Git
>    just performs a "fast-forward"; the head of the current branch is
>    moved forward to point at the head of the merged-in branch, without
>    any new commits being created.

Yeah, that is the other way around.

 (1) If the current branch is a descendant of the other--so every
     commit present in the other branch is already contained in the
     current branch--then merging the other branch into the current
     branch is a no-op "Already up-to-date!".

 (2) If the current branch is an ancestor of the other--so every
     commit present in the current branch is already contained in
     the other branch--then merging the other branch into the
     current branch can be fast-forwarded, by moving the tip of the
     current branch to point at the commit at the tip of the other
     branch, and by default Git does so, instead of creating an
     unnecessary merge.
