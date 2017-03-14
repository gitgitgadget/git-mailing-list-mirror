Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E71820951
	for <e@80x24.org>; Tue, 14 Mar 2017 22:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752215AbdCNWuH (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 18:50:07 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34700 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752143AbdCNWuG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 18:50:06 -0400
Received: by mail-pf0-f169.google.com with SMTP id v190so232151pfb.1
        for <git@vger.kernel.org>; Tue, 14 Mar 2017 15:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mli9xjLD9C/PwoecNoL0RcNH/7bGGEFnrWM8vJyBIIo=;
        b=bueX4h38nC16+hQ0bYPU/7i+9XU6hqJC6mh/MrUcJRzwNo9pphEf4s5d8LvWkuWxz3
         c3IJYivv6Yu9fvGyY7O2+TNLQ5rs84EckyfLatPvG/KOx36SaM1HfiaayqGbcb0vmzwx
         2AHCROlYdP8M3v594ADebOvnZglk5Ug4yawPWQipdKXIUkMdm2c442OH8AUD/keb14Gi
         yhh3Tov3xxPwWMoR+4m//fEpTzxpxdDnZkHuRmc6iTbVucTKn5hiTqHp5K+empzlyg0u
         vMgWYXazhHZ9VambgtxVTOPyr70b5PGM/v1NHADD0bmB+bV0zArtTMmiwgEngrUD06Wu
         f//Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mli9xjLD9C/PwoecNoL0RcNH/7bGGEFnrWM8vJyBIIo=;
        b=iRXa2okcO+o3zXEJDCYtPqgEXNpqTNxC7N6Jt7nO/6BGhgBozXePOTiq+ElnpMkCUi
         BRIZHTUScKN+/HDRitsYu6y6j3B1E3naksD6PAnikCHfa8eT+B0ViAcqXxvwvzYuzO5Q
         JFbDhmLNM6ZeAyvfABDP2k2qgjvRVoVWmpDbwWJibYAMDgW36jopphYUoXMHDPNUOBLZ
         n9xX0qtDwx4NtFhZjl34PvTnxaO73Jc0W7CwKl5LAknUxSxRSHkibmERF5Rb0PBSdQPB
         g71WJetzA9Zr2/jQm17DBlO9Dc7QGp49I8Fp/noWSrzVSE8kr8fE8JkrrE0F4sSQxTYx
         BvnQ==
X-Gm-Message-State: AFeK/H3lg/xv1GgI/q03LIqHwRjwHk+EZSEwQTc5RWhay5XAu5ranA6gE1mmg9ELI6kAjd8G
X-Received: by 10.99.36.71 with SMTP id k68mr130634pgk.68.1489531804936;
        Tue, 14 Mar 2017 15:50:04 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:491b:baa8:63f0:3cf1])
        by smtp.gmail.com with ESMTPSA id 23sm35039pfw.94.2017.03.14.15.50.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Mar 2017 15:50:03 -0700 (PDT)
Date:   Tue, 14 Mar 2017 15:50:02 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH v3 02/10] submodule status: use submodule--helper
 is-active
Message-ID: <20170314225002.GD168037@google.com>
References: <20170309012345.180702-1-bmwill@google.com>
 <20170313214341.172676-1-bmwill@google.com>
 <20170313214341.172676-3-bmwill@google.com>
 <xmqqd1djkay4.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqd1djkay4.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/14, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> >  git-submodule.sh | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/git-submodule.sh b/git-submodule.sh
> > index 136e26a2c..ab233712d 100755
> > --- a/git-submodule.sh
> > +++ b/git-submodule.sh
> > @@ -1010,14 +1010,13 @@ cmd_status()
> >  	do
> >  		die_if_unmatched "$mode" "$sha1"
> >  		name=$(git submodule--helper name "$sm_path") || exit
> > -		url=$(git config submodule."$name".url)
> >  		displaypath=$(git submodule--helper relative-path "$prefix$sm_path" "$wt_prefix")
> >  		if test "$stage" = U
> >  		then
> >  			say "U$sha1 $displaypath"
> >  			continue
> >  		fi
> > -		if test -z "$url" ||
> > +		if ! git submodule--helper is-active "$sm_path" ||
> >  		{
> >  			! test -d "$sm_path"/.git &&
> >  			! test -f "$sm_path"/.git
> 
> The $name is no longer used after this step in cmd_status function, 
> as the sole purpose of learning the name from the path was so that
> we can ask if the submodule has .URL defined and the query is done
> by name, not path.

Thanks, I'll remove computing the name.

> 
> This actually raises a question.  
> 
> Shouldn't "submodule--helper is-active" ask about submodule while
> identifying the submodule in question by name?  Or do all (or most
> of) the callers start from path and ask is-active on them so that it
> is handier to let them ask by path?

As you can Stefan already discussed the path is a much easier handle to
work with simply because that is what is more readily available as the
name is an internal detail.

-- 
Brandon Williams
