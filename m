Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B64820705
	for <e@80x24.org>; Wed,  7 Sep 2016 11:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757362AbcIGLVF (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 07:21:05 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35152 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752232AbcIGLVE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 07:21:04 -0400
Received: by mail-pf0-f177.google.com with SMTP id w87so5857803pfk.2
        for <git@vger.kernel.org>; Wed, 07 Sep 2016 04:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+xtFbn1OFknUZHBjrw/CTsCSu/HmSgpF81bX6/fhTHU=;
        b=yAcs3qJ+Ch/xq/Beb+4yjGGwB0vqv/eKVBnkOvV7nIVWOx69DaUfdGUE/7lRzhBcwu
         Sf/JSXGMNgx0JfsEBbhwEFwVyEluwIyW2e+BNXKWk87LoTCRqNBjOh7R4mWYZgHIDtB+
         yzETMSYJOVGCcYEfoGYP5KqQKZ4OnRLBmA+gITH8O9E2i6HT7DXuAuljyCC4P90bxRjf
         b1XRmooghnnZ8bLE/a9MOCcwjkAoCYs/Day2kmlb8J+PboExyGQkyLA6eAs1XUqnBeg8
         +qUBEhWs9N3azl6+zpCWJnEXIwXVGvijnCC58mbLoTLp+fxkAjukuyAf2MdzfSphW1sx
         1rfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+xtFbn1OFknUZHBjrw/CTsCSu/HmSgpF81bX6/fhTHU=;
        b=m4cZhTIujPr3mPxKwzgOvONFGw4UOy/tZZUcTvEHE9B+7JoXJDj5gKw17IQ4AX+KOK
         mkXHcEkfvAa6Y7zsGVK5VSzVvoG9SB8U8SakVeW+uWcGHwftVCu0VeQTcw558dc7Tz1p
         3F1qR2rL52rOsSKg9tZGc/IMUcdxRngyY/tt03l1vhG0jH6jlBWBK/R9W6bVyXXvNFuA
         fEJ9X6XXxKVKiYr0LEHjuESV7E/kXx8oV5A5tWo76CCRHBiBL0luVb3fNfHlOP6v2HtA
         NNoJC1epqZ0V1nFhe9UpwQelPMvt+WHYEx46zcgag2SrImx9gGxMcwVCEjHTm+MIppL2
         ftXQ==
X-Gm-Message-State: AE9vXwMGAEsEgANMpEm6gb9UGYQfElNA2IXBKFwLt6yoMb2M3R/bBnrglTpnDmHPk0zUig==
X-Received: by 10.98.107.198 with SMTP id g189mr43975648pfc.14.1473247244468;
        Wed, 07 Sep 2016 04:20:44 -0700 (PDT)
Received: from ash ([115.76.139.213])
        by smtp.gmail.com with ESMTPSA id n80sm33723184pfi.25.2016.09.07.04.20.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Sep 2016 04:20:43 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 07 Sep 2016 18:20:39 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 0/3] fix checkout ambiguation in subdir
Date:   Wed,  7 Sep 2016 18:19:38 +0700
Message-Id: <20160907111941.2342-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160822123502.3521-1-pclouds@gmail.com>
References: <20160822123502.3521-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I need some more time (which I don't have) to convince myself about
the "git checkout :/abc" patch. But these look like good bug
fix/improvement.

Nguyễn Thái Ngọc Duy (3):
  checkout: add some spaces between code and comment
  checkout.txt: document a common case that ignores ambiguation rules
  checkout: fix ambiguity check in subdir

 Documentation/git-checkout.txt |  9 +++++++++
 builtin/checkout.c             |  6 +++---
 t/t2010-checkout-ambiguous.sh  |  9 +++++++++
 t/t2024-checkout-dwim.sh       | 12 ++++++++++++
 4 files changed, 33 insertions(+), 3 deletions(-)

-- 
2.8.2.524.g6ff3d78

