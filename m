Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1451BC433DF
	for <git@archiver.kernel.org>; Mon, 18 May 2020 17:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5DAD2070A
	for <git@archiver.kernel.org>; Mon, 18 May 2020 17:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=spkdev.net header.i=@spkdev.net header.b="dmFxQ7FA";
	dkim=pass (1024-bit key) header.d=spkdev.net header.i=@spkdev.net header.b="dmFxQ7FA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbgERR0J (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 13:26:09 -0400
Received: from ns3309586.ip-5-135-160.eu ([5.135.160.121]:53692 "EHLO
        mail.spkdev.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgERR0J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 13:26:09 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.spkdev.net (Postfix) with ESMTP id 25CCF4034B;
        Mon, 18 May 2020 17:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spkdev.net; s=default;
        t=1589822768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L3YQT6n1zWd2qvYe29ELtHA0k53zX7vJV2h0yd4U4+8=;
        b=dmFxQ7FAssztjGE6sNXkG3xHhvigvhCdcGkQpvPUDsr/wdvlZ/SvIqDcKcSDToi4LZRlyP
        uilhr58Lz+YDlq2NbPtdHtqh3WdR6etkNFDwCdu0O0AujUOr44z9FYNb3RSzTxVMKEV0Zy
        +I7sR0ziA2ud34MUBamQhaJCy4XXdsg=
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.spkdev.net (Postfix) with ESMTPSA id CCA1C3FFDA;
        Mon, 18 May 2020 17:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spkdev.net; s=default;
        t=1589822768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L3YQT6n1zWd2qvYe29ELtHA0k53zX7vJV2h0yd4U4+8=;
        b=dmFxQ7FAssztjGE6sNXkG3xHhvigvhCdcGkQpvPUDsr/wdvlZ/SvIqDcKcSDToi4LZRlyP
        uilhr58Lz+YDlq2NbPtdHtqh3WdR6etkNFDwCdu0O0AujUOr44z9FYNb3RSzTxVMKEV0Zy
        +I7sR0ziA2ud34MUBamQhaJCy4XXdsg=
Date:   Mon, 18 May 2020 19:26:07 +0200
From:   Laurent Arnoud <laurent@spkdev.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v5] diff: add config option relative
Message-ID: <20200518172607.GC2110@spk-laptop>
References: <20200515155706.GA1165062@spk-laptop>
 <20200515233130.GC6362@camp.crustytoothpaste.net>
 <xmqq1rnk923o.fsf@gitster.c.googlers.com>
 <20200516173828.GB34961@spk-laptop>
 <92cb6302-09a8-6780-9398-890b1e766680@gmail.com>
 <20200516194033.GA2252@spk-laptop>
 <20200517021452.GA2114@danh.dev>
 <xmqqlflq7fyd.fsf@gitster.c.googlers.com>
 <20200518094021.GA2069@spk-laptop>
 <CAPig+cRNCdtK9SSMSXj83tTCV1n+YW3-a0EnfM_VVVCry8rXCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cRNCdtK9SSMSXj83tTCV1n+YW3-a0EnfM_VVVCry8rXCg@mail.gmail.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 18, 2020 at 12:19:20PM -0400, Eric Sunshine wrote:
> Let's move all the setup code into the test itself so that a failure
> of git-rev-parse will be caught. For instance:
> 
> check_diff_relative_option () {
>    dir=$1
>    shift
>    expect=$1
>    shift
>    relative_opt=$1
>    shift
>    test_expect_success "config diff.relative $relative_opt -p $*" "
>        short_blob=$(git rev-parse --short $blob_file2) &&
>        cat >expected <<-EOF &&
>        diff --git a/$expect b/$expect
>        new file mode 100644
>        index 0000000..$short_blob
>        --- /dev/null
>        +++ b/$expect
>        @@ -0,0 +1 @@
>        +other content
>        EOF
>        test_config -C $dir diff.relative $relative_opt &&
>        git -C '$dir' diff -p $* HEAD^ >actual &&
>        test_cmp expected actual
>    "
> }
> 
> Same comment applies to the other new function added by this patch.

Thanks its applied on the v6 patch

-- 
Laurent
