Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	RCVD_IN_RP_RNBL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFC191F453
	for <e@80x24.org>; Tue, 19 Feb 2019 23:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbfBSXpL (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 18:45:11 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45504 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727476AbfBSXpL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 18:45:11 -0500
Received: by mail-wr1-f66.google.com with SMTP id w17so23851584wrn.12
        for <git@vger.kernel.org>; Tue, 19 Feb 2019 15:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MY/pMfdzirM69uQpNtYNP1qiw6WEw+q23JzWeKbXC0o=;
        b=N8E6v6JIum1VMxVtYZqbeXvoWc2hmbGlTRLyShqHd41tq2p2zeCct3t6DqxkLoe2O/
         blhUP6V/XC6hz7aoemMLy+p5OKDuBn3kO7iIKBQDe1zEVHm3P0bC5rWa4ysrD4Kyrxmm
         KE//RFHTqgYddAmOMqnGW5QIWi3ZvzQilomzr/2hkZdnTbZIJr31/5jRgdQrRibYgHRz
         /nhP9z4whJlD9rE6WhCOJK+9iv4kqQd1IycKUdRIxo9MFUAdZWUm9C+gsgzkPC4NTODi
         IQ0nEwJbM5NgY7uuqpMR13HfjGe0VLxlk1XdDY7n2sSBxofRjpBCrde7TieTuY1Blxbh
         j6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MY/pMfdzirM69uQpNtYNP1qiw6WEw+q23JzWeKbXC0o=;
        b=sFGSv49aGqOxctaZ/89W3DahPCKlogE2m+WPt26Lhn79GyGJuE5F+BsjJwsijT0YjZ
         TQNWIuJnGfgo5JunVayb2IIhqG9f69ttbMAdC4+eDQpb8fNTr0GCcNC5SH1I0u2drWbV
         UXtPkq3KH/FOyq7OThO6Wg8Xye1AaIX7fLgDw7kiLiwUAO0Tch+dOI12Fb3FK0MVZAhY
         m/KeRbK3LdmFGqW0j4ZDP8La32IZsWgpd9INCv0rr0sriz/1Wy5x70sQ1k808gYHiqvx
         qgEGIy16/Tm14WfPAKpdPuAK9BRdVYeJNUPvQ3apvJlFfdyel1s7PB3fWAzpCfiRAsyJ
         q1UQ==
X-Gm-Message-State: AHQUAuZW9O5S0OGZVPmM2kHg2NMi7CtfNHA/zavMm+SCZiI/kTB+pqsa
        KgityebVQFdNnEEumKXbNDo=
X-Google-Smtp-Source: AHgI3IadGQOsvw4O15KASsnXiOck4tQoN38fLxu2+E0dPk1Udp6G6yS/QdThiXQViYnyoGTT3G8sMg==
X-Received: by 2002:a5d:650d:: with SMTP id x13mr51281wru.119.1550619908698;
        Tue, 19 Feb 2019 15:45:08 -0800 (PST)
Received: from localhost ([95.149.189.205])
        by smtp.gmail.com with ESMTPSA id e193sm5671594wmg.18.2019.02.19.15.45.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 15:45:07 -0800 (PST)
Date:   Tue, 19 Feb 2019 23:45:06 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [GSoC][PATCH 2/2] clone: use dir-iterator to avoid explicit dir
 traversal
Message-ID: <20190219234506.GL6085@hank.intra.tgummerer.com>
References: <20190215154913.18800-1-matheus.bernardino@usp.br>
 <20190215154913.18800-3-matheus.bernardino@usp.br>
 <20190216143824.GJ6085@hank.intra.tgummerer.com>
 <CAHd-oW60a+zz9J+u0HiRuTy-FKYN4s95fCcR3mgJz0hUokhTCQ@mail.gmail.com>
 <20190218233541.GK6085@hank.intra.tgummerer.com>
 <CAHd-oW6m6JSgxwdE6U5vBw=DcPigK+P8eODoie0_Mag3Lg_eYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHd-oW6m6JSgxwdE6U5vBw=DcPigK+P8eODoie0_Mag3Lg_eYw@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/19, Matheus Tavares Bernardino wrote:
> On Mon, Feb 18, 2019 at 8:35 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > > Also, I just noticed that dir-iterator follows hidden paths while
> > > copy_or_link_directory don't. Maybe another option to add for
> > > dir-iterator?
> >
> > That feels like quite a special case in 'copy_or_link_directory()'.  I
> > don't think it's worth adding a feature like that for now, at least
> > not until we find another use case for it.  It's easy enough to skip
> > over hidden directories here.
> >
> 
> Ok, I agree. I noticed copy_or_link_directory only skips hidden
> directories, not hidden files. And I couldn't think why we would want
> to skip one but not the other... Could that be unintentional? I mean,
> maybe the idea was to skip just "." and ".."? If that is the case, I
> don't even need to make an if check at copy_or_link_directory, since
> dir-iterator already skips "." and "..". What do you think about that?

I don't know.  The best way to look at these things is usually to use
'git blame' and have a look at the commit that introduced whatever you
are looking at, in this case why we are skipping anything starting
with a '.'.  But looking at that commit it's just the translation from
shell script to builtin.  It's also more than 10 years old by now, so
it's unlikely that the original author would still remember why
exactly they made this choice.  (Note that I didn't take the time to
actually dig into the original shell script).

I feel like you are probably right in that it could be unintentional,
and I don't think anyone should be messing with the objects
directory.  However that is no guarantee that changing this wouldn't
break *something*.

For the purpose of this change I would try to keep the same behaviour
as we currently have where possible, to not increase the scope too
much.

> > > I'm proposing some new options to dir-iterator because as the patch
> > > that adds it says "There are obviously a lot of features that could
> > > easily be added to this class", and maybe those would be useful for
> > > other dir-iterator users. But I don't know if that would be the best
> > > way of doing it, so any feedback on this will be much appreciated.
> > > Also, I saw on public-inbox[1] a patchset from 2017 proposing new
> > > features/options for dir-iterator, but I don't really know if (and
> > > why) it was rejected. (I couldn't find the patches on master/pu log)
> >
> > I don't think we should necessarily add new options because the
> > original patch said we should do so.  Instead the best way to
> > introduce new options is to introduce them when they are actually
> > going to be needed in subsequent patches.  So it would be nice to
> > implement features that are actually needed by your patches, but I
> > don't think it's worth trying to introduce new features that could
> > potentially be useful in the future, but where we don't know yet
> > whether they really will be or not.
> >
> 
> Yes, I agree with you. What I meant is that there is some space for
> new features at dir-iterator and maybe those that I suggested could be
> nice not just for my patch, on clone.c, but for others. But I see your
> point. We really should try to keep it simpler and just add the
> feature when (and if) there is a more expressive usage for it.

Right, if you wanted to pursue this, that could be a separate patch
series.  However generally patch series that just introduce something
that might be used later, but doesn't add much value on its own tend
to be much more likely to be rejected.

> Thanks again for all the help and feedback.

Thanks for working on this!
