Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 117FF20A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 18:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbeLMSue (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 13:50:34 -0500
Received: from mail-ed1-f47.google.com ([209.85.208.47]:39098 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbeLMSud (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 13:50:33 -0500
Received: by mail-ed1-f47.google.com with SMTP id b14so2906953edt.6
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 10:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O3qC3WTR6dRcT59DfrzXFQarEQQyoYQ40Roeqa/TSLQ=;
        b=O1El3PwrtW3C03EHA9yoOsB5SBBHpqWWrNtjVx0OHABWcyB7wiy/n4sWNWaOnD5bDV
         nn7yiqwT2irE/ERDdgye+IcLRVko3R82ofG1s4opWfVgJ/xtA96vt/rqkDVgWobjCU5e
         gJZVQZj1HabWeoqsh8BiGV3r2mX5eiV/yKOKCEblr/nM9raVjzEMGvonniFNb27a6dAJ
         2uVXvWTD7RV4vnUSsE93qECXuxWk3BHoxII3O16f+cRd1h1WSkWTT6hogG2KdtKHCtey
         tc4R3l19M03gIDJH1tXlAgO36qRjQYeCMcWFSblsx6YJz6gheRN3GsYcMLvnKiJxR+Du
         dcWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O3qC3WTR6dRcT59DfrzXFQarEQQyoYQ40Roeqa/TSLQ=;
        b=QG9913mVBCYIxSzCbdlD5NnVpjkwPrnEEbPvUVzX1gHyEOEr1gQvbjqAzWaeFTObh+
         0NOrg68iAThRHR22lRFflzow/++CXBm5POVmTUD76gNop6vLsJ/k8Cq1DPAQSzBJEa9E
         LB/9f4yaiZCa9pz/t/vf0Fl6HJgf/SLIMATjCLpvpWHtEsTnpR+n/UusGWQXv0soDK5g
         rYZbmWGIU9d8AELD/9LHGiETjj/afKhWdchr+1MnAX8/l4Pmnvos9sHIlnKimqb9/fXd
         vYP5Sjdxzoek5VmFnAuV2PdM3hHn8bAj832GGH3E9kwSuoTfO5nm1x9Yxksn2F2FfWYB
         ufgg==
X-Gm-Message-State: AA+aEWYdPLmxrSsjLS33DyGVrzn+8MqBZCARSirfBpCSuRWSHTvu1Ctm
        BCwYwKNWPV1qWs1x4fU2pwubAzmHxiRftJSlu4VXSscW46Q8Gw==
X-Google-Smtp-Source: AFSGD/WY+MvSKAW51O6Q6/DXg1oX3RZLWzSIhrdZB+aZJ6JnJXRCrRoskq3qAoEPAfIiZoXZ4Ka7zdW24SKQ5wh0caA=
X-Received: by 2002:a50:8fe4:: with SMTP id y91mr357942edy.231.1544727031405;
 Thu, 13 Dec 2018 10:50:31 -0800 (PST)
MIME-Version: 1.0
References: <CAHef355RQt9gN-7QjuAAT8mZsNFKfCo4hOYi2+bkp-0Av7W=Qw@mail.gmail.com>
 <xmqqva3xecjz.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqva3xecjz.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 13 Dec 2018 10:50:20 -0800
Message-ID: <CAGZ79kYsk8YEUUhMVF9fBC++fop3CPyobXTgHTuF2Lgikf9CJA@mail.gmail.com>
Subject: Re: 2.20.0 - Undocumented change in submodule update wrt # parallel jobs
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, sjon@parse.nl
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 13, 2018 at 6:17 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Sjon Hortensius <sjon@parse.nl> writes:
>
> > When switching to 2.20 our `git submodule update' (which clones
> > through ssh) broke because our ssh-server rejected the ~20
> > simultaneous connections the git-client makes. This seems to be caused
> > by a (possibly unintended) change in
> > https://github.com/git/git/commit/90efe595c53f4bb1851371344c35eff71f604d2b
> > which removed the default of max_jobs=1
> >
> > While this can easily be fixed by configuring submodule.fetchJobs I
> > think this change should be documented - or reverted back to it's
> > previous default of 1
>
> The commit in question does not look like it _wanted_ to change the
> default; rather, it appears to me that it wanted to be bug-to-bug
> compatible with the original, and any such change of behaviour is
> entirely unintended.

Indeed.

> I think the attached may be sufficient to change the default
> max_jobs back to 1.

I think so, too. I can wrap it into a commit with a proper message.

>
> By the way, is there a place where we document that the default
> value for fetchjobs, when unconfigured, is 1?

`man git config`

    submodule.fetchJobs
           Specifies how many submodules are fetched/cloned at the
           same time. A positive integer allows up to that number of
           submodules fetched in parallel. A value of 0 will give some
           reasonable default. If unset, it defaults to 1.

and that seems to be the only place, other places only reference
this place:

    Documentation$ git grep submodule.fetch
    config/submodule.txt:66:submodule.fetchJobs::
    git-clone.txt:259:      Defaults to the `submodule.fetchJobs` option.
    git-submodule.txt:408:  Defaults to the `submodule.fetchJobs` option.

The behavior of that seems to have been there since the beginning of
a028a1930c (fetching submodules: respect `submodule.fetchJobs`
config option, 2016-02-29)


> If we are not making
> such a concrete promise, then I would think it is OK to update the
> default without any fanfare, as long as we have good reasons to do
> so.  For this particular one, however, as I already said, I do not
> think we wanted to change the default to unlimited or anything like
> that, so...

We definitely want the diff below as a proper patch.

>  builtin/submodule--helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 789d00d87d..e8cdf84f1c 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1552,7 +1552,7 @@ struct submodule_update_clone {
>  #define SUBMODULE_UPDATE_CLONE_INIT {0, MODULE_LIST_INIT, 0, \
>         SUBMODULE_UPDATE_STRATEGY_INIT, 0, 0, -1, STRING_LIST_INIT_DUP, 0, \
>         NULL, NULL, NULL, \
> -       NULL, 0, 0, 0, NULL, 0, 0, 0}
> +       NULL, 0, 0, 0, NULL, 0, 0, 1}
>
>
>  static void next_submodule_warn_missing(struct submodule_update_clone *suc,
