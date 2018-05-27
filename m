Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2F2B1F51C
	for <e@80x24.org>; Sun, 27 May 2018 08:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935648AbeE0Iin (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 May 2018 04:38:43 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33203 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934160AbeE0Iil (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 May 2018 04:38:41 -0400
Received: by mail-wm0-f66.google.com with SMTP id x12-v6so38648836wmc.0
        for <git@vger.kernel.org>; Sun, 27 May 2018 01:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AijUdHaqcDH5BIRhu56zEi1qaqa2YhzUtUCQEm7nTBI=;
        b=Zh4pwBWzrqVgs1NCtkmHyxVUum1scWOPbrm0bpUjMq5nD03zqzexnzi+jhthdrzRsr
         +57OXIj3wDHmf5fer9FBO4TIFvqL+eI4KevT8zZkNeHIyyVzDOeU6bV/fxR3x97AN9J4
         KL5Qlq1wtlUvNl5plBvKB88ADfLUctvdjPhcbGLmmmkMZT+Dqnh9Y+M9iFePV9yG9jrK
         bl+f3V/4Flmgbt24YVgWVNYqwCrxt7kcyLdFshzaEb67JCd4x2hfgZP0GX6BLX6vUbPG
         /HZlK9uti7cxdiS1mnXTKh+IuO10Vyt8bSqcMO9qqsGyfVfbwlF0rqE23zZp/XAXQaAT
         mnXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AijUdHaqcDH5BIRhu56zEi1qaqa2YhzUtUCQEm7nTBI=;
        b=t5LlsigGuOr0zmm/XaZyIj+FvAoHcR7vqGvnxOQlWF9OPcRrZr8RxXarW4JFvhrVGv
         eEMrUB9BvI3+/ke1/OCTI8ikF/0WuDyhzIY4k+CotBPbwD2O33RoiKPCToX92wG2ir7l
         soC1a9iOQfWeVdxK1XeoeCJkKepk9bay+1xhCIotALGZe/lrUbgKIz0CgjL6tAVb/8eF
         cXVqbtLIlpOd2pmrRy2XA7M5lWa66zkdH6OCr+JuxuZj6bLsh6XTV2dzQ3e6DUe2/iAf
         rD9iKZWpdIOv0lnwckhQuEhzObUev+CqSVe6kXeWDxyLOAzGbWBNA9OpIbON82Pwb9So
         rgSQ==
X-Gm-Message-State: ALKqPwcx0BQKieTHiLTN+6nVCg0cFPh2w6vmaT+88RxgUDTffZxobhhR
        IPzxrSj9v0KMTP5lN52cdJY=
X-Google-Smtp-Source: ADUXVKL4Cy5h+rW1WcK7fAjxf11SUubstDa1nAdX3CIRvHQFx0zMVhDZsal8vSKUm45hx8nli83Puw==
X-Received: by 2002:a2e:1d53:: with SMTP id d80-v6mr5663720ljd.104.1527410320501;
        Sun, 27 May 2018 01:38:40 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c1-v6sm5297468ljk.80.2018.05.27.01.38.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 May 2018 01:38:39 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 0/3] completion: complete all possible -no-<options>
Date:   Sun, 27 May 2018 10:38:25 +0200
Message-Id: <20180527083828.6919-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180417181300.23683-1-pclouds@gmail.com>
References: <20180417181300.23683-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The RFC was here [1]. We have started recently to rely on
parse-options to help complete options. One of the leftover items is
allowing completing --no- form. This series enables that.

Changes since the RFC version:

- There's no magic numbers (previously we keep 3 --no- options)
- When there are some --no- options hidden, then we show --no-...
  instead of just --no-

[1] https://public-inbox.org/git/20180417181300.23683-1-pclouds@gmail.com/

Nguyễn Thái Ngọc Duy (3):
  parse-options: option to let --git-completion-helper show negative form
  completion: suppress some -no- options
  completion: collapse extra --no-.. options

 builtin/checkout.c                     | 10 +++--
 contrib/completion/git-completion.bash | 58 +++++++++++++++-----------
 parse-options.c                        | 58 ++++++++++++++++++++++++--
 t/t9902-completion.sh                  |  5 ++-
 4 files changed, 97 insertions(+), 34 deletions(-)

-- 
2.17.0.705.g3525833791

