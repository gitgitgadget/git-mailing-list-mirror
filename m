Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12FDC1F790
	for <e@80x24.org>; Tue,  2 May 2017 17:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751356AbdEBRZ7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 13:25:59 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33994 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751021AbdEBRZ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 13:25:58 -0400
Received: by mail-pf0-f175.google.com with SMTP id e64so352703pfd.1
        for <git@vger.kernel.org>; Tue, 02 May 2017 10:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ejkh2obh6pBanPRXKLNoOjA/tRWP1EbQGbdnFX/h+no=;
        b=Zm5lv72nNmGPmfNfzwqur7R6aM2/YOWxSYEFdOatuuHnw9CK6ohwroosBeW+h1s1tJ
         0pBRdQGpDTv+pRIb/Se1uChe60ifN40mG8z8J6pPLVYyc95ftHJtT4ASw8uTTeDW7MtP
         FkYSnF0Y6+/Fem7MbIped40zY8yglm5BBDCY4X3/xYUQxujSlRIfL6+6ocXE0TR7d79x
         niY3OV4JEOoxGi8N+ffjT8+eJRcJLB6xQW8mC85ghyaT1HdVIkFrns6W9wM3DI1CVVDA
         NIVvc5gKM5ij9yPuORGsP0oaYSynW3fOF4KOPogu1OW4hFCD5cF/C1vdqWiYZkjgw1Vh
         szRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ejkh2obh6pBanPRXKLNoOjA/tRWP1EbQGbdnFX/h+no=;
        b=gehKuwM/fNu5xs5wKvMz07e655meBoACmaS2yODWASK7/5MWocdHMQvYjxE3jKfqna
         G8NKWqPopvpvUeDJtKKvuF0Un6cTCpYJfm6vp5sMDiPVD13QUOk5AiYVJE+w9j1I3C0A
         rBXSqaQ1RSXuL6WEwIU7Pgy2vPuPJNJZsvQcFLO0NjEw2p43WZ+VxtvFvyuXXB6rZ6eO
         YPPNoIrxtZgKsWo8Vp5vAc7kDwr/K+uT+rU63GdmWI1Pf7NQWhkIxBknJyknOQEtgKhB
         pesNWLgcDZV+t28zslnQ/B6IGDJihez7hwMmcN5yEp4+iaEJf/2A0Q3fjOkCi8IjGpzA
         k8WA==
X-Gm-Message-State: AN3rC/5RH0I4dEGATE75aNcaEA6ixFCU0neaMpYOdkGOhcqrMMaVscT2
        DulPGad1hzwd8UkC
X-Received: by 10.84.192.37 with SMTP id b34mr43438480pld.174.1493745958002;
        Tue, 02 May 2017 10:25:58 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:61ee:b5d7:71fe:5285])
        by smtp.gmail.com with ESMTPSA id o62sm58837pfj.87.2017.05.02.10.25.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 02 May 2017 10:25:56 -0700 (PDT)
Date:   Tue, 2 May 2017 10:25:55 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 5/6] submodule: improve submodule_has_commits
Message-ID: <20170502172555.GA181268@google.com>
References: <20170428235402.162251-1-bmwill@google.com>
 <20170502010239.179369-1-bmwill@google.com>
 <20170502010239.179369-6-bmwill@google.com>
 <CAGZ79kbbz3AAjbg_dV9RVS8kgLs-zWZxt5tsFbQczCm78LcTVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kbbz3AAjbg_dV9RVS8kgLs-zWZxt5tsFbQczCm78LcTVw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/01, Stefan Beller wrote:
> On Mon, May 1, 2017 at 6:02 PM, Brandon Williams <bmwill@google.com> wrote:
> > +
> > +               if (capture_command(&cp, &out, GIT_MAX_HEXSZ + 1) || out.len)
> 
> eh, I gave too much and self-contradicting feedback here earlier,
> ideally I'd like to review this to be similar as:
> 
>     if (capture_command(&cp, &out, GIT_MAX_HEXSZ + 1)
>         die("cannot capture git-rev-list in submodule '%s', sub->path);

This wouldn't really work because if you provide a SHA1 to rev-list
which it isn't able to find then it returns a non-zero exit code which
would cause this to die, which isn't the desired behavior.

> 
>     if (out.len)
>         has_commit = 0;
> 
> instead as that does not have a silent error. (though it errs
> on the safe side, so maybe it is not to bad.)
> 
> I could understand if the callers do not want to have
> `submodule_has_commits` die()-ing on them, so maybe
> 
>     if (capture_command(&cp, &out, GIT_MAX_HEXSZ + 1) {
>         warning("cannot capture git-rev-list in submodule '%s', sub->path);
>         has_commit = -1;
>         /* this would require auditing all callers and handling -1 though */
>     }
> 
>     if (out.len)
>         has_commit = 0;
> 
> As the comment eludes, we'd then have
>  0 -> has no commits
>  1 -> has commits
> -1 -> error
> 
> So to group (error || has_no_commits), we could write
> 
>     if (submodule_has_commits(..) <= 0)
> 
> which is awkward. So maybe we can rename the function
> to misses_submodule_commits instead, as then we could
> flip the return value as well and have
> 
>  0 -> has commits
>  1 -> has no commits
> -1 -> error
> 
> and the lazy invoker could just go with
> 
>     if (!misses_submodule_commits(..))
>         proceed();
>     else
>         die("missing submodule commits or errors; I don't care");
> 
> whereas the careful invoker could go with
> 
>     switch (misses_submodule_commits(..)) {
>     case 0:
>         proceed(); break;
>     case 1:
>         pull_magic_trick(); break;
>     case -1:
>         make_errors_go_away_and_retry(); break;
>     }

I feel like you're making this a little too complicated, as all I'm
doing is shuffling around already existing logic.  I understand the want
to make things more robust but this seems unnecessarily complex.

> ---
> On the longer term plan:
> As you wrote about costs. Maybe instead of invoking rev-list,
> we could try to have this in-core as a first try-out for
> "classified-repos", looking at refs.h there is e.g.
> 
>     int for_each_ref_submodule(const char *submodule_path,
>           each_ref_fn fn, void *cb_data);
> 
> which we could use to obtain all submodule refs and then
> use the revision walking machinery to find out ourselves if
> we have or do not have the commits. (As we loaded the
> odb of the submodule, this would *just work*, building one
> kludgy hack upon the next.)
> 
> Thanks,
> Stefan

-- 
Brandon Williams
