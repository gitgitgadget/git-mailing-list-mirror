Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79A3920A21
	for <e@80x24.org>; Sat, 16 Sep 2017 11:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751248AbdIPLv7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Sep 2017 07:51:59 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37517 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751185AbdIPLv6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2017 07:51:58 -0400
Received: by mail-wm0-f65.google.com with SMTP id f4so4825936wmh.4
        for <git@vger.kernel.org>; Sat, 16 Sep 2017 04:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:mime-version
         :content-transfer-encoding;
        bh=cvtNqJErvxT4d2xvVpfs2RxrKymn3GITFzy2lNSa2ik=;
        b=MJConuIBk7L0M95IZJnK2S+Q4lAGDm5XKUwbg8bUhTNMHGA9z511vRm9w/kgDpeMt3
         yXo8mrB7kCznsrCD4+lQGw87CbSE20VMoR+mWVktCtcP7y5RovtyYPjbHuCqx+M4b1NF
         Dzco03MFt/7P7RaLQHUNJUbKxLXqTVIKwzE6wF9zoU6zStKwIwzjN7uX3eMGk5hosstV
         7545B77uLvhEb3YPjDnsM7+Alb9TCMjaSf6hjfga1YunsRFddhaMzAgeW7kN8hiL9xgD
         vjHvbIWzxKxIBjbKlbxvo6r6Lo2BLj6th27buPoweqJ0++k3UHNvFG4cSVj/FC6hv7lS
         1YnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :mime-version:content-transfer-encoding;
        bh=cvtNqJErvxT4d2xvVpfs2RxrKymn3GITFzy2lNSa2ik=;
        b=ZGRyado1Svp5yJNLF7xAUkVVyHbl/0FogJ6KJZZMeQ77trP3CmpGT5qA88pTCRy87z
         c8xbNguNQ7w9cuOLdsTtQi9RxtloD0pAvP8VyjecgCYy8eHVl4XNWzXzeY28jwhoPQmd
         euYWWYwDFnoddOuQ6I3be3tSnx5DI7Qc9574ugkPJ7+N2Vfh2J/Cth0nRbo8pbpqJ3Y3
         aTgRPQfAs2cDAv39/dSJCRoUK2rRe61rRVU5ny+Lkgx13i41wKpymxN9hCa51DsIWkhq
         r+yVbZypbj//TeCX4UAZ6ovAFu+LDKtEUZSgmCE3D7SLEjMRnqcUIrpf++gx4VNkAbRm
         FWZg==
X-Gm-Message-State: AHPjjUgTH1gSFUeX9RzXF99JhaKEMzxPrASveHEWiJwYtQamuCO3E024
        Gr1ADeqY/OKWDA==
X-Google-Smtp-Source: ADKCNb52tKWX+Px0c2PbqyC0M+r6c0nIFRecmVvKiRgiUfM8Tb6vYkqhgkrB6JCkA601Lgdqeur2Nw==
X-Received: by 10.80.139.145 with SMTP id m17mr22864640edm.304.1505562717388;
        Sat, 16 Sep 2017 04:51:57 -0700 (PDT)
Received: from localhost.localdomain (x590c36f4.dyn.telefonica.de. [89.12.54.244])
        by smtp.gmail.com with ESMTPSA id b8sm1508115edi.46.2017.09.16.04.51.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Sep 2017 04:51:56 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] for_each_string_list_item(): behave correctly for empty list
Date:   Sat, 16 Sep 2017 13:51:18 +0200
Message-Id: <20170916115118.15490-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.14.1.527.g3f6d5ed64
In-Reply-To: <b8951886-feab-a87a-9683-3c155cfa98a8@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> >> It would be a pain to have to change the signature of this macro, and
> >> we'd prefer not to add overhead to each iteration of the loop. So
> >> instead, whenever `list->items` is NULL, initialize `item` to point at
> >> a dummy `string_list_item` created for the purpose.
> > 
> > What signature change do you mean?  I don't understand what this
> > paragraph is alluding to.
> 
> I was thinking that one solution would be for the caller to provide a
> `size_t` variable for the macro's use as a counter (since I don't see a
> way for the macro to declare its own counter). The options are pretty
> limited because whatever the macro expands to has to play the same
> syntactic role as `for (...; ...; ...)`.

Another option to consider is to squeeze in an if-else before the for
loop header to handle the empty list case like this:

diff --git a/string-list.h b/string-list.h
index 29bfb7ae4..9eed47de0 100644
--- a/string-list.h
+++ b/string-list.h
@@ -32,8 +32,11 @@ void string_list_clear_func(struct string_list *list, string_list_clear_func_t c
 typedef int (*string_list_each_func_t)(struct string_list_item *, void *);
 int for_each_string_list(struct string_list *list,
 			 string_list_each_func_t, void *cb_data);
-#define for_each_string_list_item(item,list) \
-	for (item = (list)->items; item < (list)->items + (list)->nr; ++item)
+#define for_each_string_list_item(item,list) 	\
+	if ((list)->items == NULL) {		\
+		/* empty list, do nothing */	\
+	} else					\
+		for (item = (list)->items; item < (list)->items + (list)->nr; ++item)
 
 /*
  * Apply want to each item in list, retaining only the ones for which

This way there would be neither additional overhead in each iteration
nor a new global.

Alas, there is a catch.  We can't use curly braces in the macro's else
branch, because the macro would contain only the opening brace but not
the closing one, which must come after the end of the loop's body.
This means that the modified macro couldn't be used in if-else
branches which themselves don't have curly braces, because it causes
ambiguity:

  if (condition)
      for_each_string_list_item(item, list)
          a_simple_oneliner(item);

Our coding guidelines encourage this style for one-liner loop bodies,
and there is indeed one such place in our codebase, so the following
hunk is needed as well:

diff --git a/send-pack.c b/send-pack.c
index 11d6f3d98..00fa1622f 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -295,9 +295,10 @@ static int generate_push_cert(struct strbuf *req_buf,
 	}
 	if (push_cert_nonce[0])
 		strbuf_addf(&cert, "nonce %s\n", push_cert_nonce);
-	if (args->push_options)
+	if (args->push_options) {
 		for_each_string_list_item(item, args->push_options)
 			strbuf_addf(&cert, "push-option %s\n", item->string);
+	}
 	strbuf_addstr(&cert, "\n");
 
 	for (ref = remote_refs; ref; ref = ref->next) {


Luckily, reasonably modern compilers warn about such ambiguity, so
perhaps this is an acceptable compromise?


> > [...]
> > Does the following alternate fix work?  I think I prefer it because
> > it doesn't require introducing a new global. [...]
> >  #define for_each_string_list_item(item,list) \
> > -	for (item = (list)->items; item < (list)->items + (list)->nr; ++item)
> > +	for (item = (list)->items; \
> > +	     (list)->items && item < (list)->items + (list)->nr; \
> > +	     ++item)
> 
> This is the possibility that I was referring to as "add[ing] overhead to
> each iteration of the loop". I'd rather not add an extra test-and-branch
> to every iteration of a loop in which `list->items` is *not* NULL, which
> your solution appears to do. Or are compilers routinely able to optimize
> the check out?
> 
> The new global might be aesthetically unpleasant, but it only costs two
> words of memory, so I don't see it as a big disadvantage.
> 
> Another, more invasive change would be to initialize
> `string_list::items` to *always* point at `dummy_string_list_item`,
> rather similar to how `strbuf_slopbuf` is pointed at by empty `strbuf`s.
> But I really don't think the effort would be justified.

