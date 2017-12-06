Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3765420C32
	for <e@80x24.org>; Wed,  6 Dec 2017 23:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752047AbdLFXyN (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Dec 2017 18:54:13 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:38134 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751711AbdLFXyM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Dec 2017 18:54:12 -0500
Received: by mail-wm0-f54.google.com with SMTP id 64so9957228wme.3
        for <git@vger.kernel.org>; Wed, 06 Dec 2017 15:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=rIuQf/1jvHm8zdYJeZnoAIPuh6Mi4puI8SrcMqDdI/8=;
        b=fVttfzLxRsaEEm4OxoacTsuELCyM+QdGIbPmUXJUnMxzaEePTKqRZj8N3VOX0WStHZ
         2XSYP9S6CHPrDEU+Ud4CzPKpBioxHpJO3fW75L70+ygP9r8dhZBMgHQYL8djGyUUJW6u
         WEeJ5oqDrJx+Eu0ZUijESBjjvd0iD77gy9/xwp/xpuX9bjKNiXfjtL320L4Mogq5tUKT
         ZrPBk6nJobY31bHs+A8xzzaTBIeX3EYq6Z1d0vJuhruFOgM0m+9kriz589Q79KCA5rP3
         xIZLcjaa5aFR1h8gHTA08/G2/tV2/HhyzHRFqxzZ/VmPBpkOOC1jLPvHkkujwlw/Czw1
         wU6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=rIuQf/1jvHm8zdYJeZnoAIPuh6Mi4puI8SrcMqDdI/8=;
        b=mPvyWkILOUiTXpkW4qrVaVj7u4l9aCgRkqdBC/O3WhdWgAVwa+fZZzkxgCSLwphaFZ
         Cip6ZrRTyDPIN5/dreCa7lqYwDSiq32yZyGjKe/WKJFO4ZJEWEN9wxuziZVp2C32JRXk
         7xkch8Srgfxjwp2o7JW4HUCtoY2i8Q4liMfR/Aj9qJADJVcYynFOtc7QQmt4qMnFfDi/
         YMa51QfYpKHjtKybZAZukHilDJXhf31YVVb3gox6zsoVCgG2bQaIlWNqYW2DMirUuuTv
         maeK8KVUSFZ+g/JzMpKUf2GnpVT5Z9CL7qzDOtq2tuePlgtLIIxTvEhaH0A4RDtiHE07
         bSqw==
X-Gm-Message-State: AKGB3mKIrkCdL4lKS9W3xWPZMkn3nm2T/84/uB4ow0trwW2rcz0iSMzy
        1VK9BfCvbh4YpFoHI7DLtNmGB3TvKkQAa5YGoa2OHw==
X-Google-Smtp-Source: AGs4zMaJ8PUj4vv8DXfP7kHW1gASIp9O0SrGwIaP30x+X7jLR2mWg1EhxgfowLCDYgL1xKoVaKzN2RwvJUkP2xXg06k=
X-Received: by 10.80.176.70 with SMTP id i64mr792080edd.187.1512604450838;
 Wed, 06 Dec 2017 15:54:10 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.174.252 with HTTP; Wed, 6 Dec 2017 15:53:50 -0800 (PST)
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 6 Dec 2017 15:53:50 -0800
Message-ID: <CA+P7+xotDPa+=G5ypfyD7gySp6r2SKRAjMSw_0BmvuyyfcjxBw@mail.gmail.com>
Subject: git commit file completion recently broke
To:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I'm still investigating, but thought I'd send an email. I recently
updated to jch branch, and found that completion for git commit does
not work as expected.

If I have a git repository with a modified file in a subdirectiory,
then git commit <TAB> produces the name of the subdirectory instead of
the file names.

This occurs regardless of where I run the git commit command.

Thanks,
Jake
