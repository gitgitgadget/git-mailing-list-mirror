Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC85FC4321E
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 04:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiK1EVQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Nov 2022 23:21:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbiK1EU3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Nov 2022 23:20:29 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE4665D6
        for <git@vger.kernel.org>; Sun, 27 Nov 2022 20:19:00 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 82so1409196pgc.0
        for <git@vger.kernel.org>; Sun, 27 Nov 2022 20:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=rID1xdl+BB06sdoK0k07JWGgFT9hhiAuw6EKPHYxliM=;
        b=oJ1+LWuUIjxFfzYBoHI8UDKEU8LUkF1wjMn1x/dcYAaLGQzxVN86auGgtbrGsM9Vhi
         ljIWWfogLmdU7890jNPJngQgR5FyAMCRUwXNtU+Yg3Xh7Tv5zA/EZMkRG29ITZTIzcGA
         8UQEGV2pPgCli5JTeIsbxfE+pwS4jFfdqlzcH29DSbrCrDSnSOfFSznlT459y1a4J4i8
         I9tOR5J4yENjEazJa3nUtt54PkOiqkglxHdhOpVaeLoGFAkdgONU7aIMoNOdMS4TssyZ
         PUq/L+Qg144sGEQQWlwCcXjmKI0P+zJAecRbIrMzkQtXo28VRCBpWSmB5F+XSwUTx3a6
         IDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rID1xdl+BB06sdoK0k07JWGgFT9hhiAuw6EKPHYxliM=;
        b=j40MThgp+xljuZDipJdxtyn/jI118UXX2vlSFFbNpv/kgI91RcXYUkIwPQcP017Lnu
         TLe1KRACPz8UbAbjSzGtqd35cm1SJehYoDq3+Hnro5+RvYMAUsDY8cKi9oGjr75mKRYm
         2PID51Ezzo7jkD46FsyG/0FLCWw/sNtBApUhCzJwHeLmdW/i4O0o9gzLkRC+bzeCIVPX
         Bo2zSYA2VUVOOhVvmky+KMhB9IYR+KJNleYfegHDziEwG3fUkrS9vuBl5LDxNmUsluUD
         mAjkJBBiw66+KMCGqh7X7fJ34zvvoOeZfS2Ngkf4OHUg05UhxAi5vZbkGczjKv6YPvwe
         cNZQ==
X-Gm-Message-State: ANoB5pnqyoWtrtVLT//qhZpLzJ+7veIc8GzYGsaY8cQbO6TjrLNp4OeR
        CkwExKQGhXsIFXtTmjkOPWA=
X-Google-Smtp-Source: AA0mqf6artK7MBx+RQelZLFKQbG1xFoaUUA1EONzHBoAq8CORJn1N8r2nIMG8g91HfLgMvOdAK0Qdw==
X-Received: by 2002:a63:4b0f:0:b0:464:203c:b964 with SMTP id y15-20020a634b0f000000b00464203cb964mr26873572pga.270.1669609139920;
        Sun, 27 Nov 2022 20:18:59 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id jb21-20020a170903259500b00176a6ba5969sm7612345plb.98.2022.11.27.20.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 20:18:59 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Heikki Orsila <heikki.orsila@iki.fi>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v1 3/4] t1301: wrap the statements in the for loop
References: <20221127145130.16155-1-worldhello.net@gmail.com>
        <20221127145130.16155-3-worldhello.net@gmail.com>
Date:   Mon, 28 Nov 2022 13:18:59 +0900
Message-ID: <xmqq35a390ek.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> Subject: Re: [PATCH v1 3/4] t1301: wrap the statements in the for loop

That makes it sound as if there weren't a loop and now you wrapped
the statement in a loop, but that is not what is happening.  You are
wrapping the statements in something you are not telling us, and "in
the for loop" is there only to explain where the statements in
question are found.

	t1301: wrap code to prepare configuration in a separate test

or something?

> Wrap the statements which were introduced in commit 06cbe85503 (Make
> core.sharedRepository more generic, 2008-04-16)) in the for loop in a
> new test case, so if we want to skip some of the test cases, these
> unwrapped statements won't affect the test cases we choose to run.

I am not quite sure why this change is needed for the above, though.
If we want to skip u=0660:rw-rw---- test, we can skip the two
test_expect_success for the first iteration, which will still run
"git config core.sharedrepository" for the first case, and when we
test for the next one (i.e. u=0640:rw-r-----), we will overwrite the
configuration with the value appropriate for the round.

Now you have three separate tests in an interation of the loop.  If
you skipped the first one in the iteration (by mistake) and let the
other two run, they will run with a wrong configuration and values
of $x and $y variables, either unset or leftover from the previous
round.

So I am not sure how this patch can be an improvement.

If you wrapped the setting of $x, $y, $u and the config into a
helper shell function, e.g.

	prepare_perm_test_variables () {
		u=$1
		x=...
		y=...
		u=...
		git config core.sharedrepository "$u"
	}

before and outside the loop, and make these two tests in the loop to
call it upfront, then your users can skip each test and iteration
independently while ensuring that the necessary setup is always done
correctly, though.

>
> Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> ---
>  t/t1301-shared-repo.sh | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
>
> diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
> index 1225abbb6d..3ca91bf504 100755
> --- a/t/t1301-shared-repo.sh
> +++ b/t/t1301-shared-repo.sh
> @@ -78,31 +78,28 @@ for u in	0660:rw-rw---- \
>  		0666:rw-rw-rw- \
>  		0664:rw-rw-r--
>  do
> -	x=$(expr "$u" : ".*:\([rw-]*\)") &&
> -	y=$(echo "$x" | sed -e "s/w/-/g") &&
> -	u=$(expr "$u" : "\([0-7]*\)") &&
> -	git config core.sharedrepository "$u" &&
> -	umask 0277 &&
> +	test_expect_success POSIXPERM "set variables from $u" '
> +		x=$(expr "$u" : ".*:\([rw-]*\)") &&
> +		y=$(echo "$x" | sed -e "s/w/-/g") &&
> +		u=$(expr "$u" : "\([0-7]*\)") &&
> +		git config core.sharedrepository "$u"
> +	'
>  
>  	test_expect_success POSIXPERM "shared = $u ($y) ro" '
> -
> +		umask 0277 &&
>  		rm -f .git/info/refs &&
>  		git update-server-info &&
>  		actual="$(test_modebits .git/info/refs)" &&
>  		verbose test "x$actual" = "x-$y"
> -
>  	'
>  
> -	umask 077 &&
>  	test_expect_success POSIXPERM "shared = $u ($x) rw" '
> -
> +		umask 077 &&
>  		rm -f .git/info/refs &&
>  		git update-server-info &&
>  		actual="$(test_modebits .git/info/refs)" &&
>  		verbose test "x$actual" = "x-$x"
> -
>  	'
> -
>  done
>  
>  test_expect_success POSIXPERM 'info/refs respects umask in unshared repo' '
