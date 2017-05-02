Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E96171F790
	for <e@80x24.org>; Tue,  2 May 2017 19:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751420AbdEBTas (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 15:30:48 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35634 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750888AbdEBTaq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 15:30:46 -0400
Received: by mail-pf0-f171.google.com with SMTP id v14so1746467pfd.2
        for <git@vger.kernel.org>; Tue, 02 May 2017 12:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=HxNEIA/0zIRoUXDyLNlZszQ0RPhTvjxUlH3m2R+seI0=;
        b=LaF5Yr5SRWKqziz0cM5ZQBnbXksGXcY48tJeiaLFd/hy5WW2RksgkLywUqFXaHt5Q5
         EuaL5IzzS0JGejk8Pft/bDFISF7n/8Lj7xmaAFZFsOFOQ7dRWF2y/orPm2OvyxkO/EUy
         j3bS3VCQplQXfl5J5EtZU8vufL2e+8NUidAwU4d4PDk3J3I+Hc/ef9DxOUUb/ILq5lxV
         u/a92U6pJTwB8BFAlDEAap1+Fnd+k4mygp4Po+hWF9efRyD6kZLhtkMt7T8w2ZwYvXgD
         rBufLVQw/+H8lRElNYswfk1cixxAUQ77eZrpSWRln3fHRC8VLvhl0S2JpHVNwKrz/swk
         5j/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=HxNEIA/0zIRoUXDyLNlZszQ0RPhTvjxUlH3m2R+seI0=;
        b=KUdDvy2S/VcUIBy90CIiq2qgUw+8VR2L0U7orLfCt+N8D0wojNqS3VA0bGdEehvri0
         ib9typqUcxg2DOHFkb3xS/Ynz5pUy4ofaJQKIeb0gwo3WjeRJNqH/7NW/IbEyxk9x4nI
         gYZjkbbs9up5q6adsXMs50vhG7j+6C+MLKHd32rrieYa/Bw8LG4vk6sh268cG6zFoOJ3
         kTCznhqE/09I8A7i9gVceVbUcWkj6mpX/TOfv3CJrWitOYqMNCd95A+KOcHpnbFZp5Yt
         5D7nJdcrt5616uWVfoX9JY2uHRK3joeC8eOkrGS0fpvH0/u+xUrie6R9PKgsE2tz9onC
         wEEA==
X-Gm-Message-State: AN3rC/6xT17Xp4YSRm3laApwEam5SZPz1vRzEqkw4+qbRs5bVdvGx6ZO
        yZCpud8ukxkBj7z/
X-Received: by 10.99.60.21 with SMTP id j21mr20166436pga.99.1493753445975;
        Tue, 02 May 2017 12:30:45 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:bc40:7b3a:46b3:66f2])
        by smtp.gmail.com with ESMTPSA id b74sm378785pfl.58.2017.05.02.12.30.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 02 May 2017 12:30:45 -0700 (PDT)
Date:   Tue, 2 May 2017 12:30:43 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 5/6] submodule: improve submodule_has_commits
Message-ID: <20170502193043.GG181268@google.com>
References: <20170428235402.162251-1-bmwill@google.com>
 <20170502010239.179369-1-bmwill@google.com>
 <20170502010239.179369-6-bmwill@google.com>
 <CAGZ79kbbz3AAjbg_dV9RVS8kgLs-zWZxt5tsFbQczCm78LcTVw@mail.gmail.com>
 <20170502172555.GA181268@google.com>
 <CAGZ79kZxYCr+H3PLdnxJp7_aG=JmeMTGry51ppCe3=R2xLrP1w@mail.gmail.com>
 <20170502191407.GF181268@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170502191407.GF181268@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/02, Brandon Williams wrote:
> On 05/02, Stefan Beller wrote:
> > On Tue, May 2, 2017 at 10:25 AM, Brandon Williams <bmwill@google.com> wrote:
> > > On 05/01, Stefan Beller wrote:
> > >> On Mon, May 1, 2017 at 6:02 PM, Brandon Williams <bmwill@google.com> wrote:
> > >> > +
> > >> > +               if (capture_command(&cp, &out, GIT_MAX_HEXSZ + 1) || out.len)
> > >>
> > >> eh, I gave too much and self-contradicting feedback here earlier,
> > >> ideally I'd like to review this to be similar as:
> > >>
> > >>     if (capture_command(&cp, &out, GIT_MAX_HEXSZ + 1)
> > >>         die("cannot capture git-rev-list in submodule '%s', sub->path);
> > >
> > > This wouldn't really work because if you provide a SHA1 to rev-list
> > > which it isn't able to find then it returns a non-zero exit code which
> > > would cause this to die, which isn't the desired behavior.
> > 
> > Oh. In that case, why do we even check for its stdout?
> > (from rev-lists man page)
> >        --quiet
> >            Don’t print anything to standard output. This form is primarily
> >            meant to allow the caller to test the exit status to see if a range
> >            of objects is fully connected (or not). It is faster than
> >            redirecting stdout to /dev/null as the output does not have to be
> >            formatted.
> > 
> 
> Sounds good, Let me take a look at using --quiet

From our offline discussion --quiet doesn't do what we want here.  We
are checking (1) if the commit exists and (2) if it is reachable.  Using
--quiet would only satisfy (1)

> 
> > >
> > > I feel like you're making this a little too complicated, as all I'm
> > > doing is shuffling around already existing logic.  I understand the want
> > > to make things more robust but this seems unnecessarily complex.
> > 
> > ok. I was just giving my thoughts on how I would approach it.
> > 
> > Thanks,
> > Stefan
> 
> -- 
> Brandon Williams

-- 
Brandon Williams
