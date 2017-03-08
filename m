Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AD991FBEC
	for <e@80x24.org>; Wed,  8 Mar 2017 02:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933348AbdCHCRV (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 21:17:21 -0500
Received: from mail-pg0-f50.google.com ([74.125.83.50]:33373 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756546AbdCHCRS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 21:17:18 -0500
Received: by mail-pg0-f50.google.com with SMTP id 25so7354938pgy.0
        for <git@vger.kernel.org>; Tue, 07 Mar 2017 18:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ttHAXl5ufCyJ5NsA5DOztFopHDnm/Nne7+ScHOsg3mQ=;
        b=UghPKrK0HMa0e7X8pio+/9SRcbmfKUklkpK/FvE7bHmDXaSYp+9GP8TKOVrzpEFFSF
         1lpQN88vATNt10QMbHZ8Nj1D1GtC0wEvKzIa6dYMBH1g4WChxy+HynAr0P2o1IJNmpRZ
         iWHHnsd5x/w0iccJFHRUdDjEMEHC2USKB2IHPbTDSS/5uK8ebIm0y9L6YSIQGy6cOWIa
         R8CWRLVNMMq4WnQN4xr+hiU1XNwJAfBbq9Y4rz2j8fsfLOfme3nJQmGrq79yvKWgZtwW
         QDjZnbnTCXN/QdB78z9aiBIQwYqkVbjVg34bJd8pDz94q4r0r/F0mDPu1Z/phTe2792+
         HqZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ttHAXl5ufCyJ5NsA5DOztFopHDnm/Nne7+ScHOsg3mQ=;
        b=PUPWMXzZ9aZX1SEEZdlsTQgxbCFVSMnE+b2qUvUYet8s6rAGMRJh4q/vuBxTHQO4Mg
         NLZdnJruB+F/z3Vhci7jM2/tJj4QkIS8PIi0a0IttGqerleNmyrlExT/CL66/VEHc302
         icExmZHfRvYD6kXMSlVKApGJiTp4UOn0/5faMLCOuy8LDvw4HexKnyMHQho2V5CmUtuf
         dKeU36UPgyVx6g9KoH5gyEsmhpZQpLG1dnZ774oznO/jWMPSDF6zhKsHirg0eLNWOY3h
         hLLD+PsOEYcM0WrM/2j9LtQaD6OFR+2mdmSx7ezTZSIK/oA0VtrY19FwIcur6L4n/qc6
         Z+Iw==
X-Gm-Message-State: AMke39l2+LXpCHsdYbgkjdst/1hO6tWQ4YJ2esRpasIhZNeUn5zRzk7uQKSrJWjb4FddHpuw
X-Received: by 10.99.23.102 with SMTP id 38mr4083993pgx.188.1488939046762;
        Tue, 07 Mar 2017 18:10:46 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:2547:c8c9:5d3e:d641])
        by smtp.gmail.com with ESMTPSA id l3sm2176097pgn.10.2017.03.07.18.10.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 07 Mar 2017 18:10:45 -0800 (PST)
Date:   Tue, 7 Mar 2017 18:10:44 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v4 04/10] setup_git_directory_1(): avoid changing global
 state
Message-ID: <20170308021044.GB1650@google.com>
References: <cover.1488562287.git.johannes.schindelin@gmx.de>
 <cover.1488897111.git.johannes.schindelin@gmx.de>
 <2c8ab22700fb40c9e4e9b46f4981b45db7f2dcf2.1488897111.git.johannes.schindelin@gmx.de>
 <20170307233549.GA128647@google.com>
 <alpine.DEB.2.20.1703080156040.3767@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1703080156040.3767@virtualbox>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/08, Johannes Schindelin wrote:
> Hi Brandon,
> 
> On Tue, 7 Mar 2017, Brandon Williams wrote:
> 
> > On 03/07, Johannes Schindelin wrote:
> > >  const char *setup_git_directory_gently(int *nongit_ok)
> > >  {
> > > +	struct strbuf cwd = STRBUF_INIT, dir = STRBUF_INIT, gitdir = STRBUF_INIT;
> > 
> > I couldn't see any strbuf_release() calls for these strbufs so there may
> > be some memory leaking here.
> 
> You are correct, of course. Something like this may work:

Yep that should fix it!

> 
> -- snipsnap --
> diff --git a/setup.c b/setup.c
> index 9118b48590a..c822582b96e 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -1027,6 +1027,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
>  	case GIT_DIR_HIT_MOUNT_POINT:
>  		if (nongit_ok) {
>  			*nongit_ok = 1;
> +			strbuf_release(&cwd);
> +			strbuf_release(&dir);
>  			return NULL;
>  		}
>  		die(_("Not a git repository (or any parent up to mount point %s)\n"
> @@ -1044,6 +1046,10 @@ const char *setup_git_directory_gently(int *nongit_ok)
>  	startup_info->have_repository = !nongit_ok || !*nongit_ok;
>  	startup_info->prefix = prefix;
>  
> +	strbuf_release(&cwd);
> +	strbuf_release(&dir);
> +	strbuf_release(&gitdir);
> +
>  	return prefix;
>  }
>  

-- 
Brandon Williams
