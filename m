Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C2AC433F5
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 04:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED0F760FC2
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 04:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhJGERk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 00:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhJGERj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 00:17:39 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57791C061746
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 21:15:46 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id l20so5079892ilk.2
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 21:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=bbzpPG9Xpj4F48NE6C6sAh7zupX7RazAjamrzOniX0I=;
        b=PLK5PSXHWk3ma2UEIrNoQ1HQkqc+57ovzk35pqxph5LjCESvUiFDYoJmE55zJ/rv14
         rxhNY0y9MMgrtQCFXk5/HFipQlQ4ljaSbh8hasjy8Nsi2QS1h52u//nOSAHWuPHHhAJu
         gHGehaICETRE3fW9E1zPrxCkK3kT3DuYXFyk6cU76olGZkVwKQ9Uzi6iu+Ts+2wo8rNg
         mMjOi+qFTiTPRUfr1TCpVkrIruqjOFA5BT/Swx1ee+ceHIJutg796LShIixGX0M0zvhZ
         QXZeGRCTdxqTplvbhLZhfSnv8Aj7asNLg+T/I1VZ8VVpSXaaUAarNCccj9QRJjeWPjf3
         V7IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bbzpPG9Xpj4F48NE6C6sAh7zupX7RazAjamrzOniX0I=;
        b=V8h5ILhIi/meweXA3nh8vGWHWjKZIA1QOwcsvU1mbn4Ie8NxDrH0AyDip5TBCi52wz
         g/v1ORlBn8kYXLhKBtEkBY7TODNByWE3dvGJ6yvK+jfwaM4Kw9K7kBJVZOdSdNgZDUK9
         0qVdF1SRoelBWf+IquJwKnI5PaCEoW29tL014ZsG7LGYYV31H6C7AmuODDYTOVt5sxuz
         nHD60eUqeIPIGW4Cu6CkPVCGJCpQ7xfX8MTARjAnMj6SpF34bLdX/bN6DkGmLm2nRXWr
         McDYq47AZxgWwXZzsTVpX+BxDcozTmVzD/iEmwpG1qmGr0O9RGFDYXajdRv6B6jEZ4gP
         tvzQ==
X-Gm-Message-State: AOAM5321mr3nMeWXPCLddwCdbw1oMALnRP5kiGYFp1KY5OfR+lHqrCr4
        x8YhHm+4Nbxj3q/HfLFxJEPvFQ==
X-Google-Smtp-Source: ABdhPJyavM0iR0cHwFObp6wf4wFdveeTIONfUrJmVcGF9klLX/B+Oet3fhZBo/NVgrJ5FQ8Gh2jk2Q==
X-Received: by 2002:a05:6e02:216e:: with SMTP id s14mr1510347ilv.154.1633580145628;
        Wed, 06 Oct 2021 21:15:45 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s11sm12320518ilv.69.2021.10.06.21.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 21:15:45 -0700 (PDT)
Date:   Thu, 7 Oct 2021 00:15:44 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2021, #02; Wed, 6)
Message-ID: <YV50cEN6hdvNOrpE@nand.local>
References: <xmqqfstdr8b5.fsf@gitster.g>
 <YV5aaD418SyZqS/1@coredump.intra.peff.net>
 <87wnmph73b.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87wnmph73b.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 07, 2021 at 04:57:10AM +0200, Ævar Arnfjörð Bjarmason wrote:
> @@ -1927,11 +1929,9 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
>  	}
>
>  	result = write_midx_internal(object_dir, NULL, NULL, NULL, NULL, flags);
> -	m = NULL;

This was the only hunk that gave me a little bit of pause. But it is the
right thing to be doing.

When this code was originally written, write_midx_internal took a
pointer to a struct multi_pack_index, and sometimes called close_midx()
on that pointer. Calling close_midx() on the same pointer is UB, since
close_midx() frees the provided pointer.

In other words, when this code was originally written, the 'm' variable
in midx_repack() could become stale.

But since f57a739691 (midx: avoid opening multiple MIDXs when writing,
2021-09-01), we don't pass a pointer into write_midx_internal(), only
the path to an object directory. So we can always call close_midx()
here.

Thanks,
Taylor
