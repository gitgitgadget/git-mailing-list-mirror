Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 941ACC636D3
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 21:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbjBBVBA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 16:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjBBVA6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 16:00:58 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEC081B3F
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 13:00:57 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id t17so2155180pfj.0
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 13:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M0qcf49yOb9QI9dzYtxbFAIQIqEahWvlaNkmAOJmTpQ=;
        b=WCglMTf1EVPRyU4pITRQhS8++A/00i2aP4QtHPPxkpihSbuw5cNRFzqlY1JqaVcYhQ
         aXdj9shFIPEX3gvloLbWzmVW0ZI1kBgP9uvCw2St9R5h+3msC5JDWUr3lWrSj8wk3yo1
         o4o5YfX+e5i4fgeZknVYP/1b5r40l1ZwF6SFt7vc3W99iu/EO4KzWkM4Oj3YTq1yloly
         ZBGl3LkRbf0uGVFwSiTpurDg8h47wWCHSLume5N62JT+oY4pvDx/uwXFf1t+30PNQGm1
         t6pWOqXt1WJxwpJTDggOVpyqzC+YzbiEXWRdl9fOuCUV+yMPrk32/1JcUwj/mr7X4E93
         fPtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M0qcf49yOb9QI9dzYtxbFAIQIqEahWvlaNkmAOJmTpQ=;
        b=KQs3b3C0eD7457Fvv/5yZx1HifAS6LE0mhfcroWlUSmJDGTC5mRA0THi59GzizcKdN
         w+LJ8JAkzT2+abl1NqRc8L/uFVpgOfKHF99sMHBSblCcZLEA8u5QU9Jw2hjnBfGaosPB
         Uuii89Qgqd6sRCV8qX7s6Sb13C4j6zPb/zO8SDkUsuRHlN18VM0bRX6DDE7kw6qPL565
         bl7tXCQy7WbKAfGdxW0ecO92yHrq/G1xNMC0yNYzIzI6wo3/FTHMHc/oO5Dd6bfJ+TjJ
         zqXFmHNDcN+99rZBzsk+fKaGRhb1/zpkqdVCCL9WYQY/3b5jd9MMV8dHiZWieYoB24yU
         I1bw==
X-Gm-Message-State: AO0yUKWB+3Du3iGokqEUws/ldvkgIcSWQIVfmRi1LnEH3PILLtMl8H2O
        LFo+bZ+/m1bokwm0xhFznew=
X-Google-Smtp-Source: AK7set+AoLKvNyyzTHPS/3ztcm16PcvTZB5lEvBH+SwQQ4JkRezA8UaCtl9hnPSbPYSb1byo997LNg==
X-Received: by 2002:a05:6a00:2150:b0:592:501c:8968 with SMTP id o16-20020a056a00215000b00592501c8968mr7020917pfk.24.1675371657185;
        Thu, 02 Feb 2023 13:00:57 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id y66-20020a626445000000b005821db4fd84sm111976pfb.131.2023.02.02.13.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 13:00:56 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Shuqi Liang <cheskaqiqi@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/4]t4113: replace backslash with single quote
References: <20230131224929.2018546-1-cheskaqiqi@gmail.com>
        <20230202171821.10508-1-cheskaqiqi@gmail.com>
        <20230202171821.10508-2-cheskaqiqi@gmail.com>
Date:   Thu, 02 Feb 2023 13:00:56 -0800
In-Reply-To: <20230202171821.10508-2-cheskaqiqi@gmail.com> (Shuqi Liang's
        message of "Thu, 2 Feb 2023 12:18:18 -0500")
Message-ID: <xmqq1qn7u6if.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shuqi Liang <cheskaqiqi@gmail.com> writes:

The example Andrei gave you, i.e.

    Test scripts in file t4113-apply-ending.sh are written in old style,
    where the test_expect_success command and test title are written on
    separate lines ...

was quite readable, but this

> Change the old style '\'  to new style "'"

is almost impossible to understand without knowing that this wanted
to say what Andrei gave in a different way.  The title is worse.
It's not replacing a backslash with a single quote, which would
result in

    -test_expect_success setup \
    +test_expect_success setup '
        'git update-index --add file'

and obviously that is not what you did (or wanted to do).

> Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
> ---
>  t/t4113-apply-ending.sh | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)

The patch text looks OK.
