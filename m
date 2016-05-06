From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t3513: do not compress backup tar file
Date: Fri, 06 May 2016 15:45:16 -0700
Message-ID: <xmqqinyq24cj.fsf@gitster.mtv.corp.google.com>
References: <20160506183705.8214-1-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, peff@peff.net, megabreit@googlemail.com,
	Jens.Lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat May 07 00:45:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayoUx-0002OK-2Z
	for gcvg-git-2@plane.gmane.org; Sat, 07 May 2016 00:45:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758929AbcEFWpU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 18:45:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59993 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758568AbcEFWpT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 18:45:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 27D9A170D5;
	Fri,  6 May 2016 18:45:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+67aaV2xI0j/5xYf8voMioFe57k=; b=r00vVV
	YfiyyK+KBaPwDAbCbbBCLXQDtbGG0yyjv0tr8T+qdM51Gx7uiF5e0su2JsQwI81Z
	KltykwpYZjKDzy1HrpxJ9pux12n93jolm5+BY4LqTgqD7a51fpM/IvLD5tuSQyiT
	r9NYSv7G3ZnK7lYA6xHCkQelMhQJhKDdix798=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YgP+OlNfUutAIWnjQOq0eVsLWSeXzTa7
	J+/bP0CkyPyPyfBBEpomh+dWv4rrHW/cvSxy6eWK48dhVvuHkjGakj0k2tL/c9hZ
	+l/s2XHiJnVAPTsD+INUMQHu3TVhGni/0eTfe61fq+JVN3bsftyiw0/uT2lpDHS0
	i5dEYKg1WD4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1DCDD170D4;
	Fri,  6 May 2016 18:45:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 92652170D3;
	Fri,  6 May 2016 18:45:17 -0400 (EDT)
In-Reply-To: <20160506183705.8214-1-sbeller@google.com> (Stefan Beller's
	message of "Fri, 6 May 2016 11:37:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 34833766-13DC-11E6-9959-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293866>

Stefan Beller <sbeller@google.com> writes:

> Armin Kunaschik <megabreit@googlemail.com> wrote:
>> I'm trying to compile/test/use git 2.8.2 on AIX 6.1 with
>> no bash available.
> ...
>> make test does not make it through t3513-revert-submodule.sh anymore.
>> The test is not portable since it uses the z-flags of GNU-tar. When -z
>> is removed, (and extension is changed back to tar) everything runs and
>> tests smoothly.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

Thanks for a quick fix.  Even though "no bash" and "AIX 6.1" are
interesting details that are part of a good bug report, these are
irrelevant noise for a commit that fixes a bug that is unrelated to
them, so let's rephrase the message and queue it, like this:

    t3513: do not compress backup tar file

    The test uses the 'z' option, i.e. "compress the output while at
    it", which is GNUism and not portable.

    Reported-by: Armin Kunaschik <megabreit@googlemail.com>
    Signed-off-by: Stefan Beller <sbeller@google.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

>  t/t3513-revert-submodule.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t3513-revert-submodule.sh b/t/t3513-revert-submodule.sh
> index a1c4e02..db93781 100755
> --- a/t/t3513-revert-submodule.sh
> +++ b/t/t3513-revert-submodule.sh
> @@ -14,11 +14,11 @@ test_description='revert can handle submodules'
>  git_revert () {
>  	git status -su >expect &&
>  	ls -1pR * >>expect &&
> -	tar czf "$TRASH_DIRECTORY/tmp.tgz" * &&
> +	tar cf "$TRASH_DIRECTORY/tmp.tar" * &&
>  	git checkout "$1" &&
>  	git revert HEAD &&
>  	rm -rf * &&
> -	tar xzf "$TRASH_DIRECTORY/tmp.tgz" &&
> +	tar xf "$TRASH_DIRECTORY/tmp.tar" &&
>  	git status -su >actual &&
>  	ls -1pR * >>actual &&
>  	test_cmp expect actual &&

This is not a new problem, but these "ls -1pR" and "rm -rf *" makes
me wonder if it is the best way to test what is being tested.

The title says "revert can handle submodules", but when it sees that
revert finishes successfully, it discards the resulting working tree
state with "rm -rf *" (Yuck) and repopulates with the state before
the 'checkout && revert' sequence, so the 'status' and 'ls' are not
testing what 'revert' did at all.

Shouldn't it be testing HEAD^{tree} before "checkout && revert" and
after and make sure they match, and checking the working state left
by 'revert' without clobbering it with tarball extract?
