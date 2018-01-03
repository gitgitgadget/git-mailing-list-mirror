Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C9061F406
	for <e@80x24.org>; Wed,  3 Jan 2018 21:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751066AbeACVAb (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 16:00:31 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:38171 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750831AbeACVAa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 16:00:30 -0500
Received: by mail-wm0-f52.google.com with SMTP id 64so14930wme.3
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 13:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shabtay.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=bI6WtOqqfq8ARzJjFp9SfZCp37bYwpixXFwWSrIxb2c=;
        b=Bsh4nvVMrLY8iZFpcWbJlYMXB1pDp5HwtGiCDeB6KeAdsfPqCJlYRwU3JLfb0pZv9w
         fBwSEvvfFUPBV7QtEOzkPEJlNKwlfj0VcVnlIJjME7Uq0+u8vhBzMuHzAVIVgl/VNnpN
         6HHKE5SXZg92htpORJLPBx4FMIzDj7wXwJQ0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=bI6WtOqqfq8ARzJjFp9SfZCp37bYwpixXFwWSrIxb2c=;
        b=CPGSy3qsjqQTkyM1SKkXSPPVkMvyV2vvw5j/hRWWRv2A7OmAFA6KAXpeemIu0bFVJl
         qroFt0t3fLXY6zQ7m1NwkbvcgE09f/H+MjY3vdluqY6CvNVrGfGHQPF+PqpI0scZveg5
         YsGyM7TWsuD8AnQhX+dx1BHOh/QXR6OV2Bq7Sm1wPeLvgqkO21DVBRvGXKSHQFl9Ri48
         5GTQzHWx1w2DTIY0IOXbE3ZPwdGujPJOth6qA5FMe5iKoRPEtvjsk+gZkbCpGxHtERkJ
         7rifZeypJVPwL/5QMkCL1l3w2zgDU1GdxG785lF0SG/XekZVAvhomY0BaMX8J4K3Tf6F
         ripw==
X-Gm-Message-State: AKGB3mKpxpOsVGcvDEcbMJoE3WUiF2D93sMrY8VobyPxxDZfwh8fTMnx
        +zdwQtFgBb3P9XM8rPYkIcFBbWp4Sa05w0PT7p2hQzDSq08=
X-Google-Smtp-Source: ACJfBotndHn50KXLxC3V0B9IKIGVMWnbYysrk/SH8pSt8FewVbsmUg8HT6/AeOPIT1xtFUZSbAJLBOcSywZIdIfUUxI=
X-Received: by 10.80.175.65 with SMTP id g59mr4350569edd.283.1515013229411;
 Wed, 03 Jan 2018 13:00:29 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.170.203 with HTTP; Wed, 3 Jan 2018 12:59:48 -0800 (PST)
From:   Isaac Shabtay <isaac@shabtay.com>
Date:   Wed, 3 Jan 2018 12:59:48 -0800
Message-ID: <CAK2k7nSsygwRj_Hhrz7-qXZ8UBB=O+deOeC2FFTkrGmWSUpKqA@mail.gmail.com>
Subject: Bug report: git clone with dest
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,
Target directory is deleted on clone failures.

Steps to reproduce, for example on Windows:

cd /d %TEMP%
mkdir dest
git clone https://some-fake-url/whatever-makes-git-clone-fail dest

Of course, the clone will fail as it should. But looks like the Git
client also ends up deleting the "dest" directory.

This shouldn't happen.
