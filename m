Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9ADC2D0C3
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 15:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96AA2206EC
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 15:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dyntopia-com.20150623.gappssmtp.com header.i=@dyntopia-com.20150623.gappssmtp.com header.b="UDs2HOhs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbfLPPcN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 10:32:13 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32866 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728324AbfLPPcN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 10:32:13 -0500
Received: by mail-pf1-f193.google.com with SMTP id y206so5787769pfb.0
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 07:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dyntopia-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E6lLyGcdP44hNDJ9Qj3TiMUoRtcT7HA53vZFpXCmNcs=;
        b=UDs2HOhsWWeVtt0ZmE5iS4lTeIuY+PJs1jMx6FN7qXR9vTBWY+UhIPi0CcRkWnMz4d
         OVy8tBFL6546fZ6pV1ur4IMIHc026OMg6XdIY6zWRWbRcGbKHKCQSV2DlvbnuZYOYqYG
         KDR8IBpUGMCXYzpyyJOvllDclmwnjEVOKy3HEnweHMIrghErX0a73ANMSSbNxR4Kakvk
         5HeDwfBOJsqnNmw2li0o3iDfh11PtErvx1cEJnBNjC/dhjncNOozA1SMdyBh/FUp+4LJ
         YVthhgwFepLN/KszLC8WwJsuRVbQNhlsUN6fSVqKQjbuqTH6+sJoLFPgvVfgBXZEbDaU
         QBkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E6lLyGcdP44hNDJ9Qj3TiMUoRtcT7HA53vZFpXCmNcs=;
        b=n1wsm1mbPT2JO15TV43+DbL1zBhOzfw+SPMWopndK/h4Xdn2kcysFGG5PILAGZrB5k
         PE49iWabiUQVV8qKoaJsv9Bmm7l/dWsK5MQpi0JkVjWMT0PtYs7I0z6YUfSwzIFS8sq4
         sldd27j0BLdyE+q0dF3rcyLZRrvz2Kw3zxoo7wdPfHdmLI7GimMU82jRn3jLw3OG3XOY
         Is8imrdzDkl9PDHjtQltRlLRpfkGUTdmV/EtAmGiebDyWwbWhEKYsw6T0TJgOF2Or4jz
         +bRLQblhLQLwAa0GvGkFJhrBmFue3a7s2mfCyFv1ah72gGANfVaYT3KKD/ix8IQXozsC
         5Q8Q==
X-Gm-Message-State: APjAAAUip6qA/pAeSdzGqOEKt3Bzscbwss8tGuZpwvM6IPwbfjDPK9yq
        8aL1Y4y+f6ssSrRMKQ1kHO92zJpGlqI=
X-Google-Smtp-Source: APXvYqznYo8iJMbS+YbyzV45m4w1xb5kUvUCdUdC27aEF8MMGsOUgvULchAGWPTSPxMj6XuFNy+FLw==
X-Received: by 2002:aa7:9118:: with SMTP id 24mr17138406pfh.182.1576510331097;
        Mon, 16 Dec 2019 07:32:11 -0800 (PST)
Received: from localhost ([203.144.86.91])
        by smtp.gmail.com with ESMTPSA id r66sm24029822pfc.74.2019.12.16.07.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 07:32:09 -0800 (PST)
From:   Hans Jerry Illikainen <hji@dyntopia.com>
To:     git@vger.kernel.org
Cc:     Hans Jerry Illikainen <hji@dyntopia.com>
Subject: [PATCH 0/1] gpg-interface: add minTrustLevel as a configuration option
Date:   Mon, 16 Dec 2019 15:32:03 +0000
Message-Id: <20191216153204.8906-1-hji@dyntopia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously, signature verification for merge and pull operations checked
if the key had a trust-level of either TRUST_NEVER or TRUST_UNDEFINED in
verify_merge_signature().  If that was the case, the process die()d.

The other code paths that did signature verification relied entirely on
the return code from check_commit_signature().  And signatures made with
a good key, irregardless of its trust level, was considered valid by
check_commit_signature().

This difference in behavior might induce users to erroneously assume
that the trust level of a key in their keyring is always considered by
Git, even for operations where it is not (e.g. during a verify-commit or
verify-tag).

The way it worked was by gpg-interface.c storing the result from the
key/signature status *and* the lowest-two trust levels in the `result`
member of the signature_check structure (the last of these status lines
that were encountered got written to `result`).  These are documented in
GPG under the subsection `General status codes` and `Key related`,
respectively [1].

The GPG documentation says the following on the TRUST_ status codes [1]:

    """
    These are several similar status codes:

    - TRUST_UNDEFINED <error_token>
    - TRUST_NEVER     <error_token>
    - TRUST_MARGINAL  [0  [<validation_model>]]
    - TRUST_FULLY     [0  [<validation_model>]]
    - TRUST_ULTIMATE  [0  [<validation_model>]]

    For good signatures one of these status lines are emitted to
    indicate the validity of the key used to create the signature.
    The error token values are currently only emitted by gpgsm.
    """

My interpretation is that the trust level is conceptionally different
from the validity of the key and/or signature.  That seems to also have
been the assumption of the old code in check_signature() where a result
of 'G' (as in GOODSIG) and 'U' (as in TRUST_NEVER or TRUST_UNDEFINED)
were both considered a success.

The two cases where a result of 'U' had special meaning were in
verify_merge_signature() (where this caused git to die()) and in
format_commit_one() (where it affected the output of the %G? format
specifier).

I think it makes sense to refactor the processing of TRUST_ status lines
such that users can configure a minimum trust level that is enforced
globally, rather than have individual parts of git (e.g. merge) do it
themselves.

I also think it makes sense to not store the trust level in the same
struct member as the key/signature status.  While the presence of a
TRUST_ status code does imply that the signature is good (see the first
paragraph in the included snippet above), as far as I can tell, the
order of the status lines from GPG isn't well-defined; thus it would
seem plausible that the trust level could be overwritten with the
key/signature status if they were stored in the same member of the
signature_check structure.

This patch introduces a new configuration option: gpg.minTrustLevel.  It
consolidates trust-level verification to gpg-interface.c and adds a new
`trust_level` member to the signature_check structure.

Unfortunately, it breaks backward-compatibility in two ways:

1. The default trust level is TRUST_UNDEFINED.  This is compatible with
   the old behavior of every code path *except* for
   verify_merge_signature() (since, again, it used to die()s on trust
   levels below TRUST_MARGINAL).

2. The %G? format specifier no longer includes 'U' for signatures made
   with a key that is either TRUST_UNDEFINED or TRUST_NEVER.  Instead, a
   new %GT format specifier is introduced that outputs the trust level
   (as a complete string to avoid ambiguity with TRUST_UNDEFINED and
   TRUST_ULTIMATE).

Another approach would have been to simply drop the trust-level
requirement in verify_merge_signature().  This would also have made the
behavior consistent with other parts of git that perform signature
verification (and it would also have broken backward-compatibility #1).
However, requiring a minimum trust level for signing keys does seem to
have a real-world use-case.  For example, the build system used by the
Qubes OS project currently parses the raw output from verify-tag in
order to assert a minimum trust level for keys used to sign git tags
[2].

[1] https://git.gnupg.org/cgi-bin/gitweb.cgi?p=gnupg.git;a=blob;f=doc/doc/DETAILS;h=bd00006e933ac56719b1edd2478ecd79273eae72;hb=refs/heads/master
[2] https://github.com/QubesOS/qubes-builder/blob/9674c1991deef45b1a1b1c71fddfab14ba50dccf/scripts/verify-git-tag#L43

Hans Jerry Illikainen (1):
  gpg-interface: add minTrustLevel as a configuration option

 Documentation/config/gpg.txt       | 11 ++++
 Documentation/pretty-formats.txt   |  2 +-
 commit.c                           |  9 ++--
 gpg-interface.c                    | 85 +++++++++++++++++++++++++-----
 gpg-interface.h                    | 10 +++-
 pretty.c                           | 20 ++++++-
 t/t5573-pull-verify-signatures.sh  |  7 +++
 t/t7510-signed-commit.sh           | 19 ++++++-
 t/t7612-merge-verify-signatures.sh | 15 ++++++
 9 files changed, 157 insertions(+), 21 deletions(-)

-- 
2.24.1.485.gad05a3d8e5.dirty

