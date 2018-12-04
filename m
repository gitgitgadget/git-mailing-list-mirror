Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 888F7211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 00:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbeLDAbA (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 19:31:00 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:40754 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeLDAa7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Dec 2018 19:30:59 -0500
Received: by mail-ed1-f54.google.com with SMTP id d3so12386028edx.7
        for <git@vger.kernel.org>; Mon, 03 Dec 2018 16:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bwBio8ZfZijNT/LJmHIVyKITFS+bdN70FWHwNc+lK5s=;
        b=dTDCEfjBm3nzuoqBBwEiSQ3vLDJ27+NDYYBoYlBO8vWoU0Vy1+Wf1Xa6dZbTdfCQcL
         Dax3nIQiEll3SHEpRLwYwp5Y0SFF8FRO9c9oza/hdvPcgAjLcT7rXKlsL/1xfCryUcP7
         Nuw29toACQzsdnmKjXeWmR7WKcTjqeQRKb4OO9qzxf+zh437BrqjGK6i5jc+BgmhmuvO
         EnxqSPw1u5niwJJk3ItlLtSsJqmZC1B+cnggUEyS7RRJ89PN4Zm247zKhYhysGk0X53r
         gUpXySADxE2KSpjjty5/FFllkQcm+OtR90XLE1rUTqxyNvY9tmTNeHQIKSGwXBIrGcsr
         HfUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bwBio8ZfZijNT/LJmHIVyKITFS+bdN70FWHwNc+lK5s=;
        b=ME3PrVYejHFgIMMJ2DZXZObmtv8Z8GTllCG0rlBqQYzV4iB4HFfFevllBRO8nNLQYt
         XIxEvSHl7DRbI1JxH8nfdmNVfHzVploqwO8o537u3wvJV01jafV7RukG+MNo3NUqro/O
         tuY9RMQzQpIfKJOHALvb8aaQwWNUSvgpmFwcOwar4CnW5s9kTKp6xzFpzHkXVQbbJcfz
         poY9m3Ii4V+O2H8oMUg06s/3WbeITOm+auadUHHsBl2mjBU+7ddXCL5eQEb6JkHjXS+b
         HVz7jpG1BMkE4voEPcVV2zhJXX06MAw1NRBRV7C/ylNzoFTFMgb/75Raf3rE85yfWe+X
         Vpvw==
X-Gm-Message-State: AA+aEWbEfONR5KbkPSqzud9mTYnwWoET0BLD5zRYBKApVSKQx+fX+DLV
        9mD58aRQjOmo3euDmP5EzlTFEbPA1ScUmgKXlvPb0A==
X-Google-Smtp-Source: AFSGD/U0XelpF8AGAr4XZf0qDRiU10z7vMQakBrc/yKsgFdQFWdkzyol6GnQOhuRCB1pde3vuqUxiE9SLyuO918S51M=
X-Received: by 2002:a50:8343:: with SMTP id 61mr16464352edh.154.1543883457159;
 Mon, 03 Dec 2018 16:30:57 -0800 (PST)
MIME-Version: 1.0
References: <cover.1543879256.git.jonathantanmy@google.com> <e19f294df9ff999d30a47339a7848c7104bfae7d.1543879256.git.jonathantanmy@google.com>
In-Reply-To: <e19f294df9ff999d30a47339a7848c7104bfae7d.1543879256.git.jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 3 Dec 2018 16:30:46 -0800
Message-ID: <CAGZ79kZ3W3n7Y80ZLP5-eC2WSBBmC-ztx2z1zgzegvKXfD3r2g@mail.gmail.com>
Subject: Re: [WIP RFC 3/5] upload-pack: refactor reading of pack-objects out
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 3, 2018 at 3:37 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> Subsequent patches will change how the output of pack-objects is
> processed, so extract that processing into its own function.
>
> Currently, at most 1 character can be buffered (in the "buffered" local
> variable). One of those patches will require a larger buffer, so replace
> that "buffered" local variable with a buffer array.

This buffering sounds oddly similar to the pkt reader which can buffer
at most one pkt, the difference being that we'd buffer bytes
instead of pkts.
