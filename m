Return-Path: <SRS0=dClv=3H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A302BC32771
	for <git@archiver.kernel.org>; Sat, 18 Jan 2020 18:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D40324695
	for <git@archiver.kernel.org>; Sat, 18 Jan 2020 18:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlfLITuh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgARSvP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jan 2020 13:51:15 -0500
Received: from mail-qt1-f174.google.com ([209.85.160.174]:39729 "EHLO
        mail-qt1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgARSvP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jan 2020 13:51:15 -0500
Received: by mail-qt1-f174.google.com with SMTP id e5so24508884qtm.6
        for <git@vger.kernel.org>; Sat, 18 Jan 2020 10:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:subject:date:message-id:cc:to
         :mime-version;
        bh=GolLDF9tZlKUspo67ueq+L1RIIBWLWYaJqHQnbYv2zs=;
        b=AlfLITuhZlavIx4F1psxTkzL1tQllxJppbA+97DkSkazAVDBYjVGqXzQnjt+ST5HfD
         PmkEQyj28oji2nfCQ5Tt82gK+ElTq4+sX/5FyeUoAp47zP3oUv3IOBaRGcminKyxFa2v
         Nvi7gk5UQduB5wx4IRMpcDJ2t7e1/97+6pK8SLzyhqtzlCLjjh+Ej3pgSviH/kMlusPc
         3Id20y8MGNeIF4amor7vbTZuoaMbhAsNTVgO5f+nPi7Jo73TSftbIflFaElf3ij1RmQT
         jZTywltmi32/wu5OF9g8cveL1cYQg7yEqvt2WBo4+a55toFLm+mz+BxdKBB8UfKRMbj7
         Gg5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:subject:date
         :message-id:cc:to:mime-version;
        bh=GolLDF9tZlKUspo67ueq+L1RIIBWLWYaJqHQnbYv2zs=;
        b=KhuYPH+IxtO5pXMtkhhG0vYoH+JK6skueL7GSqj9Fo5tNWp99YwX54lu8sN2KNqoil
         2pxsvwxPV88d41z+kJX2FKetFsVRK+Rk3Z81METMuQ/NDU6kArBHXeK9pjuYcR5YB5HN
         y2DgoWO3PU4kGVgP8zdgV+bx8f5yvl9Vy0C/8NWSJ/f0x61DIeBHxnyY4DzDGjfStIOu
         g9QtvUmErbcTQQ6mPJhrRtzsDKH8YCYQu2TiViM5BBQEjl1Mz/7CzMGMxtn1JWq0uCT0
         aO92wNUzV7QbZikLhtS5Ux8OERtLfxbYgwLdgvQ8roJpHPlM87Ncbn2s3F1LsSbKw5w9
         BWvA==
X-Gm-Message-State: APjAAAUrTT7QHd+4xaU4O3NWvGbVhSYTUigFvc4+Jo9NJ/42mCffaDoE
        +QW6ipWrD/j2ZNrzkTAyALM=
X-Google-Smtp-Source: APXvYqwOPY6gqAVGwMmErXalma3YYHhYDyTrT27RMhPKuMvecVx05ZgHzSr1o1dJzGtN3r27AOHWaw==
X-Received: by 2002:ac8:742:: with SMTP id k2mr13111539qth.302.1579373474103;
        Sat, 18 Jan 2020 10:51:14 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id k50sm15090421qtc.90.2020.01.18.10.51.12
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 18 Jan 2020 10:51:13 -0800 (PST)
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Patchwork instance "Submitter" attribution and GitGitGadget
Date:   Sat, 18 Jan 2020 13:51:10 -0500
Message-Id: <75987318-A9A7-4235-8B1D-315B29B644E8@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de
To:     jrnieder@gmail.com
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

I=E2=80=99ve noticed that all (I think) patch series sent to the list =
using Gitgitgadget are attributed to Dscho (Submitter is "Johannes =
Schindelin via GitGitGadget") on the patchwork instance [1]. I don=E2=80=99=
t know if you are aware of that or if there=E2=80=99s a way to fix it in =
patchwork=E2=80=A6

Cheers,
Philippe.

[1] https://patchwork.kernel.org/project/git/list/?submitter=3D182351=
