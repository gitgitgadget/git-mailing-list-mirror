Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AEA3C433E1
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 20:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EE8E206C0
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 20:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t2CmDeXc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgHNUfB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 16:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgHNUfA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 16:35:00 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E57C061385
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 13:35:00 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id p25so9571406qkp.2
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 13:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R57RjyBJb4PRAJsTABBxL1EqoP1Ew4JofyjbeGxg1iU=;
        b=t2CmDeXczQn+0YBagt4BZ9d1Ft8v19uv+g6Zl0JwzvtlsehsYQgT1WD6oSa+hkiX+h
         tc251NaULYdcGZC8I8hkoX/AaLz0mmuInpFacu4yKgYYxwQPH/J7pWtBPpWW29FXIotB
         xYKJZN+fBcZDX8BWFinYrQq4jYdQWN0otlvf0TZB4k4nhnM48dqUTqlCiOwPNclYTfh0
         6ll5NjkUvyNlmhmGSQH+9I33gdulvmDwDQlWUDcFIUPhN2gG7Ech5n6poUAZexk00Hnr
         5DYZh9p5POdsN39Rr9ABt/U0/ceJK/gralukR/oYbCTDg/zWcSjhsDvrtp60rxQMNQvp
         s5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R57RjyBJb4PRAJsTABBxL1EqoP1Ew4JofyjbeGxg1iU=;
        b=br2NUVNFPRDCz6p1gjDKI21Ziyvw7x8qLt39w8kKqVbCN9BkzcG3a9Cx5ZlUFUzCLb
         qB4EWsD6cvdS7zarK9ThgE2xx2YtT9epZAP2lLB/n5U5c3nOA46FATO6MBsN/0Eam5XD
         ujPvtJGRSsqMYsnvbm+g2+D6uZeCqybO0yOFSRVbijhNV7jqtrA/xZFv4QhRTC/1ubDf
         lAc6aLYrz4djzgRzgIQBb5wbylvIUtRdcDqsTBrD5GMXfrq414Da1JIC9aRE+DBIE+vI
         /JE37h80C3gL2/18pWlz5pfs5Uhy70Luo9joc2PKcafwSwvhn9Js/xqjZWQyL9qbtD5H
         xMzw==
X-Gm-Message-State: AOAM5337hNKQlm6paGYjDdW6jlHCPZ1AeVUupi8a8UtMZJu5hYu3+Crp
        n2gZcZKdEY0vV08NzdUp2AQ=
X-Google-Smtp-Source: ABdhPJz7KEnWU7+2eYpqN4SIb/gQjFTSRcZ3w/dWFQAdM9YilCWZqBVmzPsri3QQPKJzgeF9maLclg==
X-Received: by 2002:a37:9bca:: with SMTP id d193mr3367538qke.131.1597437299390;
        Fri, 14 Aug 2020 13:34:59 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:4116:add4:1500:aeb7? ([2600:1700:e72:80a0:4116:add4:1500:aeb7])
        by smtp.gmail.com with ESMTPSA id 7sm9520639qky.89.2020.08.14.13.34.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2020 13:34:58 -0700 (PDT)
Subject: Re: [PATCH 0/3] SHA-256: Update commit-graph and multi-pack-index
 formats
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, martin.agren@gmail.com,
        sandals@crustytoothpaste.net, me@ttaylorr.com,
        abhishekkumar8222@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.703.git.1597428440.gitgitgadget@gmail.com>
 <xmqqeeo9vxl0.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <04ebec72-07de-4494-688f-a9f48442906e@gmail.com>
Date:   Fri, 14 Aug 2020 16:34:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <xmqqeeo9vxl0.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/14/2020 3:25 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> As discussed [1], there is some concern around binary file formats requiring
>> the context of the repository config in order to infer hash lengths. Two
>> formats that were designed with the hash transition in mind (commit-graph
>> and multi-pack-index) have bytes available to indicate the hash algorithm
>> used. Let's actually update these formats to be more self-contained with the
>> two hash algorithms being available.
>> ...
>> If this is the way we want to go with the formats, then I'll assist
>> coordinating these textual and semantic merge conflicts.
> 
> I agree that the files should be self-identifying, but have these
> changes tested without sha256 hash?

All of the test scripts pass with and without GIT_TEST_DEFAULT_HASH=sha256,
and this test in t5318 (and a similar one in t5319) are explicit about
testing both options:

+test_expect_success 'warn on improper hash version' '
+	git init --object-format=sha1 sha1 &&
+	(
+		cd sha1 &&
+		test_commit 1 &&
+		git commit-graph write --reachable &&
+		mv .git/objects/info/commit-graph ../cg-sha1
+	) &&
+	git init --object-format=sha256 sha256 &&
+	(
+		cd sha256 &&
+		test_commit 1 &&
+		git commit-graph write --reachable &&
+		mv .git/objects/info/commit-graph ../cg-sha256
+	) &&
+	(
+		cd sha1 &&
+		mv ../cg-sha256 .git/objects/info/commit-graph &&
+		git log -1 2>err &&
+		test_i18ngrep "commit-graph hash version 2 does not match version 1" err
+	) &&
+	(
+		cd sha256 &&
+		mv ../cg-sha1 .git/objects/info/commit-graph &&
+		git log -1 2>err &&
+		test_i18ngrep "commit-graph hash version 1 does not match version 2" err
+	)
+'
+

Since this tests exactly that the "hash version" byte is the same in
a SHA-1 repo, this checks that the new version of Git writes backwards-
compatible data in SHA-1 repos.

Or are you hinting at a more subtle test scenario that I missed?

Thanks,
-Stolee
