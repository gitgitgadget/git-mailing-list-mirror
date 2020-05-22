Return-Path: <SRS0=kZBr=7E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44501C433E0
	for <git@archiver.kernel.org>; Fri, 22 May 2020 10:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 149392065C
	for <git@archiver.kernel.org>; Fri, 22 May 2020 10:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=spkdev.net header.i=@spkdev.net header.b="qECJErv5";
	dkim=pass (1024-bit key) header.d=spkdev.net header.i=@spkdev.net header.b="qECJErv5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbgEVKsi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 May 2020 06:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728606AbgEVKsh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 May 2020 06:48:37 -0400
Received: from mail.spkdev.net (unknown [IPv6:2001:41d0:8:e379::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6522DC061A0E
        for <git@vger.kernel.org>; Fri, 22 May 2020 03:48:37 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.spkdev.net (Postfix) with ESMTP id 838EB40348;
        Fri, 22 May 2020 10:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spkdev.net; s=default;
        t=1590144514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SgetkshzBTtZYjzoTQ79xGSPEOcCTmq4PDQxtGz9N/g=;
        b=qECJErv5jiOCUZjqo0tHiPpP/Q0UbjovIxWllaqaw/RcD10rqZHfIq6X5ZNSBTaseJ5Ihg
        nueRS2Pl3HAyTc6SYemnY4IarkxjwTrqWzYrIK2YzKDy8B0FPS9WihljMJ/PqDLX6vga8w
        aNatpLB15FD8uravMs+FTcw/Zwtcv2w=
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.spkdev.net (Postfix) with ESMTPSA id 0840C400F2;
        Fri, 22 May 2020 10:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spkdev.net; s=default;
        t=1590144514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SgetkshzBTtZYjzoTQ79xGSPEOcCTmq4PDQxtGz9N/g=;
        b=qECJErv5jiOCUZjqo0tHiPpP/Q0UbjovIxWllaqaw/RcD10rqZHfIq6X5ZNSBTaseJ5Ihg
        nueRS2Pl3HAyTc6SYemnY4IarkxjwTrqWzYrIK2YzKDy8B0FPS9WihljMJ/PqDLX6vga8w
        aNatpLB15FD8uravMs+FTcw/Zwtcv2w=
Date:   Fri, 22 May 2020 12:48:33 +0200
From:   Laurent Arnoud <laurent@spkdev.net>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, phillip.wood@dunelm.org.uk,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH v7] diff: add config option relative
Message-ID: <20200522104833.GB2050@spk-laptop>
References: <xmqqlflq7fyd.fsf@gitster.c.googlers.com>
 <20200518094021.GA2069@spk-laptop>
 <20200518135656.GB1980@danh.dev>
 <xmqq4ksd5ggq.fsf@gitster.c.googlers.com>
 <20200518191205.GA1999@danh.dev>
 <xmqqo8ql0yjg.fsf@gitster.c.googlers.com>
 <20200519003006.GC1999@danh.dev>
 <xmqqv9krztwp.fsf@gitster.c.googlers.com>
 <20200519193902.GA202573@spk-laptop>
 <20200519230124.GA12509@danh.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200519230124.GA12509@danh.dev>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 20, 2020 at 06:01:24AM +0700, Đoàn Trần Công Danh wrote:
> Sorry, I didn't think about this earlier.
> 
> > +	test_expect_success "config diff.relative $relative_opt -p $*" "
> > +		short_blob_file1=$(git rev-parse --short $blob_file1) &&
> > +		short_blob_file2=$(git rev-parse --short $blob_file2) &&
> 
> This test also needs to quote that dollar.
> Beside that, LGTM.

No worries I've submitted a v8 patch, thanks everyone for the reviews

-- 
Laurent
