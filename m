Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFDC41F404
	for <e@80x24.org>; Wed, 21 Mar 2018 21:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753893AbeCUVxY (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 17:53:24 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:39910 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753882AbeCUVxS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 17:53:18 -0400
Received: by mail-pg0-f65.google.com with SMTP id a19so2464755pgw.6
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 14:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dw8n0TAWWtEwx7wYkaj1UvDrUJvitjmyZIyplwohIF4=;
        b=HqVPIEQnsA0rBJSOnL1V9gQ3VXsb1Q+AeBjY9tmoB0ZGC8L46EW4haue5J1xtzKp95
         DqfZh2hECpv3kz4Uf24GiIc/Tgg9M5MOJW0vieauJ78HEK7kgtjR08jXpOpjTmYMHjAo
         3R2SyuOMdgcmdGE2Zf+mT98AgME/JBKOFLWeSNsAhM6BNO/wH60S4F6w/qlz1FJCyyWT
         J9qdRj2OcI087u9G9mO4RxQY4nHCCh3vKU/RqEZ9gv7scq+k9fujAejJxBIz8UOAPezX
         rcVFDD/lRRWbqFaizHEupFuuUn4efyTgMXAbe4yo/gscWDF17g2tn9chhNs8EuqlTmwP
         yh8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dw8n0TAWWtEwx7wYkaj1UvDrUJvitjmyZIyplwohIF4=;
        b=uHWcbkCkMwOFfSZAHb8/uXk9skMNC9judnekLafaGFTylz4lJGf/jC3n654LkqnmwJ
         i8fTQX5V4Mr+iYSYUSVFtq4WghP2Vdd5rDrACmFnxTFlkSHv/KzxY9+sb4569DyDhkwE
         EANjdS50AFAOiGLz7mNMfhGvoyqvwy4UzH05zM0Q7UlnT19AGbNT6Ulk5lfYDMX/CVZt
         +KoypXIPmvMgF5l/uWSg8h1gDS7EuRVD1a24htNOn5/ZsT46W7d4roKm3MmrepHG/9ge
         pX9hxyaCar/62ZUHtB86652CyzHozbsCulVrK5vKQwtpv89KnB96KVTW4Ge1hjFubwER
         0mzQ==
X-Gm-Message-State: AElRT7EDS83/4170Y8Zd6zYLwy1K77FBedW/Orl5bfwqnwbDOk+5p1PD
        AStqB4RAhNpxfF5P1tuL+z8DlA==
X-Google-Smtp-Source: AG47ELuQaVek3qo8uCvICTVStDkyQLA9ivdRfmaTvsKUsHJMCYV2uxVzDARNMbYpRqqc8QL+mFKWZg==
X-Received: by 10.101.86.70 with SMTP id m6mr16435512pgs.349.1521669197671;
        Wed, 21 Mar 2018 14:53:17 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id 68sm9923112pfx.130.2018.03.21.14.53.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Mar 2018 14:53:16 -0700 (PDT)
Date:   Wed, 21 Mar 2018 14:53:15 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 02/44] repository.c: move env-related setup code back to
 environment.c
Message-ID: <20180321215315.GB18406@google.com>
References: <CACsJy8DWrNzZM1K2vkx2XiETdAR5WhwXEdPijsxd0ZD4Lj=tZw@mail.gmail.com>
 <20180303113637.26518-1-pclouds@gmail.com>
 <20180303113637.26518-3-pclouds@gmail.com>
 <20180319110735.56f860f2794c36b1e2e6180c@google.com>
 <CACsJy8D3Dn8FeSX9su8edYFM28N-qG2bjNYRpajNWaEi6qdTDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8D3Dn8FeSX9su8edYFM28N-qG2bjNYRpajNWaEi6qdTDQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/19, Duy Nguyen wrote:
> On Mon, Mar 19, 2018 at 7:07 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> >> -extern void repo_set_gitdir(struct repository *repo, const char *path);
> >> +struct set_gitdir_args {
> >> +     const char *commondir;
> >> +     const char *object_dir;
> >> +     const char *graft_file;
> >> +     const char *index_file;
> >> +};
> >> +
> >> +extern void repo_set_gitdir(struct repository *repo,
> >> +                         const char *root,
> >> +                         const struct set_gitdir_args *optional);
> >
> > Optional: Reading this header file alone makes me think that the 3rd
> > argument can be NULL, but it actually can't. I would name it
> > "extra_args" and add a comment inside "struct set_gitdir_args"
> > explaining (e.g.):
> >
> >   /*
> >    * Any of these fields may be NULL. If so, the name of that directory
> >    * is instead derived from the root path of the repository.
> >    */
> 
> Yeah. I think Eric made the same comment. I'm still (very slowly) in
> the process of unifying the repo setup for the main repo and
> submodules, which hopefully may kill this function or replace it with
> something better. But it's too early to tell. Since this part of the
> series has landed in 'next', I'll post a fixup patch soon with your
> suggestion.
> -- 
> Duy

Yeah looking at the patch this is probably my only complaint.  The rest
looked good.

-- 
Brandon Williams
