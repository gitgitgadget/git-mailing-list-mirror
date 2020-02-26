Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C4D1C4BA0A
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 07:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B9EE21556
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 07:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eciuEpHB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgBZHSx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 02:18:53 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36735 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbgBZHSx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 02:18:53 -0500
Received: by mail-qt1-f195.google.com with SMTP id t13so1572496qto.3
        for <git@vger.kernel.org>; Tue, 25 Feb 2020 23:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0k2hvsPfRauFifmkUGnoSP56O1dT+aI6EAKgUWvtjfs=;
        b=eciuEpHBHRYE3oVIHvH8LukK5cV3lq2zws3J9poQOXZoeo4FBD0pMHwpO++qSunyeE
         JBsBkQdbgBpKDKNo3bgYEcZlD9W40GgT4IOGrBooIQxxLpAew425UHMBGPfs/lgxYdPd
         Qb7Cm4pFigrvU4wflcfg1kV5VHjGzi+q0bWejR+gjeP1odttYYwUDAO0r3r10ISWtNIl
         4vfAu3MCNVnQpTwTaUSLOJ8zv4hmDZAqAGl7W09xXJJry6rAWuWrcRkMwAhw95NkNNOY
         e0bJAz2/sXPKbPgDfuI0IuMrngTIvP9uJlB/Mjq45EofCqhk7OI9KuSlvIyPS08SuH50
         S+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0k2hvsPfRauFifmkUGnoSP56O1dT+aI6EAKgUWvtjfs=;
        b=suLu2RtUMM2tzUKqxevYKrNE0ZxWY5SoytGqJ9HJoZzgM2DrjxX69w6eB/CyLmKu8F
         oAEcCOnN7RFMMUxb0ke7GOVYp4kPpgk7+rogHXSRX+2fTlJ6z4+a3cXk4yaePQHiTGuj
         9ymQXI5boQzdVvuV9iTd4XZ4dX5JdpvXMvZb8FF5tnrPJY3SqDmDSAyXHpw+OGDsf1Es
         x1AC/nZ+QvojJb5tJggDSIz1LbRdqjJMoSd0+wB3PK61yMeGRyRV981gRmLPlj2IVVLq
         Cj0zeZxpKwBmRxrVE9Yoat3bxk9tAimp8KSwCeRgdQUfY9q63WyK5SFBBC+itJ6CSJc7
         8Qqg==
X-Gm-Message-State: APjAAAWEupL/zNUlZzvwH8+LePUx9P0usBUhtBmxxtQ96kRAhbi7jmB6
        ++6Z+NWp7qajk8tG6jVSCOGS154OhUalmAlss7MjstX0
X-Google-Smtp-Source: APXvYqyEfdc0cXO6pAlPbzPEymTBV/mDBZbCFersKqm+Wj4REqLb14QXYuTx4X/ROdgcss4hlPCkgtT8NdAo4x8qFFE=
X-Received: by 2002:ac8:969:: with SMTP id z38mr3286074qth.203.1582701531968;
 Tue, 25 Feb 2020 23:18:51 -0800 (PST)
MIME-Version: 1.0
References: <CAOTb1wc2uMSyc7DMau2cWrWtk=_Z94+CCovORj1dGCrwgJhL=w@mail.gmail.com>
 <20200226023909.GC7911@camp.crustytoothpaste.net> <20200226034731.GA2915944@coredump.intra.peff.net>
In-Reply-To: <20200226034731.GA2915944@coredump.intra.peff.net>
From:   Chris Jerdonek <chris.jerdonek@gmail.com>
Date:   Tue, 25 Feb 2020 23:18:39 -0800
Message-ID: <CAOTb1wfWtFsy415k+goRiuLUiVBqtizmmoyxqFdy7xsRhjnBww@mail.gmail.com>
Subject: Re: create reflog for reflog-less ref
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 25, 2020 at 7:47 PM Jeff King <peff@peff.net> wrote:
> On Wed, Feb 26, 2020 at 02:39:09AM +0000, brian m. carlson wrote:
> > There is the option core.logAllRefUpdates, which has the value "always"
> > in more modern versions of Git.  The documentation says,
> > ...
> The current rule is actually to append to any reflog that already
> exists, or to consult core.logAllRefUpdates when deciding whether to
> create one that doesn't exist. So I think setting a one-shot config
> variable like:
>
>   git -c core.logAllRefUpdates=always update-ref refs/foo/bar ...

Thanks for the suggestions both of you. I didn't know about "always."
It looks like it was added in 2.12.0:
https://github.com/git/git/blob/master/Documentation/RelNotes/2.12.0.txt#L129

After experimenting a bit more, I seem to be finding that--

* The "one-shot" `-c core.logAllRefUpdates=always` approach only seems
to work with git-update-ref if you're *changing* the SHA with
update-ref, and
* Passing `--create-reflog` also seems to work like the one-shot
config approach (again, as long as you're changing the SHA).

I feel like these options are still wanting.. If you want to add a
missing reflog without changing the ref, these approaches still seem
to require you to temporarily change it to something different (as did
the delete-create approach I stated in my first email). It would be
nice to be able to create (or append to) the reflog without having to
change where the ref is pointing. Or maybe I'm missing a variation
that will do this..

--Chris

>
> would create the reflog, and then any subsequent updates (even without
> that config set) would append to it.
