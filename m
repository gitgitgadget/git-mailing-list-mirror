Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2801F202F2
	for <e@80x24.org>; Tue, 21 Nov 2017 02:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752104AbdKUClJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 21:41:09 -0500
Received: from mail-io0-f180.google.com ([209.85.223.180]:36520 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752010AbdKUClI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 21:41:08 -0500
Received: by mail-io0-f180.google.com with SMTP id 79so10298266ioi.3
        for <git@vger.kernel.org>; Mon, 20 Nov 2017 18:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YTUo8JsXtlKaeUpQe3rFf5ZTy9tz5C3qan4tVuAdUFs=;
        b=FYxuFGG3T6z0lwxDBe2Y7L0ytDD8zxqrsS0YyAmcy0/xCYZvqyaT9bf6UadxZ/l1aH
         9zu8e8jKJH2CXZmEcl5LxLbhCr39LPRG+1c5T0HQjHtalq/9iNliyLfZDzV1bR9aJejR
         oCzD9ecvgxCkzb1WrB1Y9Xwr3fhNFl6zzgdlvZWcdjnm+yKWZUfmbCKbu6bXNDua2U+p
         BnQN2MaDEGwKGNT22gAhFCgbcsm/vv1RGvoE993k7bYFBMDlTdn8PdkPk8S5L0eGnf4h
         ZWtnJiKUeQNDFUL8VPiHxEQn4iTR6JJLT/JkChNX+vrqrhn+dofHGGPaykMycbcKTLtC
         QZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YTUo8JsXtlKaeUpQe3rFf5ZTy9tz5C3qan4tVuAdUFs=;
        b=ne+65A6dlo3rz+7bUJ7IkFT5MHnEF3VDDodV5DEywW1LsqG0JB9l0dKliV/3OAG/dR
         b0ulF4GGNs3TXZ2SoYBeH/BOmZZ3sTKSTCzRm7zpo7CFcn7ZZzZLHrlRakab8/rZORgX
         GCf+5cww1YUjpY2l2H9qcGvOhikCjoYpZPJ+hwhsw3+fMZHA3ga3OsDDHURBBgwfq7uJ
         WvSB4QaDKBSm96mn2Z6JcRxyrjLE9+3ZMZa5bamLnFxfDsAgyaymdV3qGmKbgu2RxkxY
         fyJLfdIhT2noesEq71GjJsiImfU38ajPgG7/mVm3hyqEe9W9BGbC+k3hb563yNGA0Jbe
         /JaA==
X-Gm-Message-State: AJaThX4WlAO0jOl2A4vsuI+c/z2wUBZ7OyC1DsasasKkjvjXxna3VQ3G
        h1Ru0lxoyYIUW+um85cjtzLSoQ==
X-Google-Smtp-Source: AGs4zMYBHOHnwCoAJEnJvZHBVKamemH9zgH1Kpmk40l9c52s2CupEj9VDqy93s6BnCwrH3OeBI6K2w==
X-Received: by 10.107.167.83 with SMTP id q80mr16012431ioe.89.1511232066979;
        Mon, 20 Nov 2017 18:41:06 -0800 (PST)
Received: from dnj.pit.corp.google.com ([2620:0:1019:0:5840:7173:18ff:ed41])
        by smtp.gmail.com with ESMTPSA id j193sm85034ita.9.2017.11.20.18.41.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Nov 2017 18:41:05 -0800 (PST)
From:   Dan Jacques <dnj@google.com>
To:     avarab@gmail.com
Cc:     Johannes.Schindelin@gmx.de, dnj@google.com, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re [PATCH 1/1] exec_cmd: RUNTIME_PREFIX on some POSIX systems
Date:   Mon, 20 Nov 2017 21:41:02 -0500
Message-Id: <20171121024102.14153-1-dnj@google.com>
X-Mailer: git-send-email 2.15.0.chromium12
In-Reply-To: <87k1ykwrfv.fsf@evledraar.booking.com>
References: <87k1ykwrfv.fsf@evledraar.booking.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason @ 2017-11-20 21:50 UTC suggested:

> So LeonT over at #p5p helped me with this. He believes this'll work
> (unless MakeMaker INSTALL_BASE is set, but that should break the Git
> install anyway):

I think that the problem with this approach is that it uses the local
"Config" module. The primary purpose of RUNTIME_PREFIX(_PERL) is that one
can build/install Git into a directory, then either move that directory
somewhere else or archive it and put it on a different (binary-compatible)
system altogether.

The latter case concerns me here. If the "Config" module is loading local
system paths, then the relative pathing between "$Config{installsitelib}"
and "$Config{siteprefixexp}" may not be consistent between systems, so an
archive built from one system may not have a compatible relative
directory structure when resolved with the Config module on another
system.

Since we control the installation process and paths, we know that the
directory structure looks someting like:

.../prefix/$GITEXECDIR/git-perl-script
.../prefix/$RELPERLPATH/Git.pm

Our goal is to, given the directory that "git-perl-script" belongs to,
first identify the path for ".../prefix" and then append "$RELPERLPATH" to
it to generate the full library path.

The most straightforward way to do this, to me, is to:

1) Have the Makefile hard-code "$RELPERLPATH" and "$GITEXECDIR" (relative
  paths) into the header code.
2) Assert that "$FindBin::Bin" (the directory containing the script) ends
  with "$GITEXECDIR".
3) Remove "$GITEXECDIR" from the end of "$FindBin::Bin" to obtain
  ".../prefix" ($prefix). Simple string truncation is probably fine for
  this.
4) Add "File::Spec->catdir($prefix, $RELPERLPATH)" to "lib".

I don't think path separators are a problem, since the Makefile uses "/"
indiscriminately. Even Git-for-Windows seems to run its PERL scripts in
a POSIX environment (mingw).

Does this sound like a reasonable way to proceed?
