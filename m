Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B68A1F453
	for <e@80x24.org>; Thu, 25 Apr 2019 05:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbfDYFQZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 01:16:25 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39208 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728966AbfDYFQZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 01:16:25 -0400
Received: by mail-pf1-f196.google.com with SMTP id i17so10506781pfo.6
        for <git@vger.kernel.org>; Wed, 24 Apr 2019 22:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6OzqSWuhgD6kVCumhjKVOmZlzSy1MZhjugQFuJR+CZ8=;
        b=VZvHAr9trtDpcC75nCHDq3qoRlNq13aTI1ABYL0tKmRfRIl0rR/Q6l+7QfhthclJeV
         38UvSraHdFrdCJXC5Ig/nEoF1VEpOyjsTqFAzEyJXpcMmPdA4dL/QYAgi4SZpOkpXwoD
         IIbk8xNTDOhbRCLPxSPkwR3nn9R2H2Lm4FSEEPIGa7/7imkl447PP/ceN5lxzsVELdrV
         07h/vC8Weba9AULpvFmeve0grYg0oLoKIt6+KUiRZTE+RqL4ywwecj9+ZsmIIl4a/wTx
         bkCbwkLzYV8vNEdDgu0bNQbcX+TVsgM+I9WoJpAr9JJSOBgoK42XQ2wPWe+ngXhCqxUA
         v61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6OzqSWuhgD6kVCumhjKVOmZlzSy1MZhjugQFuJR+CZ8=;
        b=Oe3S51vLx4RgReUdnCec7Kd4nQ9PiHvV2ndNwmHSqJNHbp3WPc2lM7zFxyh1mEN2xa
         UcesRx0ub1/6m9V0qC+psku4LusjxJU54cl4Xn+3eAsVGonGtUBkgmIhYz6vpqSRGq41
         IWJ5hixaM/dqVLNEQmxNaDw/9VuFed1KTrzkMMm9Kn09M6xbsXWoF+7OwuQlM9CiiT4L
         BtTLnms9XzuWnenwwF3RhDBL2E5xaA4+Np5l/8VyTDhN/CdoyBDO9O992xC/9cjAtBP9
         ZpZagG9FVPb1giTksscO750oADNmQI1pRO6OH9DChgUezq4wEBRW2UDD1SC40nMAcx9A
         Q4gQ==
X-Gm-Message-State: APjAAAXWglUX9umNnfVWl5zVMji3pw5bUK0oybVxDGuQMKGroe9mvzXd
        TcOPXee7AaFn9+Q3fYKF568=
X-Google-Smtp-Source: APXvYqxfRmWBC67TPHzxXkkbWYh7YD9+fuQ1RFXgQ1aiKBtX/i7NpAi8YxMNSIKEvDX/8YAdzcmNkg==
X-Received: by 2002:a63:3dca:: with SMTP id k193mr35102546pga.146.1556169383579;
        Wed, 24 Apr 2019 22:16:23 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id o7sm14451001pgv.63.2019.04.24.22.16.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 22:16:22 -0700 (PDT)
Date:   Wed, 24 Apr 2019 22:16:20 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Aguilar <davvid@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 4/6] mergetool: fallback to tool when guitool
 unavailable
Message-ID: <20190425051620.GA32457@archbookpro.localdomain>
References: <cover.1556009181.git.liu.denton@gmail.com>
 <cover.1556142510.git.liu.denton@gmail.com>
 <e975fe4a8b206d8e40f9c4d7cd278fdb5c7358f0.1556142510.git.liu.denton@gmail.com>
 <xmqq7ebizt1c.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7ebizt1c.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, Apr 25, 2019 at 12:02:23PM +0900, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > In git-difftool, if the tool is called with --gui but `diff.guitool` is
> > not set, it falls back to `diff.tool`. Make git-mergetool also fallback
> > from `merge.guitool` to `merge.tool` if the former is undefined.
> >
> > If git-difftool were to use `get_configured_mergetool`, it would also
> 
> I agree that the precedence order below makes sense, but I am a bit
> confused by "were to use" here.  Do you mean you'll make the change
> to make difftool to look at mergetool configuraiton in a later step
> in the series?  Or is there a way for the user to say "I want my
> difftool to also pay attention to the mergetool configurations" (and
> another "I do not want that" option)?  I'll come back to this later.

Correct, it means it'll be done in a future patch (i.e. 6/6).

I guess I wasn't fully clear in the message. I meant something like, "If
`git difftool --gui` were to use..." because difftool currently already
uses this function in the non-gui case.

[snip]
> 
> > +	IFS=' '
> > +	for key in $keys
> > +	do
> > +		for section in $sections
> > +		do
> > +			merge_tool=$(git config $section.$key) && break 2
> > +		done
> > +	done
> 
> And you do up to four iterations to cover the combination in the
> precedence order.  Which makes sense.
> 
> I am not sure about the wisdom of setting IFS here, though.
> 
> As far as I can see, both $keys and $sections do not take any
> arbitrary values, but just the two (for each) values you know that
> do not have any funny characters, so I am not sure what you are
> trying to achieve by that (i.e. benefit is unclear).

The reason why IFS is being set is because at the top of mergetool--lib,
we set IFS to '\n'. As a result, without setting IFS, the strings
won't parse properly into the for loop.

> 
> As long as the get_configured_merge_tool function is called always
> for string_emitted_to_stdout=$(that function), the updated setting
> will not leak to the outside world so there is no risk to break its
> callers, but it is not immediately obvious if helper functions
> called in the remainder of this function are OK with the modified
> value of IFS (i.e. safety is not obvious).

When I was writing this, I didn't realise that the value of IFS bleeds
out of this function. I'll reroll this to use a helper function just in
case.

> 
> Now for the promised "come back to this later", I think you meant
> "the get_configured_merge_tool function is already prepared to be
> used from difftool in this step and when difftool starts to call it
> here is what happens".  But I wonder if it makes the evolution of
> the topic easier to follow if you defer it to a later step when you
> actually make difftool to start calling it?  In other words, in this
> step, your get_configured_merge_tool would look like
> 
> 	sections=merge
> 
> 	case "$1" in
> 	true)
> 		keys="guitool tool" ;;
> 	*)
> 		keys="tool" ;;
> 	esac
> 
> 	for key in $keys
> 	do
> 		for section in $sections
> 		do
> 			merge_tool=$(git config ...) && break 2
> 		done
> 	done
> 	...
> 
> and then in a later step (6/6?), the unconditional setting of
> sections to 'merge' would be updated so that in diff_mode, you'll
> iterate over two sections.
> 
> I dunno.

As stated above, difftool currently uses this function in the non-gui
case. I think that clarifying the log message on my part should make it
easier to understand the evolution of this topic.

Thanks for the careful review,

Denton
