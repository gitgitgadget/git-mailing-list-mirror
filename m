Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65AB1C43217
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 02:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiJMCRo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 22:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJMCRm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 22:17:42 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194C750525
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 19:17:42 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id u2so310669ilv.6
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 19:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zuAtLH1WtdOir+m2tSjKrAZDz4NhHsWHkGGY/nWRuJM=;
        b=Hgn1/D1NrnwwPOybZonu569uLyvClqkRP4IOoTCewbYUY6eScf30Gg/reo5mbXWK4e
         QUXXkseNkdEbnZur7/MLXnVQPWzXSPV7EvO11Ql75/Mj/tnRb5GUI9veVT44sTsF5V68
         pwJGR9+JevIJSVcHTcqpR7DSLrBKAWg4oQCPd838R+ejFAJ0p5TAAKmLZ8tnArjopkia
         rTbmvXPaAxXDqZslC5bkCwrIFeAyUIgzXqJsycLZ4teP7LFlxiglXUOOtIYqlGCX36JO
         FlgNTNvI52JIeoM2X3FwvMsSC3jjfbDNvRF10YLrLb5/mkwUMxMA2uYfYsCEdbg+yzdn
         pIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zuAtLH1WtdOir+m2tSjKrAZDz4NhHsWHkGGY/nWRuJM=;
        b=CdNrJ9WSnXQtJB7rOstZlAt4+QyXYUwIA/+0GIX53PRsb7UYVYbo2G9kZIzqBSawut
         az7d0++b7uxOrTD++Ff5ncJcoqW0viRyq3ogOEwl9K6vyXwHKxowUbKGCdIkdgar80Jq
         2gSwvXYxHtToTdo2L+82AobF5h5nn1AVEdSFlfokuHk7e7G7N5UqfLuYAeoYj/FGGnXY
         KbKlEa+eRyIlHHmXYq8QqQ/JHlW6KLzkjEFRROlH9pBhddcr9NfDj/+ipl8TiQ5PYiKc
         fs/F1fpfZCpEA+uujt9HNm1V5D68D9utZlUBU+UigFxY9HA1+f5fruXNjF4ieooFNGRH
         eniA==
X-Gm-Message-State: ACrzQf3v59gB9qp5A/6Cr0nKsnaoRvkNF+IeR/nziG6Ig1LnXDhdqmKy
        hQXqa+guZfFNJAMVuyx29sHg0Q==
X-Google-Smtp-Source: AMsMyM4JEyrL62Vvhji4rl6qpyW6uDkDF/PuDt9fROzbE2cX8vF/hItQg/BjcL1Vr732J2dlJPk7hw==
X-Received: by 2002:a05:6e02:12c4:b0:2fa:478:5c0c with SMTP id i4-20020a056e0212c400b002fa04785c0cmr16390291ilm.122.1665627461433;
        Wed, 12 Oct 2022 19:17:41 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d30-20020a02605e000000b0035a09ad2d87sm6936632jaf.99.2022.10.12.19.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 19:17:41 -0700 (PDT)
Date:   Wed, 12 Oct 2022 22:17:39 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Ignacio Taranto <ignacio.taranto@eclypsium.com>,
        git@vger.kernel.org
Subject: Re: About git reporting missing newline for symlinks
Message-ID: <Y0d1Q/Vrgf5UZY+J@nand.local>
References: <CAAHd=zcrU3VJro1R3xDj3hmqGXZHUA6rHuDFxwhF5aewNvA8xQ@mail.gmail.com>
 <Y0cyX8Ggp+dkgAjX@tapette.crustytoothpaste.net>
 <xmqq35bsk9og.fsf@gitster.g>
 <Y0c0tDEDpV8fO6n/@tapette.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y0c0tDEDpV8fO6n/@tapette.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 12, 2022 at 09:42:12PM +0000, brian m. carlson wrote:
> On 2022-10-12 at 21:34:55, Junio C Hamano wrote:
> > Just a fun thought experiment, but I wonder what would happen if a
> > user chooses to add .clean and .smudge filter that adds and strips
> > a LF at the end ;-)
>
> I don't believe those are invoked on symlinks, since I don't recall us
> having to handle symlinks in Git LFS, which works using a smudge and
> clean filter.

That is right. It matches my memory, at least, though it has been a very
long time since I've thought that hard about the clean / smudge code.

Thanks,
Taylor
