Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73C8C3E8C5
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 18:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3145620E65
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 18:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FR1CQrLI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgKRSHd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 13:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbgKRSHc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 13:07:32 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC383C0613D4
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 10:07:32 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id i12so2341528qtj.0
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 10:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=wuTIAsM9gHQavH8W+WE2shF9ux/BV8sR6IkiuJ75gLE=;
        b=FR1CQrLIEegvCbZPs9eEbXZtYI95Bp1NHHY043zlnzhxz/LnIgXrzbyWGtzpq+LMpP
         vmsab96MzMWP4NohZKw5SlqGIwo4hzZZtH/njVTnVpSIosNGj8c9cupikdTeeiz0OAPD
         0r4l+iKPTL8ZPwdaa46Fea21wMJIBav6/xgpEom8Ft8e32xuWNWzAFOqQzumxr79nKQj
         pu4apJuqJZo7mQjLyiE5StyTDuRORCB2VyGB4rBgCQvJBmrX56ZAqp4EsKAyY1t6lHol
         j/ehl0IUUwOLJZNo3Xmw2XlcaJNt1f1NCmIhtTJ67FUcUtvnAbfbzJHr+pOOK8NTSDLH
         puVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=wuTIAsM9gHQavH8W+WE2shF9ux/BV8sR6IkiuJ75gLE=;
        b=Bx3aIu0v7bB50+xIQ79+dJAgtHyM8ZPM6tgYkutK5Rhbc7/JFQ/4zXld70QskXEpZ5
         CiUAhREm4ZVL/i+CV/iJoDRCpuvsBaF+4xChXMFHkg8VT+9mJ+SQkfk5hqbaQMEit+sx
         +kkRs7MMhSQyW8NK8ClU72Qah+1qyQp76DZdIgBlNxSo7ESi6bLtAPgAi0FXPhF08nA3
         Wy+BPAp0s/M9xxTRHqTQncviIPuW6fTH3u6yISIMWZVHQLouxEgO05oZHy5D6V2Wat8O
         Q3zYzbyBLNgvTQ51Z2G+PwDg7MVzFvqLiVAlny7bTPvhwsXuWsGrVOdzz07uZH0/UVoL
         5DIA==
X-Gm-Message-State: AOAM533O9XWRigY3EpD4ZPBWHvvAtOFIaA3xw/AUMD4mNbqW+uixItvw
        BbKhV3tkf7jNbdNNikcM+mY=
X-Google-Smtp-Source: ABdhPJyXAm+qhkPSh46tal4nYl4tTSYdAJU/yTDpfhRQR4teFG2PNvi00mz81uat7rz6uis6Tns/oQ==
X-Received: by 2002:aed:2f03:: with SMTP id l3mr6203432qtd.303.1605722851765;
        Wed, 18 Nov 2020 10:07:31 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:805f:b8ae:cbb3:6b01? ([2600:1700:e72:80a0:805f:b8ae:cbb3:6b01])
        by smtp.gmail.com with UTF8SMTPSA id c203sm12947772qkg.60.2020.11.18.10.07.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2020 10:07:31 -0800 (PST)
To:     Git List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Subject: [BUG?] "git config --replace-all key value value_regex" ignores
 value_regex?
Message-ID: <466ee1d8-efaa-fc91-f3d9-230672289ffb@gmail.com>
Date:   Wed, 18 Nov 2020 13:07:29 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As discussed [1], I am working on relaxing the "regex" part of the
value_regex parameter in the "git config" command.

[1] https://lore.kernel.org/git/xmqqlfez6alb.fsf@gitster.c.googlers.com/

As I am working to solidify how this command works, I'm adding tests
for all of the compatible options that could use a "--literal-value"
modifier. One that seemed helpful to use was "--replace-all". The
docs have this line in the SYNOPSIS:

'git config' [<file-option>] [--type=<type>] [--literal-value] --replace-all name value [value_regex]

and this in the OPTIONS:

--replace-all::
	Default behavior is to replace at most one line. This replaces
	all lines matching the key (and optionally the value_regex).

However, this test fails:

test_expect_success '--replace-all and value_regex' '
	q_to_tab >.git/config <<-\EOF &&
	[abc]
	Qkey = one
	Qkey = two
	Qkey = three
	EOF
	q_to_tab >expect <<-\EOF &&
	[abc]
	Qkey = four
	Qkey = two
	Qkey = three
	EOF
	git config --replace-all abc.key four "o*" &&
	test_cmp expect .git/config
'

The end result is that _all_ existing values are removed in
favor of one final result of abc.key=four.

Is this the intended behavior? It seems like value_regex is completely
ignored instead of actually performing a function here. The only
mailing list reference I can find include a doc update [2] and the original
implementation from 2005 [3].

[2] https://lore.kernel.org/git/alpine.LFD.2.21.1805300733440.10096@localhost.localdomain/
[3] https://lore.kernel.org/git/Pine.LNX.4.63.0511200650130.12832@wbgn013.biozentrum.uni-wuerzburg.de/

If it is _not_ the intended behavior, then would a fix to make my test
pass be appropriate? If anyone is currently specifying a value_regex
to this command, then the behavior would change in surprising ways.
However, it seems that they would get the same behavior without using
value_regex.

Thanks,
-Stolee
