Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09F342055E
	for <e@80x24.org>; Thu, 26 Oct 2017 01:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751980AbdJZBUY (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 21:20:24 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:48256 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751921AbdJZBUX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 21:20:23 -0400
Received: by mail-pg0-f66.google.com with SMTP id v78so1388766pgb.5
        for <git@vger.kernel.org>; Wed, 25 Oct 2017 18:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dropbox.com; s=corp;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=dzFCOYsf2t4/S4a/MCrFw84XU8dBtS9F5wpjuBh6U9M=;
        b=UzW6R2WlGkfrRQZTH16vcQ5IzCaWYGzJwXVMlgcOz2ccmqhjCB4mNIfckF5kNXRJro
         jiESusaGDzjE1bTymLA6XhOT4gaecU0z6X5+oexK4doSnkEgeLwhDEAfwWs6aMGLGRpp
         gZSvyZD85g4h/TjXZSNvd5cdY2e3nOgDY94Xg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=dzFCOYsf2t4/S4a/MCrFw84XU8dBtS9F5wpjuBh6U9M=;
        b=A8PM8hFNd6ITeDOsKGMbi8B7bxmTvRkpx8+Vt/PyPSRt3hOunPBYqTdKvKPJuvMdkt
         kbaXwezSizzYd2E2tWAb0XwISdfboyjlQ7nO2UKftGIU29Jg6NCtgOKQXdwqTgVcANfa
         nqEOj6s42brlK/Aoz3k86Nw+zLsq1+GpRzntx/1JxbcF1rbVvDdu3FCezafeX5fYrcQQ
         ErDO/ocfhXVi+/3Ja7Gsx2lP2lEqmqeIq64Rys46B4KE8oXQLiKonjA5UO/NPwqiW70H
         klm+3hEQl8p+u/6FKeoCc8Uug9SNb10K6KSb0R+HcuqARlxtBuCv/THYieuHATM0X0if
         Lv6w==
X-Gm-Message-State: AMCzsaWTKZum05fWYMQFHYjE7dqK9Ks7j6jC8vUYy2BRf8V7L2Tl1i7d
        vi2dPeBzrsPF3ioM/GuSp721zw==
X-Google-Smtp-Source: ABhQp+ShP1dlX0LJMEz2TpKcMEgraeMYT5B4ok1nT9kYsxMCj146a7RELpsVuNSZTPKmP1Sw8NZXDQ==
X-Received: by 10.84.134.3 with SMTP id 3mr3125470plg.154.1508980823114;
        Wed, 25 Oct 2017 18:20:23 -0700 (PDT)
Received: from alexmv-linux.corp.dropbox.com (v160-sfo11-br02.corp.dropbox.com. [205.189.0.164])
        by smtp.gmail.com with ESMTPSA id d2sm6012494pgu.86.2017.10.25.18.20.22
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 25 Oct 2017 18:20:22 -0700 (PDT)
Date:   Wed, 25 Oct 2017 18:20:14 -0700 (PDT)
From:   Alex Vandiver <alexmv@dropbox.com>
X-X-Sender: alexmv@alexmv-linux
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
cc:     git@vger.kernel.org, Ben Peart <peartben@gmail.com>
Subject: Re: [PATCH 4/4] fsmonitor: Delay updating state until after split
 index is merged
In-Reply-To: <alpine.DEB.2.21.1.1710201503380.40514@virtualbox>
Message-ID: <alpine.DEB.2.10.1710251818360.9817@alexmv-linux>
References: <20171020011136.14170-1-alexmv@dropbox.com> <05670bb6e3c6378119b1649144c80dd6d72bfe29.1508461850.git.alexmv@dropbox.com> <alpine.DEB.2.21.1.1710201503380.40514@virtualbox>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 20 Oct 2017, Johannes Schindelin wrote:
> From the diff, it is not immediately clear that fsmonitor_dirty is not
> leaked in any code path.
> 
> Could you clarify this in the commit message, please?

Will do!

> > @@ -238,6 +225,29 @@ void remove_fsmonitor(struct index_state *istate)
> >  
> >  void tweak_fsmonitor(struct index_state *istate)
> >  {
> > +	int i;
> > +
> > +	if (istate->fsmonitor_dirty) {
> > +		/* Mark all entries valid */
> > +		trace_printf_key(&trace_fsmonitor, "fsmonitor is enabled; cache is %d", istate->cache_nr);
> 
> Sadly, a call to trace_printf_key() is not really a noop when tracing is
> disabled. [snip]

Apologies -- I'd meant to remove the tracing before committing.  I
think we're all on the same page that it would be nice to lower the
impact of tracing to let it be more prevalent, but I'd rather not
block these changes on that.

Thanks for the comments!
 - Alex
