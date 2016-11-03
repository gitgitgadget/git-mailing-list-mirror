Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFD642021E
	for <e@80x24.org>; Thu,  3 Nov 2016 18:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753680AbcKCS4O (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Nov 2016 14:56:14 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35011 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751292AbcKCS4O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2016 14:56:14 -0400
Received: by mail-pf0-f174.google.com with SMTP id i88so35938076pfk.2
        for <git@vger.kernel.org>; Thu, 03 Nov 2016 11:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0kjd7AKokHIP5pKcVdxNzgwpbU2Ri5RYwHS2zMtvZP8=;
        b=ksK/pYNg740v6oAm5lP6x9UuY1P5nNnwFe6jKEvIdC02IKexIjiZqI44hIvYK9lYAW
         xRYiwpTRePoideIQkHhZg2hSCbRfV/SBlFG0kEBPxXmu9Co0FeFC6Pw2sgQave6OJRrR
         hu2coaTML/K9MMB5GDcp/95w0EwG7PzBBv0sAsc2qrAu8l6Wh+Am918G+HMNFnSe7roz
         biz6R2FlJJ+3m2IJWyQp3N98uywGQCwpo20Bv1VqIapibSax+oCFXF43g6ThWr3A8TY0
         Ny87toKKPkpDPePdrYUPnyds0jPbuPB7d64xhN3hlk6iSMhiKSF4S2+vwXANLOvORZxB
         Afcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0kjd7AKokHIP5pKcVdxNzgwpbU2Ri5RYwHS2zMtvZP8=;
        b=Ob0KrWFxlz7mQIZiUX0zJyy+E/bExcs79j8iluuvIFfxfMETwWkrL3QyJk0Z/LG0PL
         GslEoqQcWnmj6ukDL+FC791AACOvVLFP+1oPvhBJV2q8u+9c7eqsNfj99w0azCYmdVoY
         xGYLTsYxy6ZQwf1GXJE/M/Ph8ueGp/j4lUndVTxRtvcGOym/ZmNvBVrWZfUvIIC9abGz
         EUYPdyjaAuUF/MVFA4Y2XjkenNIRx+0brIV+WTajS9CRRobE+FjGSd2bP3GqEx2zkGYA
         QAgGUfAXUXM5twvmnseF0GTRmh0Q40w6bgYbXmRb8VBLl1QJIqibJkq2JflJ9bK3am3u
         vV4g==
X-Gm-Message-State: ABUngvcLJ+KEkV1VeplqfQUtFlfaVm4icZMzd3yYgMcNb+n7F+RQKl0FYgfY5WwsqZpNWQJj
X-Received: by 10.98.138.219 with SMTP id o88mr19498004pfk.52.1478199373056;
        Thu, 03 Nov 2016 11:56:13 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b42d:d807:c3e3:2b82])
        by smtp.gmail.com with ESMTPSA id g82sm14459456pfb.43.2016.11.03.11.56.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 03 Nov 2016 11:56:12 -0700 (PDT)
Date:   Thu, 3 Nov 2016 11:56:11 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>,
        Blake Burkhart <bburky@bburky.com>
Subject: Re: [PATCH] transport: add core.allowProtocol config option
Message-ID: <20161103185611.GF182568@google.com>
References: <1478125247-62372-1-git-send-email-bmwill@google.com>
 <20161103002225.GA13369@google.com>
 <20161103143806.hce4msk3dhxtgpre@sigill.intra.peff.net>
 <20161103172515.GA182568@google.com>
 <20161103175327.nn2yasvlsxsy22be@sigill.intra.peff.net>
 <20161103182428.j3r574evsk7ypfie@sigill.intra.peff.net>
 <20161103184538.GE182568@google.com>
 <20161103185052.q46x4hlcwne7kpc5@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161103185052.q46x4hlcwne7kpc5@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/03, Jeff King wrote:
> On Thu, Nov 03, 2016 at 11:45:38AM -0700, Brandon Williams wrote:
> 
> > On 11/03, Jeff King wrote:
> > > 
> > > So this seems like a reasonable direction to me. It obviously needs
> > > documentation and tests. Arguably there should be a fallback "allow"
> > > value when a protocol is not mentioned in the config so that you could
> > > convert the default from "user" to "never" if you wanted your config to
> > > specify a pure whitelist.
> > 
> > Yes I agree there should probably be a fallback value of 'never' maybe?
> > What you currently have preserves the behavior of what git does
> > now, if we did instead have a fallback of 'never' it would break current
> > users who don't already use GIT_ALLOW_PROTOCOL (well only if they use
> > crazy protocols).  We could ease into it though and start with default
> > to allow and then transition to a true whitelist sometime after this
> > change has been made?
> 
> I don't see the value in moving the out-of-the-box install to any
> default except "user". Right now the experience of using a third-party
> helper is something like:
> 
>   cp git-remote-hg /somewhere/in/your/PATH
>   git clone hg::whatever
> 
> We restrict its use in submodules by default, which is unlikely to bite
> many people. But if we started falling back to "never" all the time,
> then that second command would break until you officially "approve"
> remote-hg in your config.
> 
> I was thinking of just something to let people decide to have that level
> of paranoia themselves (especially if they want to just set up a
> whole-system white list via the config without bothering with
> environment variables). Like:
> 
>   git config --system protocol.allow never
>   git config --system protocol.https.allow always
> 
> That behaves exactly like:
> 
>   export GIT_ALLOW_PROTOCOL=https
> 
> except it just works everywhere, without having to tweak the environment
> of every process.
> 

Ah ok, so essentially letting the user specify a default behaviour
themselves.

-- 
Brandon Williams
