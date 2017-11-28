Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0253D20954
	for <e@80x24.org>; Tue, 28 Nov 2017 21:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752210AbdK1Vca (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Nov 2017 16:32:30 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:45036 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751701AbdK1Vc2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Nov 2017 16:32:28 -0500
Received: by mail-wm0-f68.google.com with SMTP id t8so2311616wmc.3
        for <git@vger.kernel.org>; Tue, 28 Nov 2017 13:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x6CsFR4qqXXM9C1unoza4TyKv1IEaHTXH3Fppp9C9Jo=;
        b=aPFXg3nakEtVJtehfSm2bQw+PlHRqNaDoB93ImdAGH/mCOJlDzRH5Du3KDK5unIGr8
         natAhdENbvJc8Axo3q+nFs9pnvnkOC6ZO0Sa++BqOju0LazfP8ffGlKlzjh4sDMBArYw
         qMF/c7PC9k9Wb06tNv7jhtf2vNEtZzZg5FoNcIpYa+dxwFHYoBdXq7y6iUNqnmS9ncbq
         aNc+n69DGv7+2eLDnNQY/iyoBvucGgHRiHULMck/MHdIWfTA1ETYX9JjoN2N81sXm1Pz
         c3wpCH+CFqfn/Lh+8trRA8S/gf+RaOxVfITh/ZgvfreXy5Z28LC7pD3yZZm0Um42eXlU
         Xt0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x6CsFR4qqXXM9C1unoza4TyKv1IEaHTXH3Fppp9C9Jo=;
        b=mCh87K+/vtV4EihPqgieSdAQ8WChSX9KkfK9ews4mXtLKLPD/AHReFZd0gKF4snDB+
         XVE48Re/k9QrDp35vAwgKXRBhTnNrKEup4WZNFCHEQn3DUxgeFORwWSg7I6B6qLMMQYQ
         0PbFfFD9tMAsLZci1tRFnDk39hu96ClievigN0CyepUjwiG8PfymAMTC87ycollCPHGa
         qM5kWptXhNDDvRIncoQqJCv+OCfh3tgVeVa9n1ao2RXFks4ZAuFRrYYmbwP1tT8v5ZSY
         8D1vaYhQSFjx7NSFL57TmlP8Vh7xxX+1WKmRvOGyAMugJ299Cm9rZrp83w+sOgjtVodC
         8O+g==
X-Gm-Message-State: AJaThX556zcQHqBWvezBjKZbcv3a02EM9w/4742wu3fYyEoaId59FZEK
        v9YkAqlAobuvlZgFmnVojUWfOQ2X
X-Google-Smtp-Source: AGs4zMaHPxbn6+7Aq0bp8bA4t37WTZ/DwYjjHHfSxysQWNyzbxFFA2wFWijiG+JF9HSbALvz8pdaGQ==
X-Received: by 10.28.155.200 with SMTP id d191mr885205wme.31.1511904747238;
        Tue, 28 Nov 2017 13:32:27 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id d18sm147361wrd.54.2017.11.28.13.32.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Nov 2017 13:32:26 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Takashi Iwai <tiwai@suse.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/4] Makefile: don't error out under DC_SHA1_EXTERNAL if DC_SHA1_SUBMODULE=auto
Date:   Tue, 28 Nov 2017 21:32:11 +0000
Message-Id: <20171128213214.12477-2-avarab@gmail.com>
X-Mailer: git-send-email 2.15.0.403.gc27cc4dac6
In-Reply-To: <20171128213214.12477-1-avarab@gmail.com>
References: <20171128213214.12477-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a logic error in the initial introduction of DC_SHA1_EXTERNAL. If
git.git has a sha1collisiondetection submodule checked out the logic
to set DC_SHA1_SUBMODULE=auto would interact badly with the check for
whether DC_SHA1_SUBMODULE was set.

It would error out, meaning that there's no way to build git with
DC_SHA1_EXTERNAL=YesPlease without deinit-ing the submodule.

Instead, adjust the logic to only fire if the variable is to something
else than "auto" which would mean it's a mistake on the part of
whoever's building git, not just the Makefile tripping over its own
logic.

1. 3964cbbb5c ("sha1dc: allow building with the external sha1dc
   library", 2017-08-15)
2. cac87dc01d ("sha1collisiondetection: automatically enable when
   submodule is populated", 2017-07-01)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Makefile b/Makefile
index e53750ca01..8fe8278126 100644
--- a/Makefile
+++ b/Makefile
@@ -1497,7 +1497,9 @@ else
 	LIB_OBJS += sha1dc_git.o
 ifdef DC_SHA1_EXTERNAL
 	ifdef DC_SHA1_SUBMODULE
+ifneq ($(DC_SHA1_SUBMODULE),auto)
 $(error Only set DC_SHA1_EXTERNAL or DC_SHA1_SUBMODULE, not both)
+endif
 	endif
 	BASIC_CFLAGS += -DDC_SHA1_EXTERNAL
 	EXTLIBS += -lsha1detectcoll
-- 
2.15.0.403.gc27cc4dac6

