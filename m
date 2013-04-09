From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] add: refuse to add paths beyond repository
 boundaries
Date: Tue, 09 Apr 2013 12:09:40 -0700
Message-ID: <7vwqsbr05n.fsf@alter.siamese.dyndns.org>
References: <CALkWK0m_82ThYKxcr=YHGBnOaHr9yBpYFHxx2KrnQkWD_zjp1A@mail.gmail.com>
 <1365499297-8667-1-git-send-email-artagnon@gmail.com>
 <1365499297-8667-3-git-send-email-artagnon@gmail.com>
 <7v4nfftyu3.fsf@alter.siamese.dyndns.org>
 <7vvc7vsj4p.fsf@alter.siamese.dyndns.org>
 <CALkWK0k0YMWjhJQFWLv6b7kAHqRm8-Dq23gMVHYfatq1SLUDhQ@mail.gmail.com>
 <7vmwt7si6z.fsf@alter.siamese.dyndns.org>
 <CALkWK0nF0aTLDZyPXfa=4kp=BnDPm3+_ZfMvP_6ZcimeJtzxvw@mail.gmail.com>
 <7va9p7sfl8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 09 21:09:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPdvQ-0001bv-GW
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 21:09:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935513Ab3DITJn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 15:09:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58420 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761628Ab3DITJm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 15:09:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C45315B63;
	Tue,  9 Apr 2013 19:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9RHHy+woASeG1PKKc2Cg+br9bpw=; b=s/vPJk
	MACysNMLRuN0cWwwqgijeWN15CrR0TWnGXR9S9GK1jBozDx2UbLz49+kwGNyhV8o
	3jdNcCmq7RmcxM2UqmCOdkxUGgCT70zjVb2XhH2jOWHfSzDkBFQYYOBX56EYHjTs
	aI3RRYlE9rxEYzluhUtlHkhcMSUqBQb3nfRJo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PH3pdyKztRHf27b0Lsl9kYtbmQAZ2ud6
	sHBMVnCks3eO1dcPqkbqlOWcxT52+0XI+z2nK44ECBOm7DtjkG+ZcBDZyqAgBE6m
	wksR41lIJjg53zzGqVr8al3CZQr6/HU3c7WyFoSc3p+nNfDYrJ0T2DBnk24zmv/2
	UD0vniLD/2k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2FAFC15B62;
	Tue,  9 Apr 2013 19:09:42 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7EF4715B5F; Tue,  9 Apr
 2013 19:09:41 +0000 (UTC)
In-Reply-To: <7va9p7sfl8.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 09 Apr 2013 11:50:59 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 081C56AC-A149-11E2-926A-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220617>

Junio C Hamano <gitster@pobox.com> writes:

> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> The reader is now wondering what this could possibly be, and why you
>> didn't send this patch earlier. 
>
> Because it wasn't written back then?
>
>> Perhaps clarify with: s/there are
>> cases/there may be cases/ and append "One such case that we currently
>> don't handle yet is a path inside another git repository in our
>> worktree, as demonstrated by test tXXXX.X."
>
> I think "we currently don't handle" is a misstatement.  It is not a
> bug that we don't.

We can think of it this way.

In your working tree, there is an upper bound for the paths you can
include in your commit.  When you are at the top-level of your
working tree, you do not say "git add ../f" or "git add ../d/f".
The root-level of your working tree is an upper bound and you do not
cross that boundary.

It turns out that there are lower bounds for the paths as well.
When we say "Git tracks symbolic links", anything that appears
beyond a symbolic link is beyond that boundary.  If we track a
symbolic link "l", we can of course add "l". When "l" leads to
a directory somewhere else, the filesystem gives you an illusion
that there are things under "l" (e.g. "l" points at "/etc" and there
is "l/passwd" there), but that is beyond the boundary.  You do not
add "l/passwd".  Otherwise "git add l" would become meaningless.
Does it add the symbolic link itself, or all the files in there,
pretending "l" is actually a directory?  We have chosen to say it is
the former, and apply that rule consistently.

It is the same for "Git tracks submodules", which defines that the
top-level of the submodule working tree as such a lower boundary.
