Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CBAC678D4
	for <git@archiver.kernel.org>; Tue,  7 Mar 2023 19:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbjCGTJS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Mar 2023 14:09:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233703AbjCGTIz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2023 14:08:55 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC3BAB0B7
        for <git@vger.kernel.org>; Tue,  7 Mar 2023 10:53:52 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id h17-20020a17090aea9100b0023739b10792so12786937pjz.1
        for <git@vger.kernel.org>; Tue, 07 Mar 2023 10:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678215229;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=20Akj9vs/rJsXiYK14jJcOm7USQVqHIbdKAZxuEz1HU=;
        b=OWKnP/56vQvyQXa11A0iY868sGhshwUGMHSv+qoOtNsJetLnB5sjeC9uY1q3vAG7D6
         bw1OQ4iVgdL0OHTCE5/XvGuStV4Ni9pmD5E/DkrzKu6yKHFqry3yK/g72Y0EVPQEVt2y
         o0UyDZbhkB3awjZHXtB2WYTced9gk32DS00Tm1XTW6YwsQWtLlFfk5Ph98avhpqxz5gk
         xrtTHVwyjMDKFgmJnfDSQWad8avOqpEp3YVl0RVUcGTr9KF3hd7jCkiC5D9oNGBy6Ad/
         fU6PJ/5YQc4j0Rw17yV+m37fFH/YMFFLS6lrBeQWAFKdsynu160eYs/hwEqQuG56PXz1
         ZneA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678215229;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=20Akj9vs/rJsXiYK14jJcOm7USQVqHIbdKAZxuEz1HU=;
        b=1YSTcc+eYUglGeZEE+YNdRfTrG/ihNw9yVUXF0mkiNWxfbx2ar0dxGb+zXeFSUmNCC
         Yz3CrCEv5Ry7FZkF5ilETJkVDBdb6ZQjNpYLTsmrTxEXpr8FhydPhndyHtCKm0EUbSAC
         Q4gi/yoLjDwOJ/96Z4F+22XsiPAANcGzxoZKrWJapjW23OBYYayEzD79yWk5QGBnlzml
         ekGUlSq7AL1vNCAgEp63sKUeNV+dt7Yit0+het4h7iuFs/7HiNdmG3uXdob0olGpGgGn
         JE1mCi5ikgSpkjFzFMkIBue/SkWpL2Gjy5ufx8PtimbqW7asE1Vy5AjUzXIC2BOydqMg
         zh6w==
X-Gm-Message-State: AO0yUKWHYEgGVACQRfIHA/F/KBFPm579XtBIfFVtSFztDGcFXss4iC0I
        XkDssr6StQdfUHH7idpgTtcbpl6ub54=
X-Google-Smtp-Source: AK7set+WC4923qEt/cJVxjMzDg6CjqYyzLKv6lKKlHrbvFzV3vwhzyzaQjf4Z3e+XZGfy3h/1atJWQ==
X-Received: by 2002:a05:6a20:be27:b0:cb:c276:58cc with SMTP id ge39-20020a056a20be2700b000cbc27658ccmr15124085pzb.28.1678215228634;
        Tue, 07 Mar 2023 10:53:48 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id t24-20020a632258000000b005034a46fbf7sm6114712pgm.28.2023.03.07.10.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 10:53:47 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Shuqi Liang <cheskaqiqi@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com, derrickstolee@github.com
Subject: Re: [PATCH v2 1/2] t1092: add tests for `git diff-files`
References: <20230304025740.107830-1-cheskaqiqi@gmail.com>
        <20230307065813.77059-1-cheskaqiqi@gmail.com>
        <20230307065813.77059-2-cheskaqiqi@gmail.com>
Date:   Tue, 07 Mar 2023 10:53:47 -0800
In-Reply-To: <20230307065813.77059-2-cheskaqiqi@gmail.com> (Shuqi Liang's
        message of "Tue, 7 Mar 2023 01:58:12 -0500")
Message-ID: <xmqqy1o8xuis.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shuqi Liang <cheskaqiqi@gmail.com> writes:

> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 801919009e..9382428352 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -2055,4 +2055,42 @@ test_expect_success 'grep sparse directory within submodules' '
>  	test_cmp actual expect
>  '
>  
> +test_expect_success 'diff-files with pathspec inside sparse definition' '
> +	init_repos &&
> +
> +	write_script edit-contents <<-\EOF &&
> +	echo text >>$1
> +	EOF

(Documentation/CodingGuidelines)

 - Redirection operators should be written with space before, but no
   space after them.  In other words, write 'echo test >"$file"'
   instead of 'echo test> $file' or 'echo test > $file'.  Note that
   even though it is not required by POSIX to double-quote the
   redirection target in a variable (as shown above), our code does so
   because some versions of bash issue a warning without the quotes.

> +	#add file to the index but outside of cone

Can you have a SP after "#" here to make it more readable?

> +	run_on_sparse mkdir newdirectory &&
> +	run_on_sparse ../edit-contents newdirectory/testfile &&
> +	test_sparse_match git add --sparse newdirectory/testfile &&

We create a new directory that is outside the cone, with or without
using the sparse-index feature.  We know we are violating the cone,
and have to override the safety with the "--sparse" option.  OK.

What output do we expect out of "git add" to match in the two cases?

> +	#file present on-disk without modifications
> +	test_sparse_match git diff-files &&
> +	test_sparse_match git diff-files newdirectory/testfile &&

As "diff-files" is about comparing between the index and the working
tree, the new path should not appear in the output when the sparse
checkout feature with or without the sparse-index feature is NOT in
use.  Does the picture get different when we are sparse?  IOW, would
we notice that we now have newdirectory/testfile that is supposed to
be missing in the index and show that in the output?

> +	test_sparse_match test_must_fail git diff-files --find-object=HEAD:testfile &&

What does HEAD:testfile refer to in this test?  This expects "diff-files"
invocation to fail, and perhaps in your test it failed in both test
repositories the same way, but are they failing for the right reason?

In a non-sparse repository whose HEAD commit does not have
'testfile' (e.g. "git" source tree), I get

    $ git diff-files --find-object=HEAD:testfile
    error: unable to resolve 'HEAD:testfile'

without sparse checkout or sparse index.  It is unclear what value
we get out of having this test here.

> +	#file present on-disk with modifications
> +	run_on_sparse ../edit-contents newdirectory/testfile &&
> +	test_sparse_match git diff-files &&
> +	test_sparse_match git diff-files newdirectory/testfile &&
> +	test_sparse_match test_must_fail git diff-files --find-object=HEAD:testfile

Ditto.

> +'
> +
>  test_done

Thanks.
