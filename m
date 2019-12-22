Return-Path: <SRS0=9sC2=2M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11749C2D0C3
	for <git@archiver.kernel.org>; Sun, 22 Dec 2019 00:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA0C4206C3
	for <git@archiver.kernel.org>; Sun, 22 Dec 2019 00:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dyntopia-com.20150623.gappssmtp.com header.i=@dyntopia-com.20150623.gappssmtp.com header.b="pYLBkdq6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbfLVAba (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 19:31:30 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44293 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfLVAba (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Dec 2019 19:31:30 -0500
Received: by mail-pf1-f196.google.com with SMTP id 195so6410861pfw.11
        for <git@vger.kernel.org>; Sat, 21 Dec 2019 16:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dyntopia-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5JsathtGWPcmdBXdnOndkLJfKOTAwoxxc1ask30fuUg=;
        b=pYLBkdq6Rhari+eCzjxW8iDiGQAOUYsdiZmsr1j8jOOEy9cxinr3IJzMMo31Cu+deP
         xy5HfVSIvTM4J3S+QxkuQhUdZPuzsDsahPUuG+mlfb0/jxwjH279V6tgniCk+MFeXf00
         Ebtk9xTyvoldNOY0L2L+rjoargnPeeecLromoFLIgLbpRxYufO4xa4Sgaw+AYwNd1pTK
         tR21dotiIApuMDi6ib4GqrSnm4OdejpFwySaaWzErg1zyufT8zY7X1coLXHJEqmrkz0d
         lVcQVBuP9CERRmRdJU0zFIEbb6TnJ0na8f21f4NE1KpZwNDCQ39gJJG2Px96PQP4zE2W
         dPVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5JsathtGWPcmdBXdnOndkLJfKOTAwoxxc1ask30fuUg=;
        b=C+VVj3YqWwRG8cd1b7Xedzfwxg5uNdNAAQOp+fZdCKyeFwwFXnDkkyvY3HOHaudbXO
         p+biONHnz8nRFcLUjoLM3+pndy/fLRlxtl4QfJRGk8ZNTSm6hmfSWY6Ph5gwon5j/e4c
         36Nv14QzltSwGyRVHEVyI255MGPZmus/Pmn4GO1+bb3e7Wg837QAb5BNIyarrGIiG8AB
         sadehcbb2cvCv0Rlc7nFJ64693PK+zTF2hexf2SXGJFAlS2PHIZx1j/BxyADIcSXG5zy
         AOjA64qF+ZfBGA7ez7oF7K5SFVnPET4O+YnPocuUT51l5UbKdq/b6oif9sUUzH6yIu7f
         Eb5Q==
X-Gm-Message-State: APjAAAVhPogj3y7VonikDIkBfgAUcSYJ2wS37xwc+IShkr0WIjoXqxtZ
        QuQP0LqcDbyo3njvhWwbnSMjSnUpUwk=
X-Google-Smtp-Source: APXvYqy8bM17u2QU/JoJ96sl2zAoFhy0Ohz4/++GsjrPyRdqy4pgR24EFobMjmxL0Z/swEfqxV/x6g==
X-Received: by 2002:a63:5818:: with SMTP id m24mr23670775pgb.358.1576974688420;
        Sat, 21 Dec 2019 16:31:28 -0800 (PST)
Received: from localhost ([203.144.80.234])
        by smtp.gmail.com with ESMTPSA id e1sm19109879pfl.98.2019.12.21.16.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Dec 2019 16:31:27 -0800 (PST)
From:   Hans Jerry Illikainen <hji@dyntopia.com>
To:     git@vger.kernel.org
Cc:     Hans Jerry Illikainen <hji@dyntopia.com>
Subject: [PATCH v2 0/1] gpg-interface: add minTrustLevel as a configuration option
Date:   Sun, 22 Dec 2019 00:31:22 +0000
Message-Id: <20191222003123.10555-1-hji@dyntopia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191219000140.9056-1-hji@dyntopia.com>
References: <20191219000140.9056-1-hji@dyntopia.com>
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
themselves (except for a grace period with backward compatibility).

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

Backward-compatibility is maintained by introducing a special case in
verify_merge_signature() such that if no user-configurable
gpg.minTrustLevel is set, then the old behavior of rejecting
TRUST_UNDEFINED and TRUST_NEVER is enforced.  If, on the other hand,
gpg.minTrustLevel is set, then that value overrides the old behavior.

Similarly, the %G? format specifier will continue show 'U' for
signatures made with a key that has a trust level of TRUST_UNDEFINED or
TRUST_NEVER, even though the 'U' character no longer exist in the
`result` member of the signature_check structure.  A new format
specifier, %GT, is also introduced for users that want to show all
possible trust levels for a signature.

Another approach would have been to simply drop the trust-level
requirement in verify_merge_signature().  This would also have made the
behavior consistent with other parts of git that perform signature
verification.  However, requiring a minimum trust level for signing keys
does seem to have a real-world use-case.  For example, the build system
used by the Qubes OS project currently parses the raw output from
verify-tag in order to assert a minimum trust level for keys used to
sign git tags [2].


Changes since v0:
* Added backward-compatibility with the old behavior of
  verify_merge_signature().  The old behavior is overridden if a user
  has configured gpg.minTrustLevel.  My approach is kind of ugly because
  now all users of verify_merge_signature() has to be aware of
  gpg.minTrustLevel to know if it should override the default behavior.
  An alternative might be to have a configurable per-operation trust
  level (e.g. merge.minTrustLevel), but I'm not sure how sensible that
  is either.
* Added backward-compatiblity with the old behavior of %G?.

Changes since v1:
* Fixed compatibility with gpg1 in parse_gpg_output().  One significant
  difference between gpg1 and gpg2 is that the trust levels above
  TRUST_NEVER are written without any additional space-separated
  information in gpg1 [3].  This broke the logic in the previous
  iterations, because the end of the TRUST_ string were searched for by
  looking for a space character.  Now a new-line is used as a fallback.


[1] https://git.gnupg.org/cgi-bin/gitweb.cgi?p=gnupg.git;a=blob;f=doc/doc/DETAILS;h=bd00006e933ac56719b1edd2478ecd79273eae72;hb=refs/heads/master
[2] https://github.com/QubesOS/qubes-builder/blob/9674c1991deef45b1a1b1c71fddfab14ba50dccf/scripts/verify-git-tag#L43

Hans Jerry Illikainen (1):
  gpg-interface: add minTrustLevel as a configuration option

 Documentation/config/gpg.txt       | 15 +++++
 Documentation/pretty-formats.txt   |  1 +
 builtin/merge.c                    |  9 ++-
 builtin/pull.c                     | 13 ++++-
 commit.c                           | 12 ++--
 commit.h                           | 12 +++-
 gpg-interface.c                    | 93 ++++++++++++++++++++++++++----
 gpg-interface.h                    | 10 +++-
 pretty.c                           | 30 +++++++++-
 t/t5573-pull-verify-signatures.sh  | 64 ++++++++++++++++++++
 t/t7030-verify-tag.sh              | 24 ++++++++
 t/t7510-signed-commit.sh           | 39 +++++++++++++
 t/t7612-merge-verify-signatures.sh | 22 +++++++
 13 files changed, 321 insertions(+), 23 deletions(-)

--
2.15.1.8615.g16a7d4acf3
