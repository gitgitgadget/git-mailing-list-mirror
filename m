Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_12_24,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA4851F859
	for <e@80x24.org>; Sat,  6 Aug 2016 20:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751660AbcHFUAv (ORCPT <rfc822;e@80x24.org>);
	Sat, 6 Aug 2016 16:00:51 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:51830 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751559AbcHFUAt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2016 16:00:49 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 052392018E;
	Fri,  5 Aug 2016 23:38:38 +0000 (UTC)
Date:	Fri, 5 Aug 2016 23:38:38 +0000
From:	Eric Wong <e@80x24.org>
To:	Lars Schneider <larsxschneider@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>, gitster@pobox.com,
	jnareb@gmail.com, tboegi@web.de, mlbright@gmail.com,
	remi.galan-alfonso@ensimag.grenoble-inp.fr, pclouds@gmail.com,
	ramsay@ramsayjones.plus.com, peff@peff.net
Subject: Re: [PATCH v2 5/5] convert: add filter.<driver>.process option
Message-ID: <20160805233838.GA29867@starla>
References: <20160722154900.19477-1-larsxschneider@gmail.com>
 <20160727000605.49982-1-larsxschneider@gmail.com>
 <20160727000605.49982-6-larsxschneider@gmail.com>
 <20160727094102.GA31374@starla>
 <64C7D52F-9030-460C-8F61-4076F5C1DDF6@gmail.com>
 <20160805185559.GB463@starla>
 <4499EF4B-974C-4D59-B95F-541EA4CF4078@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4499EF4B-974C-4D59-B95F-541EA4CF4078@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

> >>> larsxschneider@gmail.com wrote:
> >>>> +static int apply_protocol_filter(const char *path, const char *src, size_t len,

Lars Schneider <larsxschneider@gmail.com> wrote:
> > On 05 Aug 2016, at 20:55, Eric Wong <e@80x24.org> wrote:
> > Perhaps using xsize_t in git-compat-util.h works for now:
> > 
> > 	len = xsize_t(file_stat.st_size);
> 
> Thanks for the hint! Should I add the same check to sha1_file's use
> of fstat in line 1002 or is it not needed there?
> 
> https://github.com/git/git/blob/c6b0597e9ac7277e148e2fd4d7615ac6e0bfb661/sha1_file.c#L1002

Not needed, if you look at the definition of "struct packed_git"
in cache.h, you'll see pack_size is already off_t, not size_t
like `len` is.
