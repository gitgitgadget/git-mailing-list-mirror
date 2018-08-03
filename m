Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0290A1F597
	for <e@80x24.org>; Fri,  3 Aug 2018 02:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbeHCEvS (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 00:51:18 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43260 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbeHCEvR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 00:51:17 -0400
Received: by mail-pg1-f196.google.com with SMTP id d17-v6so2124170pgv.10
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 19:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JJE6+NgvcOI/OyFHfEuTQ7PNX5hWS/Jl0yHIhOUxl6Q=;
        b=YXYD395uQH7Grw51XV5jrkLf0KoM/SQwfxopcmU22soA2L8/pKLxjfMzTegJGs58b6
         /KBKk2EW24nu+kQFU7oSmpUxRAB74LZhM/CmOF5TeEAO3Vgff4NLJUA79Ay1ynAo/dnU
         8McSI94nsUqvc4EmrvT9EKCNhHIlNBpoSqYwW0yhAzMrqp0Zuqd60EcSc5agckp3WVS+
         ZJIbMC00tpwxS8xl5spE5ciehj5NdOWf7MotMq4wdbrQBTxU7DI6uWng948xdXcVtSuK
         EQwJIzvOULHOBWIN9qZREwecUHaemEsdk3dllSCmAuzmEdQ7NPzr70hU7Ujd5skWAsp9
         ebMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JJE6+NgvcOI/OyFHfEuTQ7PNX5hWS/Jl0yHIhOUxl6Q=;
        b=N3fnOavpnoiNZWTh7t1J/U+SKeOj7Gu462znqyYedDWFzp+VCP37RCm5uD4M+YkDLd
         sO3BB4XmcFXdRFN1ONpVQGLlNs59BYud4ea/gx9irjDDhkNx2amghNc1GVI4CeAYQ4Bw
         ejsmGICwCxLc3uDBvkIiw08uSg/pjp4wTvOSSTTo4Vb6L7gfn7KPlkHC/Jwjc6cbHLuT
         UyC+6Kj6NVHMteAzy9CHR+bkbxhns5aJsqJARZfChJah7dEWFHKzkmAncGab7LAr1ylT
         hrj1KRU0iDy3Nb5vLGoOE8xmT37NyWfW/zoBHge5gcpAWl/irCl13jc7B5bsfnAruwq+
         3c8w==
X-Gm-Message-State: AOUpUlGTMNjI5ScUMrlynVsX0Iix4Sta7CnEBZIbM7BpCnpbZflQnjAD
        49lZP+hi9L86VA7ytPpCVZADlSCu
X-Google-Smtp-Source: AAOMgpevc+NLXopDZWkKLpOfry3zeg6V/5p3KvCA/7Z2LvajNEMvrPGzcd2fkxPfkYcWNSOeKPeYfg==
X-Received: by 2002:a63:e206:: with SMTP id q6-v6mr1866244pgh.223.1533265032159;
        Thu, 02 Aug 2018 19:57:12 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id 1-v6sm5888348pfm.145.2018.08.02.19.57.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 19:57:11 -0700 (PDT)
Date:   Thu, 2 Aug 2018 19:57:09 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Dan Shumow <danshu@microsoft.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Edward Thomson <ethomson@edwardthomson.com>,
        Git Mailing List <git@vger.kernel.org>,
        demerphq <demerphq@gmail.com>, Adam Langley <agl@google.com>,
        "keccak@noekeon.org" <keccak@noekeon.org>
Subject: Re: Hash algorithm analysis
Message-ID: <20180803025709.GD197924@aiede.svl.corp.google.com>
References: <20180609205628.GB38834@genre.crustytoothpaste.net>
 <20180609224913.GC38834@genre.crustytoothpaste.net>
 <20180611192942.GC20665@aiede.svl.corp.google.com>
 <20180720215220.GB18502@genre.crustytoothpaste.net>
 <20180724190136.GA5@0f3cdde9c159>
 <CA+55aFwSe9BF8e0hLk9pp3FVD5LaVY5GRdsV3fbNtgzekJadyA@mail.gmail.com>
 <xmqqzhygwd5o.fsf@gitster-ct.c.googlers.com>
 <20180724221008.GI18502@genre.crustytoothpaste.net>
 <nycvar.QRO.7.76.6.1807301058560.10478@tvgsbejvaqbjf.bet>
 <MWHPR21MB01738A46E37527E45E950937C42F0@MWHPR21MB0173.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB01738A46E37527E45E950937C42F0@MWHPR21MB0173.namprd21.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dan,

Dan Shumow wrote:

[replying out of order for convenience]
> However, I agree with Adam Langley that basically all of the
> finalists for a hash function replacement are about the same for the
> security needs of Git.  I think that, for this community, other
> software engineering considerations should be more important to the
> selection process.

Thanks for this clarification, which provides some useful context to
your opinion that was previously relayed by Dscho.

[...]
> So, as one of the coauthors of the SHA-1 collision detection code, I
> just wanted to chime in and say I'm glad to see the move to a longer
> hash function.  Though, as a cryptographer, I have a few thoughts on
> the matter that I thought I would share.
>
> I think that moving to SHA256 is a fine change, and I support it.

More generally, thanks for weighing in and for explaining your
rationale.  Even (especially) having already made the decision, it's
comforting to hear a qualified person endorsing that choice.

Sincerely,
Jonathan
