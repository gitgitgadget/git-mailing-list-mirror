Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A305C433EF
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 17:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbiBVRdd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 12:33:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbiBVRdc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 12:33:32 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80B6170D5C
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 09:33:06 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id d3so13195660ilr.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 09:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Mo7eaHZYV0j6g7prBdRHwpDzAGFd0RfJgl8MoQnU+7U=;
        b=PBOKbh9l+ZUf68BaQvSKIk1KVQekKVNbrJpfxFWx7Z5y5Y0sTbK1vsP+MIcfbpzuSG
         szZAWSBO3msM7L/5f5PtOvFIclbHlqK9/q0TLF3HrkASHP0K+ALALCGv/8g8uxnkK58t
         TXW6APf1tNIzjnv4H4+wgmxP7XwYiVwdxzLwkIaKVqjq0pIFZVDY8C2nfAth35v/QBZ/
         Q5vmunOxRMfZTKuH7QklN+vaUopdiT+GX26WW4ogPuqF9VX0PODqWHiibUsNdfxifp5D
         wPLoPExgB+bm7AyBZAYEXfKfvbHOWArZc2/62yEtQ/M2idVk35fNiEuCGVlobiVbfmTU
         lylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Mo7eaHZYV0j6g7prBdRHwpDzAGFd0RfJgl8MoQnU+7U=;
        b=gpJWlYx+ReDxv/7RrMlusTu7Q51xFRSkmvRX8uFB2Q2egDZAamG0DHm5ny2vX0Nzje
         rl5wBcn2DL9b2TFSr36ZBXao3st6sWqZx2OWcxtniBKoFjDoPy/VGPIUN23NVNmpoHAM
         g78jLbk7cET+Y2j2DSIDWAMCb+9xLH3KalLE0Ir+vzHdu5Nz1lEX2uKUf6ddQ8QmBjxQ
         ULVoWJbr7OX2zrIZONsgd3uqjkyLl5dHvWOZxG5zFKflPNZNqxMSWFyM7PjL6H6P32K8
         J5w3jF7hLurBr66Ra2Q2/7myciY3fRgmeSb+m0m01gv7v5aYWGyegJVfeWUNGWO2lnEi
         jxkQ==
X-Gm-Message-State: AOAM532uFGZ70XaJtutolq/DzDDYd17XAZlJb9HgNGv0O+Y1/aQAbfw2
        eRwvho1zOH32l7499MftnmznNw==
X-Google-Smtp-Source: ABdhPJwaRQFkZmtZq5gQWkgXVBSkF6qiqFLTTcnjXINgR+BtOWrFN1iJNZIiq5hU4KisNr6Lo3Z1rg==
X-Received: by 2002:a92:c148:0:b0:2c2:615a:49e9 with SMTP id b8-20020a92c148000000b002c2615a49e9mr2881742ilh.98.1645551186122;
        Tue, 22 Feb 2022 09:33:06 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a19sm790478ilq.19.2022.02.22.09.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 09:33:04 -0800 (PST)
Date:   Tue, 22 Feb 2022 12:33:04 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, John Cai <johncai86@gmail.com>,
        Robert Coup <robert.coup@koordinates.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 0/4] [RFC] repack: add --filter=
Message-ID: <YhUeUCIetu/aOu6k@nand.local>
References: <pull.1206.git.git.1643248180.gitgitgadget@gmail.com>
 <pull.1206.v2.git.git.1644372606.gitgitgadget@gmail.com>
 <CAFLLRpJ1aDyLb4qAoQwYDyGdP1_PH8kzLAQCKJpQwiYiapZ5Aw@mail.gmail.com>
 <CB2ACEF7-76A9-4253-AD43-7BC842F9576D@gmail.com>
 <YhMC+3FdSEZz22qX@nand.local>
 <CAP8UFD2dpicW64eqBK47g43xDWA1qv2BMBEOSqj_My5PUs8TSg@mail.gmail.com>
 <YhQHYQ9b9bYYv10r@nand.local>
 <CAP8UFD3U4t-inWC5mZYhybWpjVwkqA7v4hYZ5voBOEJ=+_Y1kQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD3U4t-inWC5mZYhybWpjVwkqA7v4hYZ5voBOEJ=+_Y1kQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,

I think my objections may be based on a misunderstanding of John and
your original proposal. From reading [1], it seemed to me like a
required step of this proposal was to upload the objects you want to
filter out ahead of time, and then run `git repack -ad --filter=...`.

So my concerns thus far have been around the lack of cohesion between
(1) the filter which describes the set of objects uploaded to the HTTP
server, and (2) the filter used when re-filtering the repository.

If (1) and (2) aren't inverses of each other, then in the case where (2)
leaves behind an object which wasn't caught by (1), we have lost that
object.

If instead the server used in your script at [1] is a stand-in for an
ordinary Git remote, that changes my thinking significantly. See below
for more details:

On Tue, Feb 22, 2022 at 06:11:11PM +0100, Christian Couder wrote:
> > > > I share the same concern as Robert and Stolee do. But I think this issue
> > > > goes deeper than just naming.
> > > >
> > > > Even if we called this `git repack --delete-filter` and only ran it with
> > > > `--i-know-what-im-doing` flag, we would still be leaving repository
> > > > corruption on the table, just making it marginally more difficult to
> > > > achieve.
> > >
> > > My opinion on this is that the promisor object mechanism assumes by
> > > design that some objects are outside a repo, and that this repo
> > > shouldn't care much about these objects possibly being corrupted.
> >
> > For what it's worth, I am fine having a mode of repack which allows us
> > to remove objects that we know are stored by a promisor remote. But this
> > series doesn't do that, so users could easily run `git repack -d
> > --filter=...` and find that they have irrecoverably corrupted their
> > repository.
>
> In some cases we just know the objects we are removing are stored by a
> promisor remote or are replicated on different physical machines or
> both, so you should be fine with this.

I am definitely OK with a convenient way to re-filter your repository
locally so long as you know that the objects you are filtering out are
available via some promisor remote.

But perhaps I have misunderstood what this proposal is for. Reading
through John's original cover letter and the link to your demo script, I
understood that a key part of this was being able to upload the pack of
objects you were about to filter out of your local copy to some server
(not necessarily Git) over HTTP.

My hesitation so far has been based on that understanding. Reading these
patches, I don't see a mechanism to upload objects we're about to
expunge to a promisor remote.

But perhaps I'm misunderstanding: if you are instead assuming that the
existing set of remotes can serve any objects that we deleted, and this
is the way to delete them, then I am OK with that approach. But I think
either way, I am missing some details in the original proposal that
would have perhaps made it easier for me to understand what your goals
are.

In any case, this patch series doesn't seem to correctly set up a
promisor remote for me, since doing the following on a fresh clone of
git.git (after running "make"):

    $ bin-wrappers/git repack -ad --filter=blob:none
    $ bin-wrappers/git fsck

results in many "missing blob" and "missing link" lines out of output.

(FWIW, I think what's missing here is correctly setting up the affected
remote(s) as promisors and indicating that we're now in a filtered
setting when going from a full clone down to a partial one.)

> If you are not fine with this because sometimes a user might use it
> without knowing, then why are you ok with commands deleting refs not
> checking that there isn't a regular repack removing dangling objects?

I'm not sure I totally understand your question, but my general sense
has been "because we typically make it difficult / impossible to remove
reachable objects".

Thanks,
Taylor

[1]: https://gitlab.com/chriscool/partial-clone-demo/-/blob/master/http-promisor/server_demo.txt#L47-52
