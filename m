Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE051C00523
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 10:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ED1620705
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 10:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gyswhDss"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgAHKCq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 05:02:46 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]:41067 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgAHKCq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 05:02:46 -0500
Received: by mail-wr1-f43.google.com with SMTP id c9so2659696wrw.8
        for <git@vger.kernel.org>; Wed, 08 Jan 2020 02:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:reply-to:to:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kc/QbJbEp6upSV49mj0a1s9WsfA2JX0BaMbPZhHWv60=;
        b=gyswhDsscvAmJim346VkN+2KHrb26PGpVzcpX8XDOhAg1UUZnEyk6yXk4MHKit6tAy
         zyzrUr7CM97b/2X330ChDoWL+yz/cydSG9F4a6JhcJzjMEUG7VXo6L22Ebug9Y75iXje
         nsnlNdvnl3g8vMx/0sXS0S+HtgfSX9GdS9+qB7FbfKOHBIblhJuUEjY65qWKSwAcVdn3
         +JDLWNk11yeXqsir3gt0bdpexDqzFLfVBJdGCdqZw0H2QOMmuK8RPWAZOlxMRX0pxYos
         RzMuJN1AewIiNwrhtRqZr0WFbWSvZ9IGuheedEYZhqf1V6OQgRsa6DtwhmXcshvMaTdT
         t2uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:date
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=kc/QbJbEp6upSV49mj0a1s9WsfA2JX0BaMbPZhHWv60=;
        b=CAbxYdqpWKJiBuyXjOLUHQOmXG+AH50NDuMlYi2vn0N6Gb1bKhL3ler0cHPoIvjH0a
         6vy+NzSFfI6BrI8ULMDPpUrAs265MRg6CTG05f1oAM7otdDbl1wOBu/UJplwZ3bhD2CX
         a99oFTUuOAgHuQdlh+0W/7GqVjy3Z5OUh39vF9/CFDcOYlYcIjAuB5/qiMqjH/ZkLeL5
         0kjiYGVAOBmIns5zW/nDTJeU+YCJyNIcvlSv/zEDXsiJvsqPs2JJH4N7NJw4fkV/VjmU
         vkxufHn9mvB7Q5qGnnhgQhgEHHNxA126LLaRmJ9KT/Qo/CFAIC0/18w9kImj2BHZD07U
         YQLQ==
X-Gm-Message-State: APjAAAUGAIwwMMRjkAvLcpLwRXRk5C0q19YLMCtEzYYSB+Bv9ncMLfuU
        s2cnITub4JEh7mWE06RE7e8GoiZZ0Hw=
X-Google-Smtp-Source: APXvYqxEYeIiLKHks/BPc7rKDkEcO8ahrbbgRuHVc8YdvKPQzz5a221uIjoPwcJrlr8guGtx3708Dg==
X-Received: by 2002:a5d:6652:: with SMTP id f18mr3701423wrw.246.1578477762389;
        Wed, 08 Jan 2020 02:02:42 -0800 (PST)
Received: from torstenknbl.mgm-edv.de ([185.40.248.10])
        by smtp.googlemail.com with ESMTPSA id n3sm3245169wmc.27.2020.01.08.02.02.41
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Jan 2020 02:02:41 -0800 (PST)
Message-ID: <2423f8c0b91578c0faf7527b7d97b0e1e9666261.camel@gmail.com>
Subject: Re: Broken branch after git commit - tracked files in staging area
 can't be removed with restore --staged, or commit or stash
From:   Torsten Krah <krah.tm@gmail.com>
Reply-To: krah.tm@gmail.com
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Date:   Wed, 08 Jan 2020 11:02:41 +0100
In-Reply-To: <20200108091119.GB87523@coredump.intra.peff.net>
References: <07c84224bb0b093ab3770be9b5ab2ec23ce2d31a.camel@gmail.com>
         <234df85965f8a685be5e563fe795ed477f359d7c.camel@gmail.com>
         <f0638fc0d09c213b661d2b244d3457f362daebe0.camel@gmail.com>
         <20200108091119.GB87523@coredump.intra.peff.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am Mittwoch, den 08.01.2020, 04:11 -0500 schrieb Jeff King:
> That step seems wrong, and I can't reproduce it here. If "git status"
> lists the files as unstaged, then "git commit" should not be
> committing
> them. Can you show us a more complete example that we can run
> ourselves
> (i.e., that does not rely on whatever is in "main", and what is in
> $FILES)? Barring that, can you show us the output of the commands, as
> well as "git show FETCH_HEAD FETCH_HEAD~1"?
> 
> -Peff

Hi Jeff, I have a poc you can try:

cd /tmp
mkdir testrepo
cd testrepo
touch TEST1 TEST2
git add -A
git commit -m First
touch TEST3 TEST4
git add -A
git commit -m Second
git reset --soft HEAD~1

git status

   Auf Branch master
   Zum Commit vorgemerkte Änderungen:
     (benutzen Sie "git restore --staged <Datei>..." zum Entfernen aus
   der Staging-Area)
   	neue Datei:     TEST3
   	neue Datei:     TEST4

git restore --staged TEST3

   [10:57:26][tkrah@torstenknbl:/tmp/testrepo]  (master) $ LC_ALL=C git
   status
   On branch master
   Changes to be committed:
     (use "git restore --staged <file>..." to unstage)
   	new file:   TEST4

   Untracked files:
     (use "git add <file>..." to include in what will be committed)
   	TEST3

git commit -m Second

   [master 5b62331] Second
    2 files changed, 0 insertions(+), 0
   deletions(-)
    create mode 100644 TEST3
    create mode 100644 TEST4

And now TEST3 is in the commit and what is even more "interesting" is
the next one:

   [10:59:16][tkrah@torstenknbl:/tmp/testrepo]  (master) $ LC_ALL=C git
status
   On branch master
   Changes to be committed:
     (use "git restore --staged <file>..." to unstage)
   	deleted:    TEST3

   Untracked files:
     (use "git add <file>..." to include in what will be committed)
   	TEST3

TEST3 is unstaged and deleted now.

This seems wrong - or did I something wrong?

Cheers

Torsten


-- 
Mit freundlichen Grüßen / Best regards

Torsten Krah

mgm technology partners GmbH
Neumarkt 2
04109 Leipzig

Tel. +49 (341) 339 893-539
E-Mail Torsten.Krah@mgm-tp.com

Innovation Implemented.

Geschäftsführer / CEO: Hamarz Mehmanesh
Sitz der Gesellschaft / Registered office: München
Handelsregister/ Commercial register: AG München HRB 161298
USt-IdNr. / VAT ID: DE815309575

