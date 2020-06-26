Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6150AC433E0
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 18:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36037207E8
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 18:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcJjQmWU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbgFZSeG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 14:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgFZSeG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jun 2020 14:34:06 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDBFC03E979
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 11:34:05 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id h15so10390327wrq.8
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 11:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EJQKMmJNsVbaJcA4QqZIMo6vY38HbVZX9hIxW7E/KOE=;
        b=kcJjQmWUj5BhOF24g1Eo500ivE8upLs9g6RxAreZC6+aHoPkbdU9XKqOkUlgzz6ZWA
         lpTAHHkRkYoitmHa/mSW4WiLRClCD6Er6L6sjGbgOE4eX0ocq8t6nPuwFGm78mi8IoPO
         sr15KQk7ECDgvrcTIAUVBfRqt0khIw9kjmSHJBhuvKZmWk9p5Rq5rBUumRJ2Q8S72ITn
         K83CT2zR9nieJEAcdyJikgKmzrlk+FX10aYBnVv4H2C+4CZh/gmx5oDGXLy1vJZIJgk6
         NoGUqE0PepDu5MZQClccjKwhIljjYaMFrs+wV4PbuVYMMOV9fMen791hNdjV0+QDPa/N
         4OVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EJQKMmJNsVbaJcA4QqZIMo6vY38HbVZX9hIxW7E/KOE=;
        b=JK5YJ1BG6437HbGrqOZRTQR9TMBAOm9GTBDFW84zfxJqmFZBjSq6Z4MOTn15DBRWQe
         nFZQv4pqXOxLnATKs3Naum1OZ3afFMggrouUDYukb+REpT0QH9bY6wT7TURpMwM07HC9
         PFJWmua11eWgpx2Ce74R4nuR1G5yqvhb5omaLW5OKtJ2RvN8oo3aeUxcISXT85plhHrM
         80VggzyymdVo2rOIk/zSJqMMZd8df3UXvGx1owgvlNugnhsQJ5Iwj1PgRd8FF3QalgC8
         yspeF3KC5gOj7SqBaLyPApH07wg/7k7WE4HjfCawFtZv0Lt0jHPwv83ZhzU5vJ5BDuCI
         Rimg==
X-Gm-Message-State: AOAM533XSe36pJmRoSgfHx7+H5zhcpicjvG9qyVxCbKDBHd01VNRVhYQ
        BInXBkwTbH7zCOst6sjIP8P3guTThAXjeTWWKpRxsG51utM=
X-Google-Smtp-Source: ABdhPJw4EIxiYyBnl+x+H03h/AgtKrbY47jOFnqO3vIc12J0R128ixli5cAQr8va234O4FJVH//AHcOUBbxkHMDXWUs=
X-Received: by 2002:a05:6000:10c4:: with SMTP id b4mr4815219wrx.50.1593196444207;
 Fri, 26 Jun 2020 11:34:04 -0700 (PDT)
MIME-Version: 1.0
References: <B4814F42-7AF8-4D80-93D4-FAF752C72F21@me.com>
In-Reply-To: <B4814F42-7AF8-4D80-93D4-FAF752C72F21@me.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Fri, 26 Jun 2020 11:33:53 -0700
Message-ID: <CAPx1GvcZk2o7f8-27xokwxUayWwO+t5qdsMjLrjBymc+WHznmw@mail.gmail.com>
Subject: Re: Regarding Git and Branch Naming
To:     Craig H Maynard <chmaynard@me.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 26, 2020 at 10:19 AM Craig H Maynard <chmaynard@me.com> wrote:
> Does the git init command really need to create a default branch? Perhaps that step could be left to the user.

The HEAD pseudo-ref must exist and must contain a valid OID or
branch name.  (If it does not exist, Git says that the directory
is not a repository.  Perhaps this test could be weakened, but
that's definitely a fairly big change.)

In a new, empty repository there are no valid OIDs, so HEAD must
contain a branch name.  The branch itself need not exist, but
whatever name is in HEAD is the branch that will be created
when the user makes the first commit.

Chris
