Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE88E20798
	for <e@80x24.org>; Wed,  4 Jan 2017 22:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968499AbdADWBy (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jan 2017 17:01:54 -0500
Received: from mail-pg0-f43.google.com ([74.125.83.43]:36691 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968484AbdADWBr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2017 17:01:47 -0500
Received: by mail-pg0-f43.google.com with SMTP id f188so231556849pgc.3
        for <git@vger.kernel.org>; Wed, 04 Jan 2017 14:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=lc4Hocs886kyFfYrpZNI91i4ChuH2LL42el46/x0vXI=;
        b=FbUQ16+jAUYEXqeP8QXoafc58cDJW58NGUehBV/QbBid2NrijHW3b50tpu7lBtM3Fd
         1F/MQU9eosPmm/7G8NdRwVAyb1OyrRcQn4TrWfz6iLV0rmqXc7l7HaAIcP38jnToXbtL
         wjQYOja03wYzqe3XX7n5+eMXCEDEXKMUHOr/Zpg8q6D8zOGJ6cBWqrbTGGl2JDDRdMoB
         nD/ncFYryGRMNN+gLBZWT8wXR0riQP37htvUnUPz+gm9610Hx6hP6Mz4mefn1lOoK3Me
         IA/P5mXxeo0iEFFsqX8MHwcAId03YNmHOVeKz7SXm+QeWHl3BC6FiZKibzpAEyukJUGc
         Rx3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lc4Hocs886kyFfYrpZNI91i4ChuH2LL42el46/x0vXI=;
        b=gTFo8k3hgiT/gN36Jdxgm5g2so8CAan6xJ6QYY24VopDPsMYssppZngKJ8et7w96d+
         UIgSpx4PdpKjjSFBviA6x+dWOhpszNoffbg23XJmYrqjt+qnrHS8DinfxLcxaCW1h8PE
         64c4di8TEJPYA/Ci+hl0L1iStj13IFYnTb+NO4gEHJdyeu2Qgz0knqxAMzF1Jm0EK+5Z
         vGsuCoX5P0cpvWphkC1DHzxjYagP4XNsvVcg/cg8rXxHdfm0L6txpJxzTXOsM4TfLM9J
         bKsCvYg49BD1fepz5pSx2VgOq3FWdbcPEZenMW0znsbfUJ02gOSPAyXb5BUE4puRLebQ
         oaiQ==
X-Gm-Message-State: AIkVDXLj2Kf4r5085Q7PE6zXisJr3WZxaSWuH6KoLsQOQEJEJTpzmphPBehFep4wyH9bUCzS
X-Received: by 10.84.164.231 with SMTP id l36mr150318146plg.33.1483566922372;
        Wed, 04 Jan 2017 13:55:22 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:1930:3cb0:6c91:e070])
        by smtp.gmail.com with ESMTPSA id p68sm148954065pfd.11.2017.01.04.13.55.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 04 Jan 2017 13:55:21 -0800 (PST)
Date:   Wed, 4 Jan 2017 13:55:20 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Sixt <j6t@kdbg.org>, Duy Nguyen <pclouds@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v4 0/5] road to reentrant real_path
Message-ID: <20170104215520.GA68241@google.com>
References: <1481566615-75299-1-git-send-email-bmwill@google.com>
 <20170103190923.11882-1-bmwill@google.com>
 <20170104004825.3s27dsircdp5lqte@sigill.intra.peff.net>
 <3f9a530c-402f-f276-4721-fa6a8a6fef41@web.de>
 <20170104070107.huse2a6thz737epv@sigill.intra.peff.net>
 <20170104181318.GC69227@google.com>
 <CAGZ79kbdNuGe038Wb9OR1SKq-XYtsPrLsn6XueO6zsKKGFYiNg@mail.gmail.com>
 <CA+P7+xp+j1ajPLjE-RukSmp33_bRkD7J65X-++frkYd9LWLSkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+P7+xp+j1ajPLjE-RukSmp33_bRkD7J65X-++frkYd9LWLSkQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/04, Jacob Keller wrote:
> On Wed, Jan 4, 2017 at 10:22 AM, Stefan Beller <sbeller@google.com> wrote:
> > On Wed, Jan 4, 2017 at 10:13 AM, Brandon Williams <bmwill@google.com> wrote:
> >> On 01/04, Jeff King wrote:
> >>> On Wed, Jan 04, 2017 at 07:56:02AM +0100, Torsten Bögershausen wrote:
> >>>
> >>> > On 04.01.17 01:48, Jeff King wrote:
> >>> > > On Tue, Jan 03, 2017 at 11:09:18AM -0800, Brandon Williams wrote:
> >>> > >
> >>> > >> Only change with v4 is in [1/5] renaming the #define MAXSYMLINKS back to
> >>> > >> MAXDEPTH due to a naming conflict brought up by Lars Schneider.
> >>> > >
> >>> > > Hmm. Isn't MAXSYMLINKS basically what you want here, though? It what's
> >>> > > what all other similar functions will be using.
> >>> > >
> >>> > > The only problem was that we were redefining the macro. So maybe:
> >>> > >
> >>> > >   #ifndef MAXSYMLINKS
> >>> > >   #define MAXSYMLINKS 5
> >>> > >   #endif
> >>> > >
> >>> > > would be a good solution?
> >>> > Why 5  ? (looking at the  20..30 below)
> >>> > And why 5 on one system and e.g. on my Mac OS
> >>> > #define MAXSYMLINKS     32
> >>>
> >>> I mentioned "5" because that is the current value of MAXDEPTH. I do
> >>> think it would be reasonable to bump it to something higher.
> >>>
> >>> > Would the same value value for all Git installations on all platforms make sense?
> >>> > #define GITMAXSYMLINKS 20
> >>>
> >>> I think it's probably more important to match the rest of the OS, so
> >>> that open("foo") and realpath("foo") behave similarly on the same
> >>> system. Though I think even that isn't always possible, as the limit is
> >>> dynamic on some systems.
> >>>
> >>> I think the idea of the 20-30 range is that it's small enough to catch
> >>> an infinite loop quickly, and large enough that nobody will ever hit it
> >>> in practice. :)
> >>
> >> I agree that we should have similar guarantees as the OS provides,
> >> especially if the OS already has MAXSYMLINKS defined.  What then, should
> >> the fall back value be if the OS doesn't have this defined?  5 like we
> >> have done historically, or something around the 20-30 range as Torsten
> >> suggests?
> >
> > As a fallback I'd rather go for a larger number than too small.
> > The reason for the existence is just to break an infinite loop
> > (and report an error? which the current code doesn't quite do,
> > but your series actually does).
> >
> > If the number is too large, then it takes a bit longer to generate the error
> > message, but the error path is no big deal w.r.t. performance, so it's fine
> > for it taking a bit longer.
> >
> > If the number is too low, then we may hinder people from getting actual
> > work done, (i.e. they have to figure out what the problem is and recompile
> > git), so I'd think a larger number is not harmful. So 32?
> >
> 
> I think I agree as well.
> 
> Thanks,
> Jake
> 
> >>
> >> --
> >> Brandon Williams

That's two people for 32.  I'll use that as the fallback and resend the
series.

-- 
Brandon Williams
