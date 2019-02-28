Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0A3320248
	for <e@80x24.org>; Thu, 28 Feb 2019 21:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733082AbfB1VnW (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Feb 2019 16:43:22 -0500
Received: from mail-yw1-f51.google.com ([209.85.161.51]:37273 "EHLO
        mail-yw1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727601AbfB1VnV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Feb 2019 16:43:21 -0500
Received: by mail-yw1-f51.google.com with SMTP id k14so12361170ywe.4
        for <git@vger.kernel.org>; Thu, 28 Feb 2019 13:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=publicis-com-do.20150623.gappssmtp.com; s=20150623;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=huQAxDW0+8l3C6T+WYiS9wSW/lrXPMpxlXASepfgxY4=;
        b=VSFXCTcXvytgZV+/a2kPqXYXePb8aXUAyQ6t16bh+N5zzQVfOVOnjGZNK8lHFDjhAe
         RRffbPoGCoyD0niNP6o7Jbe012wrwiqfsd30IoJHF7mXMnyU5dvCOt/LUn9RSFkc1WlC
         /yz05jLP2h8UTjRduIbCrQxDXCHkpeV7kqFYl7rQUg0g2mF7kdJP+FL4kwXjEe4AIK9N
         5sb5JWapHR+8pit45G1LXm7m/WwvBfkv56U/fvjcbPKCC6i5S1/T5Ir3HCBRvVlkGUh5
         qlSADxr3FGnnBT2eeyaDQHHSxZbXIKZzGQ1BELqcAX7uCYe/n2hjP3k5Y6t2Jmn3qGqt
         QH1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=huQAxDW0+8l3C6T+WYiS9wSW/lrXPMpxlXASepfgxY4=;
        b=sYS+zTvcFnGnp+vDr5k6z5cJFyTZGrOeQnpSc/QA80WNHdsM0ODxH8sbNl/MlP+0AW
         3mqy4nM8n252nbzO/nQnvrpGkY6UuqKPESmQ4l997hKduw22Z+S93MbMNvbEdrKQFAVk
         9+qNk5qMmQqFf7DvxoKRPHky61sO8RpmTW2eIuWJr7UjWlnN+oVVjWSpvBDUMAvg23MT
         W7qrYnlti7ke75X8CZhzmf1HvEyfOGTRBdPyn90uuu7GxhacgmYEb979EuJIUoFqPKiC
         jS0oTnq99z2bW5C+jwQ0iYz6Me8fHqgzQTWiAyoDg+FYYwECe2cqs60dl8ZNTso1ijhL
         BcIg==
X-Gm-Message-State: APjAAAUaIYQDbd8aPPCKUZr12mRPf+yyaal5hIiQGU8/Jqjt4oWUTQp+
        gUtabZOTdS2L498HOglnhUXK0N4qqVo=
X-Google-Smtp-Source: APXvYqwnR5k4pdsQbgXFKP5Kkx5WsMGP3y+iSfkSvDP00ExMYNj7r2x48Q8ggNMRF2Qk62/tH+XGeg==
X-Received: by 2002:a25:80c4:: with SMTP id c4mr1504073ybm.146.1551390200253;
        Thu, 28 Feb 2019 13:43:20 -0800 (PST)
Received: from [152.146.78.37] ([148.101.181.146])
        by smtp.gmail.com with ESMTPSA id b188sm9180650ywa.58.2019.02.28.13.43.16
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 13:43:16 -0800 (PST)
From:   Manuel Guilamo <manuel.guilamo@publicis.com.do>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Prevent reset --hard from deleting everything if one doesn't have any
 commits yet
Message-Id: <15568DDA-F501-48C9-A1C0-97C72C29DA23@publicis.com.do>
Date:   Thu, 28 Feb 2019 17:43:15 -0400
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3445.9.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I accidentally executed git reset =E2=80=94hard in a project that =
doesn=E2=80=99t have any commits yet. git erased everything, everything =
I=E2=80=99ve worked the past week, I believe this is not a desired =
behavior, considering I=E2=80=99m not able to undo that action, because =
git doesn=E2=80=99t have any history whatsoever.=
