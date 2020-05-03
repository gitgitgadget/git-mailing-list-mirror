Return-Path: <SRS0=AD9v=6R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDC0C28CBC
	for <git@archiver.kernel.org>; Sun,  3 May 2020 10:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 469F520721
	for <git@archiver.kernel.org>; Sun,  3 May 2020 10:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pAs3wU7l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbgECKP1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 May 2020 06:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728111AbgECKP0 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 3 May 2020 06:15:26 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889A5C061A0C
        for <git@vger.kernel.org>; Sun,  3 May 2020 03:15:26 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id r2so3643342uam.7
        for <git@vger.kernel.org>; Sun, 03 May 2020 03:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=4wN/ZQeOLbkr7LJCQG6C2cvl5nrBivL1fh7LTWmnbdg=;
        b=pAs3wU7lIujMeDXv7X4uHE9T/0TVD0spViOSlXw3zzhTgmnll9CGReP/cPDvAVUxIo
         l43AVTjADP3w9MwR2VkYk0de/wiaYKw3ftT3YCSYitsOVimOg7hSZI/H9N5HWQegbFls
         htKBtCH1uqiIbuxkVjBVv+blqSTWxatfVFkMZwzL+3gUjPF33QSLzecmC0jP7uzQz+ba
         9tHi3BRrqCjyOZi/jTJoFtBDGMdKetcM906tgvtBsY0xB2TupSsVgvxYxZZex6dAsXbE
         fNShbmbytflmnF0qyzdDW+VMa06hVguVDgGOvQe0rhxGa3uh/5BuXqjubd6jjJhoHM1E
         yxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=4wN/ZQeOLbkr7LJCQG6C2cvl5nrBivL1fh7LTWmnbdg=;
        b=fNYp7tuLNyTc4fcLrM/JUN7YWT77Rlargt9/AY4JEeI/HoMXtNos1AfFSq+UVuwipJ
         k87DuUorqrJiLdpbnIyEcJaReQzN37DWxyLtAMAj1uEvEgrCTads46O/7Z1LaYWdbG6g
         8C6M+bUMSDCIfBt5M0JblJXcLLZ10lE5y7uCQ+ZILlCUvBtAlTSODJeNc8TyFvS+ClsF
         LHVoRqVyFAUyJJkZv+IjnAU2isfzE+rH0CBQX70pSntyrEEy7UO9j8+TlFnADq3ca0cK
         7nMRUD2GlYQwI4UEArYy1//+Xp2NH896v71cUeIIbMaJO7e/K/pXTaAyaqwOU7xNq9zT
         xmIg==
X-Gm-Message-State: AGi0PuaMUXgDZLD2dogwpW2ycq4eMPzNJWDi0rM7pH0taSnx5Gz8yccj
        JM9QZN8g6RvmzmvhYbvQpd+QGIkwUzOKtY8lp9JQXLFW
X-Google-Smtp-Source: APiQypJyPFAZ1XUdvFTnzf9d08KBo08H7xogRkMTGmGCk+saNxnpSZYB+AhyPhAwohbywkmQlacQfDQtX9B62oxH+x8=
X-Received: by 2002:ab0:3250:: with SMTP id r16mr332134uan.61.1588500925500;
 Sun, 03 May 2020 03:15:25 -0700 (PDT)
MIME-Version: 1.0
From:   clime <clime7@gmail.com>
Date:   Sun, 3 May 2020 12:15:14 +0200
Message-ID: <CAGqZTUu2U6FFXGTXihC64O0gB5Bz_Z3MbD750kMoJWMciAGH6w@mail.gmail.com>
Subject: :format:%s for date fields seems to be shifted by timezone
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello!

my current timezone is UTC+0200.

I create a test repo, add one commit and create a tag:

Now:

$  git for-each-ref --format="%(taggerdate:format:%s)" refs/tags
1588504146

$ date +"%s"
1588500585

$  git for-each-ref --format="%(taggerdate:raw)" refs/tags
1588500546 +0200

Somehow %(taggerdate:format:%s) gives a Unix timestamp which is one
hour in future and it is different than what ` date +"%s"` gives
around approximately the same time the tag was created.

clime
