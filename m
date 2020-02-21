Return-Path: <SRS0=3Brp=4J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DCAC35646
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 18:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33E812071E
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 18:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGZnLLpb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgBUSdZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Feb 2020 13:33:25 -0500
Received: from mail-lj1-f181.google.com ([209.85.208.181]:40860 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgBUSdZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Feb 2020 13:33:25 -0500
Received: by mail-lj1-f181.google.com with SMTP id n18so3190385ljo.7
        for <git@vger.kernel.org>; Fri, 21 Feb 2020 10:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=uKRL3IK4Rmt+hgfWPF/LeL92FULcRnNuaX9t8cXUuq8=;
        b=KGZnLLpbi2c6gwKG965MEXMizpcHqX0HtpYXu5LPB+pHquVnkBEl78Venf1gwOS4Sx
         bEv/SXi1k8WgCyTvSs+HaEPEJyLq7+heq71PlWvv7MTMiTBX3E5GhKJljoHfi3WutODo
         JL+cAm1Bw4DoSLiA40yTXqzNbtt5Yrw54MbEy+tXThrzrUOb9V50RFgvrwo9mLQ0vUQc
         me/xdM25JlZaN+FqOIRNHC9AIbfa6Um1HXHcYzgStvHS/50GseM45XM50/lQVBqc/uK9
         SbyWJoD2MkUjscQlS0Zb20LYbamu1vJ0MULrjs2cLfaAYMtIxxOmb8VVmrytQwelsUtF
         iN4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=uKRL3IK4Rmt+hgfWPF/LeL92FULcRnNuaX9t8cXUuq8=;
        b=rSbwBjWG2S8iadf/z35qbNdUzTHlK6hjyD+gT/BoZPue9R2bjfqyrRu73bu+R6zXLn
         ZbrEKIJxeE2sqjccDJHL2q7TnGNH+WLbDttNVUBw50oOl+8mDc4AQastYKfsrNUKy/sE
         6xmK45t0+ffSfJ9LzseFccOLJgh/Ops3ukYXHAsfoO2pDDU1vNgsM2dc+I7uXnkkJXwp
         X/mYNYFQq0d0m4UetHpGxGGXXP9L41jpMZJd9sXpVCa07OOZ5SsEgXZSP6Hrqg/NsIJz
         JUMp/ooR3Hqr5UZ8YbvxXiFO74po2kh9YbiLBwei4AHMRXENhVPjEFJlAdTzjz9jTctk
         to4A==
X-Gm-Message-State: APjAAAWyobtjX5DuyVdDHOzQFLNRz9Y38ldzTJ9AY5o9hNGAUextiCIF
        SvPzNWLc8cq0zkApoSG46WgQGQqIf8pMCsizpLoo/eQB
X-Google-Smtp-Source: APXvYqxS5DIewfMbSBiuYIXZfylIIrA19r68WgBdP/XdiKDxtrn7YPBBGotuQ8S6LTz6PhqH2Ir9Gicmq36+M2wo+rw=
X-Received: by 2002:a2e:96c6:: with SMTP id d6mr4276733ljj.4.1582310002753;
 Fri, 21 Feb 2020 10:33:22 -0800 (PST)
MIME-Version: 1.0
From:   Zachary Santer <zsanter@gmail.com>
Date:   Fri, 21 Feb 2020 13:33:10 -0500
Message-ID: <CABkLJUKaMwT+_AeUo+gdMF5ELEfZzxRqJ_dDhUpdXp2dGeE=8Q@mail.gmail.com>
Subject: Feature request: ability to pass merge strategy options to 'git
 checkout --merge'
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Perhaps using a command like:
git checkout --merge=3D"-s recursive -Xpatience -Xignore-all-space"
[<tree-ish>] [--] <pathspec>=E2=80=A6
for instance.

I'm merging two long-lived branches that I had no hand in developing.
I used the following command to get started:
git merge -s recursive -Xpatience -Xignore-all-space --no-commit <other bra=
nch>

I need to be able to quickly ensure that it is not the case that both
branches implement the same behavior in different sections of the same
file. In the case of a file that merged without conflicts, I've been
doing the following, in order to use my merge tool:
git checkout --merge <file>
git mergetool <file>
git add <file>

This allows me to quickly look over what each side of the merge added.
However, it's also creating merge conflicts where there were none
resulting from the original merge.

On the other hand, it would be more efficient from the user's
perspective to be allowed to run mergetool on a file without merge
conflicts from the get-go.

Still, this would undoubtedly be a useful feature in use cases besides my o=
wn.

Thank you,
Zachary Santer
