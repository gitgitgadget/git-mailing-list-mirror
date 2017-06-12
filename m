Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97CBC20C4C
	for <e@80x24.org>; Mon, 12 Jun 2017 21:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752814AbdFLVYe (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 17:24:34 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34729 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752490AbdFLVYc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 17:24:32 -0400
Received: by mail-pf0-f177.google.com with SMTP id 15so29185770pfc.1
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 14:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cHXheWmIULXy9d40phBCEjiqabPuGMUQzW5Al626nl8=;
        b=UG2Ly3lXJHSYNt+BjstSTVRbpEdXt2jJ8uqXkfQEAD6LPGfYGnzx2yzckYhvOCOS07
         sjmu9USbDpmgddKK95cVtNyl4Ncs3AFmZ9um1Qvxu4i9SNzk2sxc0zUaj3aOrPfU4Ie1
         nevC16wjtMiTLMKi8wvUygRuNTKGfWOmWHjF5cZP3+14pYMT3sOxSztrLgd2h3gXP7w9
         usb3PipRh8V0fYlJU3ExoHrqcVeZkIqO52Ny0FKYHJv3hab6NAv/ChUJuCTHIHWn+Z6h
         r7+b10MKXj8mUU3NxsIV5kWfAeQOwd+nLLYl2HD49JPVwD1x8NR3ZrF1khdoMlQFmb1F
         uf8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cHXheWmIULXy9d40phBCEjiqabPuGMUQzW5Al626nl8=;
        b=qDeRFGUi35G44OlfEOZIg8u1I45MBg90OzhBNatdKdNyadeyqzOMXEDVJQvToB6Ron
         KWMa0tpna/+b3fR1kTsuCjZPR4h2PR52EKQ6/cSApJeY+krghArZDe0ly7elEVVCFhDB
         Q/00btz6p3bbYIHKhc1LXYmhk5CNSbSB/l2x1PF9f9X/pmuwlja9vy4KqBLGz15PJGMc
         zfnPP0LvcakgLaE4io3TF78+Dt5CgkMoIHp6zX4AFdvcJYlyLnNT7R5Lurt+vEdZKt+H
         4kBqsPrF6bx2f9F9jcaSatjOrI9xFIq+0Id7BYGHW8HHVS1hE9cIGDOH7YiMoPMYyLD7
         cYGQ==
X-Gm-Message-State: AODbwcA26Zl0uz/XQMDUCkbxqvDK/HpoKHr2beerlyZQ6R92cmfCVAzP
        k7BV3I3wuGjBXJF7
X-Received: by 10.98.110.198 with SMTP id j189mr13217629pfc.176.1497302671380;
        Mon, 12 Jun 2017 14:24:31 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:9d75:7c5f:d212:fb28])
        by smtp.gmail.com with ESMTPSA id d185sm18258996pgc.39.2017.06.12.14.24.29
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Jun 2017 14:24:30 -0700 (PDT)
Date:   Mon, 12 Jun 2017 14:24:29 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sbeller@google.com, jrnieder@gmail.com,
        jacob.keller@gmail.com, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, peartben@gmail.com,
        pclouds@gmail.com, peff@peff.net, git@jeffhostetler.com,
        avarab@gmail.com, jonathantanmy@google.com
Subject: Re: [PATCH v2 32/32] ls-files: use repository object
Message-ID: <20170612212429.GD154599@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
 <20170608234100.188529-1-bmwill@google.com>
 <20170608234100.188529-33-bmwill@google.com>
 <20170609000849.GA130522@google.com>
 <xmqq8tl02xjv.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8tl02xjv.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/10, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> >> -	if (read_cache() < 0)
> >> +	if (repo_read_index(the_repository))
> >
> > oops, looks like this should have been:
> 
> Queued, with this fix-up already applied.
> 
> It had a bit of conflicts with topics in flight that may added some
> more globals, so please make sure that the conflict resolution is
> sane (i.e. do not look only at bw/repo-object and be happy; rather,
> please check "pu^{/^Merge branch 'bw/repo-object' into pu}".
> 
> Thanks.

Thanks for picking this up and merging it to pu.  After some discussion
I think it may be ideal to split this thing up so that the parts that
aren't specific to the 'repository object' can be reviewed more easily
as a 32 long patch set can be daunting to review.  I also need to think
a little bit more about the breakage this series causes in pu.

-- 
Brandon Williams
