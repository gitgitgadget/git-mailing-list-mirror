Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B3FA1F404
	for <e@80x24.org>; Mon, 16 Apr 2018 16:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752067AbeDPQHM (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 12:07:12 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:39329 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751002AbeDPQHL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 12:07:11 -0400
Received: by mail-pl0-f65.google.com with SMTP id e7-v6so10292514plt.6
        for <git@vger.kernel.org>; Mon, 16 Apr 2018 09:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ZlrolOG/jLcRMvDOsEHf2lnZ+EKsTW1URjXq9C1aMOU=;
        b=Ai80LUryI3N3+7FhiB+aZvx0c+mg2LH1bZpwl3DEw/h8dC2dvIJZNcAVyIB8CE0y70
         4B59GkXJQSLQrgjVVceJE2WlH1HYJO6cZNOMtMFEUMq8CgZYAG7FCfOoAtEEAJ+4d21V
         39BY/AVVU6bo6GWh9Eil8akOQUFK0++YMVJu7mP7J2d0HiFGIfRFanQTed6Ccs1E316v
         iX0h3uvP5nk/yJzirhJrBOVSNvB+47HTsITNIeCwIL7Hscdrj3ETIzNG8wlVCYAOZnaP
         jxNen64W6DGmEIYaerK3sNBa66l52FXfRhKDQ0kzRtGTxaoO6zVi58Rfo/qWHo5kG8m/
         /q0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ZlrolOG/jLcRMvDOsEHf2lnZ+EKsTW1URjXq9C1aMOU=;
        b=cFFrASFGYWqDT4mQM+vDcRLrcFDx21b2NrjnsZ28WSN2X4/0dDKXcz1MAEJzAdkaXt
         1oWVeE1cZiwxZPnt/PQjQOIcF8N+ut3yjSkh4xYv1OuY0vL1vGpAQFbGMDYzfR6rvzk+
         f6b/hq5ConaPGjzAJ9K0wncTi964ddcX7uZNkAfwcHTE6KxjmcFP8jmcU2rq8U9YIGVT
         gmFIM6R6iQgtdOaNUzTqD/OMcjbfY7B7dtm4JW0/GmNlI4exblplA5dk9f+mtyemnkb8
         oGzje+u/g9YC698XtEZwFM55+NHFzRO/9aUOR8R5gkrqrXnWSqJuI46TOOWhpFvZLmdM
         X0xQ==
X-Gm-Message-State: ALQs6tAU8h6EyEHxVm59WP5pGUCcOfu7J/h4UKPzmdQI7FDwkE2GXqda
        jfjrD3kuEJ3KkVzkRY/myHczKAjh
X-Google-Smtp-Source: AIpwx49c1p9RB55K6FE7k1Iz8hYVGm2uOXXOjduP0aA61VQfW47OJKAjZtgvrYg07rFmauj9iPSpOQ==
X-Received: by 2002:a17:902:b105:: with SMTP id q5-v6mr16226713plr.173.1523894830838;
        Mon, 16 Apr 2018 09:07:10 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id q17sm22000841pgt.70.2018.04.16.09.07.05
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Apr 2018 09:07:09 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Optimizing writes to unchanged files during merges?
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CA+55aFxP8j7YbYaRXt-8Y0n8cHafB=FPKMy8gKFYH5QsKX4S=Q@mail.gmail.com>
Date:   Mon, 16 Apr 2018 18:07:00 +0200
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, mgorny@gentoo.org,
        rtc@helen.PLASMA.Xg8.DE, winserver.support@winserver.com,
        tytso@mit.edu
Content-Transfer-Encoding: quoted-printable
Message-Id: <F1738316-71EF-4053-82E5-F009F491CCE8@gmail.com>
References: <CA+55aFzLZ3UkG5svqZwSnhNk75=fXJRkvU1m_RHBG54NOoaZPA@mail.gmail.com> <xmqq604w2j4u.fsf@gitster-ct.c.googlers.com> <xmqqtvsg10bu.fsf@gitster-ct.c.googlers.com> <CA+55aFxA9YVLoh_23V8Hi+X7ODEmqg-dhdAYZz1jbq5JhXqBFw@mail.gmail.com> <CA+55aFwM2CaafNGq8_=GkYAw9inpm-4xcyHUmKprLv4Gb3-aVg@mail.gmail.com> <CA+55aFw5mpEcEpPTOWych-kjNLc8pEn8FdjJHe2u7HUBBLy-Fw@mail.gmail.com> <CA+55aFwwVZDetd-SobOzzLQW4_GEwm3krxEGR+cpqzkzK-yiwQ@mail.gmail.com> <CABPp-BHQsOSCJiPU9Ku5b67QTkAjnEBrhx04mTXf2QdPBriHmw@mail.gmail.com> <CA+55aFwi9pTAJT_qtv=vHLgu=B1fdXBoD96i8Y5xnbS=zrfSzg@mail.gmail.com> <xmqqbmekylgc.fsf@gitster-ct.c.googlers.com> <CA+55aFxP8j7YbYaRXt-8Y0n8cHafB=FPKMy8gKFYH5QsKX4S=Q@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 16 Apr 2018, at 04:03, Linus Torvalds =
<torvalds@linux-foundation.org> wrote:
>=20
> On Sun, Apr 15, 2018 at 6:44 PM, Junio C Hamano <gitster@pobox.com> =
wrote:
>>=20
>> I think Elijah's corrected was_tracked() also does not care "has
>> this been renamed".
>=20
> I'm perfectly happy with the slightly smarter patches. My patch was
> really just an RFC and because I had tried it out.
>=20
>> One thing that makes me curious is what happens (and what we want to
>> happen) when such a "we already have the changes the side branch
>> tries to bring in" path has local (i.e. not yet in the index)
>> changes.  For a dirty file that trivially merges (e.g. a path we
>> modified since our histories forked, while the other side didn't do
>> anything, has local changes in the working tree), we try hard to
>> make the merge succeed while keeping the local changes, and we
>> should be able to do the same in this case, too.
>=20
> I think it might be nice, but probably not really worth it.
>=20
> I find the "you can merge even if some files are dirty" to be really
> convenient, because I often keep stupid test patches in my tree that I
> may not even intend to commit, and I then use the same tree for
> merging.
>=20
> For example, I sometimes end up editing the Makefile for the release
> version early, but I won't *commit* that until I actually cut the
> release. But if I pull some branch that has also changed the Makefile,
> it's not worth any complexity to try to be nice about the dirty state.
>=20
> If it's a file that actually *has* been changed in the branch I'm
> merging, and I'm more than happy to just stage the patch (or throw it
> away - I think it's about 50:50 for me).
>=20
> So I don't think it's a big deal, and I'd rather have the merge fail
> very early with "that file has seen changes in the branch you are
> merging" than add any real complexity to the merge logic.

I am happy to see this discussion and the patches, because long rebuilds=20=

are a constant annoyance for us. We might have been bitten by the exact=20=

case discussed here, but more often, we have a slightly different=20
situation:

An engineer works on a task branch and runs incremental builds =E2=80=94 =
all=20
is good. The engineer switches to another branch to review another=20
engineer's work. This other branch changes a low-level header file,=20
but no rebuild is triggered. The engineer switches back to the previous=20=

task branch. At this point, the incremental build will rebuild=20
everything, as the compiler thinks that the low-level header file has
been changed (because the mtime is different).

Of course, this problem can be solved with a separate worktree. However,=20=

our engineers forget about that sometimes, and then, they are annoyed by=20=

a 4h rebuild.

Is this situation a problem for others too?
If yes, what do you think about the following approach:

What if Git kept a LRU list that contains file path, content hash, and=20=

mtime of any file that is removed or modified during a checkout. If a=20
file is checked out later with the exact same path and content hash,=20
then Git could set the mtime to the previous value. This way the=20
compiler would not think that the content has been changed since the=20
last rebuild.

I think that would fix the problem that our engineers run into and also=20=

the problem that Linus experienced during the merge, wouldn't it?

Thanks,
Lars=
