Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8138520248
	for <e@80x24.org>; Sat, 13 Apr 2019 05:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbfDMFve (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Apr 2019 01:51:34 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56061 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfDMFve (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Apr 2019 01:51:34 -0400
Received: by mail-wm1-f68.google.com with SMTP id o25so13696059wmf.5
        for <git@vger.kernel.org>; Fri, 12 Apr 2019 22:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=rD4/WgkVPhpTR+kAVp+YsUtr/NNCAmDRYiP1+IvITiU=;
        b=MyVZ2kIUoopDqa3atFIGJs81P27WdwfShZ2TDXUCQXDk2Co+TpnLilL8KEIhzJyyaW
         2bvbpfNzc/c28I5p9NthzsLDXetKCAWJUD1RTiPzu1JrrLdQeb0rBvxgLUTyAkRg2Fj9
         CWj5W4h0O2TilE4QU/xCKHUPHXZmSABi1FB5YFJF7OqI0LLTkPpeYT8lgZizhu3Eg1oi
         q/edTQ/Ygo6KHXJ2juY6FPMZnc640fly8sRHankGj1V2iy64bYzL9ArQZVbleMGrlpT+
         Qo7ENGnKvBbjd4CeCzTh28Svdez2VVnfDDGcsPPpelx3baFd/qVm7aC9ukcTJf45+yOf
         mTWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=rD4/WgkVPhpTR+kAVp+YsUtr/NNCAmDRYiP1+IvITiU=;
        b=Tx8BoGonFcGKpZkvYRXczCAgRUhipOyzVBseibxfqSIEVR9Bkeo+8dSgyubDQvCORF
         L0+oXfAg2mGNO70WDQQjsJl0GZS+4EmJUcY12S+yjbgEVZ2Z0NX19+4XkEm1R6otwQOc
         buqncnMOknORoSUYqNJlpf9hZ7TXmaVZvNe0FePHgaP1NM5GBgAfjmSxsgBiLVJ93OJL
         7aGMt1lCx5Bb+bB4354Mp8oIIJsHZZ4PYxGIeOdxmd7mALqpQ2gg2KVCKyZPzy3/dYgo
         zGCxWmsQnkQ3asRfzPoQgcwm/ED0i8BpKxxiewyRTTB8GhcaZG6sHiTrIS6e1gc2Uq1K
         Q5Jw==
X-Gm-Message-State: APjAAAWKhwmg8Wakdru+3H7sK0H8Qv9xisONolkx+JFuVt5ZF2Zbi0MT
        25XszH/3HC9IkXuhh0XPDyCrcrmvo+w=
X-Google-Smtp-Source: APXvYqzfZlDt9SZCs8OJZ1WpfA+1uYsc1tvrne35HfaNs3D9dqx6tEwGJOA75MviUaPtTsl7kvXMlQ==
X-Received: by 2002:a1c:e904:: with SMTP id q4mr13639770wmc.43.1555134692293;
        Fri, 12 Apr 2019 22:51:32 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id x21sm40402459wrd.45.2019.04.12.22.51.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 22:51:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Rohit Ashiwal via GitGitGadget <gitgitgadget@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Subject: Re: [PATCH 1/2] archive: replace write_or_die() calls with write_block_or_die()
References: <pull.145.git.gitgitgadget@gmail.com>
        <7a9525a78a7b7b237150b9264cf675a4a0b37267.1555110278.git.gitgitgadget@gmail.com>
        <20190413013451.GB2040@sigill.intra.peff.net>
Date:   Sat, 13 Apr 2019 14:51:31 +0900
In-Reply-To: <20190413013451.GB2040@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 12 Apr 2019 21:34:52 -0400")
Message-ID: <xmqqzhouwizg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> +/* writes out the whole block, or dies if fails */
>> +static void write_block_or_die(const char *block) {
>> +	if (gzip) {
>> +		if (gzwrite(gzip, block, (unsigned) BLOCKSIZE) != BLOCKSIZE)
>> +			die(_("gzwrite failed"));
>> +	} else {
>> +		write_or_die(1, block, BLOCKSIZE);
>> +	}
>> +}

I agree everything you said you your two review messages.

One thing you did not mention but I found disturbing was that this
does not take size argument but hardcodes BLOCKSIZE.  If the patch
were removing use of BLOCKSIZE in its callers (because everybody
uses the same constant), this would not have bothered me, but as the
caller passes BLOCKSIZE to all its callees except this one, I found
that the interface optimizes for a wrong thing (i.e. reducing
one-time pain of writing this single patch of having to repeat
BLOCKSIZE in all calls to this function).  This function should be
updated to take the size_t and have its caller(s) pass BLOCKSIZE.

Thanks for a review, and thanks Rohit for starting to get rid of
external dependency on gzip binary.
