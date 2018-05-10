Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E6291F406
	for <e@80x24.org>; Thu, 10 May 2018 14:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965188AbeEJOx1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 10:53:27 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:37200 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965006AbeEJOx0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 10:53:26 -0400
Received: by mail-qk0-f193.google.com with SMTP id 11-v6so1769860qkk.4
        for <git@vger.kernel.org>; Thu, 10 May 2018 07:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=UWMgIpQETyGL9PcPNb3KRv+WXVruVLtRIDJli9WUcjg=;
        b=TSSnPZiKWl/nAiQFeEA/UknzwNGntz+W3R9S00aM9mbsRblszZglE6A9RxVrJZqlxX
         lG5ljDdF//1ipqVYUGrRzjHrwuq/DpyR6zLv7Sur3VbKDN9S1aVtVQnKhtYVRFQX7xpv
         PjCUSK+5tytA3mqVQtna/TCpjDRr84ExC7FCuOYkKP0ChcyjpUKSyXo04omKv+afbhWD
         etJzECvOxJ6d1D5EnuvA1+KA8F8jvIoh2BeyLHumjVm/3g73I617j8G2yJWQYfUWw0Tn
         qYRk/VRAChpB9gXVFpJNjk/jmGxGSEEZ1lhC7Umq9HP+0t4PqJA4XlrKXDo9D0ubpIcS
         bBdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=UWMgIpQETyGL9PcPNb3KRv+WXVruVLtRIDJli9WUcjg=;
        b=uOpysByGG5/KUAOegCBuJ5r82JIosWtu6HuI1ayw+kw1xml7wBUTsECmqF2hgVwh0d
         MUOxYtaCz9l9lRyaIEgjtoLHWUO9wx6zbyzCibaum8jJfktXPMOBLjkGKnVKgKvAB+Jd
         G/dMy2yHhajlP+eUjeobw1kcjld0/U3Te0cTaVeirBo99vOygqvWQ9CuE8lA6xJkNh03
         DPPynEuRCxC4h0F4kRmqfE6gYp8OqE47DoZmc5ruGUyDGKpRe5nESS8W0fZdCirBM63s
         lO1mJFp5RVa95+U4+gUo7AvKK6UwNwclgI4pRc9agnPaGB9II30vSbq1f1XUF1yuqvpc
         dzbA==
X-Gm-Message-State: ALKqPwdyVbpuxglWx07Qsfzfjjqe5ZVBSgOo859LMxG/49U8XWkyDMLq
        ObsdvWXQ5q9/xf+D0kb28ol4Tf276KA=
X-Google-Smtp-Source: AB8JxZoT+WW5P0flLUCTk9wdQjiMB0UhRSkg5uQlK6eJ3l7IoKaqj4Ze/RAyM9fZcOq0tLqyB+yIRA==
X-Received: by 2002:a37:b987:: with SMTP id j129-v6mr347094qkf.25.1525964005207;
        Thu, 10 May 2018 07:53:25 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id v14-v6sm639507qto.72.2018.05.10.07.53.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 May 2018 07:53:24 -0700 (PDT)
Subject: Re: [PATCH 2/2] replace-object.c: remove the_repository from
 prepare_replace_object
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
References: <20180509234059.52156-1-sbeller@google.com>
 <20180509234059.52156-2-sbeller@google.com>
 <xmqqtvrfizce.fsf@gitster-ct.c.googlers.com>
 <20180510115623.GA20632@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <da155b13-b915-edb7-9bf9-6bef900cdde9@gmail.com>
Date:   Thu, 10 May 2018 10:53:23 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180510115623.GA20632@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/10/2018 7:56 AM, Jeff King wrote:
> On Thu, May 10, 2018 at 07:23:13PM +0900, Junio C Hamano wrote:
>
>> This one was doing
>>
>> 	ptr = xmalloc(sizeof(*another_ptr))
>>
>> and it was OK because ptr and another_ptr happened to be of the same
>> type.  I wonder if we are making it safer, or making it more obscure
>> to seasoned C programmers, if we introduced a pair of helper macros,
>> perhaps like these:
>>
>> 	#define ALLOCATE(ptr) (ptr) = xmalloc(sizeof(*(ptr)))
>> 	#define CALLOCATE(ptr,cnt) (ptr) = xcalloc((cnt), sizeof(*(ptr)))
> I've often wondered that, too. It's the natural endgame of the
> ALLOC_ARRAY() road we've been going down.

I'll chime in that I like this idea.

Because I'm trying to learn more about Coccinelle, I added the diff 
below and ran 'make coccicheck'. It resulted in a 1000-line patch on 
'next'. I'll refrain from sending that patch series, but it's nice to 
know a "simple" transformation is possible.

Using `git grep` I see 230 instances of 'xmalloc' and 261 instances of 
'xcalloc'. After the Coccinelle transformation, these are down to 194 
and 190, respectively, because the rest allocate in the same line as the 
definition. It's worth thinking about the macro pattern for those cases.

diff --git a/contrib/coccinelle/alloc.cocci b/contrib/coccinelle/alloc.cocci
new file mode 100644
index 0000000000..95f426c4dc
--- /dev/null
+++ b/contrib/coccinelle/alloc.cocci
@@ -0,0 +1,13 @@
+@@
+expression p;
+@@
+- p = xmalloc(sizeof(*p));
++ ALLOCATE(p);
+
+@@
+expression c;
+expression p;
+@@
+- p = xcalloc(c, sizeof(*p));
++ CALLOCATE(p,c);
+
diff --git a/git-compat-util.h b/git-compat-util.h
index f9e4c5f9bc..5398f217d7 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -843,6 +843,9 @@ extern FILE *fopen_or_warn(const char *path, const 
char *mode);
   */
  #define FREE_AND_NULL(p) do { free(p); (p) = NULL; } while (0)

+#define ALLOCATE(ptr) (ptr) = xmalloc(sizeof(*(ptr)))
+#define CALLOCATE(ptr,cnt) (ptr) = xcalloc((cnt), sizeof(*(ptr)))
+
  #define ALLOC_ARRAY(x, alloc) (x) = xmalloc(st_mult(sizeof(*(x)), 
(alloc)))
  #define REALLOC_ARRAY(x, alloc) (x) = xrealloc((x), 
st_mult(sizeof(*(x)), (alloc)))

