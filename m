Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8D0C433EF
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 19:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241106AbiCaT4w (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 15:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236682AbiCaT4r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 15:56:47 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D81C61A37
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 12:54:58 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id o13so599165pgc.12
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 12:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=BzpyA2OAGsxviWnQz6ogXkInke3CKHvsOxWeeaKx8q0=;
        b=nN0MbByOcjssTBKA0qdaUyPo2k4TAksLJAaKqJ8TIVtExFZ3biYHFfOAYOxecRBSS5
         HEjJr76gKqD+m7PpylymigsiuwkcAcSnr5xVWV2Qi7yiN19LCTXBc5G0Jol/Q52T3+BI
         KFxa96B3Y1RY6kH6Af241g8+oxk10BESTfnSwkiJKD6ApOGaFwhUL2G+ADwtji0yNUiX
         Nvn3K7aKIYv6aXtRzKxarSgN7b7H/Qa1X/i4LT1J4mk8Bi8Ubb1NkKNMSDaLgvaafCB/
         tAtfD4YLhONYd/zaJHG25TRvHzqFTRsTzeoIkdeYyXPwJWsZkrRadbY+yqySxwcsubFt
         a16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=BzpyA2OAGsxviWnQz6ogXkInke3CKHvsOxWeeaKx8q0=;
        b=NJ4D6vc4efJ8T2xBIleCXEfV635FYzOT8CYEVTPor7kpMglUanLdG8nTCMmMy/Dpdr
         44E+uLWxxQi6vyetE0kEhk16ywDHM8u7h0dxsP+j6Il5FwjIFbMLzom96feu1EjrF4Q1
         a2Rb3eoR49oquc8Mbw7V3zQpRJmH/dS/aeIV9rjh//++AlO9qa0KwUYQq6nYPiMpuZQL
         9pzY8Dcn/yxwPsiJMQv5VZLvqJZmYU6lRvRjcl5+b3pEn2qY9LfIcWkW/IMS0/cKlf4X
         Bnmf+K1YB7SW0vPgjFti8gcAzlDejVGoy4y/fr41xqyWYuAreD3rbOisShYHzKmXxsSI
         Mj8w==
X-Gm-Message-State: AOAM530HM2CA7fI0M/BMKYOHQx26Ae8OwcSACCSga9hHBkqjd6OaaviV
        /5y2kYKC2j/A1uIN1RaNzB0=
X-Google-Smtp-Source: ABdhPJzyxs70bSMRwAbJwCC4Ah3ziPvL62RoF3zB5jnlg7kiHZuPZq/uysTvin8r1/oEPfk9L17AYg==
X-Received: by 2002:a62:1c8d:0:b0:4fa:8dcb:6da2 with SMTP id c135-20020a621c8d000000b004fa8dcb6da2mr7010510pfc.19.1648756497443;
        Thu, 31 Mar 2022 12:54:57 -0700 (PDT)
Received: from neerajsi-x1.localdomain (c-24-56-226-231.customer.broadstripe.net. [24.56.226.231])
        by smtp.gmail.com with ESMTPSA id bw17-20020a056a00409100b004fadad3b93esm276965pfb.142.2022.03.31.12.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 12:54:56 -0700 (PDT)
Date:   Thu, 31 Mar 2022 12:54:53 -0700
From:   Neeraj Singh <nksingh85@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Han Xin <chiyutianyi@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Neeraj Singh <neerajsi@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Han Xin <hanxin.hx@alibaba-inc.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v12 5/8] object-file.c: add "stream_loose_object()" to
 handle large object
Message-ID: <20220331195453.GA24610@neerajsi-x1.localdomain>
References: <cover-v11-0.8-00000000000-20220319T001411Z-avarab@gmail.com>
 <cover-v12-0.8-00000000000-20220329T135446Z-avarab@gmail.com>
 <patch-v12-5.8-3d64cf1cf33-20220329T135446Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v12-5.8-3d64cf1cf33-20220329T135446Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 29, 2022 at 03:56:10PM +0200, Ævar Arnfjörð Bjarmason wrote:
> From: Han Xin <hanxin.hx@alibaba-inc.com>
> 
> If we want unpack and write a loose object using "write_loose_object",
> we have to feed it with a buffer with the same size of the object, which
> will consume lots of memory and may cause OOM. This can be improved by
> feeding data to "stream_loose_object()" in a stream.
> 
> Add a new function "stream_loose_object()", which is a stream version of
> "write_loose_object()" but with a low memory footprint. We will use this
> function to unpack large blob object in later commit.
> 

Just a thought for optimization which you might want to try on top of this
series:
try using mmap on both the source and target files of your stream. Use a
big 'window' for the mmap (multiple MB) to reduce the TLB flush costs. TLB
flush costs should be minimal anyway if Git is single-threaded.

If you can set the source and target buffers of zlib to the source and
dest mappings respectively, you'd eliminate two copies of data into
Git's stack buffers.  You might need to over-allocate the dst file if
you don't know the size up front, but doing an over-allocate and truncate
should be pretty cheap if you're working with a big file.

Thanks,
Neeraj
