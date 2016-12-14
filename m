Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAE4F1FF40
	for <e@80x24.org>; Wed, 14 Dec 2016 22:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933073AbcLNWGm (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 17:06:42 -0500
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35824 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933061AbcLNWGl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 17:06:41 -0500
Received: by mail-pf0-f179.google.com with SMTP id i88so5334376pfk.2
        for <git@vger.kernel.org>; Wed, 14 Dec 2016 14:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kZHGNlV5h/9gJsNgvJGhfQG1Aaewqev6y8eWy0ms3SA=;
        b=CDsxezn1OOHA/L9xrTIf9Bs9u1Sp3vgl5qARzytryMijjSGqXDixZKbCn4GTmob1Je
         8SsISRiPGQMGT+gsKQ+3VUqor4Ifl3GcAcs7SxozGxeVuxckO43IgO/bU5anlB0Thdwh
         boS1MqbyRoIxw/werahrOV5MlF21v4C2Vd3q9lu83NRehw9g0SENiIBflF2nXyliG1xY
         YW8zegORNtOuHrKxd91zICzqp3CQP+wmdVSRhtYLOI7mNPe4J+gU4OvPC+tdBRmKBQ14
         6kjIHYJbP93huslyLs/xZ6G13ewbZ08RhTl+iy5LE9lEsU95RkrtCUR79dVL+ex0++Nl
         OVAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kZHGNlV5h/9gJsNgvJGhfQG1Aaewqev6y8eWy0ms3SA=;
        b=GAPBQHcDfkkrynF2OdTMHl3Ue3WwHYoDgIn/9N5iqLtG5118EuPhksSGNQZaLDIZ9T
         5Pje/UUlpEkrumuUcPZxlAkszncBcZKmP3Q3Y6K7+TkbPSg+YX8VqnpAjWPus/Msa+ic
         rncEsl6ayRNubcNQZzUWZUjyNpTiB/QlYbrV6V7EhVGxkOyq7i/REX5M/6af2J8OuyWJ
         SX6EuXGz0b6wAdZ5XlJOB43mHKDKLFyok8x0FkFr7V+BYkYx8umSP/KcttUPTdM5fZu8
         8+9wJ/CumGCtJFNbBRIrQEEx8faComFaYiCPjT8v43R15hL1+rv221q4CmR/gRAo4MJE
         wt/w==
X-Gm-Message-State: AKaTC01acp5wDBuciey87/6mr3n6saKrjYabMNMQLCdm02a+kuMGaSFOPfD8qqNIEj7qruv4
X-Received: by 10.99.146.76 with SMTP id s12mr187542885pgn.8.1481752714796;
        Wed, 14 Dec 2016 13:58:34 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:a0bd:b7d6:4331:46ad])
        by smtp.gmail.com with ESMTPSA id r124sm90038508pgr.6.2016.12.14.13.58.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 14 Dec 2016 13:58:33 -0800 (PST)
Date:   Wed, 14 Dec 2016 13:58:32 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, sbeller@google.com, bburky@bburky.com,
        gitster@pobox.com, jrnieder@gmail.com
Subject: Re: [PATCH v9 5/5] transport: add from_user parameter to
 is_transport_allowed
Message-ID: <20161214215832.GF20063@google.com>
References: <1480636862-40489-1-git-send-email-bmwill@google.com>
 <1481679637-133137-1-git-send-email-bmwill@google.com>
 <1481679637-133137-6-git-send-email-bmwill@google.com>
 <20161214164050.uxk434kzhw6au4c2@sigill.intra.peff.net>
 <20161214201323.GC20063@google.com>
 <20161214203349.6ym3v2ny2gonovx2@sigill.intra.peff.net>
 <20161214211229.mpgu3hahlfbdxys6@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161214211229.mpgu3hahlfbdxys6@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/14, Jeff King wrote:
> On Wed, Dec 14, 2016 at 03:33:49PM -0500, Jeff King wrote:
> 
> > One other "simple" fix is at the moment we parse http-alternates, to
> > parse the URL ourself and check the policy. Like:
> > [...]
> > I may have convinced myself this is a reasonable approach.
> 
> So here it is in patch form, with a test.
> 
> I also took a look at how bad it would be to plumb through the "this is
> an alternate" flag. And it's actually a little nasty, because the
> http-walker isn't calling get_active_slot() itself. It's relying on
> http_get_file() and other wrappers. The recent http_get_options makes
> this slightly less terrible, but I'd still rather avoid infecting the
> general http code that is used for the smart-http code paths.
> 
> So I think this patch on top of your series, plus the other minor fixes
> we've discussed, the topic should be ready for 'next'.

Sounds good, I'll make those few changes, place this patch ontop of
the series and send out v10 of the series in just a bit.

-- 
Brandon Williams
