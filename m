Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0EC2C433EF
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 21:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiC1VXl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 17:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiC1VXj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 17:23:39 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA8F1275C0
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 14:21:52 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id g21so5541102iom.13
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 14:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eVXmMgzWbt5f1tjbawoeWRa8v0RFRknO20v5jVtCPBw=;
        b=2BSBefUEmHHhgEfctQSOtAs8/GOaVvjdLRUHuxq+d08lY4I60ki3ZSam72N7zQtjJo
         lxtgjbFl5wh5el0M1S+ET45EzTGpDmYjXCpbXRs0ZJWM4ZVsEHDaoluJgyYrNojVjY/3
         JKemoAqdjYfQUw2ndeCz1C33lms4wKrYL2CCme9hFOpI92LZ/h5mlOQLeS6ezihP/ulo
         ux50nF2+I8tKBGC6ZvmUFMtcNWoaqc0p0zRGwYQXc9I28tC9kOJgWO3uAQdREONJH4CN
         JA9HEL0ymIIBMQaeIPS/mR3rRB8GH36RHCTrBumy0NXtqlzUpyQYOgrKeXnZ+RCMC1yN
         M/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eVXmMgzWbt5f1tjbawoeWRa8v0RFRknO20v5jVtCPBw=;
        b=vPQRohblhfFipnUSLFaFREX9nmRgDhXCeX4SNTLUZPCmJBN/QRpv77Ubg7XmY+ODIH
         1fQ77Ge2s1pm1Yu8qDiUofkmpVMsaK3faB5SesPKIIoeBnS3vrXiDVxDkxwAirgvB5zJ
         hjMXzPbctteDEK8ljJqmw201d1sdccF9M3vF5wEADIjyGCE1NeIajviMDtvN+DtedJ+v
         UcLjaYc1Y9fAxsqdeGKuHtgrlFY99p6Pr1IzuCkTpNe/gBMq/raXjkQUF/PZiG6IBRSQ
         Q27flMAy9IYRnBKBPvAL++YYAIT8kF3VuB48hSqvKKsZfqeIEpNHvCRioDd4BbnL8Bpa
         iQzw==
X-Gm-Message-State: AOAM532Vh+uAZ/4yU5vWia8D08izMXPvwk2Ho26Pvl1JkwfsUnvbqb60
        LjTNnHU5Pgqq2iLbwNloP0UirA==
X-Google-Smtp-Source: ABdhPJwXsAS6eAKMBHpjdTPo8AA8sWat9nx7TuQ2LOEGf6HGuLtCe/aHGBHkLQW38cXLFsWE9P0Mcg==
X-Received: by 2002:a6b:d206:0:b0:5f0:7095:78b5 with SMTP id q6-20020a6bd206000000b005f0709578b5mr7294668iob.213.1648502511769;
        Mon, 28 Mar 2022 14:21:51 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id n3-20020a056e0208e300b002c9c9974c48sm920376ilt.36.2022.03.28.14.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 14:21:51 -0700 (PDT)
Date:   Mon, 28 Mar 2022 17:21:50 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        tytso@mit.edu, derrickstolee@github.com, larsxschneider@gmail.com
Subject: Re: [PATCH v3 01/17] Documentation/technical: add cruft-packs.txt
Message-ID: <YkIm7lnQsUT0JnvS@nand.local>
References: <cover.1646266835.git.me@ttaylorr.com>
 <784ee7e0eec9ba520ebaaa27de2de810e2f6798a.1646266835.git.me@ttaylorr.com>
 <YiZI99yeijQe5Jaq@google.com>
 <YjkjaH61dMLHXr0d@nand.local>
 <YjpDbHmKY9XA2p0K@google.com>
 <YjpHbaBspUasDdEy@nand.local>
 <YjpWFZ95OL7joFa4@google.com>
 <Yjpxd8qhwnAIJJma@nand.local>
 <YkICkpttOujOKeT3@nand.local>
 <xmqq8rst23w0.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8rst23w0.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 28, 2022 at 01:55:43PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > To summarize Jonathan's point (as I think I severely misunderstood it
> > before), if two writers are repacking a repository with unreachable
> > objects. The following can happen:
> >
> >   - $NEWGIT packs the repository and writes a cruft pack and .mtimes
> >     file.
> >
> >   - $OLDGIT packs the repository, exploding unreachable objects from the
> >     cruft pack as loose, setting their mtimes to "now".
>
> And if these repeat, alternating new and old versions of Git, we
> will keep refreshing the unreachable objects' mtimes forever.
>
> But once you stop using old versions of Git, perhaps in 3 release
> cycles or so, we'll eventually be able to purge them, right?

As soon as all of the repackers understand cruft packs, yes.

> > One approach (that Jonathan suggested) is to prevent the above situation
> > by introducing a format extension, so $OLDGIT could not touch the
> > repository. But this comes at a (in my view, significant) cost which is
> > that $OLDGIT can't touch the repository _at all_. An extension would be
> > desirable if cross-version interaction resulted in repository
> > corruption, but this scenario does not lead to corruption at all.
>
> A repository may not be in a healthy state, when tons of unreachable
> objects stay around forever, but it probably is a bit too harsh to
> call it "corrupt".

I agree, though I would note that this is no worse than the situation
today, where unreachable-but-recent objects are already exploded as
loose can already cause the kinds of issues that this series is designed
to prevent.

> > Another approach (courtesy Stolee, in an off-list discussion) is that we
> > could introduce an optional extension available as an opt-in to prevent
> > older versions of Git from interacting in a repository that contains
> > cruft packs, but is not required to write them.
>
> That smells too magic; let's not go there.

I'm not sure... if we did:

--- 8< ---

diff --git a/setup.c b/setup.c
index 04ce33cdcd..fa54c9baa4 100644
--- a/setup.c
+++ b/setup.c
@@ -565,2 +565,4 @@ static enum extension_result handle_extension(const char *var,
 		return EXTENSION_OK;
+	} else if (!strcmp(ext, "cruftpacks")) {
+		return EXTENSION_OK;
 	}

--- >8 ---

but nothing more, then a hypothetical `extensions.cruftPacks` could be
used to prevent older writers in a mixed version environment. But if you
don't have or care about older versions of Git, you can avoid setting it
altogether.

The key bit is that we don't have a check along the lines of "only allow
writing a cruft pack when extensions.cruftPacks" is set, so it's opt-in
as far as the new code is concerned.

> > A third approach (and probably my preferred direction) is to indicate
> > clearly via a combination of updates to Documentation/cruft-packs.txt
> > and the release notes that say something along the lines of:
> >
> >     If you use are repacking a repository using both a pre- and
> >     post-cruft packs version of Git, please be aware that you will lose
> >     information about the mtimes of unreachable objects.
>
> I do not quite see how it helps.  After hearing "... will lose
> information about the mtimes ...", what concrete action can a user
> take?  Or a sys-admin?
>
> It's not like use of cruft-pack is mandatory when you upgrade the
> new version of Git, right?  Perhaps use of cruft-pack should be
> guarded behind a configuration variable so that users who might want
> to use mixed versions of Git will be protected against accidental
> use of new version of Git that introduces the forever-renewing
> untracked objects problem?

I don't think we would have much to offer a user in that case; if the
mtimes are gone, then I couldn't think of anything to bring them back
outside of setting them manually.

But cruft packs are already guarded in two places:

  - `git repack` won't write a cruft pack unless given the `--cruft`
    flag (i.e., `git repack -A` doesn't suddenly start generating cruft
    packs upon upgrade).

  - `git gc` won't write cruft packs unless the `gc.cruftPacks`
    configuration is set, or `--cruft` is given as a flag.

I'd be curious what Jonathan and others think of that approach (which,
to be clear, is what this series already implements). We could make it
clear to say:

    If you have mixed versions of Git which both repack a repository
    (either manually or by auto-GC / background maintenance), consider
    leaving `gc.cruftPacks` unset and avoiding passing `--cruft` as a
    command-line argument to `git repack` and `git gc`, since doing so
    can lead to [...]

> Perhaps a configuration variable, repack.cruftPackEnabled, that is
> by default disabled, can be used to protect people who do not want
> to get into the "keep refreshing mtime" loop from using the cruft
> packs by mistake?  repack.cruftPackEnabled can probably be part of
> the "experimental" feature set, if we think it is the direction in
> the future.

I'd probably want to leave `-A` separate from `--cruft`, since something
about setting `repack.cruftPackEnabled` having the effect of causing
`-A` to produce a cruft pack feels strange to me.

Thanks,
Taylor
