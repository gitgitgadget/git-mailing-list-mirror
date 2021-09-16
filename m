Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBF0C433EF
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 21:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A9E061074
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 21:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240086AbhIPV72 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 17:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234142AbhIPV71 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 17:59:27 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1FFC061574
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 14:58:06 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id v16so8178416ilg.3
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 14:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=inNnqeiO2t8ZOqolY7TXx25F7OApLvsJ+II0Kv1FbxE=;
        b=OT3GW9lsB7onVzTiKzVjWla9dYa+XGCSROE60DLDMq867C6d71M3NN+A72nc0hkyY7
         cHG0PXL6YuNUqz3IzvNwutX/xx34q/eYtafEHCpn/HID/kKqtHGiuxCQmI+yNaxaeVFJ
         Krbt9pltIy4JLQIchx2sW60l3EyDyhugaSq8lcjDLXdINz2GQtfANcz2JwEATnzYvkwC
         8v9Oq3VEMxialVwL96so2EpfMMMPkYM/55xsvCbXDlNcOfqzYHDd/jzdtU+sYj+kohxM
         3gFtyN5XLKIbJNHdU9y+KBU1uJB/J5+HZ38uZDLVFUh5D0WpL+c090pWvuoVIi6MgvaW
         D8Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=inNnqeiO2t8ZOqolY7TXx25F7OApLvsJ+II0Kv1FbxE=;
        b=x8wI278264SYzHlw6t15ig7t71U5ijPWr1ihe3dDlpLTVTCJJUJXSrvFu8goStYCtA
         e6+VnIiocyLYKWFDU+Cf28Ez7x/rUjAyAnxT0ORLV4Op6zdcguoabBLdkPR+ByOWCZys
         5pX24zbJdbdhUYCCbYqzg1xSLE4Z53VTRBZrMIzFIamj3+yS5BjRLDwp1IAcgLt2ltQ6
         YFBgWBM/HY7fL4ZF6NYcwae+HqOJAueFgV1D28lJNqop5dTunU5oLLLFxFsOEmrJfvd/
         aUNJiSF2+RJPYhki8+mNcJ8AnmcuLv2zTOz+wuBlPvaoWbknvaOVi2dPlsLNOs636gxg
         LW9A==
X-Gm-Message-State: AOAM532u59AYSrtiucBj5hU7HH6cybtDxBExh8TxD6o95gqYiSwT4xaK
        fi8ZpNC9gPHDSoYnAqWmGlDRWg==
X-Google-Smtp-Source: ABdhPJw8xaE4sDnI6PK41JApQdJEm32K5pRLETWYVXLkkfr3L2+oTYq6+YVV5LptWRc6gDrBh6eI3g==
X-Received: by 2002:a05:6e02:1906:: with SMTP id w6mr5667611ilu.295.1631829486362;
        Thu, 16 Sep 2021 14:58:06 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x5sm2386911ilo.11.2021.09.16.14.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 14:58:06 -0700 (PDT)
Date:   Thu, 16 Sep 2021 17:58:05 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH v6 13/22] object-file.c: split up ternary in
 parse_loose_header()
Message-ID: <YUO97RoOzY639hYW@nand.local>
References: <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com>
 <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
 <patch-v6-13.22-90489d9e6ec-20210907T104559Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v6-13.22-90489d9e6ec-20210907T104559Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 07, 2021 at 12:58:08PM +0200, Ævar Arnfjörð Bjarmason wrote:
> This minor formatting change serves to make a subsequent patch easier
> to read.

Hmm. I'm not sure if I agree.

As far as I can tell from reading the subsequent patch, this is designed
to make it easier to add a comment above "return type" that pertains
just to the case when !*hdr.

I think it would have been fine to go from the ternary to this style
with the comment in a single patch. But I also think it would have been
fine to add the comment above the ternary and instead start it off by
saying "when !*hdr, ...".

Thanks,
Taylor
