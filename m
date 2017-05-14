Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F50E20188
	for <e@80x24.org>; Sun, 14 May 2017 04:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751283AbdENE0B (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 May 2017 00:26:01 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35977 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750848AbdENE0B (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 May 2017 00:26:01 -0400
Received: by mail-pf0-f179.google.com with SMTP id m17so47341309pfg.3
        for <git@vger.kernel.org>; Sat, 13 May 2017 21:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=M0T+tW1n6Je72nM/Wn+lrLYIyT3VgNT3LIF3x1KZreU=;
        b=eE6DFMVDIObgFeMP4uJ3nv7swd8jZhgYU21NqOxIch7JUrTjuu98GSB6v1ZsV6lT6k
         4xteZxSb9tZHAenKRExJx3kn+PCpQmXJWP4RM+tctTK3iVmDaw7Vc8PVF1nZfiaSTPfc
         rvATy2FsFKZ2vTiQeiI+23y8iaLhcTNETH8qDMAn2H42BetfvSikEcHyfzjk8uBRnX19
         nTSDTmj5QIhtoiwbCy3TX1yN12fE8M7eqPJPdQi3Xm6cjzqLtsnFEZe3dxfw2/XV1K+O
         xK43sim5nCFAQ2qZhD667Mky97PzTCAt7Pve7eBoR8ehUF5gLPcEVQ2+/DDVzzeUstKj
         hJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=M0T+tW1n6Je72nM/Wn+lrLYIyT3VgNT3LIF3x1KZreU=;
        b=ZHJQslbKNR6RTm5F7dIK7BfQRFkrgV8LkRetrMv8PBFy2J9/IMdnJM+c/ZatbvyJl7
         lKc2LTnIl39RlOfH+M9Hnn+BmbHa8GO0sO3CFZzq6mqN1/z4tZXdhopCOGS6Jtq2Nwlj
         Wyu8Ewpo22712PHbvqPefQr0ro2IdquqbFUW5bMKZrwuGHuoCru1uoayVTKqfD/27sXE
         DXTmenerhh48/TxTTHfWsN0nIFtcDt7NLdKPHp3XAebFU4o6EHbqyUY5hnri1EOcMeeM
         gf7YDpdKHC0TxXRmTlGTzvl5Vpgv1OBEyINCQPOwpcf6eLINww7tFH15gllYsTVT+sjq
         d60g==
X-Gm-Message-State: AODbwcDoUr414Fj6QA6KbxQUAs2TIvm6tIeVPjbN9e+085gnhR6SBKKx
        citXyJaD2pzE6zgtQEnrPpoDmueLTI8i
X-Received: by 10.84.248.73 with SMTP id e9mr16408904pln.76.1494735960508;
 Sat, 13 May 2017 21:26:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Sat, 13 May 2017 21:25:59 -0700 (PDT)
In-Reply-To: <20170514040559.uvs6c2dnd6aelrln@sigill.intra.peff.net>
References: <20170514040117.25865-1-sbeller@google.com> <20170514040117.25865-19-sbeller@google.com>
 <20170514040559.uvs6c2dnd6aelrln@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Sat, 13 May 2017 21:25:59 -0700
Message-ID: <CAGZ79kaWQJ-UJxdVfkaXVdpXzHET+8xg9U9Pj9geE4kchcR1zA@mail.gmail.com>
Subject: Re: [PATCH 18/19] diff: buffer all output if asked to
To:     Jeff King <peff@peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 13, 2017 at 9:06 PM, Jeff King <peff@peff.net> wrote:
> On Sat, May 13, 2017 at 09:01:16PM -0700, Stefan Beller wrote:
>
>> +             for (i = 0; i < o->line_buffer_nr; i++);
>> +                     free((void*)o->line_buffer[i].line);
>
> I haven't looked at the patches yet, but this ";" on the for line is
> almost certainly a typo (gcc catches it due to the misleading
> indentation of the next line).

Grr  :/

I have spent hours trying to figure out why this does not work,
questioning the design, my mental model of how pointers work
and programming in general.

/me should get gcc 6 and set  -Wmisleading-indentation

Thanks,
Stefan

>
> -Peff
