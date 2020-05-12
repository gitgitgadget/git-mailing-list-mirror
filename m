Return-Path: <SRS0=6g9E=62=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EF5C54E4A
	for <git@archiver.kernel.org>; Tue, 12 May 2020 11:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CE25206CC
	for <git@archiver.kernel.org>; Tue, 12 May 2020 11:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPTzDl3V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729528AbgELLqR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 07:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgELLqR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 May 2020 07:46:17 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39483C061A0C
        for <git@vger.kernel.org>; Tue, 12 May 2020 04:46:17 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id x15so4608870ybr.10
        for <git@vger.kernel.org>; Tue, 12 May 2020 04:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=FFULXSKKXezW1KWGE+ZLUKs1rUyf1IBlZDCBTtDWBc4=;
        b=cPTzDl3Vsg+tTF7OHnaNb6bcyHI9TMyINCQgO4EjHTB4e0hS6J8P1sa0z2ADwKUlm3
         0v4YwrZvXbM71wPvZvQKbWsVkAqCn1qjkxKonHZkTAkWnooBJdWn4NVnmsDCEHxwNC6m
         i5kTKsRHQ2fv4PB7wxzZFamM+6QIPNR5gJnwAmJvO1RNr9K4tCIJiRm/ObWvqC9Z2KJ5
         KK4eP/+7l+lh37RmbsN6ej8uYoKMSH+A2fhO/UTLEaaL1P9rUgG7zFPrxVwKatwrhqbq
         M4lMxUQ7aS36hvPavxGvbCTew5p6Kjf98F9YhYplZ5BpQekv+nxvux3vQToSqpgf3deJ
         4T1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=FFULXSKKXezW1KWGE+ZLUKs1rUyf1IBlZDCBTtDWBc4=;
        b=ltwiKX24g+Y8KvRg9vVY6kAvipcrtaPoZuOB2Qy1nbCOZtDJIPiFg1uqJkGXx8voBt
         gvJ9tVEV+CTm6X/DclUsv8aseP9UDbbkqBgnE3PN6jZtY1fHNtWyqVFnAJ00K3fKtTdW
         pVEs2wHPoxNA8qBqJD0eavMpnnPYHDjDwlWXUte+3Sz9aa4Y/UCduEISP+tVcPRxcD/r
         KoyODZ0tjC9WMUkwNv6shVRVx712jsG7J+T5oHit2yorwGJar5T5zV10lwY2z/jRjAij
         edQ8WR/36Zv3Do85yV7p1E06eYHbbVTE9zIvWilrokEQdCIprtjNX9ea8nO/W/uIaA2Z
         iI/Q==
X-Gm-Message-State: AGi0PuZ1tpeTIYIijR/PxIPJ4Pzqg4WDcqdv4C2uHalRu6cTF5ZNt2QN
        hu3QwToyrubxs72Um0Yq4s025J+sEw3mMb+JLyg4U7C5
X-Google-Smtp-Source: APiQypLxKumc3WbCurTA/5C0G9PvtYrgRIlWZzr9G+mZuNM9JHMfXoH5w3At/E45rZ5jjIPQi5+vg/qmtyQIM81m0Yg=
X-Received: by 2002:a25:c402:: with SMTP id u2mr33059330ybf.82.1589283976188;
 Tue, 12 May 2020 04:46:16 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?SmFrdWIgRMSFYmVr?= <jakub.dabek@gmail.com>
Date:   Tue, 12 May 2020 13:45:54 +0200
Message-ID: <CAAop36+Qg1vEsOoJehNBDDAvxYQO4cba9g2j9-sKbrxsuoJk5A@mail.gmail.com>
Subject: stash pop results in conflict after stash --keep-index with the same
 file in index and working directory
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was trying to write a pre-commit hook for testing using stash to
keep irrelevant changes, but pop couldn't apply changes automatically
when the same file with different changes was in index and working
directory at the same time.

Reproduction:

  mkdir git-stash-test && cd git-stash-test
  git init
  echo foo > foo.txt
  git add . && git commit -m 'init'
  echo foo2 > foo.txt
  git add foo.txt
  echo foo3 > foo.txt
  git status # (*)
  git stash push --keep-index
  git status
  # do testing
  git stash pop

Expected result: same state as before push (*); actual result:

  Auto-merging foo.txt
  CONFLICT (content): Merge conflict in foo.txt
  The stash entry is kept in case you need it again.

--index option doesn't help when used with pop.

My assumption is that pop should be the reverse of push when nothing
has changed in between, but I don't know if this is a bug or
unexpected behaviour. (git version 2.26.2)
