Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4D061F954
	for <e@80x24.org>; Fri, 17 Aug 2018 17:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbeHQULt (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 16:11:49 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53543 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727607AbeHQULt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 16:11:49 -0400
Received: by mail-wm0-f65.google.com with SMTP id s9-v6so8206979wmh.3
        for <git@vger.kernel.org>; Fri, 17 Aug 2018 10:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=l4h97937DWyK9qHlh48A3/PR7OzSoJQ4VgyaC8zXego=;
        b=Wrdp2KhgNUiR1RL5KxdvPWtycn7CK/WJIPcdOk0PXk4AawUCH1DU1LiUMWqjXHwlF8
         OVHYA34QtB5CK88Z00vOjkBEdSGJiwFAqYWJoxDhflq8IF25DjGGby51lQLs3A39uO0e
         ElW/CF2k4PrjdOcgTpJYaVozDB6+47JL+hhNZpagjrlShDyJKgBBD9/PHHcFe1LsStKT
         wHvZwv15AGcPepQ3h6i9SbEfEj6UqVf56S3oaclpZsf3o6ytw+XSD0cP+8JfGuBDaHTQ
         De2mAmrXufkPGAqbYq7wbe7XjJJaHxhT9jNcvOIo+csU6j1z04LFPvDpk/bOhEPoguoJ
         h+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=l4h97937DWyK9qHlh48A3/PR7OzSoJQ4VgyaC8zXego=;
        b=RClBxmbhnplnuoONULdeeKfA1VM8ItvMZmPaFn1So5NTzNEXRd8SFX7zpjm1yO6sgx
         Krjz4EJ8p9yydQwsvTBPhxl+0gHC3Iu5hGjrIcHzQhHIiqVUvmFjwjLEVLnMtiTCtHej
         JIpQ0/KH2fOh6Ip9z/kX7/g5oyCT4HbLHql/B6aQ3w3XTiyZKKjQqOIydkg94FQII5Oy
         x0y+xs+epuYactQ282Lb2wzBctLzeV2vDU8FyQIEkzQdoaVqIHMsTLtbaDxJ35oTvywj
         KnVwENFlwYMgh2VQxJ2YcmZ9tc80+qMKvDdKUWu1m90GT3BjJTlLWmofDdRkRXxRU1uk
         p/Wg==
X-Gm-Message-State: AOUpUlErZRawAcLt33AEjzGYxgGbdrrphe3b79Gj5d2lwQBj2Cyt7/lm
        zQkMlc8Vz2BI+bqq4XUmzXg=
X-Google-Smtp-Source: AA+uWPyNBa1tgY37Z57r0+BabWhVuuccPOndBi/fd1PAa/QBzwYKE1EwjGvmxc0zJ7k4lprIQBCNZw==
X-Received: by 2002:a1c:1188:: with SMTP id 130-v6mr18899594wmr.138.1534525657904;
        Fri, 17 Aug 2018 10:07:37 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id n14-v6sm2797752wmc.14.2018.08.17.10.07.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Aug 2018 10:07:37 -0700 (PDT)
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
        <xmqqpnyhaq93.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 17 Aug 2018 10:07:36 -0700
In-Reply-To: <xmqqpnyhaq93.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 17 Aug 2018 09:53:44 -0700")
Message-ID: <xmqqlg94c46f.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> It is a bit sad that
>
> 	- if (E)
> 	  FREE_AND_NULL(E);
>
> is not sufficient to catch it.  Shouldn't we be doing the same for
> regular free(E) as well?  IOW, like the attached patch.
> ...

And revised even more to also spell "E" as "E != NULL" (and "!E" as
"E == NULL"), which seems to make a difference, which is even more
sad.  I do not want to wonder if I have to also add "NULL == E" and
other variants, so I'll stop here.

 contrib/coccinelle/free.cocci | 60 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/contrib/coccinelle/free.cocci b/contrib/coccinelle/free.cocci
index 4490069df9..29ca98796f 100644
--- a/contrib/coccinelle/free.cocci
+++ b/contrib/coccinelle/free.cocci
@@ -16,3 +16,63 @@ expression E;
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
+- if (E != NULL)
+  free(E);
+
+@@
+expression E;
+@@
+- if (E == NULL)
+  free(E);
+
+@@
+expression E;
+@@
+- if (E != NULL)
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
+
+@@
+expression E;
+@@
+- if (E != NULL) { free(E); }
++ free(E);
+
+@@
+expression E;
+@@
+- if (E == NULL) { free(E); }
++ free(E);
+
+@@
+expression E;
+@@
+- if (E != NULL) { FREE_AND_NULL(E); }
++ FREE_AND_NULL(E);

