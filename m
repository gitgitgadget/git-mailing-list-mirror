Return-Path: <SRS0=Z/Vr=2I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99042C43603
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 19:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F27B206D8
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 19:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VD7YNVpC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfLRTdQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 14:33:16 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46958 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbfLRTdQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 14:33:16 -0500
Received: by mail-ot1-f68.google.com with SMTP id c22so3788569otj.13
        for <git@vger.kernel.org>; Wed, 18 Dec 2019 11:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DgEnNFNQMZol90/AjTo7kkKPSRIAFEUYJlezGeV+BE8=;
        b=VD7YNVpC0z9L4q8y1vUe4cdEB2iRz1kBCSFrTn35SMHeTsV325Vui6PXm/XnpO+12k
         EXI1xTSQZHussxbjtlW8xKswrIzhWEitbGUL3RhN0D9nu2Qgr9zb0PPBAzPTT3P1CVV7
         Ly6ro9X9mq6Bhneg993ywCvQGdpjZXy/p6jpyX6bLQx5lOmZ1HkrGv1lUglwNlkM32an
         lPaV5HeSXbJPk7j52gsJzfgjYPmdfLzxSGFO3YBRRpmkugw/K8/g7RAry7T3tQgVvaaR
         Oi/T1NGVPaO0/tKvKzo9qUeWtFAwjXMAB8zNyacFcCQ+wGUsGGTAI7xDhqxAKyFwhMea
         HULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DgEnNFNQMZol90/AjTo7kkKPSRIAFEUYJlezGeV+BE8=;
        b=g3mPy2p6/Zqz6dcYxLY6q4/RtPAFrSwJVzyWRPFC7tQmNrSrXuRAqWfyoWlhJBE6ku
         ov7mhjaMV3baLMNflH+HW6XOFLX9wi6y9jUXJWMQRxG3xtfPHp3u2lP2x22uBNC/79Af
         FZSZyTbTQeAbkGzL55hn8DEjN1OI63NvRFnzbsEZTHMwufj6zvvx/FKa6wOADv3gFDIV
         thbgnTcNl1jIAomq1wcXHf5JTs+6d1sZboy0Siau96rYhR9qHYV17F2DawSw0DPAYTJX
         16Z0dqqaEVGPuvMZZvm/gDjWQ2R+9mfEAjENm5dR7yikGVJLEjt/xhYJTHLq9A1ncwCx
         UVKQ==
X-Gm-Message-State: APjAAAVVYLdieHogQT8IrFs9ZFWHfS97jaccFhodnCAkfoTBR2vn6pqU
        wYlS8pytr+ex9qo6iC131OYhu0WdZ7Zp5ugTcThH/pPU
X-Google-Smtp-Source: APXvYqwauI4/Hu71T2kOXnN0/KmHyJuGY9CZuNynytiTLHxmRvZIkN8WdfH3gL9MqLrNKPjRqWqO6ER5+NAe/qgVDyk=
X-Received: by 2002:a05:6830:681:: with SMTP id q1mr4440155otr.162.1576697595342;
 Wed, 18 Dec 2019 11:33:15 -0800 (PST)
MIME-Version: 1.0
References: <xmqqa77qfw99.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqa77qfw99.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 18 Dec 2019 11:33:04 -0800
Message-ID: <CABPp-BEyNcJPp0BSPLiAYpmCMLWcqiQQc5GZnhahbCez2vyqzQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Dec 2019, #04; Tue, 17)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 17, 2019 at 2:03 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.  The ones marked with '.' do not appear in any of
> the integration branches, but I am still holding onto them.
>
...
> [New Topics]

It appears that
https://lore.kernel.org/git/2d1f9a8485e744e23b1f02826877afe829a639cf.1576271025.git.gitgitgadget@gmail.com/
from last Friday may have fallen through the cracks.  Could that one
be picked up?
