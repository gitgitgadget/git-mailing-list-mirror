Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AB4C1FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 23:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933792AbeAHXip (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 18:38:45 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:39594 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932846AbeAHXio (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 18:38:44 -0500
Received: by mail-pf0-f194.google.com with SMTP id e11so3439154pff.6
        for <git@vger.kernel.org>; Mon, 08 Jan 2018 15:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FXvEjk9d32syTpU+Er+rf44ZgOilf6V5hULa+uCz27A=;
        b=sXEYFKqXcdlL/E7gnOanBBwRPobEdaDbnCWRW9XJTytAOw5is4Gfx4bcp5FsmdEPbx
         6Je1PEiCCvZPmbffskTfn3ZineNacoAn3Y33YGpTd9Jx01SdU506Lc3K+cfiFpdNRUb3
         pVIHQSegwQMQStCU1zXg/nB6diF3Mwb55+/xvRmNz9oZL/8dc5xpEbRBADdIzhejDfRJ
         nER8kRam+zXdQQZdwyjzeOkYukJhu5G+m3TzicPnF4vPySjSdyDVTtcAjPIl9NkevEBf
         fmP3IhsrrNvVmj1LMfjsczp38TB2Av6MFN/lioaMldha9l4el/xtsvDvlOahaPZJC0OW
         WQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FXvEjk9d32syTpU+Er+rf44ZgOilf6V5hULa+uCz27A=;
        b=CbRWPfUNayqJFsefyCHs43vyl0K3XzW7AdcF+lAM/1LKq0/0sPrehHugdI8nD9cv71
         LQjSbJGQbi6abmmb7wTrbtIuVmK5IYsqX/PSzds8pSVQEFmyZpDMaRccTAQodtvHLbQv
         vBffqmyXRVJtAB8RS2SGSk18Vc3v51R97uTwoIlwl0Xvs8spHZiDtbajAMui8yvH23p/
         bneXf+qkKP3c8Fm0i0M7WHvYqL+FbavjUvTk40pQ55WqbGZwwdBPgiXU49YAgYBzTjib
         MAWm3Rgxx/ZvMP5lbVFXF7YHT+iIc4unjspSMmx5dFyFKgBkV44FGHPdHxMdWITxJN/+
         pB8g==
X-Gm-Message-State: AKGB3mL3fYI1YlOgh5jp5FJ8kYcR31dFeGncs+VLQktmAirN9G4yjVaL
        j4G5Czc4XzTzRtIknGS/fdfeqfsA+T4=
X-Google-Smtp-Source: ACJfBouoTccVIVeioQH3nISTzEdmmxMo2pz4VPEH+hsvvefbDaTnMtxma9ywaDHk6cYnJQipzKJ2AQ==
X-Received: by 10.98.31.72 with SMTP id f69mr7524972pff.196.1515454723161;
        Mon, 08 Jan 2018 15:38:43 -0800 (PST)
Received: from google.com ([2620:0:100e:422:2054:b9e9:e494:59bb])
        by smtp.gmail.com with ESMTPSA id i11sm22422584pgq.75.2018.01.08.15.38.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 08 Jan 2018 15:38:42 -0800 (PST)
Date:   Mon, 8 Jan 2018 15:38:40 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 1/3] read-cache: fix reading the shared index for
 other repos
Message-ID: <20180108233840.GB156560@google.com>
References: <20171217225122.28941-1-t.gummerer@gmail.com>
 <20180107223015.17720-1-t.gummerer@gmail.com>
 <20180107223015.17720-2-t.gummerer@gmail.com>
 <CACsJy8DBkAwoNWSma-+WkOUkQrenbkT5c1-Ez2jmmf-+wGRbxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8DBkAwoNWSma-+WkOUkQrenbkT5c1-Ez2jmmf-+wGRbxQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/08, Duy Nguyen wrote:
> On Mon, Jan 8, 2018 at 5:30 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > @@ -1896,16 +1895,17 @@ int read_index_from(struct index_state *istate, const char *path)
> >                 split_index->base = xcalloc(1, sizeof(*split_index->base));
> >
> >         base_sha1_hex = sha1_to_hex(split_index->base_sha1);
> > -       base_path = git_path("sharedindex.%s", base_sha1_hex);
> > +       base_path = xstrfmt("%s/sharedindex.%s", gitdir, base_sha1_hex);
> 
> Personally I prefer the repo_git_path() from v2 (sorry I was away and
> could not comment anything). The thing is, git_path() and friends
> could do some path translation underneath to support multiple
> worktrees. Think of the given path here as a "virtual path" that may
> be translated to something else, not exactly <git_dir> + "/" +
> "sharedindex.%s". But in practice, we're not breaking the relationship
> between $GIT_DIR/index and $GIT_DIR/sharedindex.* any time soon, doing
> manual path transformation here is fine.

My biggest complaint about v2 is that we still don't quite know the best
way to integrate worktrees and struct repository yet so I was very
reluctant to start having them interact in the way v2 was using them
together.  I'm very much in favor of this version (v3) as each worktree
can explicitly provide their gitdir to be used to determine where to
read the shared index file without having to replicate a struct
repository for each.

> 
> What about the other git_path() in this file? With patch applied I still get
> 
> > ~/w/git/temp $ git grep git_path read-cache.c
> read-cache.c:           shared_index_path = git_path("%s", de->d_name);
> read-cache.c:   temp = mks_tempfile(git_path("sharedindex_XXXXXX"));
> read-cache.c:                         git_path("sharedindex.%s",
> sha1_to_hex(si->base->sha1)));
> read-cache.c:           const char *shared_index = git_path("sharedindex.%s",
> 
> I suppose submodule has not triggered any of these code paths yet. Not
> sure if we should deal with them now or wait until later.
> 
> Perhaps if we add a "struct repository *" pointer inside index_state,
> we could retrieve back the_repository (or others) and call
> repo_git_path() everywhere without changing index api too much. I
> don't know. I like the  'struct repository' concept but couldn't
> follow its development so I don't if this is what it should become.

I'm not too keen on having an index_state struct contain a back pointer
to a repository struct.  I do think that we may want to have worktree
structs contain a back pointer to the struct repository they correspond
to.  That way there is only one instance of the repository (and
object-store once that gets integrated) yet multiple worktrees.

-- 
Brandon Williams
