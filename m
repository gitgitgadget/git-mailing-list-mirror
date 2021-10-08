Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66DDC433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 21:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AABA860F5E
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 21:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243409AbhJHVKa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 17:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243398AbhJHVK3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 17:10:29 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A705C061570
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 14:08:33 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id 2-20020aa79102000000b0044c216dd8ecso4975943pfh.18
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 14:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2Bg6Smsefxe/mCrHnotq+16z95fJQIxNbww+rLENA70=;
        b=CjfVElZadedZDmGcB7HqNIInwVLLG67NWjR7oc6pSub1arAxWs1/hplk77GP1tKxnV
         XFFKRwvhqWB0/dHTos+Frm7c/xO55j2bmPFmhTwTWSmAH3/ODn4nek1tMn/trRsifop7
         MMeympt0BIer7RjHTB9b4vd1B+E72ubs52c2WfOKtTaqxEOyIQjGPXG3MtBR4bI1FISk
         RBJOZtlDqw+1C57xHal4595+kkRXqsFLH1gclbakDvA6CQ02+enaizFeLa5ptBsVsSCY
         uBi0Npbn9mSPdrcMLEHO6/xeiIny7+nD0/Efw3bQFeYbtvsryw8XIM5+sEj7ARnoTJ3l
         HSOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2Bg6Smsefxe/mCrHnotq+16z95fJQIxNbww+rLENA70=;
        b=3dtjU9FCG7NcYTqG3Cs6Muk09DHvMJHlomplJdAesliED70tYc6Bi6ZGo+Z+D53Kzg
         DqykWDEq9uHy/d67jJCyHHeSKFFaEyLAmsSqk9f9oMhqvScroIyglAYbgQPrTXggICTy
         fmfkANaDTC7xEOm6sGtuREKW96cAZDIdvHAORlC04jCh1eUBAlW4KTyOAjniWH+JQ2T6
         pmktptjH4p9dHHGhj6yktnHyqGH3U5W8rgJlSAvDicp5RH/CoxtzdDZi6fB9Ekd8lUAT
         pFOYHow236dx4Y3h/Bj8g/PQftJUaXVzGlf3kZ9mkrTQm76n+9dyMwU18Mvftconhbmr
         vPFg==
X-Gm-Message-State: AOAM532wu4nUHiXA+K0EAoBYFvqOOe+0kS8kHod6mTFBi/eEARbrv07u
        Ljhr8d/l83nbLhdtrmdo0g+73TSWjf3h7jcN97jFJiatJZRfG0KZpTLLCy/bZ/SKvdO/VSYkV1A
        Bj0z/eZXLArOhom9acPlR30GIQMLRT4S+DgbIcxa5sdBY0e7/OwJciMcXM/IF+nRxNOcecATscE
        vL
X-Google-Smtp-Source: ABdhPJxgnSEHF4QfWQWANLvLG0+He0Z6pzB7Poy324Wp40hlrZq41pYcLM6aeKiI7T7m7g68zch8fJPYMIuwAZ4BEy76
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:8ec5:b0:13a:2789:cbb0 with
 SMTP id x5-20020a1709028ec500b0013a2789cbb0mr11473586plo.60.1633727312880;
 Fri, 08 Oct 2021 14:08:32 -0700 (PDT)
Date:   Fri,  8 Oct 2021 14:08:18 -0700
In-Reply-To: <cover.1633727270.git.jonathantanmy@google.com>
Message-Id: <78473b0f892da8f69b334e88208321b277c33c3c.1633727270.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1632242495.git.jonathantanmy@google.com> <cover.1633727270.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v4 5/7] object-file: only register submodule ODB if needed
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, carenas@gmail.com,
        chooglen@google.com, steadmon@google.com,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a35e03dee0 ("submodule: lazily add submodule ODBs as alternates",
2021-09-08), Git was taught to add all known submodule ODBs as
alternates when attempting to read an object that doesn't exist, as a
fallback for when a submodule object is read as if it were in
the_repository. However, this behavior wasn't restricted to happen only
when reading from the_repository. Fix this.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 object-file.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/object-file.c b/object-file.c
index be4f94ecf3..0a1835fe30 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1614,7 +1614,14 @@ static int do_oid_object_info_extended(struct repository *r,
 				break;
 		}
 
-		if (register_all_submodule_odb_as_alternates())
+		/*
+		 * If r is the_repository, this might be an attempt at
+		 * accessing a submodule object as if it were in the_repository
+		 * (having called add_submodule_odb() on that submodule's ODB).
+		 * If any such ODBs exist, register them and try again.
+		 */
+		if (r == the_repository &&
+		    register_all_submodule_odb_as_alternates())
 			/* We added some alternates; retry */
 			continue;
 
-- 
2.33.0.882.g93a45727a2-goog

