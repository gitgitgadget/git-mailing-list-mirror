Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD5FC54FD0
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 17:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B907E20857
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 17:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyWGHKVQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbgDXRRn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 13:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728454AbgDXRRn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 13:17:43 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056C7C09B048
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 10:17:43 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k18so3965376pll.6
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 10:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UpO8z0Go+U/HLJaiGw1EEYBZsxl83GdIt6NsRiz2xaI=;
        b=hyWGHKVQQIO8UR/9wxLlwO385ugtz48yyWQoV2NosRP5wPtVGQbPYXm/IWD7V2/hiW
         5kfiRfbza1pJLE40VHbkT7BRSMkOk0CIgYiTi0fDGzRPKKqI34VzZpxiT7ILJBWNNFd9
         /7Ud5RyeXufc2YalnWNbqEtxD3GfLKxqjOznD/hOZTkV8pKarZfZMzOQnPnXKUi2f/jX
         56VVjMKRd5/SZB+ROQ77JZ/RWvS5Ihy7GEkEz2W5vQMRRj92shdrKb59/FBUcD1zQToz
         vG6yvfG1PTXIONhfUn4CCf9gpZ7w7aqdCEKjRbLs1Ox9vm552CkvkYMKV7FqXceKIXoU
         bKYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UpO8z0Go+U/HLJaiGw1EEYBZsxl83GdIt6NsRiz2xaI=;
        b=O9v1F5PW1TCkS3dxS7/qf3GgWDbJ+zXUjbJ9bwNeaWF0pR2wiEnaRC/+EfgUkbBKYF
         oUWz/vAR1H6hj9thMjwXLOST7SOClMBhr81V6udD8lJ6k71VF6rM6jw7yBtdKn1MQEqY
         IgUPhD72WMskxt+q9uiqUvoD9pX9SepPN6QfeVDN1JM+kv7A8xY/WKMFhq9FF02yXLQf
         A5yEM77JD3kwLHZfuxe7CDNqtuRx+kJfcOvWftzgbk/iTmCKZQgURXJhbkuorYJsLv/R
         zPBABkBTUe/8mAebYRbPuVgroI1B9CP2yEn4oxXdoV9r004vj8Vty4dClEvIUqfykRVq
         xQdg==
X-Gm-Message-State: AGi0PuZKaPA98KLrhDUZe6wROCPbPr3Y2mwNRnHUSJBGX/KBiE5FDOLh
        EWgR67bcSwyck/zhf6tGu7k=
X-Google-Smtp-Source: APiQypIUh0S84aEi2aHLBxyc6qbLaTphXpHR79VN8Vmy4Hx/xjIkiHcbaJG3cu3qFi+RiSWt5pPvtA==
X-Received: by 2002:a17:902:a40e:: with SMTP id p14mr9727194plq.297.1587748662341;
        Fri, 24 Apr 2020 10:17:42 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id 135sm6201446pfu.125.2020.04.24.10.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 10:17:40 -0700 (PDT)
Date:   Fri, 24 Apr 2020 10:17:38 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com, gitster@pobox.com,
        newren@gmail.com
Subject: Re: [PATCH v2 1/2] t5537: use test_write_lines, indented heredocs
 for readability
Message-ID: <20200424171738.GA17217@google.com>
References: <20200423001438.GC19100@syl.local>
 <cover.1587601501.git.me@ttaylorr.com>
 <5c9217ad8fc594fbff46507c4be7961eb5a478e2.1587601501.git.me@ttaylorr.com>
 <20200423011444.GG140314@google.com>
 <20200424171139.GA61470@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424171139.GA61470@syl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau wrote:
> Subject: [PATCH] t5537: use test_write_lines, indented heredocs for readability
>
> A number of spots in t5537 use the non-indented heredoc '<<EOF' when
> they would benefit from instead using '<<-EOF' or simply
> test_write_lines.
>
> In preparation for adding new tests in a good style and being consistent
> with the surrounding code, update the existing tests to improve their
> readability.
>
> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  t/t5537-fetch-shallow.sh | 70 ++++++++++------------------------------
>  1 file changed, 17 insertions(+), 53 deletions(-)

The commit message is missing the mention of \EOF quoting.

See "git log --grep='modernize style'" for some examples about how to
write this kind of commit message without it getting tedious.

That said, I think it's fine --- just mentioning that for the future.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
