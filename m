Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 515B01FAF4
	for <e@80x24.org>; Wed,  8 Feb 2017 21:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751443AbdBHV3r (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 16:29:47 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:34060 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750941AbdBHV3o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 16:29:44 -0500
Received: by mail-it0-f66.google.com with SMTP id o185so324446itb.1
        for <git@vger.kernel.org>; Wed, 08 Feb 2017 13:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=9R4brR0WijaOf3dORW3GWEOFXkkD+wY5thDF9d37yD8=;
        b=N3LBMkqkysVU6EtYA8GmKIqchjb7Avko5SPOu9kPAJF3KyGeXWg2s5DVzXieSn9zr+
         w27sPnE3AbgRu/+e5sqT/ZYIbKC65fM7BVPovoTqZnv80zkZISyFFOsD1HSka2/n+CYO
         NzCsgjFTzptU6rkhKja7C9gj4cpLoKD7Cj5QcNyOx2j85W9+48poj9C7N/WfQBSLLuJa
         phMMxaqoLk8xBp8t0G9rNMvLqkM+Fko4O9prMvEdRwojS0dvJVD/viys2VgEMoaM5/1y
         LYve64FYuRKZWo983h3KeAjSIhQqf8s3idjOqdzC49iXpRw3sL3ZIQIrlUwXFyD9hxBo
         RKWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=9R4brR0WijaOf3dORW3GWEOFXkkD+wY5thDF9d37yD8=;
        b=JcdTiuihq1eNKwrpHhfLq/rnflpd3qDPUB3myPexGB8AEsL0uMmHI5ZGrSR38fiQs0
         yP6CsrDMPbPa4damtXTfT/M7f5U6DC2V9yac4DbC6/mQSQvn2hkDnkPGD7bSnYWmsC0f
         DPD+bB5G/MWFnLl64m5rwFOiMi7lC/79zxf6EYn0QoDeeENXKDDko24IKKLw1nKkqmHF
         E5QGQW33buLNU0XsDfeo4o9+DAywjd59031M0aUFvEHSk8XtvuwyyGAouJR6WpmKe+wx
         uqVnmD71kR7IuKpUu0JupypTWRZ7cH2Ybe2Q95p13u8lBQJET7pvwdBgS6HGdjPw33Rd
         /iMw==
X-Gm-Message-State: AIkVDXJB2030TmodkA7+Sg7kbIVn+wki6/i7iGD5S3WuZN1wHZxPMlNQEOZ017+MBgWHgA==
X-Received: by 10.84.129.2 with SMTP id 2mr36771433plb.108.1486589324933;
        Wed, 08 Feb 2017 13:28:44 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:7c20:fa7c:46cb:2209])
        by smtp.gmail.com with ESMTPSA id q22sm22636297pfj.77.2017.02.08.13.28.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 08 Feb 2017 13:28:44 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     cornelius.weig@tngtech.com
Cc:     git@vger.kernel.org, karthik.188@gmail.com, peff@peff.net,
        bitte.keine.werbung.einwerfen@googlemail.com
Subject: Re: [PATCH v4] tag: generate useful reflog message
References: <20170206222416.28720-1-cornelius.weig@tngtech.com>
        <xmqqpoiv15ew.fsf@gitster.mtv.corp.google.com>
        <20170206222416.28720-2-cornelius.weig@tngtech.com>
Date:   Wed, 08 Feb 2017 13:28:43 -0800
In-Reply-To: <20170206222416.28720-2-cornelius.weig@tngtech.com> (cornelius
        weig's message of "Mon, 6 Feb 2017 23:24:16 +0100")
Message-ID: <xmqqshnov0c4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

cornelius.weig@tngtech.com writes:

> From: Cornelius Weig <cornelius.weig@tngtech.com>
>
> When tags are created with `--create-reflog` or with the option
> `core.logAllRefUpdates` set to 'always', a reflog is created for them.
> So far, the description of reflog entries for tags was empty, making the
> reflog hard to understand. For example:
> 6e3a7b3 refs/tags/test@{0}:
>
> Now, a reflog message is generated when creating a tag, following the
> pattern "tag: tagging <short-sha1> (<description>)". If
> GIT_REFLOG_ACTION is set, the message becomes "$GIT_REFLOG_ACTION
> (<description>)" instead. If the tag references a commit object, the
> description is set to the subject line of the commit, followed by its
> commit date. For example:
> 6e3a7b3 refs/tags/test@{0}: tag: tagging 6e3a7b3398 (Git 2.12-rc0, 2017-02-03)
>
> If the tag points to a tree/blob/tag objects, the following static
> strings are taken as description:
>
>  - "tree object"
>  - "blob object"
>  - "other tag object"
>
> Signed-off-by: Cornelius Weig <cornelius.weig@tngtech.com>
> Reviewed-by: Junio C Hamano <gitster@pobox.com>

This last line is inappropriate, as I didn't review _THIS_ version,
which is different from the previous one, and I haven't checked if
the way the comments on the previous review were addressed in this
version is agreeable.

> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> index 072e6c6..894959f 100755
> --- a/t/t7004-tag.sh
> +++ b/t/t7004-tag.sh
> @@ -80,10 +80,24 @@ test_expect_success 'creating a tag using default HEAD should succeed' '
>  	test_must_fail git reflog exists refs/tags/mytag
>  '
>  
> +git log -1 > expected \
> +	--format="format:tag: tagging %h (%s, %cd)%n" --date=format:%F

We do not want to do this kind of thing outside the
test_expect_success immediately below, unless there is a good
reason, and in this case I do not see any.

Also write redirection operator and redirection target pathname
without SP in between.

>  test_expect_success 'creating a tag with --create-reflog should create reflog' '
>  	test_when_finished "git tag -d tag_with_reflog" &&
>  	git tag --create-reflog tag_with_reflog &&
> -	git reflog exists refs/tags/tag_with_reflog
> +	git reflog exists refs/tags/tag_with_reflog &&
> +	sed -e "s/^.*	//" .git/logs/refs/tags/tag_with_reflog > actual &&
> +	test_cmp expected actual
> +'

In other words, something like:

test_expect_success 'creating a tag with --create-reflog should create reflog' '
	git log -1 \
		--format="format:tag: tagging %h (%s, %cd)%n" \
		--date=format:%Y-%m-%d >expected &&
	test_when_finished "git tag -d tag_with_reflog" &&
	git tag --create-reflog tag_with_reflog &&
	git reflog exists refs/tags/tag_with_reflog &&
	sed -e "s/^.*	//" .git/logs/refs/tags/tag_with_reflog >actual &&
	test_cmp expected actual
'	

Even though %F may be shorter, spelling it out makes what we expect
more explicit, and what is what I did in the above example.

Thanks.
