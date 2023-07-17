Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75F5C00528
	for <git@archiver.kernel.org>; Mon, 17 Jul 2023 14:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbjGQOFg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jul 2023 10:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjGQOF3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2023 10:05:29 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDCBBD
        for <git@vger.kernel.org>; Mon, 17 Jul 2023 07:05:28 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-403b07cf5d0so38163751cf.2
        for <git@vger.kernel.org>; Mon, 17 Jul 2023 07:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1689602727; x=1692194727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nEV9Aio+neC/kLAR54FBW28f8c2azkItz9eRBVkglZ0=;
        b=b6E08mSkkIX05cU8beZWRgu3eNs2FnOcZg1vlaUJ7dwPf5GHA1Afk3yBwSDGguM3S7
         Nlm/a0DQnMMFYfimzCHK2Xql8hl5VHXMoYrYoUJNb18CUQw8zc1myU6BhrVnWlP18Ocg
         2e+ZdgDXcxwQvfkTTO8CctMfQ77y5cVz5kJqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689602727; x=1692194727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nEV9Aio+neC/kLAR54FBW28f8c2azkItz9eRBVkglZ0=;
        b=bnjnaRnGKJ/9mY0mm/IXe6eFO+u0i/I3X9q1DbgEcNoYGTXcLmOr10WS3AYqKm1UE5
         TnpSNhp4U/qhE/lp6UTLuknsqk0lUPEMySqVVSC9ExycI007OAiAJOws4H/Kp1SbCSLI
         qK35oDl9Gu4qNf5II+7kTjqdPVgx6AJxxfAApSlUdtFn+1iEnw/n9eixg2uAQZx2/aMc
         MfF7D2tgerfLmAvE3DBGaLXdsDCTYJB+A3FgzV2QhQE6O7znJREisOVi/HfrQxVtfAyh
         GZwFNpjZHMkUgFIbO+5kadCMLMSX8NCUrdmlkLmveSASPf6eXi/aJ6MPSMDqdwlovsiO
         60xg==
X-Gm-Message-State: ABy/qLZ7Jyb+D5fWFQZEADuBF3/DujEpL2c57uF9wPlS9vgrfa3wdk7u
        OJIWXG5Wiu+SaJzw3wAu3f+ChdYWk/rXFCd2yM4=
X-Google-Smtp-Source: APBJJlEBNgp5COUgVJK8VBTcutxm7N9E7ghrjeJpxLrZ7Rq6eZ4/pdX7gP4ehf4X/NOsqpqgOD8wvQ==
X-Received: by 2002:ac8:5b42:0:b0:403:a1d4:deb with SMTP id n2-20020ac85b42000000b00403a1d40debmr18045996qtw.41.1689602727576;
        Mon, 17 Jul 2023 07:05:27 -0700 (PDT)
Received: from meerkat.local ([142.113.79.114])
        by smtp.gmail.com with ESMTPSA id u16-20020a05622a199000b003fde3d63d22sm6261078qtc.69.2023.07.17.07.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 07:05:27 -0700 (PDT)
Date:   Mon, 17 Jul 2023 10:05:18 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Tom Isaacson <tom.isaacson@teknique.com>
Cc:     git@vger.kernel.org
Subject: Re: Parsing git send-email
Message-ID: <20230717-upscale-repacking-a56622@meerkat>
References: <CA+EiEZ+PBLEtQ1bD_TnsstT0jNehAs2CGgYXebEE4aweK=kmgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+EiEZ+PBLEtQ1bD_TnsstT0jNehAs2CGgYXebEE4aweK=kmgg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 16, 2023 at 11:22:20AM +1200, Tom Isaacson wrote:
> I'm trying to find a way of parsing emails sent by "git send-email".
> Does anyone know of any existing solutions?

Define parsing?

If you just want patch/description/header information, the easiest is to use
git-mailinfo. If you want to do something more than that, then you need to
give additional information regarding what your end-goal is.

-K
