Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5666C433EF
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 00:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ABCF61051
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 00:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbhKBAm7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 20:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhKBAm6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 20:42:58 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0BAC061714
        for <git@vger.kernel.org>; Mon,  1 Nov 2021 17:40:24 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id w15so70127104edc.9
        for <git@vger.kernel.org>; Mon, 01 Nov 2021 17:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=BFaKfEqmHojqJjUI5Ki8nofXRFj4oURD7Qe2nVYWWm8=;
        b=G3kFt8LbuFjuoeqTZ7xXbRX8mdxh/TPChFYg3uiNG0PdQ8ekuN/BJ/84wTJXzrD2ki
         oCA63Uk6YEy+0ygC8LrRttsezO/A7rQcc2Z2GBNrQCHuTKigZu7+IAKOugeR3+jTsQ2H
         /I9g7jp7asoz+cgxhlY+lE4BhOZ8/qTby729jvYsCIDQX9h90iGMz+SN83zdBcMFyosp
         409aOjXsZfNHF62l2zagtd75WUNcJba5JJSFH3IB2nX7fJuijd3jMXt4q2R7m3cy09qE
         VwvBOqniYyBYplusQTF5MoFF8bJoxTmXs310uqyihB7aSxs/z2CBKasBXC0DIf3qQmcP
         hHPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=BFaKfEqmHojqJjUI5Ki8nofXRFj4oURD7Qe2nVYWWm8=;
        b=6I+m6IDTwfTrXuFawdUBh7j9EgTi5oimhjGw1OilPQTgb4f6dOcG64gy/iPtqf/bB0
         AN3dPgDaVVe5ZzcOy6KIbasbPLBjvNiBuIZJ3JyH9MTuPB8bVYHV/aihDHrvshDrRDqX
         cFsiICSW6SL/SN/gLK9W1WfZbtGAfa2Ckebd8Kp76sz3vyU0aPhZTMvRDCMwy/uZGFNn
         DTxeRvbwputIAH1/MgBUElc19dEsZKMyTg1QzxT0zaHQ6PsEaoRVgjhHTgT6I4DmrcOv
         AZOVhBfPkcOllzht/oHFp5WxtHXOzmzAxhzUBSwohmsx+92un5mT884EIe1WtwBFoJdR
         QyFw==
X-Gm-Message-State: AOAM531I+M4rVFPPAtnvlqeHH98Vfcz7R8FZmpTMtowC0J7i2XWy9YEM
        KYGKiRCOB9JXOE8vePIVOV+mJZ5QgfYy8A==
X-Google-Smtp-Source: ABdhPJwWUd06jGi/xIucCb9Wn599KlPzpNwFoQ70n5EQtKQffA1RlhY8uEz8PjCanTdNSDUwsBtjJw==
X-Received: by 2002:a50:e0cf:: with SMTP id j15mr47502838edl.23.1635813622063;
        Mon, 01 Nov 2021 17:40:22 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id oz40sm7717922ejc.82.2021.11.01.17.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 17:40:21 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mhhqf-002CRV-58;
        Tue, 02 Nov 2021 01:40:21 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, bagasdotme@gmail.com, gitster@pobox.com,
        johannes.schindelin@gmx.de
Subject: Re: [PATCH v3 1/3] t0301: fixes for windows compatibility
Date:   Tue, 02 Nov 2021 01:37:01 +0100
References: <20210913085600.35506-1-carenas@gmail.com>
 <20210914072600.11552-1-carenas@gmail.com>
 <20210914072600.11552-2-carenas@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <20210914072600.11552-2-carenas@gmail.com>
Message-ID: <211102.86y2671jbe.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 14 2021, Carlo Marcelo Arenas Bel=C3=B3n wrote:

> [...]
> `mkdir -m` can't represent a valid ACL directly and fails with
> permission problems, so instead call mkdir followed by chmod, which
> has been enhanced to do so.

This looks like a good change:

>  test_expect_success 'use user socket if user directory exists' '
> @@ -79,14 +94,15 @@ test_expect_success 'use user socket if user director=
y exists' '
>  		git credential-cache exit &&
>  		rmdir \"\$HOME/.git-credential-cache/\"
>  	" &&
> -	mkdir -p -m 700 "$HOME/.git-credential-cache/" &&
> +	mkdir -p "$HOME/.git-credential-cache/" &&
> +	chmod 700 "$HOME/.git-credential-cache/" &&
>  	check approve cache <<-\EOF &&
>  	protocol=3Dhttps
>  	host=3Dexample.com
>  	username=3Dstore-user
>  	password=3Dstore-pass
>  	EOF
> -	test -S "$HOME/.git-credential-cache/socket"
> +	test_path_is_socket "$HOME/.git-credential-cache/socket"
>  '

But this adjacent changes is also needed to make this pass on
AIX. I.e. for the adjacent test, which I assume "works" on your Windows
setup because it doesn't have SYMLINKS:

diff --git a/t/t0301-credential-cache.sh b/t/t0301-credential-cache.sh
index 698b7159f03..120b50e8c14 100755
--- a/t/t0301-credential-cache.sh
+++ b/t/t0301-credential-cache.sh
@@ -111,7 +111,8 @@ test_expect_success SYMLINKS 'use user socket if user d=
irectory is a symlink to
                rmdir \"\$HOME/dir/\" &&
                rm \"\$HOME/.git-credential-cache\"
        " &&
-       mkdir -p -m 700 "$HOME/dir/" &&
+       mkdir -p "$HOME/dir/" &&
+       chmod 700 "$HOME/dir/" &&
        ln -s "$HOME/dir" "$HOME/.git-credential-cache" &&
        check approve cache <<-\EOF &&
        protocol=3Dhttps

FWIW on AIX this fails because apparently they got quoting wrong and end
up trying to shell out to "chmod 700 [trash dir name up to the first
space]", i.e. the "trash directory" part.

Not an rc0 issue, this has been in "master" for a while...
