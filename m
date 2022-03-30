Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA940C433F5
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 02:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241927AbiC3CZr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 22:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240933AbiC3CZq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 22:25:46 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983123FBDA
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 19:24:01 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id b16so23297969ioz.3
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 19:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y2hDeC3Ov5BmZxxgbtou0uqDdxBfrU89GYSZA6XG3KI=;
        b=7aJsfCWpwNBsuF3t59oj8xfifP8X+aY8crhWAnlASqYskPSkdFCy8wagcSy2riuXHk
         Q0gLDSbuACJceNwRXTCeTN30BXWd8QmHN/ICyH6BFnasTmcfQTDE1FYXq1sLn2SJIl3D
         lvg80dhf2FAhC+nEyYCI3Rn/lrP01mP/s7a5A4ev5NLbWkwPm9MtFLbEKw7NKCVNORKA
         lezWdJlmfvIrAl1XrYTH63AZzIhyoVsmZymBjG4U9yt9Fkq1NfI2tYyYvwsO3K/4Nn2k
         +tMhCoo9kFoaaZO5Gg6q1GLPUznCCdNUIEgh4McSjJY4HHrqag4/5oZadwbExyH760PO
         CZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y2hDeC3Ov5BmZxxgbtou0uqDdxBfrU89GYSZA6XG3KI=;
        b=iu5O+lZxFNATLMrIgCo1+jMMTPCwjmpD+TTgHyLeTdCqd1C7f+rdH4aXV+oVNrkzLj
         CMw2NB+x4r6MCdtJqoLku8iVpn4ILKVw9UM5HwMpfwyi1Dm2+M1gYZ8vTGKRXJyYkCh0
         JUwGJFUHstgkxbnBGosw3+mwanIUfy0TOubV9DvQOJeHKauL8S1YxRaXFFYlBd7Uz5r0
         CoRvJcg3bOmiy27075VZeFg+ltY5gD9+HmwJZcvQ1DZdkniLyS4a1Ls+prwJu2jQYzyk
         kXx2Mtn+CxmIv49IFShP830JDg9x+LDezFUsvv5Csz5HOY6Lvf/TCNlVUaiX6ly2ck0V
         M2wg==
X-Gm-Message-State: AOAM533HXMjQ/pHMdudGEbMjNHmC7USuwZVBHdkwdaIdXtmaAYNQFbj8
        Tp4BU+pCrAhPBoDnRm8WffI05Q==
X-Google-Smtp-Source: ABdhPJxrtMVBsAaQkm2w3A8xk8wmUfwcWCPTCJMAEMepa/ztKfaSvFE+nGx/Giz6nXEZVb9xhX4vxg==
X-Received: by 2002:a05:6638:218f:b0:321:3fa6:79b8 with SMTP id s15-20020a056638218f00b003213fa679b8mr18329046jaj.206.1648607040858;
        Tue, 29 Mar 2022 19:24:00 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f4-20020a92b504000000b002c21ef70a81sm9950280ile.7.2022.03.29.19.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 19:24:00 -0700 (PDT)
Date:   Tue, 29 Mar 2022 22:23:59 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        tytso@mit.edu, derrickstolee@github.com, larsxschneider@gmail.com
Subject: Re: [PATCH v3 01/17] Documentation/technical: add cruft-packs.txt
Message-ID: <YkO/P3xgGYmhAz2O@nand.local>
References: <YiZI99yeijQe5Jaq@google.com>
 <YjkjaH61dMLHXr0d@nand.local>
 <YjpDbHmKY9XA2p0K@google.com>
 <YjpHbaBspUasDdEy@nand.local>
 <YjpWFZ95OL7joFa4@google.com>
 <Yjpxd8qhwnAIJJma@nand.local>
 <YkICkpttOujOKeT3@nand.local>
 <xmqq8rst23w0.fsf@gitster.g>
 <YkIm7lnQsUT0JnvS@nand.local>
 <xmqqa6d8yckj.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa6d8yckj.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 29, 2022 at 08:59:24AM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > I'm not sure... if we did:
> >
> > --- 8< ---
> >
> > diff --git a/setup.c b/setup.c
> > index 04ce33cdcd..fa54c9baa4 100644
> > --- a/setup.c
> > +++ b/setup.c
> > @@ -565,2 +565,4 @@ static enum extension_result handle_extension(const char *var,
> >  		return EXTENSION_OK;
> > +	} else if (!strcmp(ext, "cruftpacks")) {
> > +		return EXTENSION_OK;
> >  	}
> >
> > --- >8 ---
> >
> > but nothing more, then a hypothetical `extensions.cruftPacks` could be
> > used to prevent older writers in a mixed version environment. But if you
> > don't have or care about older versions of Git, you can avoid setting it
> > altogether.
>
> Smells like "unsafe by default, but you can opt into safety", which
> is backwards, isn't it?

I see it a little differently. The default (not writing cruft packs at
all) is safe, even in a mixed-version environment. If a user (a) wants
to use cruft packs, and (b) has older versions of Git also gc'ing the
repository, and (c) can't get rid of them, _then_ an opt-in extension
would make it impossible for those older versions to interact with the
repository.

I still can't shake the feeling that this is a pretty fringe and
timing-dependent scenario, which at worst keeps too many unreachable
objects around.

But I think this in conjunction with the already opt-in nature of cruft
packs would be a nice way to create safeguards for the situation
Jonathan described. There may be a simpler way, but I'm not sure I see
it (i.e., if you control whether or not `--cruft` is passed when
doing maintenance with newer versions of Git, but not whether older
versions are running around doing their own maintenance, then an
extension would be necessary to lock the old versions out).

> > But cruft packs are already guarded in two places:
> >
> >   - `git repack` won't write a cruft pack unless given the `--cruft`
> >     flag (i.e., `git repack -A` doesn't suddenly start generating cruft
> >     packs upon upgrade).
> >
> >   - `git gc` won't write cruft packs unless the `gc.cruftPacks`
> >     configuration is set, or `--cruft` is given as a flag.
>
> Hmph, OK.  So individuals can sort-of protect from hurting
> themselves by refraining from running these with --cruft or writing
> --cruft in their maintenance scripts.  An organization that wants to
> let the more adventurous types to early opt-in can prepare two
> versions of the maintenance scripts they distribute to their users,
> one with and the other without --cruft, and use the mechanism they
> use for gradual rollouts to control the population.  Perhaps that
> would make sufficient protection?  I dunno.
>
> Jonathan, what do you think?

I'm confused: if newer versions of Git are writing cruft packs, then
having the older versions gc'ing in the same repository runs into the
same scenario Jonathan originally describes.

The thing I think Jonathan seeks to prevent is older versions of Git
gc'ing a repo that has cruft packs. I think I may need you to clarify a
little, sorry :-(.

> > I'd be curious what Jonathan and others think of that approach (which,
> > to be clear, is what this series already implements). We could make it
> > clear to say:
> >
> >     If you have mixed versions of Git which both repack a repository
> >     (either manually or by auto-GC / background maintenance), consider
> >     leaving `gc.cruftPacks` unset and avoiding passing `--cruft` as a
> >     command-line argument to `git repack` and `git gc`, since doing so
> >     can lead to [...]
>
> That message is (depending on what comes in [...]) much more helpful
> than just throwing a word "mtime" out and letting the reader figure
> out the rest ;-)

Yes, totally agreed.

Thanks,
Taylor
