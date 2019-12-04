Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F93C432C0
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 05:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 575AC206DB
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 05:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725839AbfLDFSm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 00:18:42 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33383 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfLDFSm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 00:18:42 -0500
Received: by mail-wr1-f66.google.com with SMTP id b6so6964086wrq.0
        for <git@vger.kernel.org>; Tue, 03 Dec 2019 21:18:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cfazvkg50ik4mMEi7F6pEEhbDi6pZa8FvCDv74Fyv0M=;
        b=o2Tcmx3yW7LwhiHUSIBWVeP15pyuRdhGSQ5JoSQqrr4lLXzPmmpVE89MdyjYzt5Kob
         cY3X++0xSbjixt9SpeeEzdcqakoJpdYUzqrLyqF/QB4MuW2P1bNtlNbdIrDR8E8NWuWB
         XUEDDDlaiGfZHSWINb7PqDesZqips+rpb6o7nVu5xDg57PIG57H3q0LjAVCerOzyjfnD
         qNOXxLgeIQ/K9eJhGZtLYEzLDiyvS1r6ioR/dYNwA6f1VxEqjF8AHJmm/b6yd260Mu/6
         1/WhKoDLiyK93Lo09wdyUcE0i7mtiUcxjhBj7Q2lDk6G1oWIFS023kh9S/8XP9vMCpPe
         MWFA==
X-Gm-Message-State: APjAAAVbjKwkwRKevEIEyjaLhnQNs2vVfkW255YvgRnKxZezMD7GI5Ch
        KlWbYKskv/Bm0EvQ8WUv0aOrsQll2HxSfRrBnj4=
X-Google-Smtp-Source: APXvYqwnyFJFYiv+BYpNCpyohkE6IxAFMapoxCYPH1UKwCZvZGjFobrUpiJ8ZPjKmJopAAnqNUlbKoG0xzua+70HzlY=
X-Received: by 2002:adf:c611:: with SMTP id n17mr1755523wrg.317.1575436720094;
 Tue, 03 Dec 2019 21:18:40 -0800 (PST)
MIME-Version: 1.0
References: <20191203201233.661696-1-mst@redhat.com> <20191204044449.GB226135@google.com>
In-Reply-To: <20191204044449.GB226135@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 4 Dec 2019 00:18:28 -0500
Message-ID: <CAPig+cTFbpAo5+kahLT+7E1zQe24S5icm0SSB=HF4xqsD2VdAA@mail.gmail.com>
Subject: Re: [PATCH v2] contrib: git-cpcover: copy cover letter
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 3, 2019 at 11:45 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
> Michael S. Tsirkin wrote:
> > My flow looks like this:
> > 2. vi <dir>/v<n-1>-0000-cover-letter.patch <dir>/v<n>-0000-cover-letter.patch
> > copy subject and blurb, avoiding patchset stats
> > 3. add changelog update blurb as appropriate
> >
> > The following perl script automates step 2 above.
>
> Neat.  I wonder, should "git format-patch" learn an option for this?
>         git format-patch -v<n> --cover-letter \
>                 --last-cover-letter=<dir>/v<n-1>-0000-cover-letter.patch \
>                 -o <dir>

That was my first thought, as well, although, as this has similar
purpose to the new git-format-patch --cover-from-description= option,
perhaps a more suitable name might be --copy-cover-from= or something?

I could even imagine a new option -V<n> which has the combined effect
of setting the re-roll count (like -v) and automagically copying the
cover letter material from cover letter v<n-1> located in <dir>.
