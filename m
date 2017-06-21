Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	SORTED_RECIPS,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34B6F20401
	for <e@80x24.org>; Wed, 21 Jun 2017 22:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752105AbdFUWQG (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 18:16:06 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:34659 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751755AbdFUWQF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 18:16:05 -0400
Received: by mail-pg0-f43.google.com with SMTP id e187so30296220pgc.1
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 15:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Yn2Yx24y/JQIvCC9DJAh66QFr5aNzIWPc76nV0fUVZY=;
        b=DSDYXjBiHDEPKi6KdgOILJBbPe1vWXbSe9igJlKtapZumWAYxd0TVLmBhYqEi11Cg8
         cb3sWtlBCaeL+3dzS6TOP4TAQVXdQO3uCg3ejH7BGVX/PdccfRe/pom4OfHt3hXU7Vnh
         JzZS8NXvZtw1k2axO0Bhb2VlTvhMwfegQMK/2pVB4+Q1oRPgzKgMOLWpeVFeRQokiQi6
         HbkrvebprB9CYw2yu2dVsS4B5Xuettz3hpopTbL/wGe3tuXpH200zoETz1qaLUibbEw+
         Eu4PDlvnz8SlDYfrHxuLFq1sddflHfhvN2L6+yY31fJWv8Em3+L4MjH9FNEkzw9zhO/5
         8Usw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Yn2Yx24y/JQIvCC9DJAh66QFr5aNzIWPc76nV0fUVZY=;
        b=iXgDvMD+S88TT7oLEd1ujIaMgAa9P4A19USj8RlApYNjSf1Klj+fVniTU0Rjvb/u3p
         FFMfEGeYZmtq86DlT/CEgIhmsT2RwA20R/jY/HruljAQXxbWmbjKz/09R84KjLKyAB6i
         /XbcatgUH1sOyHthDDnO72GvdIcyzB7YUazOb7duRHv/UrbltDy0k4LVeFCRmcAAii7K
         B2+WmAegPrTUk/u8JdYHxit6l94xm4E5KbnhLnKaub8/8xb/kaY9hkXYJGJpGBm+QNz+
         0dHob2BGJwWyGPuvVohR/qL/MwR/J0h5JLoVgkFgyCxY5/6t2rExYqWWP0JTS76ciVO6
         mq5A==
X-Gm-Message-State: AKS2vOxOQVQuonX5XTkzOZdn3a44JHLbIQ7V5e/VzXJbH+NYd5UdgaDE
        19fD0NFZVBxTJMW0VPb5vs01ckpoBF/7M4o=
X-Received: by 10.84.232.205 with SMTP id x13mr19761142plm.245.1498083364512;
 Wed, 21 Jun 2017 15:16:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.161.227 with HTTP; Wed, 21 Jun 2017 15:16:04 -0700 (PDT)
In-Reply-To: <20170621213949.GD53348@google.com>
References: <CAGZ79kaqjQYmkt77kk5m=fdBfbZAvwd0YhhT7=O5b-FkQmDfHg@mail.gmail.com>
 <20170620024816.20021-1-sbeller@google.com> <20170620024816.20021-18-sbeller@google.com>
 <20170621213949.GD53348@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 21 Jun 2017 15:16:04 -0700
Message-ID: <CAGZ79kbQRy_gv7ZYiFM6CbF-sDnBVpP=dP+qa7aqxPH+MiQNig@mail.gmail.com>
Subject: Re: [PATCH 17/26] diff.c: convert show_stats to use emit_diff_symbol
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>>       case DIFF_SYMBOL_SUBMODULE_PIPETHROUGH:
>>               emit_line(o, "", "", line, len);
>>               break;
>> +     case DIFF_SYMBOL_STATS_SUMMARY_NO_FILES:
>> +             fprintf(o->file, " 0 files changed\n");
>
> Why is this one a fprintf call instead of an emit_line call?  I'm sure
> this is intended It just stands out to me.

I am sure it is unintended to stand out in such a way.
Originally I wanted to make it as close 1:1 conversion,
and as we did not emit the line prefix at the time but relied on
the line prefix being emitted prior to when this was printed.
Will convert to emit_line as that seems to be a bug in this patch.
