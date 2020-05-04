Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D6AC47254
	for <git@archiver.kernel.org>; Mon,  4 May 2020 05:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDC4920643
	for <git@archiver.kernel.org>; Mon,  4 May 2020 05:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLFbXqcU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgEDFml (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 01:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgEDFmk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 01:42:40 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFAAC061A0E
        for <git@vger.kernel.org>; Sun,  3 May 2020 22:42:39 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id mq3so3304575pjb.1
        for <git@vger.kernel.org>; Sun, 03 May 2020 22:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o8ff2N3sr1fs7jVoQVJGJadL6klt2nXG+Q+DS0Bnzxo=;
        b=SLFbXqcUx6uojmV1WISsVoO6lh/6mJIsV1vd3/W8dm2AenHtCk4Jjspl7PxhabzVXf
         U12g33r/z/jk6NTjD5PNpk1fIY0B+0rZxhFLwc1ksYW9ZGJZrWgENBxUPmYMOh8PFH7W
         3f0ZIfdy9ulA2+puite40iUI/G1ip9/X1cURKqhSMaczdfDTE/aLaV/rieLOQpHHbQHa
         j05ChGV3p/6eC71ipRZTvU8t8iD5CCWdzfDtgpKOyWtFnHF6maelafIC0QC70yre3G66
         nGVofU8sK3r0FkjNHR9dYSkC/6/+rr8ysc7ATkiPAn0zonKl93FjjLuM3QOUtQvIMAUO
         YkRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o8ff2N3sr1fs7jVoQVJGJadL6klt2nXG+Q+DS0Bnzxo=;
        b=KHT9XbVFzKSRNZW9w5cmBAwYLVajunJoo1H/2Kjpp6oWPh8Et0CHygNePKgjpWEaw3
         j9mCUv6LS+O2GcdgtTp1iRQewYaRuIa6/yvEKRZcT2KA2K6qfM1zmtEPURe6VhZ/2Vss
         7tSJLln/inXBZQTxAJ6nyJ0J32UE65Gd7Qs0t40Ha2aVdmsbcQzRxUQCEvrV5y/tZXnp
         W2dohthf2ySQdoBSEigCpGjb33SQmDtAKx4EvtlopHLCcbvjupD/NERAhKJcOSH3e+1Q
         XAuiGcrMIV9u+R8H0OTgU94/w/pW0y5X9O1UA6+KPuzN930qzj+LCUDPdg96OddydoYJ
         U0ww==
X-Gm-Message-State: AGi0PuZiiwvE4DKAOtfSETW6b5Bri9QJ9tlvqkSA9YYmVwt6dZyjFq2D
        d6Wt1KV62AWwX5r1GUjtHSUZ4+V1Cpg=
X-Google-Smtp-Source: APiQypLYeQrbgDhBMU4nE1F6ExQRX+e9+NRTu2x1c4+vLgPRrXTJUbDXRNjASdvUvp71cLAkGSEPOg==
X-Received: by 2002:a17:90a:bd91:: with SMTP id z17mr16112453pjr.189.1588570958291;
        Sun, 03 May 2020 22:42:38 -0700 (PDT)
Received: from konoha.iitr.ac.in ([103.37.201.176])
        by smtp.gmail.com with ESMTPSA id 189sm7850785pfd.55.2020.05.03.22.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2020 22:42:37 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net, newren@gmail.com,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [PATCH v5 3/4] gitfaq: shallow cloning a repository
Date:   Mon,  4 May 2020 11:12:22 +0530
Message-Id: <20200504054223.11125-3-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504054223.11125-1-shouryashukla.oo@gmail.com>
References: <20200504054223.11125-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add issue in 'Common issue' section which covers issues with cloning
large repositories. Use partial cloning to selectively clone the
repository.

Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
I fixed the heading of this section and improved it overall though,
as pointed out by Junio, there is a bit confusion as to what URL I
am trying to point to:
https://git-scm.com/docs/partial-clone
This is the URL I want to point to.

 Documentation/gitfaq.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
index 875cfa0acd..5dfbb32089 100644
--- a/Documentation/gitfaq.txt
+++ b/Documentation/gitfaq.txt
@@ -244,6 +244,17 @@ I want to change the remote of my repository. How do I do that?::
 One can list the remotes of a repository using `git remote -v` command.
 The default name of a remote is 'origin'.
 
+[[partial-cloning]]
+The repository I am trying to clone is too big.  Is there an alternative
+way of cloning it in lesser space?::
+	A good way to save space when cloning a repository is by using
+	`partial clones`.  A partial clone will clone the full history of
+	the repository but will skip out the entities specified by the
+	`--filter` option one uses in `git clone`.  Any entity which has
+	not been cloned to save space can be cloned	on-demand (hence this
+	presumes that the user has an always-on network connection to the
+	original repository).  See linkgit:partial-clone[1].
+
 Hooks
 -----
 
-- 
2.26.2

