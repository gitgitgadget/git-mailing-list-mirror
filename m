Return-Path: <SRS0=KQVw=7S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED9A6C433E1
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 04:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6AEF207D5
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 04:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+5Vk5ST"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgFEEVr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Jun 2020 00:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbgFEEVo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jun 2020 00:21:44 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35218C08C5C0
        for <git@vger.kernel.org>; Thu,  4 Jun 2020 21:21:44 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id r18so4106492ybl.5
        for <git@vger.kernel.org>; Thu, 04 Jun 2020 21:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y3TbPp+cBwAuFpdha8dgAp2RxnDBht85ZOEBvAneuAQ=;
        b=m+5Vk5ST6Txb3S0gqaB+jLcGrSDesHwKlzW2Ib5VGDCkeikKokY3q8TeYP3I9LG9Ao
         Mos50AaYD2FSILYxml06m3Ogmdm1GorpbuUs7Pg+LNySUgxOE9SvzDw9sJ3hlATYrYNw
         fwXnDP7EcIEZ74HuhW+BUvxP14YGJ0er/AEgAkQGxgAurY9tqXgOyLh5SI+1nq0dfIIS
         fGZX9EjXts9KutFa0O5uGI/2UbwbbwLf6AESrRGFRN3yo4LEPWapi4XnruqvjB8m3muq
         ss4DhADLKtiz+XwdNJugE2sze/DK19uAeyQiDRH2t6vIYZ/QkeSdmGtqaAktuYicthtm
         jb3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y3TbPp+cBwAuFpdha8dgAp2RxnDBht85ZOEBvAneuAQ=;
        b=EnObnCDONJaUdx8b5/ZcO+51cMeyPki4FbfNBjVPBGPid0MZk21v8OcTbdYOHFSPYZ
         wArIXIZ4yQtFIMrIDCkQAwf/50w571xx8akMQkG0Owzw8z/CwiK1jWR2T1FlOlUTBN11
         WZBpuOyO+5WcU/2CkqrBbtr0P8iz1ENgokdcOesCOk6pmj4J2tIDi4gsmWsvwXCMdP3+
         6ztiF6P7VQSYuMAoTbYEPQfCAOheQ2Nrw/Qv1yHMssoqkc0eMkyovwpHESgqTQTo4JuG
         BxPPS+LgFBAR6Ja+b6fcoJVy3OYLY0HBolKF0w6aCJyAer3YIgYzW31vAWQtROQKTNiu
         nb2g==
X-Gm-Message-State: AOAM5306Lef/tUwUfft8EM/2dtOavs0BBRtAyHJwnG8XGdoS5/cUDlIY
        ANgznG1SJC5grANTeZKHDZhxGhDNv0kNMluTyovi8NRn6gM=
X-Google-Smtp-Source: ABdhPJxUKYCvHIBnbeR6GtndIiNzAYuQZF9ZFMujytsiVucieGxB+huW+kpp6tzyvuPVmbzwiZO3YPMjwSe17Oxhkas=
X-Received: by 2002:a25:7ac5:: with SMTP id v188mr13982299ybc.237.1591330902272;
 Thu, 04 Jun 2020 21:21:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAAXzdLXt4+-34+OhS=Jn=-VeORN3Y2jMzzg9+bhyn88aN4hm0A@mail.gmail.com>
 <20200605000039.GB6569@camp.crustytoothpaste.net>
In-Reply-To: <20200605000039.GB6569@camp.crustytoothpaste.net>
From:   Steven Penny <svnpenn@gmail.com>
Date:   Thu, 4 Jun 2020 23:21:32 -0500
Message-ID: <CAAXzdLVk3jLzuB2vgKGObQDjPydpdiawKJJ+-NMa376Gu1zt1A@mail.gmail.com>
Subject: Re: Change Native Windows shell
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 4, 2020 at 7:01 PM brian m. carlson wrote:
> If you really need Git functionality that doesn't rely on sh, you can
> look into libgit2 and its assorted language wrappers.

Uh yeah, no. Im not reimplementing the entire Git program, when the fix is 7
lines. Here it is, if anyone is interested:

diff --git a/run-command.c b/run-command.c
index 9b3a57d..4945632 100644
--- a/run-command.c
+++ b/run-command.c
@@ -271,9 +271,6 @@ static const char **prepare_shell_cmd(struct
argv_array *out, const char **argv)
     if (strcspn(argv[0], "|&;<>()$`\\\"' \t\n*?[#~=%") != strlen(argv[0])) {
 #ifndef GIT_WINDOWS_NATIVE
         argv_array_push(out, SHELL_PATH);
-#else
-        argv_array_push(out, "sh");
-#endif
         argv_array_push(out, "-c");

         /*
@@ -284,6 +281,10 @@ static const char **prepare_shell_cmd(struct
argv_array *out, const char **argv)
             argv_array_push(out, argv[0]);
         else
             argv_array_pushf(out, "%s \"$@\"", argv[0]);
+#else
+        argv_array_push(out, "powershell");
+        argv_array_push(out, "-Command");
+#endif
     }

     argv_array_pushv(out, argv);
