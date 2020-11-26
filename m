Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228CBC56201
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 01:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A650820770
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 01:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="fOLMqXE5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729926AbgKZBHA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 20:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729760AbgKZBHA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 20:07:00 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24846C0613D4
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 17:06:59 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id x24so104809pfn.6
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 17:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G2ZAD5EAqr87FzlpPqdJeF+g9m4sR/L4uZQfFaBgazI=;
        b=fOLMqXE5OzN3qkVRBQYnwgLe0SQhT4Oqye/Li070876Jdnam6urQuWiyb445AS86wD
         S3DN/W1YNa2wQxM5zr7eEfO07IJqGDSUVRNowEMGTG6VBhwnnUfH8qJk57i3oCTHEsQ4
         BIk9az/GnDXVwiT5/Rru2ojmM5YT3q4hCk80QWU0M3IlHkttnScITrQjdqbwUhhwsMbD
         j9jfTgogrA6WMjaKKRDrVakYuh/v6b2F4MclFAZr3YEiNNMcXpKkPGAUq4CvAGSpBYa/
         +KjN0dvAqtFgZQdpNiQDNFUotoENfWoAN1FRmkaIditOlY0wpUFaClyPSOyJFhqAzW/1
         PNGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G2ZAD5EAqr87FzlpPqdJeF+g9m4sR/L4uZQfFaBgazI=;
        b=D3RvgimtArDwXohUuBd0BLc98Zzdyv/p4IuPrl2tBx+kRPqYKlPsV6rQsjYxLO7peZ
         QoXHfuGeSlKrwHXnyBpI7H5llFWJ3j+EgLUfe37ImOqRYcjR45d6SymEMhO47BNu9UOa
         5Pn432T8Li1IKq1UDvV/B68S+uoBWTOJH1P+z9tKRLfwi99h9O09zMtE+9Zq/7Xu01P/
         MV4l2Q/yQnuXzORjRA78T9O9gY+RRnlGYyedKEG7/DxWZNcjamX0dG36PNf18UNpXugG
         zuwJLTyNvaH8paF8JO7qwElj53DDvyk2Y4J8T3tFthpkHCS0eQypFpMxfFWzDUhGlG9P
         KZUA==
X-Gm-Message-State: AOAM530CslWQ1TUHCIPCxVed0ZnuPcO+dSsbKItezqqHiGlZrPJ4CpY9
        ZTIy2CQvA1c7yzBYuhZvEhSlM1V+Hd33JxLd
X-Google-Smtp-Source: ABdhPJzomy0EBv7ZJFeky1CwaGpMaOuQfsp1bYoWzJmlMKBX+hzbXkjraikxf0Imb9zTWbBBZp3eYQ==
X-Received: by 2002:a62:ea09:0:b029:198:3d34:989 with SMTP id t9-20020a62ea090000b02901983d340989mr598894pfh.42.1606352818068;
        Wed, 25 Nov 2020 17:06:58 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id b29sm3014351pff.194.2020.11.25.17.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 17:06:57 -0800 (PST)
Date:   Wed, 25 Nov 2020 20:06:55 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2020, #05; Wed, 25)
Message-ID: <X77/r2bK2gdmC0HD@nand.local>
References: <xmqqft4xaq7n.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqft4xaq7n.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 25, 2020 at 04:58:52PM -0800, Junio C Hamano wrote:
> * tb/pack-bitmap (2020-11-21) 24 commits
> [...]
>
>  Various improvement to the codepath that writes out pack bitmaps.
>
>  Needs a bit of reshuffling?
>  cf. <X7xzWClGr3bM3wcg@coredump.intra.peff.net>

Yep, this needs to be shuffled around. I know that Stolee and Jonathan
Tan are discussing some of the patches, too.

So, half of me is holding off while they discuss, to see if there is
anything that falls out and needs picking up. The other half of me is
busy preparing GitHub's MIDX bitmaps patches for upstream, and hasn't
had the time ;-).

I'll likely send a new version of that series after the US holiday when
I'm back in the office next week.

Sorry for the delay :-/.

Thanks,
Taylor
