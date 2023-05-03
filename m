Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F13C77B75
	for <git@archiver.kernel.org>; Wed,  3 May 2023 23:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjECX0E (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 19:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjECX0B (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 19:26:01 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065DE8A7F
        for <git@vger.kernel.org>; Wed,  3 May 2023 16:25:59 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-52c30fbccd4so3448093a12.0
        for <git@vger.kernel.org>; Wed, 03 May 2023 16:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683156358; x=1685748358;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=cVE0LyNxC5YlR6XbNlNiO/TUhyyMAHxJ6RQiLRVx8Uo=;
        b=YGRL/vPW5oOz9cIJVMjmN514dczXD5hV0LAoMh1260MarAD4ju1Qu9nl56SZsBV3v1
         X31ikygLM0qdNAQUbUCp4wlK9aRAQX55xiB/hhuQlExGa6TQf/naqsWG9DmDPJObkkWq
         0waoImFH0IK4QbokXYN+kfgNA61xVSURZeY9HxNP8cjysEhe8Lqro1YMwfzu5tFynNlo
         X7jokQXV4NNxO/OgzwuKdRGJS6ogDObFVB9hUIZVHLQ4xyqAEFveYCYENcA/QMUCP6QH
         +NMfK96NQLQ8u54rBwmg/3EYaOH6Kdjdr//Lbooi6EZNuGgBVEnIXRkTdbPPBiXQQLs7
         euVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683156358; x=1685748358;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cVE0LyNxC5YlR6XbNlNiO/TUhyyMAHxJ6RQiLRVx8Uo=;
        b=VTjU7zlL5OUIi5UuukPO/3diMNwUKhqeWAczeIXZpgJk5WS5psQ7dMKMg+nOelKxJn
         f2NCqQnwvAgO7w81FFfb/yWQ6qe3PNhbbQGHUWiLm3uTQGU8BZ81cwZokY/czOQ9uje4
         5P5FfyACumuxFqHHzOHouuG4RJ+YxOsBUv+9pgzwnROtL8KOitI5e+VQg6S+vZr9Vxhp
         eUYZj5poS49kK5uzbinfpV1mqyz1FTTW2KCWh4F0lkmB1kuYv21N+ktNNHV4uuMi3CkS
         H5NB0SgqXcX2gzj/DHKPsYPdKbwi6LuChqWSh3G+zBIAy7kcT6igGqoN6DWkAoDRExcY
         QzNA==
X-Gm-Message-State: AC+VfDykqrsH6Nrx3jPYdOpltLJUga/fgrxZZ+3k6jibtUwViMQt9ivd
        w+XG7TS8cgBBZQ1U8KIitWM=
X-Google-Smtp-Source: ACHHUZ7AkS9dm20Ukt44fwFlfbuctjP/45t3N2CuRz1fvhi6b2pu4YYHjA4eAA0GspAofMt7pB107g==
X-Received: by 2002:a17:90a:c981:b0:24e:1144:ef52 with SMTP id w1-20020a17090ac98100b0024e1144ef52mr262542pjt.11.1683156358338;
        Wed, 03 May 2023 16:25:58 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id h24-20020a17090a9c1800b00247735d1463sm3837344pjp.39.2023.05.03.16.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 16:25:57 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Shuqi Liang <cheskaqiqi@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com, derrickstolee@github.com
Subject: Re: [PATCH v10 1/2] t1092: add tests for `git diff-files`
References: <20230502172335.478312-1-cheskaqiqi@gmail.com>
        <20230503215549.511999-1-cheskaqiqi@gmail.com>
        <20230503215549.511999-2-cheskaqiqi@gmail.com>
Date:   Wed, 03 May 2023 16:25:57 -0700
Message-ID: <xmqqpm7hm1yy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shuqi Liang <cheskaqiqi@gmail.com> writes:

> +	test_sparse_match git diff-files -- folder2/a &&
> +
> +	write_script edit-contents <<-\EOF &&
> +	echo text >>"$1"
> +	EOF

> +	# Add file to the index but outside of cone for sparse-checkout cases.
> +	# Add file to the index without sparse-checkout cases to ensure all have
> +	# same output.

Are these two sentences supposed to explain the following two
commands that are run in all three repositories?  As far as I can
tell, no command in this test adds anything to the index.  Perhaps
it is a leftover/stale comment from previous rounds or something?

> +	run_on_all mkdir -p folder1 &&
> +	run_on_all cp a folder1/a &&
> +
> +	# file present on-disk with modifications
> +	run_on_all ../edit-contents folder1/a &&

With the above three commands taken together, we have made folder1/a
on the working tree different from what is in the index, so we can
expect to see differences between the index and the working tree
files.  "# file present on-disk with modifications" is a good way to
summarize a half of what we are trying to achieve, with the other
half being that we try to do that to a path outside the cone of
interest.

So, perhaps get rid of this comment between the step 2 and 3 of the
preparation, and rewrite the comment before the step 1 (i.e. "mkdir
-p") of the preparation to explain the whole thing, perhaps like:

	# The directory "folder1" is outside the cone of interest
	# and may not exist in the sparse checkout repositories.
        # Create it as needed, add file "folder1/a" there with
	# contents that is different from the staged version.

to explain what scenario these three run_on_all commands are trying
to create?

> +	test_all_match git diff-files &&
> +	test_all_match git diff-files folder1/a &&
> +	test_all_match git diff-files "folder*/a"

I think Victoria suggested to use the double-dash disambiguators for
these tests, and it may not be a bad idea to do so, i.e.

	test_all_match git diff-files &&
	test_all_match git diff-files -- folder1/a &&
	test_all_match git diff-files -- folder\*/a

> +'
> +
>  test_done

Thanks.
