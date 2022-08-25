Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF24FECAA27
	for <git@archiver.kernel.org>; Thu, 25 Aug 2022 19:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242997AbiHYTuh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Aug 2022 15:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiHYTuf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2022 15:50:35 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C0C33A30
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 12:50:34 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id bd26-20020a05600c1f1a00b003a5e82a6474so3048615wmb.4
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 12:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc;
        bh=gNs8lIaI2RV4wO/Ugm9Ihib6c5xgHgMP9imPLmacU7g=;
        b=okULyt1M/P5mYcb0/zyijxc8TkSBwUECDAb32gi2zt/v7FwaS8YCC88a07Ev8OG1NK
         p5aORwIP7GKJeEJwLgGlThKr7/eyB+t6oRyarF4el6/mSKYJxsK3T7OeYJu5Tmmj8XEL
         NRXcp7gym9xrduef3nWdaOwqwlvunymoEmxvwU5+VRYwJgDHpIYvRQ+zPawW9RUHmEjn
         cHXNOMi7v/scazd7Jw2ZasZdUx6CufX35ZLPaE741m7CrLaG1kThgRCna4e5RJcxI/MV
         EB39hFuFgIvNcHP0VYOxtW8OisG0P5m9eeRB4XA5BxSlPSpaSKdOBoCPaZYN/w+q+Ayy
         CCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc;
        bh=gNs8lIaI2RV4wO/Ugm9Ihib6c5xgHgMP9imPLmacU7g=;
        b=SVGMDQjO3q4G6divE+fD/Q11b8E2IEniNxPwjkJOYj5/sDvftpGfhCdw8w4FEUQl/H
         BlVle9+kbyMndeGT9k1SBJfOO4wrYkqMF07F05kI2jNecRVknOV6AsgNhOpNchh0Cs0U
         f749ENqdXHkja4Pwzf8xk1/fY7TFqv4Fq8iXkyxolnQcHCJQdOF09DRsG48f0OChK/o9
         9NoxL2+Ylipj7rj95JCUHt1wjlUZ79xLlob+UqdJxonM9jEEWvffR9VxaZSMFlwj9OJD
         Wl+yc+7oJubmsyEYhlLcMX3FoQGsVhesEwUZGz4pJlfeBa9jsqnGTySZOb1581ArCzhp
         0BbQ==
X-Gm-Message-State: ACgBeo0cqkrc1LflIMl9aI9Ciz/u1djtmbojlzUunPUeCajd7X0U3lfj
        iRKOR2vYs0QmBcNgDtcOQtkIGCQBHF8=
X-Google-Smtp-Source: AA6agR5h7/VFLkLnd6J18PqA9sQ36R9PvOYy+saV/FID8DEVAT+v2j8z3RXlE3O7dIsK7jH35u/RuA==
X-Received: by 2002:a05:600c:3516:b0:3a5:c28a:f01d with SMTP id h22-20020a05600c351600b003a5c28af01dmr9592954wmq.165.1661457033498;
        Thu, 25 Aug 2022 12:50:33 -0700 (PDT)
Received: from [192.168.2.52] (5.83-213-116.dynamic.clientes.euskaltel.es. [83.213.116.5])
        by smtp.gmail.com with ESMTPSA id n123-20020a1ca481000000b003a5c244fc13sm6297948wme.2.2022.08.25.12.50.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 12:50:33 -0700 (PDT)
Subject: Re: [PATCH] branch: allow "-" as a short-hand for "previous branch"
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?Rub=c3=a9n_Justo_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
References: <pull.1315.git.1659910949556.gitgitgadget@gmail.com>
 <s7862q69-05o8-s5s8-n635-823s34q358q4@tzk.qr> <xmqqk07iu3c3.fsf@gitster.g>
 <5194s6qn-570s-6053-2104-9s22qo1874sn@tzk.qr>
 <55n449n3-71r9-28n9-094q-6r61545r7505@tzk.qr>
 <4d8eb431-dc25-5ea9-14b8-3f84ae0c1561@gmail.com> <xmqqo7w82sx1.fsf@gitster.g>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <b5076054-1be6-1dc5-868a-05005a594b0d@gmail.com>
Date:   Thu, 25 Aug 2022 21:50:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqo7w82sx1.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 8/25/22 6:23 PM, Junio C Hamano wrote:
> Rubén Justo <rjusto@gmail.com> writes:
> 
>> struct rev_info *revs, struct s
>>                  revarg_opt |= REVARG_CANNOT_BE_FILENAME;
>>          for (left = i = 1; i < argc; i++) {
>>                  const char *arg = argv[i];
>> -               if (!seen_end_of_options && *arg == '-') {
>> +               if (!seen_end_of_options && *arg == '-' &&
>> !strchr(".^~:@", arg[1])) {
> 
> Yuck.  I really didn't want to see that strchr() or any other logic
> that _knows_ what letter is allowed after a "rev".  It will be
> impossible to keep it in sync with the real code paths that needs to
> know and parses these syntactical constructs, and folks new to the
> codebase will never be able to tell at a first glance if the above
> is sufficient (or what the strchr() is doing).
> 

Some logic is needed to disambiguate from options. It is difficult than 
that set of chars changes, they are all around the code. And if any new 
is added should be reviewed and hopefully some test will be broken.

Maybe a more centralized approach?

diff --git a/parse-options.c b/parse-options.c
index 2757bd94c1..303854e8a4 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -740,7 +741,7 @@ enum parse_opt_result parse_options_step(struct 
parse_opt_ctx_t *ctx,
                     ctx->argc != ctx->total)
                         break;

-               if (*arg != '-' || strchr(".^~:@", arg[1])) {
+               if (*arg != '-' || 
!check_refchar_component_special(arg[1])) {
                         if (parse_nodash_opt(ctx, arg, options) == 0)
                                 continue;
                         if (ctx->flags & PARSE_OPT_STOP_AT_NON_OPTION)


diff --git a/refs.c b/refs.c
index 0ed9f99ccc..5327a8ec1f 100644
--- a/refs.c
+++ b/refs.c
@@ -159,6 +159,32 @@ static int check_refname_component(const char 
*refname, int *flags,
         return cp - refname;
  }

+int check_refchar_component_special(char refchar)
+{
+        int ch = refchar & 255;
+        unsigned char disp = refname_disposition[ch];
+
+        switch (disp) {
+        case 1:
+                /* end of component */
+                return 0;
+        case 2:
+                /* ".." components */
+                return 0;
+        case 3:
+                /* "@{" components */
+                return 0;
+        case 4:
+                /* forbidden char */
+                return 0;
+        case 5:
+                /* pattern */
+                return 0;
+        }
+
+        return -1;
+}
+
  static int check_or_sanitize_refname(const char *refname, int flags,
                                      struct strbuf *sanitized)
  {
