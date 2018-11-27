Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A5351F97E
	for <e@80x24.org>; Tue, 27 Nov 2018 19:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbeK1GYU convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 28 Nov 2018 01:24:20 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36900 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbeK1GYU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 01:24:20 -0500
Received: by mail-qt1-f196.google.com with SMTP id z16so23094521qtq.4
        for <git@vger.kernel.org>; Tue, 27 Nov 2018 11:25:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xVQtAmrEEduiOZHUPP52swp045mK6oIzODFFS+34rZg=;
        b=Zofj49UW8vk3hEzaK07aXF1FZmdfuy+X+SgeIpY+0MFwELR3UVnU+UMx6hZX+qg2pw
         R1e8Fji6CRfweiGmb5Lw4BYWaSLWQN0/iJbTZ5hKFNUkXqjd7GYX3HUCuHzAVgsKCcYP
         3ccrSmKtRhixt74jx7bLXkAblj8NVg2W+GUP+hWgITcq7MCghcD7WvHCpkKu4Ljgq550
         PYgthSizN42Ak5MlOn+yZonVW9p5cyWfxypY5hStAHQJZYcXspnrmutFTT6AOLKInj81
         EqZToxgoJ+26rc6UImkB+CnTty4berrB1ELOwq1GxZ6gabyNnd1xnivFv2dXxv4Wp69k
         wOuw==
X-Gm-Message-State: AA+aEWbAQabfuC2JYOnyq1E75P93Cm3Dkkl+VpuxvRaO0bgrEe1kLVpL
        uq7tdcT0QcoyC8jVgbv/eIywWgQhWcsMY25sSag=
X-Google-Smtp-Source: AFSGD/Ws4OxAa4Mw3aqc50FZ4c8Yovy35wtaspSVmRoXHPyS5g1tiPbFospvCDKNM2sooULp6Gaj62528zcTwgJyAgU=
X-Received: by 2002:a0c:86c1:: with SMTP id 1mr31591613qvg.6.1543346227162;
 Tue, 27 Nov 2018 11:17:07 -0800 (PST)
MIME-Version: 1.0
References: <20181127164253.9832-1-avarab@gmail.com>
In-Reply-To: <20181127164253.9832-1-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 27 Nov 2018 14:16:55 -0500
Message-ID: <CAPig+cS-_m8RBsCME_Gj15EEs1tcFcGn0Acfvq4HgxKiL9PaHg@mail.gmail.com>
Subject: Re: [PATCH] tests: avoid syntax triggering old dash bug
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        hsed@unimetic.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 27, 2018 at 11:43 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> Avoid a bug in dash that's been fixed ever since its
> ec2c84d ("[PARSER] Fix clobbering of checkkwd", 2011-03-15)[1] first
> released with dash v0.5.7 in July 2011.

Perhaps enhance the commit message to explain the nature of the bug
itself. It is not at all obvious from reading the above or from
looking at the diff itself what the actual problem is that the patch
is fixing. (And it wasn't even immediately obvious by looking at the
commit message of ec2c84d in the dash repository.) To help readers of
this patch avoid re-introducing this problem or diagnose such a
failure, it might be a good idea to give an example of the syntax
which trips up old dash (i.e. a here-doc followed immediately by a
{...} expression) and the actual error message 'Syntax error: "}"
unexpected'.

Thanks.

> This fixes 1/2 tests failing on Debian Lenny & Squeeze. The other
> failure is due to 1b42f45255 ("git-svn: apply "svn.pathnameencoding"
> before URL encoding", 2016-02-09).
>
> This particular test has been failing since 5f9674243d ("config: add
> --expiry-date", 2017-11-18).
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
