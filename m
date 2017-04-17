Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7A2C20D09
	for <e@80x24.org>; Mon, 17 Apr 2017 02:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932389AbdDQCNm (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 22:13:42 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:36385 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932320AbdDQCNl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2017 22:13:41 -0400
Received: by mail-pg0-f41.google.com with SMTP id g2so65182222pge.3
        for <git@vger.kernel.org>; Sun, 16 Apr 2017 19:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sE2brxicvU4jMPZHfPnzA6gXrKk40fZs+WHAtzuKY8I=;
        b=ItUm3Oru2ZDHysy6Yk3eW+pjHkeJRaqKUJOlR98wF7Tf5yMQUjb6teKN+Uwb61A9Z2
         xPATXm+rskK9CFli/txKH5oeWVFvtmX4WhltrTjtMpQ+ZV88ENOgdDNKVphvnsDkDm4C
         PsnBO//fOI/kLZxsUnpZzhdE/5MUB9M3H4ew3kGlUM3fx3AwDRW39LRBgtVFaDHFxVL7
         ws6t322jeaK+ug/feXWBThSU4ADxPpB7Q98m5FnFU94tBKRVZ+g37xd8iPils+Di3dl3
         5ZaV96zyxMlzJgeH8At0la/gsIpxjCDgSXoe6IA4pQ1mm0og7vjeKk1/+laD6KR5UIoM
         +pjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sE2brxicvU4jMPZHfPnzA6gXrKk40fZs+WHAtzuKY8I=;
        b=I9G4TNT3VzsAhtlc+2GofYjYv2aksQhR+E/cAObQglWIS1hBAsUznODkDC4cachhVD
         2lLFBDpzjA29gsuqp2MfBvg5M4t2ZewqByDHjpE3n7osuu2MX6j+t5eTpFXb9IR0NGdO
         UFBC9fLwGoecz5jYddJAj/qr4jng0C0lTcN7sOvb+of63uYizOD7tURuCaoW4SqQIB2Z
         YKXyFZyHyP2jNNflAySEFUpkhBZSBdn2mJBYtyZS5iH2kIIi9z6pSvP0sB9TzfXoCkzE
         K3AdheLkLzPd8/Oo2e3nnACk15dyJLr6HyYfclVxnJvp+0YqBYhvpGcXml+I/2f0VI0j
         4cEQ==
X-Gm-Message-State: AN3rC/4hFLJtSwg0esu08yDa3BeWKpek/GHgnaw17lxcfkWRg2TiSwuM
        XhGn0E3/dnAqvQ==
X-Received: by 10.99.116.20 with SMTP id p20mr5969958pgc.74.1492395220419;
        Sun, 16 Apr 2017 19:13:40 -0700 (PDT)
Received: from duynguyen.vn.dektech.internal ([14.161.14.188])
        by smtp.gmail.com with ESMTPSA id b10sm14326135pga.39.2017.04.16.19.13.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Apr 2017 19:13:39 -0700 (PDT)
Date:   Mon, 17 Apr 2017 09:13:35 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        bert.wesarg@googlemail.com
Subject: Re: [PATCH 2/2] config: handle conditional include when $GIT_DIR is
 not set up
Message-ID: <20170417021335.GB8987@duynguyen.vn.dektech.internal>
References: <20170416045004.2ghhiv7jzgroejgw@sigill.intra.peff.net>
 <20170416104125.15300-1-pclouds@gmail.com>
 <20170416104125.15300-2-pclouds@gmail.com>
 <20170416155131.ppp5iakohiiphzmk@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170416155131.ppp5iakohiiphzmk@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 16, 2017 at 11:51:32AM -0400, Jeff King wrote:
> > diff --git a/cache.h b/cache.h
> > index e29a093839..27b7286f99 100644
> > --- a/cache.h
> > +++ b/cache.h
> > @@ -1884,6 +1884,8 @@ enum config_origin_type {
> >  
> >  struct config_options {
> >  	unsigned int respect_includes : 1;
> > +	unsigned int early_config : 1;
> > +	const char *git_dir; /* only valid when early_config is true */
> >  };
> 
> Why do we need both the flag and the string? Later, you do:
> 
> > -static int include_by_gitdir(const char *cond, size_t cond_len, int icase)
> > +static int include_by_gitdir(const struct config_options *opts,
> > +			     const char *cond, size_t cond_len, int icase)
> >  {
> >  	struct strbuf text = STRBUF_INIT;
> >  	struct strbuf pattern = STRBUF_INIT;
> >  	int ret = 0, prefix;
> >  
> > -	strbuf_add_absolute_path(&text, get_git_dir());
> > +	if (!opts->early_config)
> > +		strbuf_add_absolute_path(&text, get_git_dir());
> > +	else if (opts->git_dir)
> > +		strbuf_add_absolute_path(&text, opts->git_dir);
> > +	else
> > +		goto done;
> 
> So we call get_git_dir() always when we're not in early config. Even if
> we don't have a git dir! Doesn't this mean that programs operating
> outside of a repo will still hit the BUG? I.e.:
> 
>   git config --global includeif.gitdir:/whatever.path foo
>   cd /not/a/git/dir
>   git diff --no-index foo bar
> 
> ?
> 
> I think instead the logic should be:
> 
>   if (opts->git_dir)
> 	strbuf_add_absolute_path(&text, opts->git_dir);
>   else if (have_git_dir())
> 	strbuf_add_absolute_path(&text, get_git_dir());
>   else
> 	goto done;

Do we care about the case when the override instruction is "we don't
have $GIT_DIR, act as if it does not exist, even though have_git_dir()
returns true"?

I'm guessing no, we won't run into that situation (and am inclined to
restructure the code as you suggested). Just throwing it out there if
I'm mistaken.
--
Duy
