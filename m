Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45F3D1FC44
	for <e@80x24.org>; Mon,  8 May 2017 17:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754843AbdEHRM7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 13:12:59 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:35258 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753819AbdEHRM6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 13:12:58 -0400
Received: by mail-pg0-f42.google.com with SMTP id o3so38649553pgn.2
        for <git@vger.kernel.org>; Mon, 08 May 2017 10:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0/rejUCSXBjB3BTLdeIDVc27ylU2z6F6Y6w13tedQjo=;
        b=YfOeomCL34ZNBpKgc3p89YUrkmgi3nFMUfhBO4gmUOkIvUThmBvD/xfC9Io4W/TaPH
         uSRhPdIUkNVip0J/QfrUxf6SjwycLTmpxxRBvG3pDKd2hC9Ov1G6DDVvkOeZav7iGtLV
         I7g1zg1MVXqJCIseQijgPlhTfsJBthx1zMo9INNvfL1loGYVuFmE25zzktogrgmSjeD8
         hDxF1BqMU+6DW1CMKZNnV0ZYFBrSjDn6qb6JbNqgzBggIVzoLhifg86KHMEZjnOPt9HE
         i4DaKNEWxkCRtcPn0HRk9h7D84cPqrn30bMVJlV3dc/W22Ai46+PqhnRJkFXdgac/hWl
         ZNfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0/rejUCSXBjB3BTLdeIDVc27ylU2z6F6Y6w13tedQjo=;
        b=RlM8AJLisGzsfAoD+u9ssiFXGNspG4aB772jFZKvl550/dS6TfFN8T6LheOQt0Hzy8
         WfY8gEd2OyOM2utXexiZNff/YQA5mxNvVR4AYI9VamvzlqjZsjMobLlgUN9jq+RtF4Wo
         5ifRgPqGgBefnTKy/u8xUaJqBQV+6s8Vnl/AI9eG48FGbFvG46u0qzRDoQxm4dKKf4D7
         Zu/+KLy52iEFxkoz8CfHVF5edHKt0zxWpt+IF01gsaC40rIU+AlJHt0iF9e/ZTJGBECp
         0NCWUNElYLV0bRtezf6Fa3J/Yp8icxxHbduo2vkR3KtnONv+VCRFuTvtePS9+xh2F4FD
         NSFQ==
X-Gm-Message-State: AN3rC/6TdEXwzg6XKKhrrFrlky5ZboVPMsSs3u0ngFCkwq5JqrbPB650
        rTT3irKq2qygXwoQ
X-Received: by 10.84.129.1 with SMTP id 1mr83846835plb.125.1494263577555;
        Mon, 08 May 2017 10:12:57 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:998e:2b7a:726f:b074])
        by smtp.gmail.com with ESMTPSA id o29sm17993023pgc.27.2017.05.08.10.12.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 08 May 2017 10:12:56 -0700 (PDT)
Date:   Mon, 8 May 2017 10:12:55 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sbeller@google.com, jrnieder@gmail.com,
        Johannes.Schindelin@gmx.de, pclouds@gmail.com
Subject: Re: [RFC 00/14] convert dir.c to take an index parameter
Message-ID: <20170508171255.GE179149@google.com>
References: <20170505195334.121856-1-bmwill@google.com>
 <xmqqmvaq702u.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmvaq702u.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/06, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > One of the things brought up on the list in the past few days has been
> > migrating away from using the index compatibility macros.  One of the issues
> > brought up in that thread was how simply doing that conversion doesn't
> > eliminate the reliance on global state (specifically the_index).  If one day we
> > want to have a 'repository object' passed around then we first need to convert
> > different subsystems to be prepared to handle that.  This series provides a
> > first step, converting the code in dir.c to take a 'struct index_state' and
> > using that instead of implicitly using 'the_index'.
> 
> Very nicely done (I only skimmed "dir.c" in the end result and didn't
> go through the changes with fine toothed comb, though).
> 
> I would have done this without the first step and then instead had a
> final patch that only inserts a single
> 
>     #define NO_THE_INDEX_COMPATIBILITY_MACROS
> 
> at the beginning of dir.c once everybody in dir.c loses the
> reference to all "cache" macros at the end, if I were doing this
> series, but it is a personal taste.  
> 
> The resulting dir.c does not even refer to the_index, which is very
> nice.

Thanks! I'm glad there's a few people who see this as a positive change.

> 
> Thanks.
> 
> > Brandon Williams (14):
> >   dir: stop using the index compatibility macros
> >   dir: convert read_skip_worktree_file_from_index to take an index
> >   dir: convert directory_exists_in_index to take index
> >   dir: convert get_dtype to take index
> >   dir: convert dir_add* to take an index
> >   dir: convert last_exclude_matching_from_list to take an index
> >   dir: convert is_excluded_from_list to take an index
> >   dir: convert add_excludes to take an index
> >   dir: convert prep_exclude to take an index
> >   dir: convert is_excluded to take an index
> >   dir: convert open_cached_dir to take an index
> >   dir: convert read_directory_recursive to take an index
> >   dir: convert read_directory to take an index
> >   dir: convert fill_directory to take an index
> >
> >  builtin/add.c          |   7 +-
> >  builtin/check-ignore.c |   3 +-
> >  builtin/clean.c        |   4 +-
> >  builtin/grep.c         |   2 +-
> >  builtin/ls-files.c     |   4 +-
> >  dir.c                  | 200 ++++++++++++++++++++++++++++---------------------
> >  dir.h                  |  27 +++++--
> >  unpack-trees.c         |  10 +--
> >  wt-status.c            |   2 +-
> >  9 files changed, 151 insertions(+), 108 deletions(-)

-- 
Brandon Williams
