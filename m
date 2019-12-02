Return-Path: <SRS0=5D3W=ZY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B327C432C0
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 15:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A37F2084F
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 15:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5uzEcjp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbfLBP7a (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Dec 2019 10:59:30 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37793 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727453AbfLBP7a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Dec 2019 10:59:30 -0500
Received: by mail-ot1-f66.google.com with SMTP id k14so15854833otn.4
        for <git@vger.kernel.org>; Mon, 02 Dec 2019 07:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nu1uS01HDpaxyu9Vo6DulSsPjjDeJo818TbXTrRpSsU=;
        b=E5uzEcjp82QOEhat/9pfMr0zaKGhnAEuAmHNUaWuHCN14+xBGdw23BW+7Z7NKlh7C6
         zoYs77qn1djeNAE8PeF+xq4TFkJJn/mfOgFwSGYBkz0NexTW7WrnwIaCoKwVS/nsvztC
         DKo2gbtWSm4c/otbuHO6Y00TLv2oTKEMPAbYQsKR6y8aSx7Uu1R9Tag7emhtUt9azpIG
         D+HXmG0/PR2ndmzzkOQ9GEg1AFRnnuL/ZPBtuvpK3SFKAmh0zhGY4PEg1J7+0QWw91K1
         Qf1tuykMeFTGgaOnkir22wL8N3IQw8bkPk349J46yNFTwlM4JsQ1fzuC3q2eZ/3LuiQV
         kp2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nu1uS01HDpaxyu9Vo6DulSsPjjDeJo818TbXTrRpSsU=;
        b=CodW5AOD9/C87/8jUoCOInzxtSHKghKowfW7OCCHzBUARFbvPiaIAvU6f/hfmJHHmh
         o9rKk0ZOJuTT+lI6bv0tbelR47Y8HfRmW+Go2LZ4vubfjHtOlHdQ7JbITKuMPObRF0En
         GZoD1zKrf0bKFewsBZe3RWdut7AJI+zi+L7YXOqzRNn+AxBtsCjuYPOPUVQGaAJmXOjK
         S7ZKmAD2soBSaBrNSpyJQrAAwIKNBM8RhQaSKaACe6d0GoIW2cMc7uU7cXK0IDOC6o3F
         Ox48MIZ/+wQ+g5CvJtZ5o3h/e8n+8lwBOnMZgD3BGzbbzW69a0YEJ7p/DFBBscaIX8H+
         g+zA==
X-Gm-Message-State: APjAAAV50D6jFwDpG3xLuenngPOFxS/XXn0Hsi5CN6ClnK6XIo1KnZ5s
        mXZ6Y5lS/z8+KyZT31t8osm7IKeN1rtEtIFkguo=
X-Google-Smtp-Source: APXvYqxlbIT3jssty2R5r9j5/58HafGMsIEfZSrS1+Sm1IfAYafig5HtcS9CNm1cut21FrGsuqVpHVhsa4cABCDIbW4=
X-Received: by 2002:a9d:6f07:: with SMTP id n7mr10324450otq.112.1575302369306;
 Mon, 02 Dec 2019 07:59:29 -0800 (PST)
MIME-Version: 1.0
References: <xmqqpnh6yfrl.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqpnh6yfrl.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 2 Dec 2019 07:59:18 -0800
Message-ID: <CABPp-BE01sXeNT9QtK+svfpeiVRvjw-U+R91BtJfiKhJCkrfxA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Dec 2019, #01; Mon, 2)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 2, 2019 at 6:19 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.  The ones marked with '.' do not appear in any of
> the integration branches, but I am still holding onto them.
>
> The second batch of topics are now in 'master'; this was a rather
> large update, so there might be some fallout.  Many topics are still
> in 'next' to be merged to 'master' soonish, and many others are
> waiting to be in 'next'.

Did you forget to push these out?  I see:

$ git ls-remote git://github.com/gitster/git | grep refs/heads/master
d9f6f3b6195a0ca35642561e530798ad1469bd41 refs/heads/master
$ git ls-remote git://git.kernel.org/pub/scm/git/git.git | grep
refs/heads/master
d9f6f3b6195a0ca35642561e530798ad1469bd41 refs/heads/master
(...and the same for a few other clone URLs)

$ git log -1 d9f6f3b6195a0ca35642561e530798ad1469bd41
commit d9f6f3b6195a0ca35642561e530798ad1469bd41 (origin/master,
origin/HEAD, gitster/master)
Author: Junio C Hamano <gitster@pobox.com>
Date:   Sun Nov 10 18:00:59 2019 +0900

    The first batch post 2.24 cycle

    Signed-off-by: Junio C Hamano <gitster@pobox.com>
