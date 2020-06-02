Return-Path: <SRS0=E3tc=7P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FD9C433DF
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 18:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EDDD2077D
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 18:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpV3JsM2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbgFBSEM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Jun 2020 14:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgFBSEL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jun 2020 14:04:11 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B3DC05BD1E
        for <git@vger.kernel.org>; Tue,  2 Jun 2020 11:04:11 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id r15so4052298wmh.5
        for <git@vger.kernel.org>; Tue, 02 Jun 2020 11:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lTOPGe816G7kk2+DzFlyI2n2KXAoFVxArvI+BDcJrRY=;
        b=MpV3JsM2ROWK0d7t3cRXZZhpoKnw3Aq9LQv0yYvNQxg0rYG0yGenLc+57/A5hAU6FZ
         bi1eUwoYp6Chv8k35wd/27Emu6jY5qNeZMMPBUJbH5J/bJkZdIjH32/wJ0Lgozv++Luv
         JlwiMtNxiZV6pU5k5j4Ap7B4fauDOS00SD2vwAI0t8cFamcppWN4kFSLV6/4MxOEJJYE
         WIFiqKtrGVe0CcZeaBktXJsSz7Qqj1M5Y4UHLFdFjqFRzdtVA8KOep1iIV5zrzVop51d
         8yDT1SPC6yV2/qPdPvNUmeeoBBqL7dnOPiJw2sTrfkROiQGHHkv8iz4UB6DSoHo3mHKG
         JLKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lTOPGe816G7kk2+DzFlyI2n2KXAoFVxArvI+BDcJrRY=;
        b=dmwIO//Czio2EZ+Dbncd79sFdI3P9G9PcV1iMpEqv16CsJXiTMZ8TE+zLvIGcTKt7N
         EfpzzfY3r/avFPZurie7b6BhDol8YmC8xARbZI+RHaJ1+3N//rQ9/7wNPdsDUr0O2DIx
         bLfrO9LCGBJ+802EFZ/2qlm/PPlmo8NBXxMAmT/bOuiIno9QWRTYeltd2jcdCj3akobf
         TGJKNLzPbYSeCKj/k6evCl7Sgz7zZepsxePDskyz2S7fZdDN5sqwbqDDMVkl/CfNfMpF
         tJQUvcChlX6N/znvvOSv+Vy1p5zOF45kDKraAmJANqJiHY6/FDGG/dJkCJ+kOTfHtwz/
         Zxqw==
X-Gm-Message-State: AOAM530D1zd2PgHzbVd+hzMJKLVGWs6l0bkKaXTQ/dPNGvIcRmjnQ4wI
        BsowQTXpyKFdmxX482IunOA=
X-Google-Smtp-Source: ABdhPJxm3tcCNi9ZppxzbMMJHhhA3Lc/ygkSLpPouOF7utAer9qYIQIg+/blkmIO2xSzYz89q97VqA==
X-Received: by 2002:a1c:f312:: with SMTP id q18mr3515540wmq.106.1591121050065;
        Tue, 02 Jun 2020 11:04:10 -0700 (PDT)
Received: from szeder.dev (78-131-14-185.pool.digikabel.hu. [78.131.14.185])
        by smtp.gmail.com with ESMTPSA id k14sm4757232wrq.97.2020.06.02.11.04.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jun 2020 11:04:09 -0700 (PDT)
Date:   Tue, 2 Jun 2020 20:04:03 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com
Subject: Re: [PATCH 1/2] t5318: use 'test_must_be_empty'
Message-ID: <20200602180403.GA4791@szeder.dev>
References: <cover.1591034353.git.me@ttaylorr.com>
 <fddbe588147444fe2675224c94f50e24a1d12871.1591034353.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fddbe588147444fe2675224c94f50e24a1d12871.1591034353.git.me@ttaylorr.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 01, 2020 at 12:01:27PM -0600, Taylor Blau wrote:
> A handful of tests in t5318 use 'test_line_count = 0 ...' to make sure
> that some command does not write any output. While correct, it is more
> helpful to use 'test_must_be_empty' instead, since the latter prints the
> contents of the file if it is non-empty.
> 
> Since 'test_line_count' only prints the expected and actual line count,
> not the contents, using 'test_must_be_empty' may be more helpful for
> debugging if there is regression in any of these tests.

These two paragraphs essentially say the same thing, so I think only
one would be sufficient, but...  Both paragraphs are wrong, because
'test_line_count' does include the content of the file on failure:

  expecting success of 9999.1 'test': 
          cat >foo <<-EOF &&
          Add
          some
          content
          EOF
          test_line_count = 0 foo
  
  test_line_count: line count for foo != 0
  Add
  some
  content
  not ok 1 - test

Having said that, I think that the change itself is good, because
'test_must_be_empty foo' is more idiomatic.

