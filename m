Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A506202DD
	for <e@80x24.org>; Thu, 19 Oct 2017 22:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752865AbdJSWBD (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 18:01:03 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:52534 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752142AbdJSWBD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 18:01:03 -0400
Received: by mail-qk0-f169.google.com with SMTP id b15so12214241qkg.9
        for <git@vger.kernel.org>; Thu, 19 Oct 2017 15:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tGQwredzm9aje3diiCCQF8sfls/J9Yd2f89TT7isMhU=;
        b=rk07593MvwL1JiJslBZkN1UI7pT4nR1isquLvrvAR3WU9fXA1V2D/Ymp2d0FyEumrx
         Q4QIu79HVvfSEnv+D7ArAzfqYiDrN3KswkVofMKmUrdzmTjdw9erqyu20r4jOxEUhrBi
         5ONPbP7lK0rhij32lcA4PCIIAbEXJ33eCLNB8p29DcLa/zCHFAzDwTSYx51tKctTqmHb
         f8Up3isbCeov2x37SHE/4HBRAde4f1N+cYD3hoXFCcbel0GrcjVWjqRvoAT9sSWLLCYI
         YeWz1gN15UG5Nii7Vr8JnO9E4G/s4QaJsHIC2o9VjjVL3LdruL8okphubP/FTRipvJdo
         +1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tGQwredzm9aje3diiCCQF8sfls/J9Yd2f89TT7isMhU=;
        b=fDJPJZ/3To52zdxFiQxa4+kedpVzjJ6ZnnCJ18SIkXy5Cp3rKwONnb9Nk8uA35l9XK
         uU3Kml+gilJcFMB20c9iTQ34g9AEYM/iHDQ0u0yPLJ9Y+rmFi9Phn9029QpiUz4U8AdD
         YSYVMa4FkROz4akiS20pBY0y9nwuFUGAmt2wgSDLUs+KuY1bSz2RlmcSx/47SXX9gb7A
         /yB47ILpG0OS6BU1z7vqtpwobobbJiVFF65gihXqSdYlCqVaIProYY4HiYN+DdUdT9rk
         xQJAVJlZck+GOmHyDvCXHewYCn9OECyn0TCwJriuVAi3Z5jyAvXKhmjQtmwQDfMx80Ar
         Q4hA==
X-Gm-Message-State: AMCzsaVufu7irybXsAs69lTCHeXcGsdNuLoIjGfXv73RaI5ma5+9/r9K
        18PKqOKB4FAxbdKEFL0VQfI5CcEpC+pcf6CuL0dsXg==
X-Google-Smtp-Source: ABhQp+SfHDxCur+1m3MDDx3KKWrQxkgRsqcbGSsCo5EPis27IvewMbSHFOZEiFnkW/p+9LPmsBD3uwyk4ZP3+6lcjpw=
X-Received: by 10.55.111.3 with SMTP id k3mr3938772qkc.332.1508450462149; Thu,
 19 Oct 2017 15:01:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Thu, 19 Oct 2017 15:01:01 -0700 (PDT)
In-Reply-To: <20171019123030.17338-2-chriscool@tuxfamily.org>
References: <20171019123030.17338-1-chriscool@tuxfamily.org> <20171019123030.17338-2-chriscool@tuxfamily.org>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 19 Oct 2017 15:01:01 -0700
Message-ID: <CAGZ79kZMCBAQhfu0N=dopCfifT1Mc5qWBY7wMNYeRzD+OTo4Sw@mail.gmail.com>
Subject: Re: [PATCH 1/6] t0021/rot13-filter: refactor packet reading functions
To:     Christian Couder <christian.couder@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 19, 2017 at 5:30 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> To make it possible in a following commit to move packet
> reading and writing functions into a Packet.pm module,
> let's refactor these functions, so they don't handle
> printing debug output and exiting.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---

It looks good to me, though I am no perl expert by far.
