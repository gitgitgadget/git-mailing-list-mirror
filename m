Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0C742022A
	for <e@80x24.org>; Wed, 26 Oct 2016 12:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938703AbcJZM06 (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Oct 2016 08:26:58 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:35704 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965899AbcJZM0v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2016 08:26:51 -0400
Received: by mail-it0-f67.google.com with SMTP id f129so776519itc.2
        for <git@vger.kernel.org>; Wed, 26 Oct 2016 05:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rscRTSPLFLDu/w8v/66G8PHkTBjnd5qtatAs4ROhizw=;
        b=JbuobtXifeZjCKvIXtZeQ2AUf4SGhvmNWo7opNCtHesXzE+G7JxKn+Ke65gfl4tVUP
         x1yfMw8fVEkppy6Z9UJ2ZItdXaapw6SdmZheYX6UCvaQriAb2HFSH0b7rz0saQvytWUI
         dbNicvDS8p5MecRdUWeD65sMebT/7HuXViipCW1s0rspDMAwCIPzSG8MnODiDq7PS5/i
         PceI0NdXmsXGcetQrB7+6K8rsAHKDqfDWoc10i4+LFSlIxvEPIPDdnkx5SPNTdmb0/Ly
         1HwOVRA6ZusBnNdAZhgsKkU1jDMo3bdxKjqctK/RRSae1obr2bP68SBgqpeTdZWACUz0
         N2iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rscRTSPLFLDu/w8v/66G8PHkTBjnd5qtatAs4ROhizw=;
        b=Z5wA+TpDtPZU1zO7NeUR/Ia6KJSPIa79dOemffVExdvjW+TEiBIyhZf3no7SohcUow
         qDpvORNp9n08UBmBUeiaVZf7OIoZA02Qgh9+UxeGQiCg13L1aAYocn9lcHYIckt/QjCI
         mSw9dC+yz+DXS0GrW8yn4WT7va8uGNgMZdbw1dveuECywmfBoLSL09t9wNb1HRgxlSYe
         wlayw+ZTBk5leXnAIwaZLxIb80T1iTux6CBHXTfo06iThdzy1BIVIfcqRSHztmHJBaGS
         RECNVVbpMe7dHmQKJC+YQNCQoCmbgRzTLRWC0Yz1lyZiBpjZXqPZBVg/sywbZCYP0hvE
         xPIQ==
X-Gm-Message-State: ABUngvcHqaHI/gNxHRWq/cxRKFiolcVNr3uuuGRT0XNm/6IUg0UJ9z6WswFTYoRwKS8On+43k92wgVS1HfpDLA==
X-Received: by 10.36.118.82 with SMTP id z79mr2060839itb.74.1477484810949;
 Wed, 26 Oct 2016 05:26:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.164.102 with HTTP; Wed, 26 Oct 2016 05:26:20 -0700 (PDT)
In-Reply-To: <20161026121058.a2pmf57oc7p2mlsp@sigill.intra.peff.net>
References: <20161020061536.6fqh23xb2nhxodpa@sigill.intra.peff.net>
 <20161020062430.rxupwheaeydtcvf3@sigill.intra.peff.net> <CACsJy8DZWN0RRaDy9w2BVG5pn4FWCY=1YQDsP0V5obrr1wSzZQ@mail.gmail.com>
 <20161025151524.y7wwtetohhqgcvob@sigill.intra.peff.net> <20161026102921.GA31311@ash>
 <20161026121058.a2pmf57oc7p2mlsp@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 26 Oct 2016 19:26:20 +0700
Message-ID: <CACsJy8AHMJ7OJFKyjYAsPuT0nG=e0RGn59PuX06PJ5pYjinsqA@mail.gmail.com>
Subject: Re: [PATCH 7/7] setup_git_env: avoid blind fall-back to ".git"
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 26, 2016 at 7:10 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Oct 26, 2016 at 05:29:21PM +0700, Duy Nguyen wrote:
>
>> > I think you could conditionally make git_path() and all of its
>> > counterparts macros, similar to the way the trace code works. It seems
>> > like a pretty maintenance-heavy solution, though. I'd prefer
>> > conditionally compiling backtrace(); that also doesn't hit 100% of
>> > cases, but at least it isn't too invasive.
>>
>> OK, a more polished patch is this. There are warnings about
>> -fomit-function-pointers in glibc man page, at least in my simple
>> tests it does not cause any issue.
>
> Yeah, I tried with -fno-omit-frame-pointer, but it didn't help. The
> glibc backtrace(3) manpage specifically says:
>
>   The symbol names may be unavailable without the use of special linker
>   options. For systems using the GNU linker, it is necessary to use the
>   -rdynamic linker option. Note that names of "static" functions are not
>   exposed, and won't be available in the backtrace.
>
> which matches the behavior I get.
>
> Gcc ships with a libbacktrace which does seem to give reliable results
> (patch below for reference). But that's still relying on gcc, and on
> having debug symbols available.

Yep. On an optimized build you can't get anywhere without debug info,
which has a giant database to describe "if your rip/pc register is
here, then you clue to find your caller is there" for basically every
instruction in your program. Dwarf3 at least is a crazy world.

> I'm not sure this is really any convenience over dumping a corefile and using gdb to pull out the
> symbols after the fact.

So are we back to forcing core files? I'm ok with that! The only
inconvenience I see is pointing out where the core file is, which
should be where `pwd` originally is. On linux we can even peek into
/proc/sys/kernel/core_pattern if we want to be precise. ulimit can get
in the way, but I don't if the default out there is enable or disable
core dumping. Once we got OS info and git version, our chances of
cracking the core files should be reasonably high.
-- 
Duy
