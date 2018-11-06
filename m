Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FB501F453
	for <e@80x24.org>; Tue,  6 Nov 2018 12:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387971AbeKFWD7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 17:03:59 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]:41579 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387905AbeKFWD7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 17:03:59 -0500
Received: by mail-oi1-f177.google.com with SMTP id g188-v6so4577691oif.8
        for <git@vger.kernel.org>; Tue, 06 Nov 2018 04:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=X+/weClBLoGsbxUTLnvFZu5YdrcyiDIng+BFceHPaQ4=;
        b=n6WiGHZUo+fjnd3dlCnqGj0at3rFnsILU825FyP5DTj/2jX5oA8QhffCSIRu5z6Et1
         UESHzlvFy/jLzXPLwqsnZ37NLeTRDGqqXqk0+QFMEPAROFqv6VEWXeAfYkp9S4GhQEaX
         W2n5YoAXrp46iGy9NYLjDGIQS/CYq4SnMUtG8Kcgqln9Qa++QIJ7af0EcDnomf29GXRa
         5SL/6iEdVxlLLkXEu3SALBDyKR/DUkvgJdyg6+BW+eJJmRQWh3Qn1/yexxXC9iQRTRgE
         yFKd4FgCTH9PwzYuaScFhHTjaeGgn+sZsSoqUWyBgxkuLU4KVBXfbnA5iPpdQN1kRTsu
         FHzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=X+/weClBLoGsbxUTLnvFZu5YdrcyiDIng+BFceHPaQ4=;
        b=J+MiBMTnOahL5FEzo6IOXNJA2JaftdFHnKql8zP2IXl9GX/Ug4DLLXVPu5fHoRjF4j
         IPe9xz/1s1W8WpOBFMltKe5Smuh6GSmqGeUVFWyoH+DG+sXbgYBqBMA9+poVGY4B4qnu
         Mk3hA3jy2ISKeRfjoVqF3zVcQkKkebVahstXulWw2bm5v7BY5UWvy/DaoFilK3QM0qTi
         k51JUfzw7i73GeYNBbnK8Zfo+GFOs26p7LnjuRjt7YZxAajUM8x9EV8uAS4prKv4/xj2
         DYhx999O8+0J+l5coS0rwAtrzG+hnxhLu9mfv+J8S4U6FVWZVgfGO0wawegGP372U70a
         wvsg==
X-Gm-Message-State: AGRZ1gLn9daPMWbFdf2i5MoaH13Kl65h4L9PORo6vL0aMkoCtULNd1/8
        JETHem6Os/nnkz0LEJ1g6I6/LQI9IW42cfE1/gZzM0wo
X-Google-Smtp-Source: AJdET5cfeuh0BSpIkxks7ImCibGFSsjK2c7lLbqgsQQ0P8wkYD5VmkJ0ipi+w1oHe9use2D8vGzzgZ9Kq8xFKcIiZUs=
X-Received: by 2002:aca:d586:: with SMTP id m128-v6mr15716029oig.229.1541507936646;
 Tue, 06 Nov 2018 04:38:56 -0800 (PST)
MIME-Version: 1.0
From:   Christian Halstrick <christian.halstrick@gmail.com>
Date:   Tue, 6 Nov 2018 13:38:45 +0100
Message-ID: <CAENte7hoHxQCiQwSaAGPyaeFK8rb2Q23DcbePd01fcvgxtodZg@mail.gmail.com>
Subject: What exactly is a "initial checkout"
To:     Git <git@vger.kernel.org>
Cc:     rene.scheibe@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am trying to teach JGit [1] to behave like native git regarding some
corner cases during "git checkout". I am reading the "git read-tree"
documentation and I am not sure about the case [2]. Git should behave
differently during a normal checkout than when you are doing a
"initial checkout". I can imagine that the first checkout you do after
you have cloned a repo is a initial checkout but: What exactly defines
a "initial checkout"? It can't be an empty or non-existing index
because native git behaves like in a non-initial-checkout even if the
index is empty (see example below).

Here are some commands explaining my case. Git is facing an empty
index, HEAD and MERGE (the commit you checkout) have the some content
for path 'p'  and still git is neither updating index nor workingtree
file during checkout.

git init
mkdir p
echo initial >p/a
git add p/a
git commit -m initial
touch p2
git add p2
git commit -m followup
git rm -r p p2
echo "important data" >p
git checkout HEAD~ # successful checkout leaving p dirty
cat p # prints "important data", so 'p' is not updated during the checkout
git ls-files -sv  # empty -> index is empty

[1] https://www.eclipse.org/jgit/
[2] https://github.com/git/git/blob/master/Documentation/git-read-tree.txt#L187
