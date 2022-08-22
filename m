Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD250C28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 17:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237337AbiHVR5m (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 13:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237332AbiHVR5k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 13:57:40 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E1F4455C
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 10:57:40 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id b2so8449788qkh.12
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 10:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=dQTsUxCApczY19Wx6JwImuN4Aqc+aGTQkWMf6ZwTCIM=;
        b=E+A3ObteSNePMMnY5iDy1nXDj+UdYzVw75YWNGHD9vdsyQ7AP2E8wirFFqpKj0W0eY
         UCcLuOYZA/ii8HN9vkGXvZii5CUR8aUrMIQDODHrmy7YsSk17l8TGXNHaHDG4i31uMsS
         TTNtNq7TmfJ96ne0A4ftVOqbVuY5RRSHTOBlBu5LkSK3OIZcKt1WZ/UYpxS2uxczECsJ
         hFMoIxCI5Vp1SKzvUxe2w2Dw6ymCjkJhZkUbIGVQNGQE8p3/Vsg+gmdJ1tg2QsVn9m/v
         3CawMaxz89rKlZskp3swsmTBxY5ASFkya5zYNo7YszVd3PY+t/Z5BnosSMnp/t+7UlsW
         6+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=dQTsUxCApczY19Wx6JwImuN4Aqc+aGTQkWMf6ZwTCIM=;
        b=fAP203mopWGwCw9al2CH5zEthd/ZmRhXXY0CPfds4JAuC2U/tpD0WdZ8u4lDzh2L0n
         4Uxd5qZAkHkxOwuEhCdF91QyevQKg0l0nv8tG/rDAI2UK+4oLvhfeaKoNl5rjfTewwnI
         3DujCKkAN7YhNIzVG+wPr4DsJRKwuU3lirRLj4HznFdZH1TIccFg0UVhr6kpQnGM625p
         H9yod/JAHeScuLmGExPcZKGUp2ETTBlO0J/Cl+L1Sm1f3mcT4mwhPYMIH2JZ5hHXYr38
         oReArhDPXOfx98Y0tpwsI0nGJrTmG5GcFhTErToXv++VIoIhEPIWUkjoFjqIqCZJf5+5
         IJ/A==
X-Gm-Message-State: ACgBeo0HoE5p4/3/l4G2Vs5jOPa3XgAzs+kCRAyvmAKyHRU/AKaE9dyt
        l2Hb076Apwe+vjeg230YqxjJOxx/mOrDKnGD
X-Google-Smtp-Source: AA6agR7l5B3Z3bHKr3cqYvo7puJ6+SnQmnXJqu88SQ1vOBg6x+8cVOJ2Mk1zocvytpMEs7zNIFkAww==
X-Received: by 2002:a05:620a:294c:b0:6bc:1d0d:d873 with SMTP id n12-20020a05620a294c00b006bc1d0dd873mr3347930qkp.355.1661191059155;
        Mon, 22 Aug 2022 10:57:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a0bcb00b006bb9125363fsm11553875qki.121.2022.08.22.10.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 10:57:38 -0700 (PDT)
Date:   Mon, 22 Aug 2022 13:57:37 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de,
        chakrabortyabhradeep79@gmail.com, jonathantanmy@google.com,
        kaartic.sivaraam@gmail.com
Subject: Re: [PATCH 1/6] t5326: demonstrate potential bitmap corruption
Message-ID: <YwPDkW8KemC5Hs/C@nand.local>
References: <cover.1660944574.git.me@ttaylorr.com>
 <3e30ab1a19115107fc24a25118f2417319bd1b0d.1660944574.git.me@ttaylorr.com>
 <3525f8bd-31af-181d-b7a5-6e8a453bbba7@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3525f8bd-31af-181d-b7a5-6e8a453bbba7@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 22, 2022 at 12:09:55PM -0400, Derrick Stolee wrote:
> On 8/19/2022 5:30 PM, Taylor Blau wrote:
>
> > +test_expect_success 'preferred pack change with existing MIDX bitmap' '
> > +	rm -fr repo &&
>
> Does a previous test not delete 'repo' when necessary?
>
> Or, do previous tests re-use 'repo' and now we are in a region
> where we can safely clear that directory? Should we use a
> different name?
>
> > +	git init repo &&
> > +	test_when_finished "rm -fr repo" &&
>
> nit: test_when_finished should be the first line of the test.

The "rm-then-init-then-test_when_finished" is an (unfortunate) pattern
extended throughout t5326, mostly that some tests don't clean up "repo"
after deleting and recreating it.

But it's easy enough to just use a separate repository, and avoid
removing it altogether. Thanks for the suggestion!

> > +		# Generate a new MIDX which changes the preferred pack to a pack
> > +		# contained in the existing MIDX, such that not all objects from
> > +		# p2 that appear in the MIDX had their copy selected from p2.
> > +		git multi-pack-index write --bitmap \
> > +			--preferred-pack="pack-$p2.pack" &&
> > +		test_path_is_file $midx &&
> > +		test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
> > +
> > +		test_must_fail git clone --no-local . clone2
>
> This section is demonstrating the bug. Perhaps we should have
> comments indicating that this is not desired behavior, but is
> being demonstrated so the bug can be fixed by a later change?

Yeah, good call. Thanks again!

Thanks,
Taylor
