Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A67C11F64
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 23:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A80161CAD
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 23:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234537AbhF1Xqu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 19:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234139AbhF1Xqr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 19:46:47 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD172C061574
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 16:44:20 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 11so15929807oid.3
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 16:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=3I9EGZmgWpKYSEsAB251K13RR0VqvvI6c1UbHUR1d8Y=;
        b=RST3a0KLgBzdXb3g5qBLbJ92mPL/sY0oGzMqFlXYnZPNjY3qBujTMpEO/S60BuVM3W
         2H+dvwLKnYBRNN/pl7JiXSpMryjpgwvmbHjceVM0gh6FQ3iVpUNiPgG9/imjz+vhL0F8
         7QfObHUImyc4nPY/51jS8rO1MJLn4iAqokxPZJW4nloVUWjG90WOe7nf3up9boy4CVt+
         EhgbeyftHABHAcacGNjKE2Yv9G/zpPW23BizHvltd89fi/QnUlr+Jr3B3U0YVwfExi9A
         GrMRLP/HZ8L9iD2NtPt3PnM5G99cEwkShw0F5V6Bb9pmKmoU5Vn/F5iITB7d2JrilSme
         CbBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=3I9EGZmgWpKYSEsAB251K13RR0VqvvI6c1UbHUR1d8Y=;
        b=ZYzrvgz/oXyTPDywqNS8GLtPJH+c0ZffMlk2bSz4ws2je+w0BR2nXYRlwI3HelnPdl
         pziLXyq+SYLtLlGZHOd9+otp86ZhrulaVQ1empfkHGX/Kt1K1m6PCKBHOoBvJTHqUP/n
         LKVuxq1tRlV6T7NY6bEgp23yyN2EVuqWVej8Rm0h6SVwxoAUlohkbK1s3FljrkrDVJnc
         U9ReCsz73fqsPrn25FQQKwV99aVrqjCnogb4kz+6WLMT5hgdlur+pI0Eu5DF3ggv//BV
         bRDo41pPXC9KOrn28itO8JQ2Wyu2GzvPPJPtGunGoInLMxypxVGTScItCUyFD6Hh6xKn
         50wQ==
X-Gm-Message-State: AOAM530yslOHBh3kE2FtDA09EoZFabXxWAPydkVUaIAZjCwzu+gCEUWs
        DkCnNBSSIqXbhA2a+BBVdPqiy/rxsM1krw==
X-Google-Smtp-Source: ABdhPJzr3VCFoT4mOezffxGtD5sqRtm/itThbeQZ+ZpLmWgVzAH3gMEkIbFP4dfQV4OCWd70zZ3g/A==
X-Received: by 2002:aca:38c5:: with SMTP id f188mr18899677oia.36.1624923860002;
        Mon, 28 Jun 2021 16:44:20 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id 2sm3675074ota.58.2021.06.28.16.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 16:44:19 -0700 (PDT)
Date:   Mon, 28 Jun 2021 18:44:18 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Pratyush Yadav <me@yadavpratyush.com>, git@vger.kernel.org
Message-ID: <60da5ed21ec8c_1f78f2082a@natae.notmuch>
In-Reply-To: <20210628183004.flxirucfv2celll3@yadavpratyush.com>
References: <20210628183004.flxirucfv2celll3@yadavpratyush.com>
Subject: RE: Applying a patch with a diff header in its commit message
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pratyush Yadav wrote:
> I have a patch at $DAYJOB that contains a diff header ("diff --git 
> a/...") in its commit message, and unfortunately it is not indented. So 
> naturally, git-am trips up and thinks it is the start of the main diff 
> and tries to apply the diff starting there. It does not apply and the 
> patch is rejected as being corrupt.
> 
> I know one option for me is to manually edit the patch and indent the 
> diff header. But I would like to avoid that if possible. Is there any 
> way to apply that patch as-is? Is it possible to tell git-am where to 
> start looking for the diff?

git apply?

-- 
Felipe Contreras
