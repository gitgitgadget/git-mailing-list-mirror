Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E16C433F5
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 20:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A08A61151
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 20:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239461AbhJFUfi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 16:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239490AbhJFUff (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 16:35:35 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD1DC061760
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 13:33:43 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id c20so4041865qtb.2
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 13:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=qsdruNHxgcnZb3nZVVn4a07mL0/5WWiNxcKsqpclHSo=;
        b=APwZwGZ2QjrGFExD+/NVxIfLm40KTt+TBUL7JyGUNjxjzOXtM2NzFPryun+safyrSt
         PSbXCNRTQjygLhv4pH7w6RfCE/KPm5+Do3xOKZ4h9WP596GuovLgOAP6LA6yV7Z+C3X6
         K23x+sKmMmyc0HDhieOAm6PuN5hy5+tl33nYXazrtXgGydvxbY4fvLxgLB0OnIZ/7eOv
         Kt1GVrpsvPRXTXenqQrbf/OWGcgNwNdVC+2l5WK0fZIYzkeYwLT+Y5p4FZDZiCvDN+bY
         NVU6mluMSL5v6hFeTMl70dnuH8U145Pz4k9wjoh1HW4U34IHZZpVD3kSjtq9qTJ8pL/s
         N6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qsdruNHxgcnZb3nZVVn4a07mL0/5WWiNxcKsqpclHSo=;
        b=ED0zk1XLZWO8mViCSwxmm7COszuzzKjMe5n/1YR8UyuH1+hMQWfqvUVvSRD31/1/5P
         JZAran97O0lII9yMzutalFv6LbCFDQ1HcYxc9A/PZsSmq6+fb7HGPyJHVlTeW0h62tZm
         59l1XY95Rr1s39MfudUx20SYiepuKHgccMpYHFd+LyZNuiobqaMYzSmJNx0AcDW4wHKP
         RagxcayV5gVr4VBni2/X9PitgPi2aFTDiKGfqlaVBhqDNHIY7v4f2FBF8Wyia92cMQpW
         cAzH0+xkjQHFBtztLzrjFN2s4dDiiAsKDACq0eYAkKglxLABYDXu1fxrT0PhnY4UFy1R
         3iYw==
X-Gm-Message-State: AOAM532aU/2nJz4HrT/fnZVCXFBT4wqWSZo349tPwawNcbW+YN3A4f16
        x6azxV+nMo14qgktQxo1+63whVBJjS8=
X-Google-Smtp-Source: ABdhPJzc7u1ayx2qRL5HBBJktnzXcKuQR1W9hG5Q6xYKi3ktVtfvpvdbrGQfSK90PPtBGMYPUSxMTQ==
X-Received: by 2002:a05:622a:144b:: with SMTP id v11mr332960qtx.320.1633552422110;
        Wed, 06 Oct 2021 13:33:42 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:a5f2:2ad3:7396:8f96? ([2600:1700:e72:80a0:a5f2:2ad3:7396:8f96])
        by smtp.gmail.com with ESMTPSA id w185sm12582450qkd.30.2021.10.06.13.33.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 13:33:41 -0700 (PDT)
Message-ID: <adfa8780-197f-56a7-4977-d9ff96280ab4@gmail.com>
Date:   Wed, 6 Oct 2021 16:33:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH 3/5] cat-file: disable refs/replace with
 --batch-all-objects
Content-Language: en-US
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <YVy1sx8Xb1xMLFQT@coredump.intra.peff.net>
 <YVy3N7ZX+s6Mi93y@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <YVy3N7ZX+s6Mi93y@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/5/2021 4:36 PM, Jeff King wrote:
> When we're enumerating all objects in the object database, it doesn't
> make sense to respect refs/replace. The point of this option is to
> enumerate all of the objects in the database at a low level. By
> definition we'd already show the replacement object's contents (under
> its real oid), and showing those contents under another oid is almost
> certainly working against what the user is trying to do.
...
> So it has worked reliably this way for over 7 years, and we should make
> sure it continues to do so. That could also be an argument that
> --batch-all-objects should not change behavior (which this patch is
> doing), but I really consider the current behavior to be an unintended
> bug. It's a side effect of how the code is implemented (feeding the oids
> back into oid_object_info() rather than looking at what we found while
> reading the loose and packed object storage).

I'm with you on thinking this is a bug.

> The implementation is straight-forward: we just disable the global
> read_replace_refs flag when we're in --batch-all-objects mode. It would
> perhaps be a little cleaner to change the flag we pass to
> oid_object_info_extended(), but that's not enough. We also read objects
> via read_object_file() and stream_blob_to_fd(). The former could switch
> to its _extended() form, but the streaming code has no mechanism for
> disabling replace refs. Setting the global flag works, and as a bonus,
> it's impossible to have any "oops, we're sometimes replacing the object
> and sometimes not" bugs in the output (like the ones caused by
> 98e2092b50 above).
...
> Reading between the lines, you might guess that I also introduced a
> "whoops, our size/content do not match" bug while trying the other
> approach. ;)

I understand this perspective. Turning the feature off is the only
way to be sure.

Patch makes sense. I just wanted to :+1: your reasoning.

Thanks,
-Stolee
