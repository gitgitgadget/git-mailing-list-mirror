Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B941A1F461
	for <e@80x24.org>; Thu, 20 Jun 2019 15:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfFTPHS (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 11:07:18 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43137 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbfFTPHS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 11:07:18 -0400
Received: by mail-io1-f67.google.com with SMTP id k20so65245ios.10
        for <git@vger.kernel.org>; Thu, 20 Jun 2019 08:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3t3MiP8pqPKb5PWCcM2Y69kzjp16ynrwodWzT5VIgMw=;
        b=Czp3AZB5Cd+6scRu2u42k+msI+f3IpTZ+iuc1MY3liEy4Ld4mkww8t9lhR7xN9JLB1
         BdKEMxCPBsGTi4ipLn12g3QPrWMyn3Wbu56fIat5E7HHS7JAk1TD8cNdzYNkfSI02q59
         Gs4JqqzqNy0nG+bINiLu5Gx+CRFXQKjHw660K4wB8+ObFsVZCzxQGOv6G5BUN80BRHyR
         +VRM76NFqqQSZQO6jOtrzfazneqtBmPZbx1RYZyrInj2T9u6ALCOv0aR7gSrkKOSXZ6X
         9H80i4ZbyzaQTUlEkBIREzbLM7HBrfNluXUk1MPvPJIv9gjwccE7BhvbjdL9VJpJ57ff
         +z/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3t3MiP8pqPKb5PWCcM2Y69kzjp16ynrwodWzT5VIgMw=;
        b=jCpremFJRrAltbxy0UCLEOAEmxwrceoEVPTI0RPxOEW7hEeW3uO8tomaQFCuvpHZIX
         MlTjGHeG2lbgC90DNK5YAADXOPVefJJykLE8t6O7MA49099SbhSeM1DZUwtIci9w8Vdc
         oiGr8pbdhuUj2Q+mVK5SgfVVMt6Gb0Fs/SlhdyRjPP/ua9io1/BYGJEaegClEQuFjx+4
         M8zrZTWKd84J7Ey++4QL5PfWoThBV+s0TpDdPu0NYnGtKCfIjXWQbUeYD4EaB417pOTW
         MTh0Kv0rD387XqyE6UWgJOjkDE3ZKBNINkDpG5AfK7UN8KtcsLYD0180EYmtbz8bWOmz
         wpgQ==
X-Gm-Message-State: APjAAAXKWITwULN7vrl7lb88L5+LkHh9w/aQyP7Pu1qUepqdEtUn1cox
        4IsSBtPullupVR0OyJsGYkwo+gAzqSv+HKK4GSZiUw==
X-Google-Smtp-Source: APXvYqxUDMw3QxTkjkRb7ROFV2OQRq2uwna8Ct0bwXKOknh+U/kg+9eVIcMiM2lUlEdo1eqwXFFlRgDai1+zliipFSY=
X-Received: by 2002:a5d:8347:: with SMTP id q7mr34813246ior.277.1561043237968;
 Thu, 20 Jun 2019 08:07:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190620095523.10003-1-pclouds@gmail.com> <20190620095523.10003-3-pclouds@gmail.com>
 <446ace86-714f-9109-99d8-95554ceaf26b@gmail.com>
In-Reply-To: <446ace86-714f-9109-99d8-95554ceaf26b@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 20 Jun 2019 22:06:51 +0700
Message-ID: <CACsJy8DoEwoR67BopXLPiBmuidixREn-Ac16V5di6sFZx_Gbng@mail.gmail.com>
Subject: Re: [PATCH 2/4] switch: allow to switch in the middle of bisect
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 20, 2019 at 9:02 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 6/20/2019 5:55 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> > In c45f0f525d (switch: reject if some operation is in progress,
> > 2019-03-29), a check is added to prevent switching when some operation
> > is in progress. The reason is it's often not safe to do so.
> >
> > This is true for merge, am, rebase, cherry-pick and revert, but not so
> > much for bisect because bisecting is basically jumping/switching betwee=
n
> > a bunch of commits to pin point the first bad one. git-bisect suggests
> > the next commit to test, but it's not wrong for the user to test a
> > different commit because git-bisect cannot have the knowledge to know
> > better.
>
> When a user switches commits during a bisect, it can just create new
> known-good or known-bad commits, right? It won't mess up the next
> selection of a test commit? I'm imagining someone jumping to a commit
> between two known-bad commits or something, when it is more likely that
> they are jumping to a parallel history.

Until you run "git bisect bad" or "git bisect good" I don't think
switching could mess up bisect. And I'm pretty sure I marked wrong
ones once or twice and git-bisect did complain.

It would be a good idea to warn about jumping in known-good-or-bad
commit ranges. I'll keep this as an improvement point (there's still
another one I haven't done, also about warning improvement, sigh).

> > For this reason, allow to switch when bisecting (*). I considered if we
> > should still prevent switching by default and allow it with
> > --ignore-in-progress. But I don't think the prevention really adds
> > anything much.
> >
> > If the user switches away by mistake, since we print the previous HEAD
> > value, even if they don't know about the "-" shortcut, switching back i=
s
> > still possible.
>
> I tell everyone I know about the "-" shortcut, and I'm always surprised
> they didn't already know about "cd -".

I actually wanted to go a bit more aggressive/verbose about "teaching"
users via the advice framework, but allows the user to turn off the
"lessons" they already learned. Something like gcc adding
[-Wno-foobar] in a warning to hint how to turn it off. I'll come back
to this at some point, hopefully.
--=20
Duy
