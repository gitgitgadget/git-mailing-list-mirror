Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F18320A40
	for <e@80x24.org>; Mon,  4 Dec 2017 09:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753451AbdLDJRP (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 04:17:15 -0500
Received: from mail-it0-f42.google.com ([209.85.214.42]:45435 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752863AbdLDJRN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 04:17:13 -0500
Received: by mail-it0-f42.google.com with SMTP id z6so11101812iti.4
        for <git@vger.kernel.org>; Mon, 04 Dec 2017 01:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Ux9035j4Cv5dY31fkdipdrEnxrXP6UjDRfS56Z9QvZI=;
        b=OoQpWPQLv2ZhZHpAGZuR+vHwPtSLPUOIpV7ZIjHo/6Ge7VuAf/Y9ms2kDPLVMSUB5c
         aAruT5Hj7o+B9bj4v87LkERw0tSR/CAnsbZKNXncjYHn5swFeGz2xl4GlKTSvGvWVMCp
         jw/ES3wsWZZvnxe/XJb2G+Hb+LYFgDTf/WP4ABD08UN3VELcsCw2vBCbkMjgrLBcLiOg
         67OG+RNy19y+JPuEAIaXANuSl7euTf6qZ7YW7ckBn+xuG7PR2L18+vm0k22jc/0NWGgB
         w7LfUFZXcvlsu4vy/9P1/s7fojcd2WksaV0QtPGx4l09IVz7ZcON8byQC5mDv/i6Vuun
         SP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Ux9035j4Cv5dY31fkdipdrEnxrXP6UjDRfS56Z9QvZI=;
        b=JfkLGojd49wufqP5Nc/w8C3pK8dmDuY6I/ap1AVpEqv9kVd44/viJ/5ZxBEhqGpfV1
         ezku6+ONpyTTBIfRQaPRKCui6+MHqRH+JNyPRljiG1zXLi8BPFnOnhl82++OU9lwK76d
         sk2X8LiDsS8SiiNucXnPjgcVxi/jUPK9NoSBM5QCtJVUBxgqxooizAl1Yc+VbC29br4M
         ZqDAVW0bHGhwwDZ4Z06w544teHOpZ9wvPe02EXCxidiySrwvUUjkO9XloW67TcwhVA+M
         SDgXPgRoPaPke36xvHxEbkgyazZdh1Qj54MNiXGlygmRWcjGtnXfYYcPNBCS4vVsU/m9
         Kcdg==
X-Gm-Message-State: AJaThX6NxvGNdizpoKjkprC02521Kaxut4E4hZV1mwW+YQiQ2alNKm5y
        ytHvzkt55naiw1kLXIFvW9WnJFzTgDsOjd9zncIVQQ==
X-Google-Smtp-Source: AGs4zMbkG+z6t1bWTEjVtGcUCt3CAW0GqnaZ/iA/s7rxLKmpCMv+6YegBC3U1890zZgq5eAhoiK/SzTFjJtNhBD+TEc=
X-Received: by 10.107.131.99 with SMTP id f96mr22456308iod.215.1512379032739;
 Mon, 04 Dec 2017 01:17:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.2.119.11 with HTTP; Mon, 4 Dec 2017 01:16:52 -0800 (PST)
From:   Amandeep Gautam <amandeepgautam5@gmail.com>
Date:   Mon, 4 Dec 2017 01:16:52 -0800
Message-ID: <CAEZzL1BOTLzrqZRehBzE8cwCvTY6qgrwZsbq5gcxWUbGyva8FQ@mail.gmail.com>
Subject: Bug in git-completion.bash in __git_heads() function
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,
   This is the first time I am sending a bug report here, so if I have
not met the criteria please let me know.
   I found that at:
https://github.com/git/git/blob/master/contrib/completion/git-completion.bash#L371,
the usage of refname:strip=2 generates error:

fatal: unknown refname: format strip=2.

I am using git version 1.9.1. However using %(refname:short), I
believe produces intended behaviour.

If my findings are validated, I would be willing to submit a patch for
this. Please let me know.

Regards,
Aman
