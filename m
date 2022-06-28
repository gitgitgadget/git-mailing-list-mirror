Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735F9C433EF
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 13:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346903AbiF1Ns7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 09:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346911AbiF1Nsy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 09:48:54 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44667F2D
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 06:48:53 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id c137so9586089qkg.5
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 06:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=AXTX2B/mpDiPjmwPpKeGAYRLVxt72LODStWD9aTvKl8=;
        b=W1pDfZGf3j6o3DRM4TtCEftNsz0lEsrf08TSTYrE8iLy1jcbGeciPy0O4ep9jTU+72
         AtfY2e9fEuxH4/Efmv3yYxFV9sWLC5CZzZBIjxKsrYIaAjDSfNe4xEYHFW+UyqSmMU6l
         HBiZtqGoSa9GpF7Ky4elEzMGmCgYlX87FDUpCcQHOPvJYVbakwlVbFsbmlK/SUIAp5AA
         m9L91uCq9Immlq/tDg7RmC+ZfRbUhZ7P1u+VGUWbnXC7Dwy9DptNOf2sSXNCfOXlgMVS
         2kJ78kAEREM3we+5FdXZRZxAEpcnVnMOdW0jaz09taAdChwPgE2egQJjGjN+3T3LjRe4
         abAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=AXTX2B/mpDiPjmwPpKeGAYRLVxt72LODStWD9aTvKl8=;
        b=y/qnAgAen6lwt2TlVjTuN8uWbAuGsYQ1G9cHD9U1ySD6QNtmH6pB54IGbhpQLVXP8C
         A+oDYWIGnbtovERa2esF7bkrxsror8fP1BkK22hGFcurOZqQmfQbejUMHt7CddVTR5av
         r4wnopsVSOA7J8qOMYuRN0xBQMo068uMb0gtuZGiPPqxYq28jkbTaInr35ZCthN6CTgu
         8LEqh39ugVDba62Nw8/R10y53mgBtp0Xhmbm1m16PJ4l/rp2UoXBV3pdfn7a63G18ktR
         k2NQhJqGZtQc1byv/0p9TwLVfj4H2/VsaJgMBuirKzwht/wF1vSCQVZMaZFsBB6Nl4Kl
         TTzw==
X-Gm-Message-State: AJIora/dUpoZBWacRmqCvlSpMEwdCSoWRQ117id5BNvP2bWecZdZLKKT
        E08cELGyhQJ3IrH4ALh6U2p9x53pdHU=
X-Google-Smtp-Source: AGRyM1taCZWbj2LJt5/J/CjFbYOfNiklrd2zQB8aqE0eXf5wS6svDlJwdVpPvQcloUK0ybmq6ktJew==
X-Received: by 2002:a05:620a:20c4:b0:6af:778:10a9 with SMTP id f4-20020a05620a20c400b006af077810a9mr11282171qka.50.1656424132279;
        Tue, 28 Jun 2022 06:48:52 -0700 (PDT)
Received: from smtpclient.apple ([2601:89:c600:f150:945:395e:48be:27e7])
        by smtp.gmail.com with ESMTPSA id s10-20020a05620a254a00b006a6d74f8fc9sm12030553qko.127.2022.06.28.06.48.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jun 2022 06:48:51 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: Oddities in gitignore matching
From:   John Thorvald Wodder II <jwodder@gmail.com>
In-Reply-To: <72a1a225-5d84-56c3-2652-ec7c17c18cbd@gmail.com>
Date:   Tue, 28 Jun 2022 09:48:50 -0400
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <0871A57F-4AF4-4F45-AC56-10C1817761BB@gmail.com>
References: <DC3C4CED-3781-4380-95E6-97F5CBE1B13C@gmail.com>
 <72a1a225-5d84-56c3-2652-ec7c17c18cbd@gmail.com>
To:     phillip.wood@dunelm.org.uk
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022 Jun 28, at 05:13, Phillip Wood <phillip.wood123@gmail.com> =
wrote:
>=20
> Hi John
>=20
> On 26/06/2022 20:34, John Thorvald Wodder II wrote:
>> First: I've found that the pattern "foo**/bar" causes the path =
"foo/glarch/bar" (as well as "foobie/glarch/bar") to be ignored.  =
However, the gitignore(5) documentation states that "**/" only has =
special meaning when it's "leading"; in other circumstances, the double =
star should be treated the same as a single star (and "foo*/bar" does =
not match "foo/glarch/bar").  Is this behavior of non-leading "**/" =
deliberate or a bug?
>=20
> I've no idea if it is deliberate or not but it seems reasonable and I =
think it matches shells like fish, tcsh and zsh though not bash (I think =
our documented behavior matches bash).

OK, but it turns out that "foo**/bar" also matches just "foobar", no =
slash, which definitely seems wrong.

>> Interestingly, checking the pattern with the wildmatch test-tool =
(`t/helper/test-tool wildmatch wildmatch foo/glarch/bar 'foo**/bar'`) =
shows that the pattern should not match the path.
>> Second: The pattern "[[:space:]]" does not match 0x0B (\v, vertical =
tab) or 0x0C (\f, form feed) despite the fact that the C isspace() =
function accepts these characters, and I cannot figure out the cause for =
this discrepancy.  (The pattern does match the other characters that =
isspace() accepts, though =E2=80=94 tab, line feed, carriage return, and =
space character.)  The wildmatch test-tool agrees with this behavior, =
though.
>=20
> This is because git defines its own isspace() that does not treat '\v' =
or '\f' as whitespace (see git-compat-util.h and ctype.c). I'm not sure =
why we exclude those characters, I think the reason for defining our own =
isspace() is to avoid the locale dependent behaviour of the standard =
version.

Thank you for the explanation.

---

Through further experimentation, I've discovered a fourth oddity with =
gitignore: If "foo//" (with two or more trailing slashes) is added to =
.gitignore and `mkdir -p foo/bar` is run, then `git status =
--ignored=3Dmatching --porcelain` won't show "foo/" or "foo/bar/" at =
all, which is something I'd previously only encountered for completely =
empty top-level directories.  This holds true no matter how deep or wide =
you make the directory tree at "foo/", as long as it's all-directories; =
once a file gets added somewhere under "foo/", the "git status" command =
shows "foo/" as ignored.

-- John Wodder=
