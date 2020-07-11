Return-Path: <SRS0=UM1m=AW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09178C433DF
	for <git@archiver.kernel.org>; Sat, 11 Jul 2020 20:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C62A320720
	for <git@archiver.kernel.org>; Sat, 11 Jul 2020 20:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594500534;
	bh=XIQpCBEa99SJqHnW1wMF/WhVS5T3ErM7j4BFUecDaQ0=;
	h=Date:From:To:Subject:List-ID:From;
	b=mSpd3/wbNmm7RAUW6GQV8d+mjEbblwsgpeZa6NwkkKg0MN2cRIrQHzZHb0bu+1y7O
	 gpEUXDMQnND0EopAn+XVJzCJ8Io7L/MecbbTa1cYMvxT7FMD7O9d8qqnMcT39ohlOF
	 HDhw5a+SdzI9vQvcrhgzlq9u/QgNeOI7NlhQSnVE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgGKUsx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Jul 2020 16:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbgGKUsx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Jul 2020 16:48:53 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6140C08C5DD
        for <git@vger.kernel.org>; Sat, 11 Jul 2020 13:48:52 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id b185so8737382qkg.1
        for <git@vger.kernel.org>; Sat, 11 Jul 2020 13:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-disposition;
        bh=LEgTfz3xQQMEeG8udOJ7o0Iz/4Qzp4Z4DHpMLkoAzV8=;
        b=DwHFSKQ8ctcY3aTJEnQ48Sv5Mig0rMFqvQh1UgJclxrgBO84DK87tc6d1fI19+vrEX
         a2L21Nv56mvZIsLA56XvagQkX0Ta/WVXoBdL/B5aBcmfxwMdaEmbEjl0Yh6t+JC2pHkS
         d1xZEwfudr5C+6FSugfyd/tjlrOAm3FGIcuks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :mime-version:content-disposition;
        bh=LEgTfz3xQQMEeG8udOJ7o0Iz/4Qzp4Z4DHpMLkoAzV8=;
        b=NMbKF6aEYXcorn+afVkG5OOVtJqfEBjmWP+Vw8JhbHtB/xkelCrLDQwUk9LTj7I9VL
         FKjRtzaqXf/k8BmbGfRsWtdLfsOtImNBwHBtJDehzNUYxnf+OxlPuUMX9G+hzfZFoGec
         2x+6ytQZh/9BWuMbkj4DwLQA5plbFcK3ATVIitjUa1MwIRrewVGXHucDtctp14n6gnUS
         /sQIfDI36sL/cu6IvJyj8HKtNDWvJYMMvHU5Ia6AhiyzYXyJ43Dj1NVgNEbRjSfv5uDe
         bHmrcuj29rrYQ6EcOU38lL0Wvet/7AyQNKHkTkr75uvNhakXAZSaZ3x8cqhCZAn1AEWE
         1kQg==
X-Gm-Message-State: AOAM531TcWJ0vB+HoMYWO+LcEqL9foEAP3t+Xz7/9Nh8iufkHLGx+3yK
        pFSEerEKgdMh6RD1cf1MWxP4j6Vc0xw=
X-Google-Smtp-Source: ABdhPJyEghdd/3N6jV1J0xHU7a6vjfkp2ZIE48Q9/tTV1h2GjcQtJc24WQ+rj4GvceeVYQq/RU6wbA==
X-Received: by 2002:a05:620a:2eb:: with SMTP id a11mr70465383qko.383.1594500531646;
        Sat, 11 Jul 2020 13:48:51 -0700 (PDT)
Received: from chatter.i7.local ([87.101.92.156])
        by smtp.gmail.com with ESMTPSA id i35sm12131285qtd.96.2020.07.11.13.48.50
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2020 13:48:51 -0700 (PDT)
Date:   Sat, 11 Jul 2020 16:48:49 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     git@vger.kernel.org
Subject: FETCH_HEAD files and mirrored repos
Message-ID: <20200711204849.khfbyundun7ujqzw@chatter.i7.local>
Mail-Followup-To: git@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, all:

Are there any downsides to deleting FETCH_HEAD after performing "git 
remote update" in repos that are only used for mirrored hosting? E.g.  
source.codeaurora.org has thousands of repos where various Android/CAF 
automation creates tons of refs, so FETCH_HEAD files are routinely many 
MB in size:

$ ls -ahl FETCH_HEAD
-rw-rw-r--. 1 mricon mricon 4.4M Jul 11 04:28 FETCH_HEAD
$ wc -l FETCH_HEAD
29122 FETCH_HEAD

As far as I know, FETCH_HEAD info is only used in local-repo operations, 
so there should be no downside to deleting these files when git is only 
used for mirroring -- but I wanted to check in case I'm wrong.

TIA,
-K
