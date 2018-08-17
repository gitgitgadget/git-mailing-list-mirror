Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E957B1F954
	for <e@80x24.org>; Fri, 17 Aug 2018 16:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbeHQT5z (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 15:57:55 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40347 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbeHQT5y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 15:57:54 -0400
Received: by mail-wm0-f65.google.com with SMTP id y9-v6so7985539wma.5
        for <git@vger.kernel.org>; Fri, 17 Aug 2018 09:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=00SbN1jSwArJMQmyjfQvM+ISv19P9iqkmKnkKF/bRzY=;
        b=bE1Q/BH8KoM8EgcATfoPBP3X1b0BIK1yZfBnD1ZN1y5b1cqS4qJWwGY6c3EaSaC3AR
         66xyTWRpXVRKEHGvrAGmTPtSwmTJGU7QoT79zWbIZszm2O6b9/EyinX699djVij70DFk
         hXpFtKLa80GLw5/ES72a+Ljxf6A00+tJh7WAIVKIQ1sb1BcMf7TvlewAV6TT3I1pluAU
         oSKl59YI3p7U1ICmTdGYaXLLbJCdfKuayn/PjlCMkFy+z95bGVG9is+Jz9fyCU1bai/z
         zBnLPS5Qd641hCu+9uQTOtlFqyn82CaWGxEoGZeQeASvOgEwnhES614PkfET4hEY0rCW
         Hmyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=00SbN1jSwArJMQmyjfQvM+ISv19P9iqkmKnkKF/bRzY=;
        b=Q4+03UfCeSFD4VF7XiNlQlaOqzTaClad1mipdnc3EYb34wwhJDjpawepzRHSbsfJ7l
         OMx3hTJGr9Z7yyasM/GdQfiN3i2iw0L/j99QeQAbch/oNs9oNYbfu0gUQVngu7t7uTu7
         rQk5unwhhXoquiK4EpDOFRx+H0XZNFvuEq/DLQ2gXkfi5n6bS8N4UMcJQAUGcNoZhttT
         FavKowK7CT041UbulCVWGNRJGUIXDstrUYC2s7Hk/HwLlS9ie8YZWuYtIWEyI/D2CmpC
         6hVpDduOLUHriFaf7xTIIUKbAewyf7NEMolX0G+gi9jMDGoM5vCaCmtX+5nWJeddENkQ
         WPbw==
X-Gm-Message-State: AOUpUlEBdEIEQIhm3imGyEwonz9D+Dtu0d0NIQEqT84CgPRn9osLJ8Gm
        eyVj6892jYMi6Vfo30RcuPP9kguY
X-Google-Smtp-Source: AA+uWPzjI20ozokJnJHqgLY3nNIdTb+tRBE3hubmDsagvOvfJp4taLgybtU2CKPtH8rT0L8DdztJew==
X-Received: by 2002:a1c:4d09:: with SMTP id o9-v6mr20937176wmh.111.1534524826231;
        Fri, 17 Aug 2018 09:53:46 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id n11-v6sm4288785wra.26.2018.08.17.09.53.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Aug 2018 09:53:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] refactor various if (x) FREE_AND_NULL(x) to just FREE_AND_NULL(x)
References: <1534498806.1262.8.camel@gentoo.org>
        <20180817130250.20354-1-avarab@gmail.com>
        <CACsJy8DH2tESV4xkCYutH=Ye37zGwifGdJhdnNOsRd+JusdOwg@mail.gmail.com>
        <20180817151012.GA20262@duynguyen.home>
Date:   Fri, 17 Aug 2018 09:53:44 -0700
In-Reply-To: <20180817151012.GA20262@duynguyen.home> (Duy Nguyen's message of
        "Fri, 17 Aug 2018 17:10:12 +0200")
Message-ID: <xmqqpnyhaq93.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> Just fyi this seems to do the trick. Although I'm nowhere good at
> coccinelle to say if we should include this (or something like it)
>
> -- 8< --
> diff --git a/contrib/coccinelle/free.cocci b/contrib/coccinelle/free.cocci
> index 4490069df9..f8e018d104 100644
> --- a/contrib/coccinelle/free.cocci
> +++ b/contrib/coccinelle/free.cocci
> @@ -16,3 +16,9 @@ expression E;
>  - free(E);
>  + FREE_AND_NULL(E);
>  - E = NULL;
> +
> +@@
> +expression E;
> +@@
> +- if (E) { FREE_AND_NULL(E); }
> ++ FREE_AND_NULL(E);

It is a bit sad that

	- if (E)
	  FREE_AND_NULL(E);

is not sufficient to catch it.  Shouldn't we be doing the same for
regular free(E) as well?  IOW, like the attached patch.

 contrib/coccinelle/free.cocci | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/contrib/coccinelle/free.cocci b/contrib/coccinelle/free.cocci
index 4490069df9..f748bcfe30 100644
--- a/contrib/coccinelle/free.cocci
+++ b/contrib/coccinelle/free.cocci
@@ -16,3 +16,27 @@ expression E;
 - free(E);
 + FREE_AND_NULL(E);
 - E = NULL;
+
+@@
+expression E;
+@@
+- if (E)
+  FREE_AND_NULL(E);
+
+@@
+expression E;
+@@
+- if (E) { free(E); }
++ free(E);
+
+@@
+expression E;
+@@
+- if (!E) { free(E); }
++ free(E);
+
+@@
+expression E;
+@@
+- if (E) { FREE_AND_NULL(E); }
++ FREE_AND_NULL(E);


