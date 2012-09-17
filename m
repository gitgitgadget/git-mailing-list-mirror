From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Test failure: Test #3 in t1304-default-acl
Date: Mon, 17 Sep 2012 09:37:50 -0700
Message-ID: <7v4nmwwqox.fsf@alter.siamese.dyndns.org>
References: <CALkWK0n0bH3xPLarv35Th_agnhKCkRjgcKTJR7Xy=B_NkBHkOg@mail.gmail.com>
 <vpqy5k8raig.fsf@grenoble-inp.fr>
 <CALkWK0=h6iU_J=X6MFgLXPfo0rh236cTuVaU3nNSnAaikjKH5w@mail.gmail.com>
 <vpqd31kr7v4.fsf@grenoble-inp.fr>
 <CALkWK0=ROz8fxXgnqt-+AthU-hgq_mzFg0GhBQCrAshH_mRBPQ@mail.gmail.com>
 <vpqvcfcps2z.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Sep 17 18:38:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDeKf-0005kc-To
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 18:38:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752200Ab2IQQhy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 12:37:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42252 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752846Ab2IQQhx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 12:37:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 57E7B98AE;
	Mon, 17 Sep 2012 12:37:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1DT+H1ofKF3ZDITdhs5Bva+rbFw=; b=jAUbn7
	+P584qVU8XKQ+aR1OzFnt6BGRZfTxg2YDK2NtQ00q6nkD5doq77n4cPU7fhIMv3p
	FjBKac8MGtZjzrOZrjvJc0PWYjhfs8EkNH3FTyvlhlRERwAZrMhuCMcQ80w7zcYG
	cehfWZp+Z6rKFXYMf7N9yaALmYgFcplDupCiw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e2f6Mq5Rw5fE58rIgtdn+TvmuFFG9RaW
	pC2/8y16Ag9i/v84YA+HNAIPu5O5PqjCIM6Hui9R20vN8YKYZ6E4H3r6s0PgsP0o
	hBX/bqWKLdlTVLu+lyApIRqwe4NEmdhy7UI9VTVVBWYpkO5DAtLwrNL6FCX7UJIZ
	igN17sozUtE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 45D8398AD;
	Mon, 17 Sep 2012 12:37:52 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9F84898AC; Mon, 17 Sep 2012
 12:37:51 -0400 (EDT)
In-Reply-To: <vpqvcfcps2z.fsf@grenoble-inp.fr> (Matthieu Moy's message of
 "Mon, 17 Sep 2012 17:49:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 05EFBFEE-00E6-11E2-A39A-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205707>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> Hi again,
>>
>> Matthieu Moy wrote:
>>> Does this user have the same UID as your usual user
>>> (id kseygold; id $LOGNAME)?
>>
>> Yes.  What do you propose we do about the test?
>
> On a GNU system, something like this should do the trick:
> ...
> but it seems FreeBSD's getfacl doesn't have --numeric
> (http://www.unix.com/man-page/FreeBSD/1/getfacl/), so to be portable, we
> need some more surgery, like this:
>
> --- a/t/t1304-default-acl.sh
> +++ b/t/t1304-default-acl.sh
> @@ -33,7 +33,10 @@ check_perms_and_acl () {
>         test -r "$1" &&
>         getfacl "$1" > actual &&
>         grep -q "user:root:rwx" actual &&
> -       grep -q "user:${LOGNAME}:rwx" actual &&
> +       grep "user:.*:rwx" actual | grep -v 'user:root:' | \
> +           cut -d : -f 2 | xargs id -u > acl-uid &&
> +       id -u > actual-uid &&
> +       test_cmp acl-uid actual-uid &&
>         egrep "mask::?r--" actual > /dev/null 2>&1 &&
>         grep -q "group::---" actual || false
>  }
>
> Can you check that this second patch fixes your problem?
>
> I'm a bit hesitant to submit it to git.git, as I find it a bit too
> hacky. What do other people think?

I haven't been paying attention, but does that mean on that system,
a total stranger kseygold can write, modify, and remove whatever Ram
owns?  I am hoping that is not the case.
