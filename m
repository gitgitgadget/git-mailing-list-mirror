Return-Path: <SRS0=NngS=CY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D87C43461
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 12:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFA74206DC
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 12:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgIOMaj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Sep 2020 08:30:39 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:59599 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgIOMBm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Sep 2020 08:01:42 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N8nnU-1kWuzn0IVi-015p7o; Tue, 15 Sep 2020 13:54:09 +0200
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id 283971E01E7;
        Tue, 15 Sep 2020 11:54:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pmBaIrEjzL57; Tue, 15 Sep 2020 13:54:07 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (unknown [10.10.5.94])
        by mail.cetitecgmbh.com (Postfix) with ESMTPSA id DC84C1E01E6;
        Tue, 15 Sep 2020 13:54:07 +0200 (CEST)
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)
        id B6A3080518; Tue, 15 Sep 2020 13:54:07 +0200 (CEST)
Date:   Tue, 15 Sep 2020 13:54:07 +0200
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] Pass --ipv4 and --ipv6 options to sub-fetches when fetching
 multiple remotes and submodules
Message-ID: <20200915115407.GA31786@pflmari>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915115025.GA18984@pflmari>
X-Provags-ID: V03:K1:KgBDuY/g9+9f6eMqIJwn3UlW/NlwWeRBZIFwDvN/5i0Hc7Q3pRA
 E2rHs1bUYGMA9J7FA8nQKLO93G/i7X7yyZeJ6pyQlOr4y9u4dpjWX+Afn+6t1rU5GwAlJ5o
 TkM/ag1NEpRDb1p7qhjg+KekxWoeU5zFIILd4pxHmooPHLhes288H7bHUcW/wr4ED41MYnj
 nZl3r42nnv8R0zTz+rUWg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qdaHdPONYNg=:TQlk5V5mNvu+Pyu4J5P4Eu
 5j1atY1F0rM3wi69woJRvfa1IDP+vUqITqds7PVRa0aXMkABhszv1mHO1NwZCVcJ5Ofva97iC
 O0tnPnYU542jl1zG9VeH9RY38XnrZUgeBZ2hseKXoskcOYNZBi0JOAttd9+1998NpTNSWsI3A
 sfo50v7kjQeFI63Oi4UCV7J+d14CmNmofke2z1vk7MQrdNByjJBPn8W2VYg4qsh7mzjUnAjBw
 ntY/PhCqFgHfPo1xSTMYhIIeOb6CazsE57yp1v0FoFNMLa/Bc925ClXb9bAMSHYajV4IJsGfB
 qH8hubBzUzG3j+Ox0LJWZ7lpqU5Cl7nfk3fh1NJ5bepYSmBRsOOp4coFXcCN6YNsDohv7CDJS
 ViWErQqe1syfO0BzhYDdU00F7J0FAYDINqgJJTB/HVEHd+pxvQfVVKV4afiygHQpQyJrgvduW
 YeIiQEG1mhWw+vy0CMu8Ia/GVt8T1pmDeswf2L379QlZc9W4TxYYW3gtbfEe5ZSrROZwKeaCO
 7gq4IP/+NHC3Mn/zChUtUdYjhXOdyGykwjSxvIC8AHkdO+k3OQFa5t7T+PG0+Mb1F9pUnlCyl
 ONR7PeXUqugWR6kI5NXMyQAqNZBmZXJo9pD5/0PWT5jjQG1tmCZC7NBCp8XtepBEgGU/yjtkf
 A7UISbGwmuJONI7wdkzfVA9RmOYx4DKfZKFOinP6AglaxDrb9QMAYfz4ldVZYPOC3smOtCvKt
 Ma8+2t0qDYTVp9jbTAiAPRLvwrQj1g1GQM827Gue7HUrJmT92Tf+SvciYcARYRdMcGwhZhU1T
 o7eYOBseqa3QO5AqRK0ug4Wp3TjSQzsEZdh/f4uEmLilyrqV7IH1TIZaVD4l29sHBIT2HhK2v
 ToD+sm4fqrfKwc/1wDrg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The options indicate user intent for the whole fetch operation, and
ignoring them in sub-fetches is quite unexpected when, for instance,
it is intended to limit all of the communication to a specific transport
protocol for some reason.

Signed-off-by: Alex Riesen <alexander.riesen@cetitec.com>
---

 builtin/fetch.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 82ac4be8a5..447d28ac29 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1531,6 +1531,10 @@ static void add_options_to_argv(struct argv_array *argv)
 		argv_array_push(argv, "-v");
 	else if (verbosity < 0)
 		argv_array_push(argv, "-q");
+	if (family == TRANSPORT_FAMILY_IPV4)
+		argv_array_push(argv, "--ipv4");
+	else if (family == TRANSPORT_FAMILY_IPV6)
+		argv_array_push(argv, "--ipv6");
 
 }
 
-- 
2.28.0.21.g09e033b31f
