Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C64A61F404
	for <e@80x24.org>; Wed, 27 Dec 2017 18:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752170AbdL0S7L (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 13:59:11 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:45530 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751187AbdL0S7K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 13:59:10 -0500
Received: by mail-it0-f66.google.com with SMTP id z6so25996617iti.4
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 10:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K3ecfqjcLqBeK8g0ceDT1ymTDQn7J4LKbbqxJXmcMn4=;
        b=t8lkUNAQy2pS1bJicFT80sexVnorh63AsG7vb7x1Vsm5gqmC7SWt1yxRiBMQ7rVdNO
         MXi0P+ras/ncEozXSlrPhpaUKMrZVNgSOcw/3lmYsN+ws4YaB7MFGw8929jvyHfizvcK
         /00Vb4cGraO0lcG76sdi+9X2H5f00r3FMaLYMEtPvhcuTnAk+Y4faekCyUe1MLsK2gd1
         zxc8dVb+Qx934/bnwCQXqtQWA5x32gNUsr2zGjmr9Cew3ATOWQrNSUv5F5AvVhehG+8u
         4Z/QRGSDm8/fXoE8GVxWusJKveSpzZfKIlAZAuBt31L7aYBzB2XdcQ3Z6PGUa0aRxNmG
         Cb9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K3ecfqjcLqBeK8g0ceDT1ymTDQn7J4LKbbqxJXmcMn4=;
        b=T2Y3/vr8vYLG2PsThRUWy8NzK193d1C+EP5tF3WWfJVGJay98Bl0meGx8nA+xOEZna
         /zalDn/pDZ6O3xstDzVAcGTSu8C0qB6KkCNgeksmTuc+bMsW5lCXzFyvW4LQU9Li0QTO
         omzV7zjZaBoPrmcRaFTM5vwDbbHGdQzjTKcxTaKsFzZiXoS8aIkJNu8c0p5H5bnF2p80
         p3NYztG2qnPypn7kV/2NADdMFCuJHfx5uzbPVshd2HWnRBytMQTXmvc3imbISn4MAZRP
         VxxgctpW6uE2AXynjL9fB3YXGlU1QeoqEe9IweP8/PkxOhHj+7exmp6umNkurefSsSdo
         mIUg==
X-Gm-Message-State: AKGB3mLjsPsGraJJAQYMa5BLM5tFrkicd4Vats1eGYa7AwvMTAcZHGUi
        ZrpLSHiyjGeHKNOj3eHNGNxHCCM6
X-Google-Smtp-Source: ACJfBou1qjcYjR3EVRRS3M+hQk0umdbaSDceekqR31qV4tZxWe+WQo82mIV3p+fiW6wnzIXld/Yj5A==
X-Received: by 10.36.128.212 with SMTP id g203mr16102278itd.108.1514401149833;
        Wed, 27 Dec 2017 10:59:09 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id 189sm10766272iof.72.2017.12.27.10.59.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Dec 2017 10:59:09 -0800 (PST)
Date:   Wed, 27 Dec 2017 10:59:07 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] diffcore: add a filter to find a specific blob
Message-ID: <20171227185907.GE149622@aiede.mtv.corp.google.com>
References: <CAGZ79kaJgCchQKcRMkW-cjRmx_7eYQDqLs5GgDOgLEb1H=w-0g@mail.gmail.com>
 <20171212012422.123332-1-sbeller@google.com>
 <20171214212234.GC32842@aiede.mtv.corp.google.com>
 <CAGZ79kZdUuoM79n09ziG0F7WCWNLpZ2AiFA6fb_qgND1b3_F9A@mail.gmail.com>
 <20171214225200.GA44616@aiede.mtv.corp.google.com>
 <xmqq374cspgw.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kYiL0St-600sjxN5gjLSfyRodS1=AqxyALsidntXkg_xA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kYiL0St-600sjxN5gjLSfyRodS1=AqxyALsidntXkg_xA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:
> On Thu, Dec 14, 2017 at 6:18 PM, Junio C Hamano <gitster@pobox.com> wrote:

>> I think it would make it a better companion to --pickaxe but we need
>> to align its behaviour a little bit so that it plays better with the
>> "--pickaxe-all" option, and also needs to hide mode and name only
>> changes just like pickaxe.
>
> I looked into this, and the small changes needed led me to thinking
> it could be integrated into the diffcore-pickaxe code completely,
> roughly like (spaces mangled):

Nice, this looks promising.

[...]
> But then, it seems as if any pickaxe option is incompatible with
> any other, i.e. from reading the code, you cannot combine -S
> and -G, or even give one of them twice.
>
> I guess that would be not a big deal for the --pickaxe-object,
> but just want to point it out.

Agreed that that's not a big deal for --pickaxe-object.

>> After all, the diffcore-blobfind code was written while looking at
>> the diffcore-pickaxe's code in another window shown in the pager,
>> and I tend to agree with your earlier message that this is an
>> extreme case of -S<contents> where the contents happens to be the
>> whole file.
>
> I disagree, as the user doesn't have the content, but the hash
> over the content only and wants to know more about it. The new
> option cannot be used to find a file whose partial content hashes to
> the given sha1, either.
>
> So with these considerations, I would keep the patch as currently\
> queued at sb/diff-blobfind.

Interesting --- I come to the opposite conclusion.

The pickaxe-style behavior seems more consistent and simpler to
explain and better matches the use cases I can think of.

Thanks,
Jonathan
