Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8ED261F404
	for <e@80x24.org>; Wed,  7 Feb 2018 14:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754514AbeBGOvj (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 09:51:39 -0500
Received: from mail-qt0-f169.google.com ([209.85.216.169]:43338 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754421AbeBGOvi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 09:51:38 -0500
Received: by mail-qt0-f169.google.com with SMTP id m11so1946010qtn.10
        for <git@vger.kernel.org>; Wed, 07 Feb 2018 06:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=KzYgSGkQtV3sqyYEvVkcEVbz3O5OnyoM365sjAI5V90=;
        b=T6tNB0Oe5uiPCUWlKjQ3MPK1rNn4U/D8iroRvw8EKyZSbPiLD4suQrU1ucQLElnMPR
         rag4j8L8BV66B4pebpPIW70QE2mZcaFP9rfv7Sb7bcVWA/cMfs1hmILq1+CbcgaMeRFq
         TwrTf11HVjNALCg0vaGUhVa5bsegx8UOOCYx7GI0XFoq+BfcjiXjLt4qKa8qVPnCpXhH
         GaDbEtsbYZaM+v1FgN20i7jPooaaKutP5h0c+VX8O9WXYOtrOToSWO6XLuFlua3rvPB+
         x50J82sl2EuzXz0sqJ+UHnfsE+cxPrpmIf64q6iYyPkvcrOx2eQiubeqAsnFzT/UxGJA
         J6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=KzYgSGkQtV3sqyYEvVkcEVbz3O5OnyoM365sjAI5V90=;
        b=r7/Dmr3WHObvew/p9lQgVnYAey3+bUOZO0aLI/HpWVCNtxk2SBsLCnJ6pifptZL3KD
         2T3pcRvJCV3p5f+y/zlcO7z9tMLePBBd7AeHiKKasnBwkHm2DMeZdsfDsNgg2m8Z54GX
         4fTpRKwB3NoFAwhc5RHaaWVWT/7A3BevX5CUZqHr5vqv1YC/zZQyfhYyp8BU/gxZ6QyE
         NRIvH5F87KW+DuW5pKlJ8tOL5Rj+v5B5U6UHGvi71b+F5KQh+uBrMgI6QgI67hfFjWw3
         zpg1HkiDEzv0JvTEIZ51o7jzfhgOicGL8U8VRhIfe4ExJ3uiNOQxOzF9RCK9+up/AF3K
         hD9w==
X-Gm-Message-State: APf1xPCjFjTufZ1LVCD3AYhjucNUrZU5kaPp45bV1oaN+jqHWt1Qme62
        jIyHQtgQUZczmKOVZ574iHk8Tm1hL9oQJhid+ukEHVQ6
X-Google-Smtp-Source: AH8x227hIw4mdNSQk8GiV846FyCeDc0LmBkFIcgUKmX5cCB6PehDawIIRT+8SOCjUQYQJmpxGxfh4PgffLDSBBXe78Q=
X-Received: by 10.200.54.252 with SMTP id b57mr9995777qtc.187.1518015097264;
 Wed, 07 Feb 2018 06:51:37 -0800 (PST)
MIME-Version: 1.0
Received: by 10.237.42.114 with HTTP; Wed, 7 Feb 2018 06:51:16 -0800 (PST)
From:   Daniel Karp <danielkarp@gmail.com>
Date:   Wed, 7 Feb 2018 09:51:16 -0500
Message-ID: <CAOv5hWewPHqy5KQVBthskx0Ww6cdvpAJrEgSti1Ai4uLxg94Cg@mail.gmail.com>
Subject: Bug report: Subtree split including extra commits
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apologies if this is the wrong place to send a bug report for
Contributed software.

I've run into what seems like an issue/bug with git subtree.

I am trying to split a single directory of our repo into its own repo
using git subtree. I ran the the following command from our project
root:
git subtree split --prefix=geekui2 -b geekui2-split
where geekui2 is the name of the subdir.

For commits before mid 2017, the created split branch contains our
entire commit history, regardless whether or not they include changes
in geekui2. For commits after that point, the commits are properly
filtered to include only commits that contain changes in geekui2.

The upshot is that if I push the branch to a new repo, and check out
one of those earlier commits, I can essentially recover the entire
codebase of our application (at that point), not just the content in
geekui2. Since our goal was to share part of our repo while keeping
the rest of it private, this is obviously a problem.

I've also tried using git-subrepo for this split--it seems to
correctly filter the commits, excluding all commits without changes to
geekui2. So something seems to be going wrong with the way git-subtree
handles this relative to git subrepo.

Unfortunately, there is a lot going on in our repo--I have no idea how
I would generate a minimal reproduction of this.

While our repo is private, I'm happy to help try to help debug this if
someone wants to take a look at this issue, although it is not my area
of expertise.

My git version is 2.16.1, and I am running it on macOS 10.12.6.

I am not subscribed to the git mailing list, so if anyone wants to get
in touch with me about this, I'm most likely to see it if you send an
email.

--
Daniel Karp
