Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9767C83002
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 01:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EF64206D9
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 01:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjZd840X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgD1Bha (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 21:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726233AbgD1Bha (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 Apr 2020 21:37:30 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C977C03C1A8
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 18:37:30 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x2so6193086pfx.7
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 18:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=JWt0Ax6v2G6LXBi7lHZVhpzJLXHpTsWPUeg9iNe5Mss=;
        b=FjZd840XlnmqmCIklHdKW881b8caMcO9fMFfGPLAUgd8XIkHNA/xzgaSAYy57rkyKK
         THkZw8/9GIey0LtQXKi4CaWt7fMPsQg/9BOEZ3yRfvqKCHNe2ZF/RM1RHNseR3J2VWwk
         FUMlKh4B5c3dRKfoP8oBT0hr5u21zDKcZsRW+WduwCN0LH0MmRPGg6GrGVEG2Q6lq8yJ
         YX0IuWsO8HC3ao0TqQRUB62TeEzFVkBoUtnElfmY+ArznK1igQokmV76z7LZ0x8/hSj3
         MtzHPkMjHkwQoH6mVNInJAoNzziW9fc8lF/si/s7dIhvJ9YTBKDaCIaE8w3gKVcuD/M9
         Nwrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JWt0Ax6v2G6LXBi7lHZVhpzJLXHpTsWPUeg9iNe5Mss=;
        b=HePaMbl/x4laV8l37v+Gi2PSaMRJzoSxzMA3dfOsqgxYG/uya+mLlxIub6xQ5kRTLy
         piWC/pUYv0TcjhAeqc1S4FRe5+pL367Ooi0XKZMS+fxNDyFFDQV4e4SkcYs6BrVO0JRQ
         QPaTcaaHgzboEcIDYlTyV+c1xbRKE5xYlLIm/ZndTZGIe/fJbrksM4YF567Zuu0gQEHE
         VQmLGggCx2ZFBhCpggKo/99oTLnqU3k7wy+uXfvVFzhU/37/ULO8R48P0qDQoDEsGnor
         OZI7hq+y+8Z4B7COjFwiWEBNW+9InbPqLGh6N6b5cwyoF4616HZLpSe/isxAHSB8HVK4
         q8HA==
X-Gm-Message-State: AGi0PuaGBA3qJGOZBLgsEVX2rMAyNR0c7HNlN9tz/o0l5ZEhx4w1mO2D
        thDgIzIPgaJ7NHT8c9uebGI=
X-Google-Smtp-Source: APiQypL99dB3bDYCC/ufNpBVev/490cnaEtzqUuUXVmvcWdyyPo20V89WMEdoMLnA5ycfwbXSnLf9g==
X-Received: by 2002:a63:8ac3:: with SMTP id y186mr24482121pgd.277.1588037849331;
        Mon, 27 Apr 2020 18:37:29 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id a19sm14093563pfd.91.2020.04.27.18.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 18:37:28 -0700 (PDT)
Date:   Mon, 27 Apr 2020 18:37:26 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        dirk@ed4u.de, sunshine@sunshineco.com
Subject: Re: [PATCH v3] git-credential-store: skip empty lines and comments
 from store
Message-ID: <20200428013726.GD61348@Carlos-MBP>
References: <20200427084235.60798-1-carenas@gmail.com>
 <20200427125915.88667-1-carenas@gmail.com>
 <xmqqftco94wx.fsf@gitster.c.googlers.com>
 <20200427191858.GB1728884@coredump.intra.peff.net>
 <xmqqv9lk7j7p.fsf@gitster.c.googlers.com>
 <20200427211013.GB1732530@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200427211013.GB1732530@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 27, 2020 at 05:10:13PM -0400, Jeff King wrote:
> On Mon, Apr 27, 2020 at 01:43:38PM -0700, Junio C Hamano wrote:
> > >> These files are not supposed to be viewed or edited without the help
> > >> of the credential helpers.  Do these blank lines and comments even
> > >> survive when a new credential is approved, or do we just overwrite
> > >> and lose them?
> > >
> > > That's a good question. In the older code we do save them, because
> > > credential-store passes through lines which don't match the credential
> > > we're operating on.
> > >
> > > But in Carlo's patch, the immediate "continue" means we wouldn't ever
> > > call "other_cb", which is what does that pass-through.
> > 
> > So, does that mean the patch that started this thread will still help
> > users who wrote custom comments and blank lines in their credential
> > store by letting git-credential-store start up, but leaves a ticking
> > bomb for them to lose these precious comments and blanks once they
> > add a new site, change password, etc., at which point the user realizes
> > that comments and blanks are not supported after all?
> 
> The more I look into it, the more negative I am on adding such a comment
> feature.

FWIW I am not interested on implementing a comment feature (regardless of
what the subject says, and indeed was going to use quotes around it in my
original patch), but it was already too long ;)

my objective was to allow people that were not upgrading because of this
"regression" a path forward, but after all this discussion I am convinced
too that my approach is misguided.

if users are already manually editing this file, they should be able to
fix the corrupted lines themselves but the error shown needs to be improved.
and the failure mode corrected as well so they are not blocked.

this also means that my "sneaky" way to fix formatting issues is gone
and the passthrough is called so nothing will be lost, but as you also
said the location is not warranted to be kept so this comment "feature"
is as useless as intended.

would something like the following (wouldn't pass the last test yet as
it will need special handling to be able to handle the full path of the
broken file as shown in the warning sent to stderr) on top of Junio's
make more sense?

it still "silently" fixes the formatting issues where a leading tab (test
added) or spaces were added to easy the transition, but probably should
also error out as Junio suggested originally.

had also updated the commit message and what is left of the documentation.

Carlo
-- >8 --
Subject: [RFC PATCH v4] git-credential-store: skip empty lines and comments
 from store

with the added checks for invalid URLs in credentials, any locally
modified store files which might have empty lines or even comments
were reported[1] failing to parse as valid credentials.

using the store file in this manner wasn't intended by the original
code and it had latent issues which the new code dutifully prevented
but since the strings used wouldn't had been valid credentials anyway
we could instead detect them and skip the matching logic and therefore
prevent a fatal failure.

trim all lines as they are being read from the store file and skip the
ones that will be otherwise empty or that start with "#" (therefore
assuming them to be comments) but warn users so they will be make
aware of the issues introduced by their manual editing.

[1] https://stackoverflow.com/a/61420852/5005936

Reported-by: Dirk <dirk@ed4u.de>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 Documentation/git-credential-store.txt |  4 ++++
 credential-store.c                     |  7 ++++++
 t/t0302-credential-store.sh            | 31 ++++++++++++++++++++++++++
 3 files changed, 42 insertions(+)

diff --git a/Documentation/git-credential-store.txt b/Documentation/git-credential-store.txt
index 693dd9d9d7..e9a1993021 100644
--- a/Documentation/git-credential-store.txt
+++ b/Documentation/git-credential-store.txt
@@ -101,6 +101,10 @@ username (if we already have one) match, then the password is returned
 to Git. See the discussion of configuration in linkgit:gitcredentials[7]
 for more information.
 
+The parser will ignore any lines that are empty or starting with '#' character
+during the processing of credentials for read, but warn the user so they can
+be corrected.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/credential-store.c b/credential-store.c
index c010497cb2..f1f016fec1 100644
--- a/credential-store.c
+++ b/credential-store.c
@@ -24,6 +24,13 @@ static int parse_credential_file(const char *fn,
 	}
 
 	while (strbuf_getline_lf(&line, fh) != EOF) {
+		strbuf_trim(&line);
+		if (line.len == 0 || *line.buf == '#') {
+			warning("ignoring corrupted credential entry \"%s\" in %s", line.buf, fn);
+			if (other_cb)
+				other_cb(&line);
+			continue;
+		}
 		credential_from_url(&entry, line.buf);
 		if (entry.username && entry.password &&
 		    credential_match(c, &entry)) {
diff --git a/t/t0302-credential-store.sh b/t/t0302-credential-store.sh
index d6b54e8c65..12a158c136 100755
--- a/t/t0302-credential-store.sh
+++ b/t/t0302-credential-store.sh
@@ -120,4 +120,35 @@ test_expect_success 'erase: erase matching credentials from both xdg and home fi
 	test_must_be_empty "$HOME/.config/git/credentials"
 '
 
+test_expect_success 'get: attempt to workaround formatting isssues (ex: tab)' '
+	q_to_tab >"$HOME/.git-credentials" <<-\EOF &&
+	Qhttps://user:pass@example.com
+	EOF
+	check fill store <<-\EOF
+	protocol=https
+	host=example.com
+	--
+	protocol=https
+	host=example.com
+	username=user
+	password=pass
+	--
+	EOF
+'
+
+test_expect_success 'get: skip empty lines or "comments" in store file' '
+	test_write_lines "#comment" " " "" \
+		 https://user:pass@example.com >"$HOME/.git-credentials" &&
+	check fill store <<-\EOF
+	protocol=https
+	host=example.com
+	--
+	protocol=https
+	host=example.com
+	username=user
+	password=pass
+	--
+	EOF
+'
+
 test_done
-- 
2.26.2.569.g1d74ac4d14


