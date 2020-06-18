Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A6DC433E0
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 08:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FFF320884
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 08:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pU7VDiqX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbgFRILe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 04:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728397AbgFRILa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jun 2020 04:11:30 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F3AC06174E
        for <git@vger.kernel.org>; Thu, 18 Jun 2020 01:11:29 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id p15so2350248qvr.9
        for <git@vger.kernel.org>; Thu, 18 Jun 2020 01:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cLdMJ8hneX7fvcYwMgqPSUMGloXlhaIpwAIivjC764A=;
        b=pU7VDiqXKkFJc8oKQYeEotfFdbWVVDte+dBMVJYoA8+xtihfvZuiwZXaGzYwrM7mzt
         DUf+/YS1vfz8opUHvxmQaKONMLjouz3Iz3t4KhEOAe14zPeYEJsaNZVq28v8LfJywgZS
         gg3Thpg32ZOV0Lmaejm6rys2SZa9xTbZPxpdVehpSNBR9eZsqjP88P60U6ZHke8spenw
         vTq5yC+cNLQuUTIRJUYELJgcaIqOB0kFWB19a3W1tSpBsri4PxaAuUeHowm+RP+/Z+5K
         Q0BSaDOf6DjgxxakfgT3w9kM5O/pRurV56eeLWjTXChW7D2lP3InyeKLQSKIvjBnf8DN
         HUVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cLdMJ8hneX7fvcYwMgqPSUMGloXlhaIpwAIivjC764A=;
        b=p8cDwWzDbK121tsZ97w7kVeEgDTCVnh0UeCWkwhA3lyCoRZyWA1KKAoQnQxvtUOnom
         jF/khd+IK9cfhkw72bH7V8WnVNSHtGeo6lR8BJLiJAATcWya5ryYRvUE31wRWX7V/qBO
         wPccAIBt25+OZGCVPCa/1wb8pEMHNWOywHaR+X8M6XAoL5u5+4yLiOlhJSdIuxKKzX9E
         zkVVXXjCERmDjKz7aTrds+84MCPgaYjgXUPFGhNByhTcjyhb3EmP1fRTir2/JuvtD1h7
         +Pwpg4wwRT/Y+fPATDX2iimh084bNUNl2ij7KrgCBtNUK+wFjwvZ8m0mXdfbMeyny9AV
         pqeQ==
X-Gm-Message-State: AOAM5324Rt1iL54cP5WW3lwYFXktoBFtOvs9M5+J1zRj7VLT1YFBNdBe
        SMBQlL5k57GWJ1A8jj/wTdQjZk6VxfrT8O8XSHM=
X-Google-Smtp-Source: ABdhPJyoWsIWHuLubbw4LjSFizbZhGm65BStJcKIcZ9PIIfQ0jUisbs5FP97kPWGZmSnWa7xhs9wOzpMq3wBDDKwcd0=
X-Received: by 2002:a05:6214:144:: with SMTP id x4mr2430985qvs.229.1592467887555;
 Thu, 18 Jun 2020 01:11:27 -0700 (PDT)
MIME-Version: 1.0
References: <BY5PR19MB3400EB9AD87DFE612AFD5CC390810@BY5PR19MB3400.namprd19.prod.outlook.com>
 <CAP8UFD3m9ANt6UOyOoMDy2haTJjhzL5ctFiki46ktgH3RLPqjA@mail.gmail.com>
 <BY5PR19MB3400AE170C9F5FF501D27B18909E0@BY5PR19MB3400.namprd19.prod.outlook.com>
 <CAP8UFD0aoNQNcNJytJBazoKj0jvWwykntHHgnYoCBXr6OmGOnQ@mail.gmail.com>
 <xmqqa716zs7w.fsf@gitster.c.googlers.com> <30661592138737@mail.yandex.ru> <BY5PR19MB34007DEED68D13003C614F5F909C0@BY5PR19MB3400.namprd19.prod.outlook.com>
In-Reply-To: <BY5PR19MB34007DEED68D13003C614F5F909C0@BY5PR19MB3400.namprd19.prod.outlook.com>
From:   demerphq <demerphq@gmail.com>
Date:   Thu, 18 Jun 2020 10:11:16 +0200
Message-ID: <CANgJU+WfW4mKotMwFS+2Kaq1pDysgJutJ2NhUvyvGgowk8JXsg@mail.gmail.com>
Subject: Re: Collaborative conflict resolution feature request
To:     "Curtin, Eric" <Eric.Curtin@dell.com>
Cc:     Konstantin Tokarev <annulen@yandex.ru>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "Geary, Niall" <Niall.Geary@dell.com>,
        "rowlands, scott" <Scott.Rowlands@dell.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        "Coveney, Stephen" <Stephen.Coveney@dell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 15 Jun 2020 at 11:30, Curtin, Eric <Eric.Curtin@dell.com> wrote:
>
> > An aside that probably would not directly help Eric, but I know the
> > above workflow helps reasonably well.  The 'pu' branch is rebuilt
> > not on top of 'next', but is rebuilt with all topics (including
> > those already in 'next') in flight directly on top of 'master',
> > which serves as a way to anticipate conflicts that will require
> > resolution in the future before the topics can enter 'next' branch.
>
> Out of all the currently available options this solution helps. Thanks
> Junio! I played with incremental merge techniques this weekend.
> One problem with incrementally merging is that you start fixing
> conflicts that are later invalidated by subsequent commits. So it
> seems you end up doing more conflict resolution than necessary.
> Unless I'm misusing the technique.

I find that the solution in these cases is to first use interactive
rebase to squash and reorganize the commits in the branches so you
have a nice clean patch sequence. Once you have the branches cleaned
up and squashed into a sequence of reasonable topic based chunks you
then merge, sometimes it even means you dont get conflicts at all, git
merge is pretty smart.

And after that you change your workflows so the rule is that whomever
pushes first to the "trunk branch" wins, and the other guy has to do
the conflict resolution. People will start merging earlier and more
often so they can keep the conflicts to a minimum. :-) In other words
I second what Philip Oakley said about bad workflows. Merge early,
merge often, rollout early, rollout often, vote early, vote often. :-)

cheers,
Yves


-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
