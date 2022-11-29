Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE44C4321E
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 12:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiK2M6N (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 07:58:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbiK2M55 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 07:57:57 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034196315
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 04:57:49 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id p24so9571112plw.1
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 04:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HP4l8Bl1RnD2pWgR3dUzx8yKypmxLuGTneBdWRRWPhg=;
        b=O4S4+QocwAm8beNsQVWAQDSUnpG+FUyvpQJoXKDWB6rT1SEwxOHTdnoMczTGP7t2Y/
         ln/213B78YHO4EwekIFbyzpbOB6C0mz7FOPyZ5zhvzjROiDRS54ZIodlcOWt642mlrjB
         NQNZzFRDwI1pToBupsr4SQAUoCIxLQ1ND0t2EJ9vW97t+lGHm/2kx/DrLk9bhLEPq8+H
         XDnSClHQ0XD64r2ZYEadcu4p5bMvYtWX7OMUyrkNbcoRcpWXCQcSkv0yfKJjE0pwQKpi
         rwdmcpB1g+CnA6a/cJZADHqAc691dBJTQGpWL9eiqUWhnuiYTasl5Muugi5oWOGfXDsL
         fZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HP4l8Bl1RnD2pWgR3dUzx8yKypmxLuGTneBdWRRWPhg=;
        b=6eZcYuD50tHyCFFmJPmKjtVsgEWjgTomdAWgKgCaa44DPQHj11uf4sUvFXHFaFXcJR
         K/8y40j1M6VGY4MwmadWIMvJBP2c1QSidn6/tKYouuwpyVtmW+4AJU5UTNIW+PznPJm4
         WIPnZCiBKRmnBfgMIFSS/rrp5W62ol86YjARLwfA9WeiOLw8ecMy5fnqlgnPkpeqgB+1
         9EU8YK7Kq3tXmD8rP2hWIICD2o4yQQRq1Ixf/0AiSEElAFh2DeBY0XeZoLUEm3Fkdq+Q
         qietoJWtaGXldMl0t6uLqGAFFMLWRNq7+R7KYvMyeBe60+reaCfwC5Oe8Cj7MSveelxb
         TDlg==
X-Gm-Message-State: ANoB5pmCIAZo/vVUXA8LaOdnvzTV0cqgC6cQqy6z/CZiiYSaNoMoLZVg
        o9FL4zcmVWuhWNlmuGyK1F8uTKHJPrM=
X-Google-Smtp-Source: AA0mqf70Ou499MLtqQrLxSz+MvAfrrZ8tpr8Rk3W5CMclnV1Ve71WnJN1oWHB+wDA9rY6ezt50GuLQ==
X-Received: by 2002:a17:90a:b703:b0:20d:7716:b05f with SMTP id l3-20020a17090ab70300b0020d7716b05fmr20234009pjr.104.1669726669112;
        Tue, 29 Nov 2022 04:57:49 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.61])
        by smtp.gmail.com with ESMTPSA id n34-20020a635922000000b00476799699e4sm8360105pgb.30.2022.11.29.04.57.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Nov 2022 04:57:48 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v3 0/5] notes.c: introduce "--no-blank-line" option
Date:   Tue, 29 Nov 2022 20:57:38 +0800
Message-Id: <20221129125738.81212-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.38.1.385.g28306b7e8d5
In-Reply-To: <cover.1667980450.git.dyroneteng@gmail.com>
References: <cover.1667980450.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I personally do not have much opinion on this topic, other than that
> "--no-blank-link" would be a horrible name (i.e. uses concrete words
> to pretend that it clearly describes what it does, but is utterly
> unclear where these blank lines are etc.) for the feature to help
> end-users discover it.

I have some a candidates might like '--newline' and '--no-newline', or
'splitted-newline' or 'no-splitted-newline', but I think the latter is
a little long.

Thanks.
