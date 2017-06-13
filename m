Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 462B71FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 21:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753885AbdFMViU (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 17:38:20 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:34083 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753870AbdFMViS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 17:38:18 -0400
Received: by mail-it0-f45.google.com with SMTP id m47so3894324iti.1
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 14:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=saRIc6FAbzWR7THydHpQPvhE0mOIFPaDVGcg8wQPj4A=;
        b=MsDaCVhK98u4uhJPVCVRceCI0kVXYcZXReeUSysBm+ywP+yA60XBajo7h/CkIMJfJH
         YCuimLpdEzYzDMq1IEZUtPbf5emfkG4kR+s5KFOYlyjjGO0Hwrrnv3CTFOWhshRBWSVU
         DrsbHUt0zzK2f8c5d+O+ELoF2wmor+FmJSVgGVe1prPrgIghSh2oqW85dLuEj4TryZYA
         qr3fLk63G/+VmUPybQpKpBws8wN0rNZh7Bs8jHlUO8QD3Q1a8fOrPHWNV/GqMZ5VHfZd
         U1cxcSejxc+WkeXlvndRqDtrBjGSVi+KkGlUqckFpUjNbnlFJwV7w+IvWOd4M7vO1NVW
         zlOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=saRIc6FAbzWR7THydHpQPvhE0mOIFPaDVGcg8wQPj4A=;
        b=jnLndyhJ4+YmZ+8Bs5ERfUXNsj8lPhBuDKE24Vg/r3BS/n+/NLL9MwAEBi37z2Pmdn
         S1uUYOBmwzH67MZwwTQL8EdqMT9Uz9pOp4vacGt/yWEkmJE2fKtwjaKNrf9jI3DRuWWB
         tVEhhnJTcbS4vaAL3wPSkf1KOrDMtU8VEQ7QnPDxyrOeNv2zsq6lfQQ+a76kw1RxGYT7
         E5QSm0zsM30aGa0EIRGesbD3mjgnDy0P4PMPgB0xc57mYFdxo4AOcd1nIiWwDJUgKhWf
         Shmg2wknbb7S/yVpGG8n6H05GqYwVUSxQRpzP3TogQ0MMpK/ylW5GcudgvbBucqdGQGv
         +4oA==
X-Gm-Message-State: AKS2vOyElUJT7/LT68IAcL6aQjox8CBSP91H/Bn0HPqMUW9fq0ZDu0J/
        u59XugFE6RLshUIP
X-Received: by 10.36.123.5 with SMTP id q5mr2773408itc.16.1497389897764;
        Tue, 13 Jun 2017 14:38:17 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:dd0d:448e:29f9:5e86])
        by smtp.gmail.com with ESMTPSA id h89sm6895800ioi.18.2017.06.13.14.38.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 14:38:16 -0700 (PDT)
Date:   Tue, 13 Jun 2017 14:38:15 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de,
        peff@peff.net
Subject: Re: [PATCH v2 4/6] config: don't implicitly use gitdir
Message-ID: <20170613213815.GP154599@google.com>
References: <20170612213406.83247-1-bmwill@google.com>
 <20170613210321.152978-1-bmwill@google.com>
 <20170613210321.152978-5-bmwill@google.com>
 <20170613210806.GJ133952@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170613210806.GJ133952@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/13, Jonathan Nieder wrote:
> Brandon Williams wrote:
> 
> > Commit 2185fde56 (config: handle conditional include when $GIT_DIR is
> > not set up) added a 'git_dir' field to the config_options struct.  Let's
> > use this option field explicitly all the time instead of occasionally
> > falling back to calling 'git_pathdup("config")' to get the path to the
> > local repository configuration.  This allows 'do_git_config_sequence()'
> > to not implicitly rely on global repository state.
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> >  builtin/config.c | 2 ++
> >  config.c         | 6 ++----
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> The same comments as before still apply:
> 
> - this changes API to make opts->git_dir mandatory, which is error prone
>   and easily avoidable, e.g. by making git_dir an argument to
>   git_config_with_options

I still don't agree with this.  I have looked at all callers and ensured
that 'git_dir' will be set when appropriate in the 'config_options'
struct.  I find the notion ridiculous that I would need to change a
function's name or arguments every time the internals of the function
are adjusted or when an options struct obtains a new field.  Plus, there
is already an aptly named parameter of type 'config_options' with which
to hold options for the config machinery.  This struct is also added to
in a later patch to include commondir so that the gitdir vs commondir
issue can be resolved.

> - the commit message doesn't say anything about to git dir vs common dir
>   change.  It needs to, or even better, the switch to use common dir
>   instead of git dir can happen as a separate patch.

There really isn't any switching in this patch.  One of the following
patches in this series addresses this problem in more detail though.

-- 
Brandon Williams
