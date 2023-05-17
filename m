Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7EAEC77B75
	for <git@archiver.kernel.org>; Wed, 17 May 2023 09:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjEQJGJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 05:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjEQJGH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 05:06:07 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43187E5C
        for <git@vger.kernel.org>; Wed, 17 May 2023 02:05:56 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f4249b7badso5220065e9.3
        for <git@vger.kernel.org>; Wed, 17 May 2023 02:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684314355; x=1686906355;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LxkIAisNN9sORuaM05+mPVPYpEHxnKyE22SKPd4WvAU=;
        b=PB7tg5T3Eti1yOovopOXnmpzClxfMUcJlexTL8Rw0OWTKa+uJE80PKoErJ5S7EWIgy
         2o3eC1+sR9VCR3q9YqRgi7pvDArw/Fhy6VY/FRfRAvsjPo+RFaSk2nnwOBxCQtID8nu1
         djkdwDv8CpMr1+hZT6/Sfc2d03HacDJP1JsPT6BHKV9RUswQ2rkUcKsAhNgWSCnQp0za
         m94MHt/pAGjf9UmNycGfzKdOc0LVzbkdV6ws7V3ZhWBTJBw8Q6Dx9ueW51acYluHm3h4
         cjZHCVRTzxYLbwrYpvGfLy0QcVDyPpl/eQjO08f2eWed0ZHZgeX9/vcXbFPHbWAieUHr
         xQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684314355; x=1686906355;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LxkIAisNN9sORuaM05+mPVPYpEHxnKyE22SKPd4WvAU=;
        b=Jj0iS79NtG+50MAL4IQe3TbP/LQWxoE0Af6kl0fMWbDMGDkfpp+A9ya8w0JpJ991yT
         0P37i5og6Oa2tjfULpWaPTTamzgJ5daDT9gNCB3Pw78l4oBEi5kqKKbOyfTVpO8qWtFc
         zluJk1SVxonhNHun6jjZZSESlK5iv4cDKI+zb2lFahI3i5yLmGCv/U27CdjYvkEowTSn
         z7xeEregLZxUGSVNFf4PpLdWoKLnqGujXErWnYHZqZ824bkyNM9fU8z0Fweo7NKexiQ+
         O8oxo2xdCH9W4DbvoiYE2+oVLRix3daS9Q6MRO59vzGMk1U9DYrh/JX/n8kG0BTrflJ0
         I+9w==
X-Gm-Message-State: AC+VfDysxcEM40k/l202pMs6SVvV7C/BlVgwiJ6IZMmbMECLWT6nK2O8
        B8n5tSFzS5ZyvT464i+bCUujzPKFDWk=
X-Google-Smtp-Source: ACHHUZ4Jt8cbvbFxy+ftILfA/OtMgYgh2lhXy+zDOdJTwofSEwZ27I36oUbz8DIEaVZ8HifvV7eWig==
X-Received: by 2002:a05:600c:217:b0:3f4:f0c2:143 with SMTP id 23-20020a05600c021700b003f4f0c20143mr12969634wmi.20.1684314354503;
        Wed, 17 May 2023 02:05:54 -0700 (PDT)
Received: from [192.168.1.212] ([90.255.142.254])
        by smtp.gmail.com with ESMTPSA id p5-20020a7bcc85000000b003f4248dcfcbsm1521185wma.30.2023.05.17.02.05.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 02:05:53 -0700 (PDT)
Message-ID: <3f5e4116-54e6-9753-f925-ed4a9f6e3518@gmail.com>
Date:   Wed, 17 May 2023 10:05:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] sequencer: beautify subject of reverts of reverts
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Kristoffer Haugsbakk <code@khaugsbakk.name>
References: <20230428083528.1699221-1-oswald.buddenhagen@gmx.de>
Content-Language: en-US
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20230428083528.1699221-1-oswald.buddenhagen@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Oswald

On 28/04/2023 09:35, Oswald Buddenhagen wrote:
> Instead of generating a silly-looking `Revert "Revert "foo""`, make it
> a more humane `Reapply "foo"`.
> 
> The alternative `Revert^2 "foo"`, etc. was considered, but it was deemed
> over-engineered and "too nerdy". Instead, people should get creative
> with the subjects when they recurse reverts that deeply. The proposed
> change encourages that by example and explicit recommendation.
> 
> Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
> Cc: Junio C Hamano <gitster@pobox.com>
> Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
> v2:
> - add discussion to commit message
> - add paragraph to docu
> - add test
> - use skip_prefix() instead of starts_with()
> - catch pre-existing double reverts
> ---
>   Documentation/git-revert.txt |  6 ++++++
>   sequencer.c                  | 14 ++++++++++++++
>   t/t3515-revert-subjects.sh   | 32 ++++++++++++++++++++++++++++++++
>   3 files changed, 52 insertions(+)
>   create mode 100755 t/t3515-revert-subjects.sh
> 
> diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
> index d2e10d3dce..e8fa513607 100644
> --- a/Documentation/git-revert.txt
> +++ b/Documentation/git-revert.txt
> @@ -31,6 +31,12 @@ both will discard uncommitted changes in your working directory.
>   See "Reset, restore and revert" in linkgit:git[1] for the differences
>   between the three commands.
>   
> +The command generates the subject 'Revert "<title>"' for the resulting
> +commit, assuming the original commit's subject is '<title>'.  Reverting
> +such a reversion commit in turn yields the subject 'Reapply "<title>"'.
> +These can of course be modified in the editor when the reason for
> +reverting is described.
> +
>   OPTIONS
>   -------
>   <commit>...::
> diff --git a/sequencer.c b/sequencer.c
> index 3be23d7ca2..61e466470e 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2227,13 +2227,27 @@ static int do_pick_commit(struct repository *r,
>   	 */
>   
>   	if (command == TODO_REVERT) {
> +		const char *orig_subject;
> +
>   		base = commit;
>   		base_label = msg.label;
>   		next = parent;
>   		next_label = msg.parent_label;
>   		if (opts->commit_use_reference) {
>   			strbuf_addstr(&msgbuf,
>   				"# *** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***");
> +		} else if (skip_prefix(msg.subject, "Revert \"", &orig_subject)) {
> +			if (skip_prefix(orig_subject, "Revert \"", &orig_subject)) {

I think it is probably worth adding

	if (starts_with(orig_subject, "Revert \""))
		strbuf_addstr(&msgbuf, "Revert \"");
	else

here to make sure that we don't end up with a subject starting "Revert 
\"Reapply \"Revert ...".

Best Wishes

Phillip

> +				/*
> +				 * This prevents the generation of somewhat unintuitive (even if
> +				 * not incorrect) 'Reapply "Revert "' titles from legacy double
> +				 * reverts. Fixing up deeper recursions is left to the user.
> +				 */
> +				strbuf_addstr(&msgbuf, "Revert \"Reapply \"");
> +			} else {
> +				strbuf_addstr(&msgbuf, "Reapply \"");
> +			}
> +			strbuf_addstr(&msgbuf, orig_subject);
>   		} else {
>   			strbuf_addstr(&msgbuf, "Revert \"");
>   			strbuf_addstr(&msgbuf, msg.subject);
> diff --git a/t/t3515-revert-subjects.sh b/t/t3515-revert-subjects.sh
> new file mode 100755
> index 0000000000..ea4319fd15
> --- /dev/null
> +++ b/t/t3515-revert-subjects.sh
> @@ -0,0 +1,32 @@
> +#!/bin/sh
> +
> +test_description='git revert produces the expected subject'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'fresh reverts' '
> +    test_commit --no-tag A file1 &&
> +    test_commit --no-tag B file1 &&
> +    git revert --no-edit HEAD &&
> +    echo "Revert \"B\"" > expect &&
> +    git log -1 --pretty=%s > actual &&
> +    test_cmp expect actual &&
> +    git revert --no-edit HEAD &&
> +    echo "Reapply \"B\"" > expect &&
> +    git log -1 --pretty=%s > actual &&
> +    test_cmp expect actual &&
> +    git revert --no-edit HEAD &&
> +    echo "Revert \"Reapply \"B\"\"" > expect &&
> +    git log -1 --pretty=%s > actual &&
> +    test_cmp expect actual
> +'
> +
> +test_expect_success 'legacy double revert' '
> +    test_commit --no-tag "Revert \"Revert \"B\"\"" file1 &&
> +    git revert --no-edit HEAD &&
> +    echo "Revert \"Reapply \"B\"\"" > expect &&
> +    git log -1 --pretty=%s > actual &&
> +    test_cmp expect actual
> +'
> +
> +test_done
