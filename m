Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA4DC433E0
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 274DC20757
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAUlsdIo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730832AbgFSRPf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgFSRPd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 13:15:33 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761B0C06174E
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 10:15:33 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id dp10so4780066qvb.10
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 10:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b+gvnRXA0yR9P+TKFTRIauUBWzou9YQ6YvUi59Jt3nU=;
        b=BAUlsdIociyF/V4hmRb4JiPkvlDc2mdR7QPyIbiNn2COjKi03Ny6DEDozuF0Nicn1+
         Ru1VrxBxna859z4kGrwibulO2e0xOHCwEdhRmsOTDajcK/DaNdL2zuXdykw7Y5Rg/Shp
         kHnOGxy2bOXu7tz+pFhBSiKvZvzPgtItV/L0cTalXo/crlD4cIilqFHabdAKHapcd6fK
         a00GDi+KWb1Wm0czWWhYTN7qVDVjU9GckmWS1HkaYd8PoMpe6FD3V7VDHUXZ4bJ9oaaZ
         7jKhVrBsUeiEpzA5xcuDLfiO/jcxqq7A4xIfbT/wKyM3Vex+MXsg3+MgwDq4ApNaG4OP
         ituQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b+gvnRXA0yR9P+TKFTRIauUBWzou9YQ6YvUi59Jt3nU=;
        b=TDPWKneEU2DUSCAAMzcM08s8DE4yXN3jSFRXgwEhZ3I+ubRjDCKoGTXeQesYkldePY
         iUFoG1F4ock+x8xBREVID4Pvt75mlbfOfsZmJFOf/Sr4gM0Uid16GLyNZ9Yv4jGxZe5T
         kGWXPpCX3vzYA3uvo9a54zP8Wk3iObIgGSoMXC+TLZuLZdc0fShD7bs6jNVK0mN9WCoi
         G5k8bQjdru+kJN3U/n6YlK6rlW3aGLlczT5rna+IdAvPR6x+ce5/w2GM5/+wAQZsB/hW
         ul6hq74ZX42HlH0QNkl7Gy+p5SylJPVnLDw8ebYZ29MI47fs9zW1uNfhyrspHZJ1wIQD
         wIdw==
X-Gm-Message-State: AOAM5312UvZbBmirXPDjU2gNkY+wEHUD+iIkFmx6o6Qr8+RzKHivf36X
        qVA/S8xH2vdcG2OKLNK9j93HEZeNVMdRQvhHpdE=
X-Google-Smtp-Source: ABdhPJx+XoB6PNbWVAM+O1e4T93SGYUARbY/UW6ZsTpapIHs63Qgxn8NblF7XtfQIc9i+luXQ3ipMg5gjB+wmzxQYYA=
X-Received: by 2002:ad4:4501:: with SMTP id k1mr9657870qvu.56.1592586932713;
 Fri, 19 Jun 2020 10:15:32 -0700 (PDT)
MIME-Version: 1.0
References: <549f0cd5fffef38e8d85246a9aa2593674aad68c.1591986566.git.gitgitgadget@gmail.com>
 <20200615140349.1783-1-oystwa@gmail.com> <CAKiG+9X66yf_F8F3XuYFdFyBWiFRZ_rf0Y1mE5LVCjsi-AzKbg@mail.gmail.com>
 <xmqq8sglq8zn.fsf@gitster.c.googlers.com> <CAKiG+9VZUqDi=EbbqY2vLAiD6LEFMfR_2UHE+gbt_RpKNanUCA@mail.gmail.com>
 <xmqqk104nnll.fsf@gitster.c.googlers.com> <CAKiG+9UqvrxyMQufuG=oAP6Yo7+YSoicwqZBJjsZZFQT-Bscjw@mail.gmail.com>
 <xmqq1rmcm6md.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq1rmcm6md.fsf@gitster.c.googlers.com>
From:   Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Date:   Fri, 19 Jun 2020 22:45:20 +0530
Message-ID: <CAKiG+9VCcH+CGc8=e22Xjc7z=-HL3vbDTDq9a4zZ9ONdmgTpvw@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] cmake: support for building git on windows with mingw
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?=C3=98ystein_Walle?= <oystwa@gmail.com>,
        Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 19, 2020 at 2:30 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Sibi Siddharthan <sibisiddharthan.github@gmail.com> writes:
>
> > The reason I deferred modifying in PATCH v4 was because there was no
> > easy way(cross platform)
> > to change file permissions. The workaround is to juggle the files to a
> > temporary directory, and then copy them
> > to where they are intended to be with the required permissions. This
> > added quite a bit of code.
> > Since Windows platform was the priority, I did not address this issue.
>
> I recall asking you, in a very early iteration, if you just
> concentrate on Windows and do not even pretend you support Linux or
> any other systems, the series can be kept smaller and review
> simpler, and your answer was "no, it can be done with just a little
> extra code".  But I think you are saying it needs "workaround" and
> what needs to happen in the workaround sounds quite ugly to me.
>

I know what I said. This is the worst edge case of this scenario.

> Let's not worry about cross-platform and instead stick to Windows
> and nothing else for now to expedite the process.  As long as it is
> advertised as such, nobody would complain that it does not work on
> Linux or macOS.
>

Okay.

Just for your information.
This is the exact diff that needs to be added to address the issue.
------------------------------------------
@@ -761,6 +761,14 @@
 file(STRINGS ${CMAKE_SOURCE_DIR}/git-p4.py content NEWLINE_CONSUME)
 string(REPLACE "#!/usr/bin/env python" "#!/usr/bin/python" content
"${content}")
 file(WRITE ${CMAKE_BINARY_DIR}/git-p4 ${content})

+#Give the scripts execute permissions. This does not apply on Windows
+if(UNIX)
+       foreach(script ${git_sh_scripts} git-instaweb
${git_perl_scripts} git-p4)
+               add_custom_target(${script}_executable ALL
+                               chmod +x ${CMAKE_BINARY_DIR}/${script})
+       endforeach()
+endif()
+
 #perl modules
 file(GLOB_RECURSE perl_modules "${CMAKE_SOURCE_DIR}/perl/*.pm")

@@ -790,6 +799,12 @@
foreach(tm ${templates})
        configure_file(${CMAKE_SOURCE_DIR}/templates/${tm}
${CMAKE_BINARY_DIR}/templates/blt/${blt_tm} @ONLY)
 endforeach()

+#Give the templates read & execute permissions. This does not apply on Windows
+if(UNIX)
+       add_custom_target(templates_executable ALL
+                       chmod -R +rx ${CMAKE_BINARY_DIR}/templates/blt/)
+endif()
+

 #translations
 if(MSGFMT_EXE)
---------------------------------------------------------
If this is simple enough, I will add it in the next patch series. If
not, when in the future should I implement this?


Thank You,
Sibi Siddharthan
