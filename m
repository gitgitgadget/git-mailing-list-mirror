Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EF331FBB0
	for <e@80x24.org>; Sat,  3 Dec 2016 06:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751332AbcLCGpW (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Dec 2016 01:45:22 -0500
Received: from mail-wj0-f180.google.com ([209.85.210.180]:33986 "EHLO
        mail-wj0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751012AbcLCGpV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Dec 2016 01:45:21 -0500
Received: by mail-wj0-f180.google.com with SMTP id mp19so249470203wjc.1
        for <git@vger.kernel.org>; Fri, 02 Dec 2016 22:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=OBfYm8lKnXBujAgWVJz+7seWabgPNL2Cdvd6Bk8JPkQ=;
        b=J/V6ecgM/scqW8k9WZNXClikAIBs6r/6KOXUUoLHJqDoPeZ7O5fPcQiCcZnRRn8eUn
         Ap0qolbF/OYirNMHdojywAjUIiDRc/T963+FY9tupnj+V7WRQIZaSBIt620mt5bVITSa
         3HfU6L1xkvbNojGbZWf03xX1F83Avtfz0B0VVurRHxxlxHaiQEQaiRS11Z0u1i1lB4Nq
         i/tTWuFngU6eIJqppTS6TSufB23APgWk2sPlKgIhuEPS8fU+Dp5XnD9Y0KC7QE7ZuQ+t
         PBcKe6NNIF4868TBPkkFD5mHR8dNvVDPonmD9H6ibPN4MmhqyEUD8j5eU2Sw2hG82TsR
         hAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=OBfYm8lKnXBujAgWVJz+7seWabgPNL2Cdvd6Bk8JPkQ=;
        b=TmqBGzGKprhS4M4qyApFiD6n6pmXOdOc81BSVep0Jc3lDzjkC2mu7gb4hQt9LHMp8l
         aQ2sIz+CbyserwW+Qfa97jYfyQ8kupVId0tOSeGbrQjJxXHaXxHxD4e/RdHRIsRQvhzU
         LftD4R0qf3G3c5pxbmMLHoX3o4zhJMjX++AjvcpBLOHLCxy9IZlriwKBfzgXKEBo7ChD
         lhLda1uElQsiV8oNxY6oDiTjigwjucnqjxrNiRB3BL18kQerWC3WZ1D22tpHABWnweyA
         0OZUjNTpGTE3l19KzbwgVQYci37PiJjtC2V2rTSkvBHqn/7r7SY+7Dd2+ca831dnL7i6
         SADw==
X-Gm-Message-State: AKaTC017NrqaZkVwPoVxMrLgSfEkwiNWsws/79pugu3iSlIfP7oPuywjODKgmagwPGIO1w==
X-Received: by 10.194.89.132 with SMTP id bo4mr17235192wjb.177.1480747519948;
        Fri, 02 Dec 2016 22:45:19 -0800 (PST)
Received: from [10.18.30.185] ([46.140.123.14])
        by smtp.gmail.com with ESMTPSA id p144sm6709601wme.23.2016.12.02.22.45.19
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Dec 2016 22:45:19 -0800 (PST)
From:   paddor <paddor@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.1 \(3251\))
Subject: git add -p doesn't honor diff.noprefix config
Message-Id: <E1D7329A-A54B-4D09-A72A-62ECA8005752@gmail.com>
Date:   Sat, 3 Dec 2016 07:45:18 +0100
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3251)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all

I set the config diff.noprefix =3D true because I don't like the a/ and =
b/ prefixes, which nicely changed the output of `git diff`. =
Unfortunately, the filenames in the output of `git add --patch` are =
still prefixed.

To me, this seems like a bug. Or there's a config option missing.

Best regards,
Patrik=
