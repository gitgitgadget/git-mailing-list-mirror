Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEBA01F954
	for <e@80x24.org>; Tue, 21 Aug 2018 13:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbeHUQWE (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 12:22:04 -0400
Received: from mail-oi0-f54.google.com ([209.85.218.54]:36164 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbeHUQWE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 12:22:04 -0400
Received: by mail-oi0-f54.google.com with SMTP id n21-v6so31830974oig.3
        for <git@vger.kernel.org>; Tue, 21 Aug 2018 06:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=7VQ08RnELu1+gLPosaXZKepzBEHiQ/fFCtpAAlqSEPQ=;
        b=AiSL2XOAEiQ1P+rpVBJ06UgYEScVPg9CQ3geryey03/bAm49yPXynvznBs0Mpi6Pm6
         tmwtQ98gXcOhaga5KiBHTcib3Ih9fHVWy8Mt1MfoZAWsmMoacCmN7v9kxGFoJARgZbF4
         ImWcsvGdMZfg1MuX6buRhvQz1m0qSzKryp37ypnDjDOXTMZ0Vo15OH6nJW0chN4ALMjE
         /KD/m8FyiBKGlDP1/7FdG4V/8F1RgFVkztOP10B62ClaBQ5OuBQY+XCfJn/XgbrXFdTo
         fzRTFf/tdTLViO1W1MATHiQttv/p9RDxBeVG2ORzBZh8m6eguaCS4j+SSA4mBL2aRU+X
         poqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=7VQ08RnELu1+gLPosaXZKepzBEHiQ/fFCtpAAlqSEPQ=;
        b=Pk1+FZskUjR/CAxOCWC8mENPsPcq3hYxnTICKR05g7XYHr2eXcMC9pa2QicqcKO6Oe
         Njt/eq3N0qr15n6lvWZNK2nOsvUsvdH+NZEw0CX2hPYYmZU5CYgngOAFBkd2gEYrBd5R
         NH9cZb5KvL/V9LJHloWipPvbmN1nE3r92mSmE0rkD07kfQmfudUOJ3Eh9Jy6QMmEFOLo
         5qigyLsED0uGOXE/C91NEMgO4u5WbEVtxj4ZWwUOYP05y5F1g9iLYDbNdxYV7vnlsZF8
         1K4G7vKwoymHKCzdzDtSrUNsjLlO1VFBKdiXc5+xSYOLu44cHpGkIlaHcnAmfvglKwxs
         6MgA==
X-Gm-Message-State: AOUpUlFc7jCO0lA2JOuPBNOCbcSxccKexEKXUisngq86FtSaazIB8A9y
        sPhsCEMS8mXGeGA6CZ3sbkjPPVZi3+T9DIes5Ia/Wejg
X-Google-Smtp-Source: AA+uWPyxdPVstHXuqhr4jAjfCjHRgnjcffIhs/VDuousaKFgs5miBh0TRspw/4EcHiwtIqd+CM0BNkrAWr7a1SBrXas=
X-Received: by 2002:aca:d9c5:: with SMTP id q188-v6mr19633357oig.239.1534856519969;
 Tue, 21 Aug 2018 06:01:59 -0700 (PDT)
MIME-Version: 1.0
From:   Erik Huizinga <huizinga.erik@gmail.com>
Date:   Tue, 21 Aug 2018 15:01:48 +0200
Message-ID: <CADA507y8NAgN_v2-cxdWYZEvGUgzxFbFD52KmdyynWr6MufvRA@mail.gmail.com>
Subject: Feature request: detecting mistyped command and isdentical possible matches
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

I have an alias for 'git status': 'git st'. I also have configured
that an unrecognised (mistyped) Git command runs the closest match. In
this case I did the following:

'''
$ git stt
git: 'stt' is not a git command. See 'git --help'.

The most similar commands are
  st
  status
'''

In this particular case it would have been nice if Git also understood
that 'git st' and 'git status' are equivalent in my configuration, so
that it shouldn't have to warn me about them as different matches, but
instead just run any of them.

Thank you for Git. Maybe I'll see this feature in the future!

Best,
Erik
