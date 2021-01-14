Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B40C433DB
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 16:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3575B23B40
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 16:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbhANQ4y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 11:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbhANQ4x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 11:56:53 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6F1C061575
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 08:56:13 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id 22so8870061qkf.9
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 08:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=prUQsPamNlo/6klR5X6oic35ntGBNCTPWTg0IQQZtBY=;
        b=y8AbqzvXN0E5l/hfMajXmxrEM7R+WXnvTxU96i0bDJLIDOLvAPdfrHI/HDY3h+FYPD
         oHURe1yIjnx2CYBzgRa0iqOQErjr/QyAVIteEOfNu2Sg7eKWPP3IcHf6pYt+JWCVFx1m
         uKYbIvVMHwAQjjmujroUv8CXazt9ikAgtlg7ee7hz+5SryitLf5Oe1fl4uYX8UDeOC4U
         d8q550nWE3qwhF+CeBdtlVNJuCRhjsW5mNyiEJlCD4gEBP/apduUuarBPTmlO6NtdCu4
         IRY9OhKu7FkKZV8KAXWhj7g8iu3vhXR2GS5HcwxSxn+UHqqU5EyLOxXahSsJI++4d5Yn
         tNqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=prUQsPamNlo/6klR5X6oic35ntGBNCTPWTg0IQQZtBY=;
        b=M2r3/ciKsgT92aIiC3ssqvj6dkK+YB8+jQkN8XKxb898FwBZGEq1Mo5fWw4Zjhseti
         c2SWWkRpiPpm2pIhH8LS4pVIr+fP/fQk/zFXlXATzrJZZRqguRxn/VF1dEcRQM3A2DRN
         4tFLp+KZxUjaQUiiJRKhTlAhssfFnXjpipUV0784llzQOvSqt7XcgVCOMmn2XHksCvUt
         h138L0h7n8G8kmoH2zlutJWIErdQxCxGbAI6qEyWGlK52973jHy7cU0l4p/lY95fTy92
         0hnlyf2b2KRXDtG1ru6rkcho5a9clg9YozzL+kAWRuZa2luSAbG7uDLj4UjkLcOANMrl
         R6ww==
X-Gm-Message-State: AOAM533rPkVRMOcXRgh9Md7od6PBP4nAq+cSZzpjFO6b1f79GxAJD7j7
        JMUgd+46fCPMEI6WBCrLfta7TQ==
X-Google-Smtp-Source: ABdhPJypWWDXHX975sGRXAxhslFL7bVAqnRgsEGsXOaWuVw57T+wIH8iXuUbOJsbxA1KQ5GFux2XXA==
X-Received: by 2002:a05:620a:15e3:: with SMTP id p3mr8037837qkm.397.1610643372909;
        Thu, 14 Jan 2021 08:56:12 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:b172:2e4c:efe4:db53])
        by smtp.gmail.com with ESMTPSA id p6sm3144830qtl.21.2021.01.14.08.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 08:56:12 -0800 (PST)
Date:   Thu, 14 Jan 2021 11:56:09 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, jrnieder@gmail.com, peff@peff.net
Subject: Re: [PATCH v2 20/20] pack-revindex.c: avoid direct revindex access
 in 'offset_to_pack_pos()'
Message-ID: <YAB3qax1O++wLasq@nand.local>
References: <cover.1610129796.git.me@ttaylorr.com>
 <cover.1610576604.git.me@ttaylorr.com>
 <8400ff6c9615b4c999b198c46b2e673ec0f2b14f.1610576604.git.me@ttaylorr.com>
 <xmqqmtxcyq7e.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmtxcyq7e.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 13, 2021 at 10:42:29PM -0800, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > To prepare for on-disk reverse indexes, remove a spot in
> > 'offset_to_pack_pos()' that looks at the 'revindex' array in 'struct
> > packed_git'.
>
> Hmph, I somehow would have expected that this clean-up would be done
> before step [18/20], but that does not matter in the end.  The end
> result looks fairly clean.
>
> I wonder if the call overhead to pack_pos_to_offset(), relative to
> the direct indexing of an in-core array revindex[] followed by an
> access to a member .offset that we used to do, makes a measurable
> difference in this tight loop, though.

I'm skeptical that it does (take that with a grain of salt, since I
haven't done any per-function tests with perf, only "how long does it
take to run 'git cat-file --batch-check=%(objectsize:disk)' and so on").

But even if it were to make a difference, it'll get dwarfed in the next
series by the time that we now _don't_ have to spend building and
sorting the reverse index in memory for each new process.

Thanks,
Taylor
