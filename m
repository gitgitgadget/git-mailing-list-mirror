Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627B7C433E0
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D87F22518
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgLVAMv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 19:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgLVAMv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 19:12:51 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0282C0613D3
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:12:10 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id d20so10476476otl.3
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=UsTu/XMxRT+J82+UOuyQcLU+50aYaB68PJnlOFgNlZQ=;
        b=i7nzlz/GZ2GAzJvG4rueJAGA0aHMyW47/6mBXqXuErJ46UTev+5pcPb+QehFxEcbXQ
         E8YAPc1YYuWNFCEEUS9k2jIMHcl4EBr+t3BzuG9h+MpTV9Xw2pJJPJDO18eQRnE0HEJv
         wTq2FKMTQnMMhA8rJEPBOfhdDBI/yPKgmeB7qfG/HUZ+pr0feFMvVNz913zGDe1rL4N9
         XErhVWnFOSjPmgE2IqAVGK9fTxolJ+49Ph2ST2W29vrS2+HwQmQtppD2U+YcPox9q1Xp
         bFYI9zMKYOBDPjfr6rG8FARRADFD41M5cACpBwcm7k4qYSrn3F0wBJ4uofPXB9Pj/Us7
         oXjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=UsTu/XMxRT+J82+UOuyQcLU+50aYaB68PJnlOFgNlZQ=;
        b=ZpH7naKwghxoQqlTouCw8bK2GcTBovBQXzp44VHToBZze+ZU4AUffFFtysqeozMhTa
         8joekhxTnJmJxLBC2EzjjUtVKBL4SZ0eVwhbUppSOtr4qbK9wqavU8ofPL0h7MAMgYZp
         K37toNRo45vmPlwtRE0Ab2oRDi5iia2QfaV55pjNysbCQOdNdXQOv9xoHjgyRklveFLw
         jqiT9f7dp/dz/xg631ngOD/4vXCVGggY4Gufo7dDv6djHvPRa9nR87OzTqhpSQh3mdug
         KbLkH0GBRhi6eqY1jq7ojFDrB/kdBfclBcFTbrjNB58OYmEp1SQRFw2bReQY5WRwq1ms
         cUxA==
X-Gm-Message-State: AOAM5316Oz4SLtYmKws/ndCLJbcse5CIiGRBl6YqwdJ3CE4ZiBoujonx
        9U3+AoXhTzFN+pg4+2YJr6fT7tmSW8MqQw==
X-Google-Smtp-Source: ABdhPJyWDTrTSo+O6RponpLDcwI6IS/Ggafj24x6eVBXTcCBHeXu63d8GQFE82YKC+qPFnQ3CwBnoA==
X-Received: by 2002:a9d:875:: with SMTP id 108mr14089207oty.164.1608595930265;
        Mon, 21 Dec 2020 16:12:10 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id z6sm4030551ooz.17.2020.12.21.16.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 16:12:09 -0800 (PST)
Date:   Mon, 21 Dec 2020 18:12:08 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Felipe Contreras' <felipe.contreras@gmail.com>,
        'Junio C Hamano' <gitster@pobox.com>
Cc:     git@vger.kernel.org
Message-ID: <5fe139d895bd7_11498208e6@natae.notmuch>
In-Reply-To: <004701d6d7ea$ffd61e70$ff825b50$@nexbridge.com>
References: <004701d6d7ea$ffd61e70$ff825b50$@nexbridge.com>
Subject: RE: [NOT BUG] git-2.30.0-rc1 - Transitive OpenLDAP requirement in
 libcurl
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Randall S. Becker wrote:
> Well, looks like this probably an operator issue. I tried the build in
> a clean environment (our official Jenkins build environment) and
> 2.30.0-rc1 builds and is currently in testing on both NonStop
> platforms. Something is likely messed up in my clone. There's nothing
> in the environment that is weird. So it's obviously something I did,
> but I don't really know what (maybe git reset --hard master && git
> clean -dxf is not a sufficient reset).

I was going to say that I don't see how you could link to the libcurl
you have in /usr/local/lib.

From what I know of libraries not even this would link:

  #include <curl/curl.h>

  int main(void)
  {
          curl_easy_init();
          return 0;
  }

I would double check which libcurl library is actually being used the
build environmen that works.

Cheers.

-- 
Felipe Contreras
