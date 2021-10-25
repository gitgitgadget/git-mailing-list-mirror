Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD405C433F5
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 22:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B24F6103C
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 22:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbhJYW3Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 18:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232700AbhJYW3P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 18:29:15 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB47C061745
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 15:26:52 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id y12so5902834eda.4
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 15:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4WI2bXOK0xrCRwkKGkzBinnx60YcJz3CZrReMQhgRSI=;
        b=p4g5JZHRu6NIaXnMFVjfaQ20c06ABGcL6YehjF4bXScCdCWztuoGY1GkoqCes9HHyY
         JLPTA1LybcKWKxEpO2zdRLWoA0qSzQOgWtm2rri+TCHvHmsNgVnUXydcZYn42reMP37F
         gWnH2XJpRk4j44crklkOzxiZwsDnDsmEtOl0Ejq8r6Ei0kZiMl4x4ILjKbvSJQCH1DLp
         AokCICQY+s+SIYD5ZP24vdHNtluWhAhOXbufbd2mzRAn/3nHf6N8BvJzf9OWw35VoRb0
         puQ1BQO7xkuTK7O22OyVTVEVtvLTC8XWvDcl7S/GtsxNAL5p8xl+1FeIsV71h4VncgY0
         jBeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4WI2bXOK0xrCRwkKGkzBinnx60YcJz3CZrReMQhgRSI=;
        b=7rU0lSnFwD4wZVn15sy8a9jMVdo6QwUqhtyG21Oj8VcCEXNPY3DaZYeUD/6lEWRNxE
         QpAyL6celTEseiLUFOtFz0z76NEt/Rh4hy3XX/pCjSmFWIkBiJ7Oi1KdnhH+/DqQjeGd
         YZ7GvxYgLCSOx6EYhKc0I72Qk17KwuKr+eThPTm5KNil6bHGE9uWcJ6sLceCG7ktm0mC
         hLwqYqpM6Q+du4L6OAb3InoTWjJYYg7p9uUfHwbeUVy+KUxy1BfX028LW9iH3i2grsGc
         2xN4oJfonuVjHBD1QSHR2/tuIVsTvlKDYKo47jvDGq4Uz+O/Ctr64Ww5fHwbU6Q9UTlk
         WztA==
X-Gm-Message-State: AOAM530580sdFUrX+9WvpX/m3wL1x5cWFM+rLw4TIha08Hxm9jshJhIU
        9J7m2bCW7yjWdDlud6faObjPpV/dW3s=
X-Google-Smtp-Source: ABdhPJzzmy9Aky9khUn2LKxp4g0xlgzQRMktuX/Hi/AcMtex2uC3OlinUiGKW8epSNClAs3q69/jxw==
X-Received: by 2002:a50:da0a:: with SMTP id z10mr29302572edj.298.1635200810851;
        Mon, 25 Oct 2021 15:26:50 -0700 (PDT)
Received: from szeder.dev (94-21-23-225.pool.digikabel.hu. [94.21.23.225])
        by smtp.gmail.com with ESMTPSA id p25sm9537399edt.23.2021.10.25.15.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 15:26:50 -0700 (PDT)
Date:   Tue, 26 Oct 2021 00:26:48 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [Summit topic] Let's have chalk talks (part 1/?)
Message-ID: <20211025222648.GD2101@szeder.dev>
References: <nycvar.QRO.7.76.6.2110220950020.62@tvgsbejvaqbjf.bet>
 <b485b282-2b26-b9ab-da5d-ea59f5fcf463@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b485b282-2b26-b9ab-da5d-ea59f5fcf463@iee.email>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 25, 2021 at 09:56:56PM +0100, Philip Oakley wrote:
> In the meantime, while chatting to a colleague about the birthday
> paradox and its relation to Bloom filters, I realised I didn't
> understand what our Bloom filters were trying to do and what they recorded.
> 
> I had a look at the code and documentation, but there isn't much there
> about our Bloom filter implementation. A chalk talk could later be used
> in the same manner as the packfile discussion to show what the filters do?
> 
> If there is someone who'd like to talk through what the Bloom filters
> are doing in Git then I'd be all ears.

Then perhaps you might find it's worth your while to read through
this:

  https://public-inbox.org/git/20200529085038.26008-16-szeder.dev@gmail.com/

