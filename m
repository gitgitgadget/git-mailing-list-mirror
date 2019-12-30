Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3664BC2D0C3
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 23:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0B6D206CB
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 23:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="reMePJRH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbfL3XGN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 18:06:13 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:46641 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbfL3XGN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 18:06:13 -0500
Received: by mail-wr1-f53.google.com with SMTP id z7so33882439wrl.13
        for <git@vger.kernel.org>; Mon, 30 Dec 2019 15:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:date:subject:message-id
         :to;
        bh=SHOeAVeppZKszR8K91oKtJlt0/sF0wLdZV+Dk3lc1mw=;
        b=reMePJRHO0u+wdV+Ti6+0RMzlsMFDhh3uyfxdH3D2q4HJuNRHmdY8OaofVw14JQ9V1
         xvG+BOeYvL28fWFjBxWLTgyISmdz0eL5C3CpYnGG480kh24JkA5swahtgz0qLmKlR+lm
         EjhDFZQEmNch26xcbw0b+QmXTMFshAEjIq86tFN6zjPa/UctoEz7E8C3tXRe5ofkyM6T
         o1KzRCrmuT7VxRdkUdfyH19GEo/khIPAQKbifbJVg9LpY5Fa828sUk7zOjDgAQjYE9zh
         CtsP0UHVBSFuTwTAUVQv5k6vMKeW2NJF3DQk1sNQM0PdFU6PqKB7c1Di6J9dNu6Mja5a
         oEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version:date
         :subject:message-id:to;
        bh=SHOeAVeppZKszR8K91oKtJlt0/sF0wLdZV+Dk3lc1mw=;
        b=P/qwqDR+nLTrQh6EYqbnZOpmIo3eLqknEKJijJz8/KjCplBs1osXAnqifoFVwIfbCZ
         /DdYoKyM/zD9TGbEwTVa1lhnU8OlY9pdm9+0oPHsbfps95sFTm2G2G/vz1k09eGTL/lx
         7n+UAy7Qi8nQYrgVQTZIE1HDofFsTpZHZhbBalbYiMSy/h20CHxJdmKH7Ip5F5mlsSZ2
         zO+my9sId1SQnTxpKASzvT1Gn5XIND506eKq3liaNKQN0yFUa01Qo48iu2h/E53tArva
         RlX8tOBalELWV2Jh9IajEMScXniywkk48H3EGmnuWVfwFOtkECY0JkurK80OJpdVZr4o
         g5DA==
X-Gm-Message-State: APjAAAXro1/+h6un2lkPNSeLh//ebuS1qnWa8quns1qHtvuWWudj8S0z
        uh0rjQ54dcvIDJ9G5QpiGOQh5w6e
X-Google-Smtp-Source: APXvYqw8qPBc8/nsI3gEK9AdaWX4uHsi7VRsHbnkcrkdvE+BPP76U5eLpCJ2I+269ignbvV/JHR7NQ==
X-Received: by 2002:adf:fa87:: with SMTP id h7mr66275035wrr.172.1577747171314;
        Mon, 30 Dec 2019 15:06:11 -0800 (PST)
Received: from [10.11.23.192] (mail.inntalerhof.com. [87.247.212.29])
        by smtp.gmail.com with ESMTPSA id t5sm46514392wrr.35.2019.12.30.15.06.10
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Dec 2019 15:06:10 -0800 (PST)
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (1.0)
Date:   Tue, 31 Dec 2019 00:06:09 +0100
Subject: "gmane:" search undocumented on lore.kernel.org/git
Message-Id: <03879A6A-2E8B-45D9-A06E-51926AC949F9@gmail.com>
To:     git@vger.kernel.org
X-Mailer: iPhone Mail (16B92)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

I just noticed that the help page on lore.kernel.org/git does not mention th=
e possibility of searching for messages using Gmane id=E2=80=99s, as the pub=
lic-inbox.org/git help page does.=20

The search works though, it=E2=80=99s just undocumented, so I thought I=E2=80=
=99d share; I don=E2=80=99t know how much control we have on the lore.kernel=
.org public-inbox installation.=20

Cheers,
Philippe.=20=
