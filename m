Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2354FC433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 18:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236175AbhLGS4a (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 13:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236052AbhLGS43 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 13:56:29 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D21C061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 10:52:59 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id z13-20020a627e0d000000b004a2849e589aso150079pfc.0
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 10:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0VceLDr812G+zRrsVPliytnUYjopMmEkuDoa1GhQa6w=;
        b=gfFZFhx6sli2XxMnOFWbUzrywHD4FrSGwibdbX5dSBvQzcQXwSHxrQOdc8rAm4OwzQ
         nWOOQeA4MvjFiTde0bs2tHEVzEbSLTo4xK4dsiv89eejnYBWt/yZ5V/1OyawSRKJtcQj
         /kyIe5arZvghOcMEsLgk6m5vRHLLJI+wOtCuVrhcu7DHjz0CQRPhHH/vQZ7mKSve+BOo
         0uqsBAeoWMVz59V5bmFBsafypbTiMQIKMJGalrFUv56Hz/gon6gGHdXrNepRBTmrA2GO
         Rb/xAWb/IIk6Jr0HV9bq8LiDJKRh0pT7yhZ6u2g1z1ZPOKAwu/sVL+iVdN4vv2tkwBs/
         bFjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0VceLDr812G+zRrsVPliytnUYjopMmEkuDoa1GhQa6w=;
        b=u448JMyQWGl0bqrEfwWO1tRPFBYTFsMeZmloHDfRoDET+0PnlCegQqnvLE2orrfRc7
         LqqExXHZkbd7ambG1yJUs3mzbKc12IU+idkE7k8hGzIYASfLR9NOPCQr3YBKD6eqF64Q
         cKKciSXZJvyFSYg+mXkgGAfHUrkdmDltx7cZn8PdOwOZV53EoImgAqlPAZgl/sj3E8Gx
         oFdiAUWAL18r8BwLOTwr8JlM9snDwuAuOHSkUX+u8+vdTmdtwd+BkBjZ1EYfaYcMVwhy
         BWY+YlJZFPKqqkCcMytsegHD6xIvLonnOZf0DSXNggHb0ZWxVVlPUTRPIvgyIsox9EqL
         Ep3w==
X-Gm-Message-State: AOAM532l7VH03L3yJDk2Opdlg012bvBe4sEDNDefGQFdFtUzs0vdgic9
        utTu0m/HfP+gzF4yLT8j4ggYwZ2EhMPmSJXiVcIn
X-Google-Smtp-Source: ABdhPJyhvuFvhnRSo4RW8WMjBRh1Yk6b0U7BPPS4HY7/JwPIt05+A7D+sXsFfVrmts2ef2n1s89aBd+R3b8v5qRMFvDI
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:7004:: with SMTP id
 f4mr1157071pjk.156.1638903178633; Tue, 07 Dec 2021 10:52:58 -0800 (PST)
Date:   Tue,  7 Dec 2021 10:52:56 -0800
In-Reply-To: <211207.86k0ggnvfo.gmgdl@evledraar.gmail.com>
Message-Id: <20211207185256.2305093-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <211207.86k0ggnvfo.gmgdl@evledraar.gmail.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: Re: [PATCH v5 0/2] Conditional config includes based on remote URL
From:   Jonathan Tan <jonathantanmy@google.com>
To:     avarab@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, chooglen@google.com,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> >>  * Inlining the "remote_urls" in the struct makes its management easier;
> >>    and the free/NULL checks just check .nr now, and string_list_clear() can be
> >>    unconditional.
> >
> > I don't think we can do this - nr might still be 0 after a scan if we
> > don't have remote URLs for some reason, so we still need to distinguish
> > between not-scanned and scanned-with-zero-URLs.
> 
> You mean so that we don't double-free? The way string_list_clear()
> protects against that, but maybe there's something else.
> 
> Whatever it is (if there's anything) it could use test coverage then :)

No - we only want to do one scan per config read. If we scan and there
are no remote URLs, with your scheme, next time we encounter another
includeIf.hasconfig, we would need to scan again (because nr is still
0). With my scheme, we can see that the pointer is non-NULL, so we know
that we have already scanned.

> >>  * It would be nice if e.g. the "includeIf.hasconfig:remote.*.url globs" test
> >>    were split up by condition, but maybe that's a hassle (would need a small helper).
> >> 
> >>    Just something that would have helped while hacking on this, i.e. now most of it
> >>    was an all-or-nothing failure & peek at the trace output
> >
> > What do you mean by condition? There seems to only be one condition
> > (whether the URL is there or not), unless you were thinking of smaller
> > subdivisions.
> 
> Maybe I'm just misunderstanding the intent here, but aren't you trying
> to guard against the case of having a ~/.gitconfig that includes
> ~/.gitconfig.d/for-this-url, and *that* file in turns changes the
> remote's "url" in its config, followed by another "include if url
> matches" condition therein?
> 
> I.e. I read (more like skimmed) the documentation & test at the end as
> forbidding that, but maybe that's OK?

If we're including "~/.gitconfig.d/for-this-url" by includeIf.hasconfig,
then yes, I'm guarding against that and other similar conditions.

> > We can decide later what the future facility will be, but I envision
> > that we will not allow included files to set config that can affect any
> > include directives in use. So, for example, if I have a user.email-based
> > include, none of my config-conditionally included files can set user.email.
> 
> I didn't look deeply at the implementation at all, but why would this be
> a problem?
> 
> You parse ~/.gitconfig, it has user.name=foo, then right after in that
> file we do:
> 
>     [includeIf "hasconfig:user.name:*foo*"]
>     path = ~/.gitconfig.d/foo
> 
> Now the top of  ~/.gitconfig.d/foo we have:
> 
>     [user]
>     name = bar
>     [includeIf "hasconfig:user.name:*bar*"]
>     path = ~/.gitconfig.d/bar
> 
> Why would it matter that we included on user.name=foo before?
> 
> Doesn't that only matter *while* we process that first "path" line? Once
> we move past it we update our configset to user.name=bar once we hit the
> "name" line of the included file.
> 
> Then when we get another "hasconfig:user.name" we just match it to our
> current user.name=*bar*.
> 
> No?
> 
> Anyway, I think it's fine to punt on it for now or whatever, just
> curious...

Well, we can't punt on it because what you describe also applies to
remote URL :-)

So what you're saying is that once we have decided to include a file, we
always include it in its entirety regardless of whether the condition
changes during the file's include. That's reasonable, but other people
could have differing opinions. In this case, I think it's fine just to
prohibit it entirely. In the future, we may look into relaxing this
condition.
