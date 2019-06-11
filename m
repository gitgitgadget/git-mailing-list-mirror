Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 004241F462
	for <e@80x24.org>; Tue, 11 Jun 2019 12:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387593AbfFKMiS (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jun 2019 08:38:18 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45856 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfFKMiR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jun 2019 08:38:17 -0400
Received: by mail-wr1-f68.google.com with SMTP id f9so12822478wre.12
        for <git@vger.kernel.org>; Tue, 11 Jun 2019 05:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=LnzpW6kPkg4zMhuJkAlFbgqsvHuNjMBdfwKulsGt1dI=;
        b=F4NoppEnGzWKfhq+CWywdpYaC/ivh6mDdXeQijEzVOvzuV+HIrLZLEPQknHpsmPTvv
         fxWBaDkKFVXIsB/M4I2xcjXZYdcfEo4VJlte0FnGvt1tiQuCSeO8nPrcZEaCZ+oJAlwb
         IBRvIEiWSXMmhiWNaVL2AtMx9Tf+gkpCJTQJI8PA2MiqdlLNQR/EwQxSK4okTPNMKLQs
         7DvNMb5PTcHV9mOGTL88EAZ9EsiLhr7L4SGUO3nrIYf0a1lGcJMFEg3d1cJbmkLpzVq2
         xs5g9QRP5HWDy1wkNp+NtYx/MnUUIuwrmeSUEpWuUktPVVruqjj9IeudxeTDK5QT6Bog
         Ddjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LnzpW6kPkg4zMhuJkAlFbgqsvHuNjMBdfwKulsGt1dI=;
        b=hudiAzu0VoG7+yg3hKt++ioQXxVPqaqhjCzPQ3J7+G74MNcF1atSSrp79IJiTOKmYP
         E5GBLykpgjkUhgfBRW5i3vE54wiiJ1lDo4lIcI/8HpB19TIUMsyJNdjoInSGmcrCPlbW
         qyYvkddRLIfTjuJ/cDABjoELWFbvskFT2X1moEgxL1kH47LqT8DCEigZqch/2AyvKpud
         1ixhCGbRETiwfCXeIgGTbLVcicZDzfaRAkq4BqpqBPcQReLrwS05FpZk2PVBHgDYGOfA
         srzlxkBOjv7M6DDwifEuHi4lZayATiw2+w1s/E+r+e5Dl0ulL5SjG2JOT8CB5NEdjB8/
         986Q==
X-Gm-Message-State: APjAAAWo4atuDI4YN7WqkkRvkEJf31EBs8Zg1wTGVkEtiq+WKRiozro6
        X6QcD8KGtbyliQb9/jA8bJw=
X-Google-Smtp-Source: APXvYqxE47IKQbgyO0tQjbdzkLDb5ZHV6FR4sK2fUjD0az8sc6qOb08kHzz59sYQoxKQr2bO1Sb66A==
X-Received: by 2002:a5d:5702:: with SMTP id a2mr5104645wrv.89.1560256696124;
        Tue, 11 Jun 2019 05:38:16 -0700 (PDT)
Received: from szeder.dev (x4d0cbedf.dyn.telefonica.de. [77.12.190.223])
        by smtp.gmail.com with ESMTPSA id o6sm2733973wmc.15.2019.06.11.05.38.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 05:38:14 -0700 (PDT)
Date:   Tue, 11 Jun 2019 14:38:11 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] rebase: fix garbled progress display with '-x'
Message-ID: <20190611123811.GF4012@szeder.dev>
References: <20190430142556.20921-1-szeder.dev@gmail.com>
 <nycvar.QRO.7.76.6.1904301819540.45@tvgsbejvaqbjf.bet>
 <20190501231640.GD14763@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190501231640.GD14763@szeder.dev>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 02, 2019 at 01:16:40AM +0200, SZEDER Gábor wrote:
> On Tue, Apr 30, 2019 at 06:25:35PM -0400, Johannes Schindelin wrote:
> > > Make sure that the previously displayed "Rebasing (N/M)" line is
> > > completely covered up by printing a terminal width worth of space
> > > characters.

> > > +			if (!opts->verbose)
> > > +				/*
> > > +				 * Fully cover the previous "Rebasing (n/m)"
> > > +				 * progress line.
> > > +				 */
> > > +				fprintf(stderr, "%*s\r", term_columns(), "");
> > 
> > IIRC there are terminals (`cmd.exe`?) that would advance to the next row
> > automatically when printing the exact number of columns in a row. So this
> > would not work.
> 
> Hrm, I though about using 'term_columns()-1', or moving the '\r' from
> the format string to the string to be printed, but in the end didn't
> do either, because it seemed to work well as it is in the two
> terminals that I tried (on Linux).

And I would have been wrong doing so, because that fprintf'ed string
ends with '\r', not '\n', and therefore it is actually necessary to
write as many space characters as the width of the terminal, or the
last character in the previously displayed line won't get overwritten.

