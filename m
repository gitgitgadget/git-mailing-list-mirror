Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AA5C7EE24
	for <git@archiver.kernel.org>; Thu, 11 May 2023 09:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237219AbjEKJRA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 05:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235809AbjEKJQ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 05:16:58 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4335BA5D5
        for <git@vger.kernel.org>; Thu, 11 May 2023 02:16:25 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f42769a0c1so42370325e9.2
        for <git@vger.kernel.org>; Thu, 11 May 2023 02:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683796583; x=1686388583;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :reply-to:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+kjRGg9QNIMo2tp6uqhUWx+OVEqnlgeaUYuylivgZ04=;
        b=boF/FMiRpY7LmKB5eBhnMaIT0Rr/0NWmO5iWkZ3PFQk0sx2OeUmLVcq3WPadEsHbUD
         P+9LNI/qzJ06pTMBdlH6UG4s8U5jzdT52RYRB/9hFlnSbIZm1Z8js2GVJoWC48O7lYbM
         SV1oG9xceuqRYelXH3hpf/7L0jxx4aTaBiWWP4V2rm+4FHVhfj0obHeWIIonHWxEFonm
         ZbKF0quBR+pim9vm37nTapfxneBh2AujDjvpJFF44k/T55jDecWqzPLjiTwkXFUHaV0g
         i3Xk5qt2oDyUZxkCVkhhE1zxwleHgMn0dLY++uHzA3JeT9ZA72KXeWlN78+Zbw+DOHy4
         IMOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683796583; x=1686388583;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :reply-to:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+kjRGg9QNIMo2tp6uqhUWx+OVEqnlgeaUYuylivgZ04=;
        b=TtSnQPNZqnvDiwmfCVBlCKpGD9xmjUJm7SG+WyFJD07rs8kWgTUKdo0QNXCxozyQTv
         2+wXV9jOeSmzo3K9K/UgvJ6nc71ICNzckhVuIlqgJTiVTApm6z4ll+OFmpSI/aBsCG9y
         HDwvb7QkbcmWTgENiXU8CmwKKIUwLoJxV6k0I+uNltf+KRAIRyFUBrsCyB/u7HW4md/i
         nBIyOf52Hj1bG6SgjtFhe+4o13fUM+NrStRbQVxU4/qiX8nOxygplvxzI7PvUUmPrprd
         xGb2neEiqPTTkuGL7n/cN2h/T93O2dOTNMuwMnU382uqKQTfhdrZFY8TeDhObu/KhFAi
         Hu8Q==
X-Gm-Message-State: AC+VfDx8lPUY+Dz2s7qRXDp0Ki0/N5c6Fo95VNb+Jux3eEtIMm9b3XuB
        6erLswMnzf5tPMCwFVrz7KnpP5a1Eu4=
X-Google-Smtp-Source: ACHHUZ6Eh6EWRYMi2xUcSOoIgWPuLiUHoJER5wgOhah5PvQHsDNOj8jDl34UkPenYsj0D7Nx9uRh5g==
X-Received: by 2002:a05:600c:3658:b0:3f4:2374:3517 with SMTP id y24-20020a05600c365800b003f423743517mr9282091wmq.19.1683796582566;
        Thu, 11 May 2023 02:16:22 -0700 (PDT)
Received: from [192.168.1.212] ([90.255.142.254])
        by smtp.gmail.com with ESMTPSA id 18-20020a05600c229200b003f17a00c214sm24698850wmf.16.2023.05.11.02.16.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 02:16:22 -0700 (PDT)
Message-ID: <5720a23e-6ac0-9a6d-3d05-4e0f34bc0589@gmail.com>
Date:   Thu, 11 May 2023 10:16:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Reply-To: phillip.wood@dunelm.org.uk
Content-Language: en-US
From:   Phillip Wood <phillip.wood123@gmail.com>
Subject: Bug in unused.cocci?
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The CI static analysis job for my unit test framework patch[1] fails[2] with

Coccinelle suggests the following changes in 
'contrib/coccinelle/ALL.cocci.patch':
diff -u -p a/t/unit-tests/t-strbuf.c b/t/unit-tests/t-strbuf.c
--- a/t/unit-tests/t-strbuf.c
+++ b/t/unit-tests/t-strbuf.c
@@ -27,13 +27,9 @@ static void t_static_init(void)

  static void t_dynamic_init(void)
  {
-	struct strbuf buf;
-
-	strbuf_init(&buf, 1024);
  	check_uint(buf.len, ==, 0);
  	check_uint(buf.alloc, >=, 1024);
  	check_char(buf.buf[0], ==, '\0');
-	strbuf_release(&buf);
  }

  static void t_addch(struct strbuf *buf, void *data)
error: Coccinelle suggested some changes

I think this is due to a bug in unused.cocci. I'm not sure what is going 
wrong and admittedly we're unlikely to see code where an strbuf is 
initialized and then used it without calling any of the strbuf_* 
functions within our main codebase but it would be nice if the rule 
could handle this.

Best Wishes

Phillip

[1] 
https://lore.kernel.org/git/c902a166-98ce-afba-93f2-ea6027557176@gmail.com/
[2] 
https://github.com/phillipwood/git/actions/runs/4938207776/jobs/8827751328
