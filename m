Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D689B20248
	for <e@80x24.org>; Mon, 11 Mar 2019 21:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbfCKVmr (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 17:42:47 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40760 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728368AbfCKVmr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 17:42:47 -0400
Received: by mail-wr1-f68.google.com with SMTP id t6so480451wrw.7
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 14:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5DrUu1auoePp2j9A8D+hqrMYHFfT83R4btOUhQghzwM=;
        b=YC+OkEIuPBqmHxg9QHic6L4ZpSGXGYdIZPSiUWO7N1g2gG+afR70g5GOn0GOo5hS+I
         zfHPtuELzMkPvp/Km3dKTdseYD/ztU53JkHifiQZzy+s5otmKV2GsQ2prExQAmb6yCGK
         VACTxm9uQydceEksWwLY05mGbnxssNaovw0tQGNCEcgExOMK8GkOEB7ySxngCiNi5nsq
         uuX3ZkvVl445uFuV2s918c6M9eQs6Re59gKJaIIhiqUkwvlyjgPND2sF4YnWS30tOiUO
         ScwiLrETEK4yOIm7THoJFX/kp88uH/RSEZv3DIooGZ3d3mcBKHzp8IU89V0dk5wue+hv
         hbxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5DrUu1auoePp2j9A8D+hqrMYHFfT83R4btOUhQghzwM=;
        b=g24Nx/1x4lMJNA4hpnAzFEG7fs4+Ywtl+4XXzonu4r/Sh0/UiGZixLK/QBYM44uL7H
         Pvqmy2oSvM7LnRl2AuTvz08xB5cshyN25GDKVFhiQfMZthht9j9QCW763qKmlrP5H5eb
         zHW7AIFb+bCtmECBa7nKs5sLzTXpqJ043KeCALyP8UFwFNg7sGLEkgFnH3dDY+AOjnj/
         3Y1DRdMepZwROZ23JvPI81AMaCPR73aLn4zb8LdCjZdFk2cnobuAnrrl0fpfrmA9nzV6
         hXRPdiQONL0PRe040/d1oq7pJaam3oyQ67y2h9a04rp2z6WDwsnAhW4mddvn1fF3vMDl
         RC1w==
X-Gm-Message-State: APjAAAVaITMRFn3ELyux5RVlx6vJrRZrXwmMkXxLbf/T0VIDtw5BqOLo
        0mJVCWAAZCuhLiipp7w89RI=
X-Google-Smtp-Source: APXvYqzej/e52AJS8t9xLtlP/l/MoIN1axGth7yZyFDoHG4J+CCXPR1tlfbIM8sESM27p9WxRBg4Og==
X-Received: by 2002:adf:ecc6:: with SMTP id s6mr21927407wro.144.1552340565542;
        Mon, 11 Mar 2019 14:42:45 -0700 (PDT)
Received: from localhost ([95.148.214.107])
        by smtp.gmail.com with ESMTPSA id u14sm11416910wrr.42.2019.03.11.14.42.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 14:42:44 -0700 (PDT)
Date:   Mon, 11 Mar 2019 21:42:44 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Matthew Kraai <mkraai@its.jnj.com>
Subject: Re: [PATCH v13 18/27] stash: convert create to builtin
Message-ID: <20190311214244.GB16414@hank.intra.tgummerer.com>
References: <nycvar.QRO.7.76.6.1902191127420.41@tvgsbejvaqbjf.bet>
 <20190225231631.30507-1-t.gummerer@gmail.com>
 <20190225231631.30507-19-t.gummerer@gmail.com>
 <20190307191836.GB29221@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1903081630040.41@tvgsbejvaqbjf.bet>
 <20190309182610.GD31533@hank.intra.tgummerer.com>
 <xmqqimwqmbba.fsf@gitster-ct.c.googlers.com>
 <xmqqd0mxkgvy.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqd0mxkgvy.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/11, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Thomas Gummerer <t.gummerer@gmail.com> writes:
> >
> >> Subject: [PATCH 1/2] stash: pass pathspec as pointer
> >>
> >> Passing the pathspec by value is potentially confusing, as the copy is
> >> only a shallow copy, so save the overhead of the copy, and pass the
> >> pathspec struct as a pointer.
> >>
> >> In addition use copy_pathspec to copy the pathspec into
> >> rev.prune_data, so the copy is a proper deep copy, and owned by the
> >> revision API, as that's what the API expects.
> >
> > It does make quite a lot of sense, but do we need clear_pathspec()
> > at strategic places after we are done using these copied instances?
> 
> Another thing is that this also needs Dscho's fix to pass down the
> pathspec that was originally given, not the parsed part.

Good catch on both acconts.  I'll send a new patch soon, adding the
clear_pathspec() calls and rebasing it on top of Dscho's fix.
