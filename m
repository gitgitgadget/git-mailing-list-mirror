Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 258AF20248
	for <e@80x24.org>; Tue, 26 Feb 2019 10:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbfBZK7C (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 05:59:02 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43374 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfBZK7B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 05:59:01 -0500
Received: by mail-pg1-f194.google.com with SMTP id l11so6037319pgq.10
        for <git@vger.kernel.org>; Tue, 26 Feb 2019 02:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IL+dmwGJDfLu2OWk40x7pIaRJffZgRpj80hsHtTNC8g=;
        b=dySrvpQGzEjLlDFYS4lpFdGK/tuhvdouOeH8AqAbtOGmgqRjNYvwKjVG2ahxD+ZmoW
         IOBagwNrpu9Dgz48GpRhHLthnj36LZ2qRKMIGcccNLqgL/VUyCFG27sqcAYan2Ipzxnf
         meMj0dPrSxy1BidPAlQDyr+9+XGGHkje/cp4uLd2CAah2oI9xAcRUlDoOQ1AO9yO2VWF
         c4ALv5QWZhFW26TVM88Lch5Y4Uf8GbZxQdyJunhro+AZg5yuTvo2XYkTdaZmA0f4OjM+
         +Ay3wtfO3MzuAEeXVS+XTJSv4q9CNKGhnZcu3wxQNOx9o/SGJ2zv3Ctmysrxv7I5UoRI
         q/hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IL+dmwGJDfLu2OWk40x7pIaRJffZgRpj80hsHtTNC8g=;
        b=Uk1stBGJPIlYFPBs5WpEiGxup0te3Dx6GN4SDGjXmohoxlqSMa6v3AVZKc+DgwfTz6
         RgwS5Cg5rlHgjEsgHUu5TseChWjMq3N9zofQ4D1Vl35QbLkI6QBNt78Mumn/AZDYZ7Xo
         k2CqdExXCRq+5ne6vD+8wrbM6TX/BzuW6BG2HnNOiCHfi+kTPfpCYQH2NrLbfIvUOjSs
         MZPGQTcd6dcHbZVy1/wEWzZQl6SvQf4ARn4prPVkgJtXtf0zHBOQay3hsEZ7Vb3Fs4iS
         rPxtNUgKewWCc3Wt5lisYf/Z5gGCWtEMt0pvNG/ZrG1UfdP+e6F4RaNY72LNwV7a4Ge+
         3lhw==
X-Gm-Message-State: AHQUAua+E9joZEc36XJAY25AOebx8KXWKU/Nm2BeDhpIu4IU6apKvZBA
        jVRsYR09zNLy19qkUZxcb18=
X-Google-Smtp-Source: AHgI3IaNAmcid4xr9DnTPUIEvkuE/sTUBP39b5yDHoCoPPQVl2DL4J0d4uFSi55Ii7Qr1eq2yYr2Qw==
X-Received: by 2002:a65:5bc9:: with SMTP id o9mr23599504pgr.42.1551178741085;
        Tue, 26 Feb 2019 02:59:01 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id 11sm18971404pfn.7.2019.02.26.02.58.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 02:58:59 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 26 Feb 2019 17:58:55 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, hi-angel@yandex.ru, sunshine@sunshineco.com,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v3 0/1] worktree add: sanitize worktree names
Date:   Tue, 26 Feb 2019 17:58:50 +0700
Message-Id: <20190226105851.32273-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1.337.gdf7f8d0522
In-Reply-To: <20190221121943.19778-1-pclouds@gmail.com>
References: <20190221121943.19778-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v3 is rewritten to use refname_disposition[] to cover all invalid
chars.

Nguyễn Thái Ngọc Duy (1):
  worktree add: sanitize worktree names

 builtin/worktree.c      | 37 ++++++++++++++++++++++++++++++++++++-
 refs.c                  |  6 ++++++
 refs.h                  |  1 +
 t/t2025-worktree-add.sh |  7 +++++++
 4 files changed, 50 insertions(+), 1 deletion(-)

-- 
2.21.0.rc1.337.gdf7f8d0522

