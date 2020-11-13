Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2812CC388F9
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 06:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4CA420B80
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 06:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="su9UscP4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgKMG3F (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 01:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbgKMG3F (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 01:29:05 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C42C0613D1
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 22:29:04 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id 33so8447376wrl.7
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 22:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qO1RMhW3Hc4c4jY9bUDo7lTTswYPYv3IOW414QouN24=;
        b=su9UscP4AQ5DW2FY9AqkdUktRtDxo1uHnJDw1jUIhT1MYS5XOyltz4Qn97ZFWX8A20
         IlEI2TzhhUE8WpEHvkmKTfKIz2AjE3FTWfh9ZFBDRVxRNIaps0Q57NiRFwWkGb/8KU3Z
         GjLY3lnIahnFE4OI95qULeirY89HH+GoEh6YbmMVQXF8bZDo9WWmjq7pp/jTES+l6Vs6
         1iBxsMaEz6xtnebUCtVWp0BIINqVdT/pLfR5iZrWv0Iabk6xJs4Lq9mTH1ousFxVJt/3
         KMtPuXSsiQZ6ANa+eoUemPZ09BVpVu+TVyx8We3REqqlD1vMQmbYdRFyryYPsysX6/iD
         Y5IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qO1RMhW3Hc4c4jY9bUDo7lTTswYPYv3IOW414QouN24=;
        b=I96/Vu4AVJIEeurJSY2bRJiZmHVquxpTo52Zghq9KNf8tnavUtckqcFqSta2FHZ6c6
         1ssnVswgnlfeuTN1+KT9haZqSEM8Lbq29QFySedeHrUqKkBogkJekjE0CwteQzIIfY6J
         hKXYUnsyrux9IV4afA0XdIiG9nEmjC12ePpgUqQbSU3FtWZ2ap1+Py6kmzv4YrZtzuNH
         1cg6JpLwFC8ALBVcedpTCZ6gTIprhYU4JNqUC2rcD2232ICo7pzOjuhISBUsKvHvjzhY
         Hrt31T+WvB2vvulc4om7iIcoEcyiqLkMGilOvO0jmhhpxZK8laxPW8rt/WYiMEM6Z6sc
         PYNg==
X-Gm-Message-State: AOAM530RmhWG7Nik7HnnQjwGetfVbaFodLRJXsGdpbq1q17rPIz7L69S
        W5DYnMFbyKfzLmu/2i7YZ/0R2KEOuHMxIvXPpPg=
X-Google-Smtp-Source: ABdhPJw2plAD+sE5zA1mgSk53Y4LMOENsKzP+qzASp+tWdLravvGe3ahDhJcWg+Z40GBSJY/Hd3xOM/tw9sd7jyMTxU=
X-Received: by 2002:a5d:4349:: with SMTP id u9mr1252562wrr.319.1605248943612;
 Thu, 12 Nov 2020 22:29:03 -0800 (PST)
MIME-Version: 1.0
References: <CAMP44s3BJ3dGsLJ-6yA-Po459=+m826KD9an4+P3qOY1vkbxZg@mail.gmail.com>
 <20201113010107.GL6252@camp.crustytoothpaste.net> <CAMP44s1U1FevS7NrAYxvgVyzfR5tnD9-+BbPdw5bKnaNHkyD+A@mail.gmail.com>
 <20201113051408.GA3985404@mit.edu>
In-Reply-To: <20201113051408.GA3985404@mit.edu>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Fri, 13 Nov 2020 00:28:52 -0600
Message-ID: <CAMP44s3AeESm7VBKbar0ir_Py35g99ZW6bNX_=AK4N=OFkcrdA@mail.gmail.com>
Subject: Re: The master branch rename, and avoiding another v1.6.0 git-foo fiasco
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Don Goodman-Wilson <don@goodman-wilson.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 12, 2020 at 11:14 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:

> Is it changing the default branch name when creating a new repository?
> (Which affects only people creating new repositories)

You may choose to downplay the experience of certain part of the
user-base, because in your experience creating new repositories
doesn't happen often, but that doesn't mean these users don't exist.

Yes, this is the part I'm concerned about.

At this very moment there's people in universities trying to learn Git
and creating repositories, so are people training in companies.
There's a whole industry dedicated to teaching Git, and they rely on
creating repositories.

A simple "git grep master" on the documentation of git.git (without
the release notes) shows at least 800 instances.

This is precisely the part that was neglected in the v1.6.0 release
that I undertook: nobody bothered to change the documentation that was
using git-foo commands.

I find it curious that this is the criticism you choose to give on a
change that is supposed to be making Git more inclusive towards people
with different experiences (potentially non-existent); making light of
the experiences of very real people which we know exist.

Shouldn't we be inclusive towards these very real users as well?

Since this is 2020, and just to be crystal clear: I intend no offense,
I just truly find this argument curious.

Cheers.

-- 
Felipe Contreras
