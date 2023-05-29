Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18473C7EE23
	for <git@archiver.kernel.org>; Mon, 29 May 2023 19:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjE2TXT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 May 2023 15:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjE2TXS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2023 15:23:18 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21F593
        for <git@vger.kernel.org>; Mon, 29 May 2023 12:23:15 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-64d2e8a842cso2723617b3a.3
        for <git@vger.kernel.org>; Mon, 29 May 2023 12:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685388195; x=1687980195;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nbH1XTLeSXG23iuYcB8kzeL1RGH97EGGk8VxYIALbbg=;
        b=Rbvv4xLGptGIlJNqZDIdlvjYVwFGUeuJZGT0NOUrAx3QMh/gI83nXVuKu1G/0767M/
         J9ByO507r8JPDcPEi6Jzp6mUasNr/cqgfY5nGgEeOKeckENa5B5A1IdGbihZznLvh+En
         XbkE52JjbOeIYCOyW3opu08CuqSIZfQTn9Un0RI7hNurXHT5aYtmmP2HztDNj2BDkJvV
         LAAVX/sZC+TAqNmOj2SrIu9yh05/Uw6ZpwAT69fP7qwx0ZEfYDnKjCN6pb85eYra/cYc
         s83Idt4hSx7sYXVLgndhkaHK3lBAhthrwgHcz9qP5LppZVlvcSqGcQV07jyk8gDDFOi+
         Eq/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685388195; x=1687980195;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nbH1XTLeSXG23iuYcB8kzeL1RGH97EGGk8VxYIALbbg=;
        b=HYi9nHTGfu3tNVBiU4eglHZsqwkV/aSAi39IdwREMD4Qh+Dj66oGtKn7L5ln6QAINT
         gJLySpwkjH8ywBtJ4V83eZwqJAOYh2CaiZrX3jwPtvVHTX1WCTflsbNbQsCUTeiEVYba
         dgpWwqQihlUN55l3xuPpD6bUNyZecBoCzI1WdZjVW0XVLpOAXnlhWcWXMiti9tCX62gJ
         rabvWTh8htlY2Sc5OH3oG54fblVH5mhHqlbDrn4M+hgCth6hy3bPT9FYCMC4hs+olxda
         G8n5E3QlKsRdgUtE25IomMs3SL/meOw9K7yDfCI2x0i0sg+hkywcd0Bks05A5lCMooPv
         awIA==
X-Gm-Message-State: AC+VfDwK+LeJnlivU97SDDaUCpCwAiFTF14fGA01+p+4Bhf2Q1wTEukx
        ivUvjpcMm2qdehnR4DB1rVBjc86JoXktyw==
X-Google-Smtp-Source: ACHHUZ5jmoRjr9+MgLYCC0oo8jkgNa7UWDYAeDZ7sX2inu9fBjI0yjh/YMp8lVjmDop6ztIWbMyiPg==
X-Received: by 2002:a05:6a00:1305:b0:646:663a:9d60 with SMTP id j5-20020a056a00130500b00646663a9d60mr669466pfu.10.1685388194845;
        Mon, 29 May 2023 12:23:14 -0700 (PDT)
Received: from fivlite-virtual-machine.localdomain ([49.37.145.178])
        by smtp.gmail.com with ESMTPSA id i16-20020aa78d90000000b0064fa43129fcsm277694pfr.130.2023.05.29.12.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 12:23:14 -0700 (PDT)
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     git@vger.kernel.org
Cc:     Kousik Sanagavarapu <five231003@gmail.com>
Subject: [GSoC][PATCH 0/2] Add new "signature" atom 
Date:   Tue, 30 May 2023 00:02:04 +0530
Message-ID: <20230529192209.17747-1-five231003@gmail.com>
X-Mailer: git-send-email 2.41.0.rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
This series duplicates the code for signature related formats from
pretty to ref-filter, which is a step in the process of duplicating all
the pretty formats which are not present in ref-filter, with the end
goal of a single formatting interface for git in mind.

PATCH 1/2 introduces a new prereq GPG2 for the purpose of testing stuff
that breaks with GPG version <= v2. This is evident from the CI failure
in [1] that was sent with the same subject as this series (more info
below).

PATCH 2/2 adds a new "signature" atom, which is a duplication of the %G*
formats in pretty. This was sent before by Nsengiyumva Wilberforce and
was in "seen" until May and was removed because of CI failure. I have
built upon it and have done some minor changes to it. The CI jobs are
now successful which can be found at [2].

[1]: Patch

	https://lore.kernel.org/git/20230311210607.64927-1-nsengiyumvawilberforce@gmail.com/

     Junio's email about CI failure

	https://lore.kernel.org/git/xmqqpm9bosjw.fsf@gitster.g/

[2]: https://github.com/five-sh/git/actions/runs/5114306975/workflow

Here is the range-diff, compared to Nsengiyumva's final version posted
to the mailing list

-:  ---------- > 1:  5c97d11b79 t/lib-gpg: introduce new prereq GPG2
1:  8a49102b1f ! 2:  e89f14283d ref-filter: add new "signature" atom
    @@
      ## Metadata ##
    -Author: Nsengiyumva Wilberforce <nsengiyumvawilberforce@gmail.com>
    +Author: Kousik Sanagavarapu <five231003@gmail.com>
     
      ## Commit message ##
         ref-filter: add new "signature" atom
     
    -    This commit duplicates the code for `signature` atom from
         pretty.c
    -    to ref-filter.c. This feature will help to get rid of current
         duplicate
    -    implementation of `signature` atom when unifying
         implementations by
    -    using ref-filter logic everywhere when ref-filter can do
         everything
    -    pretty is doing.
    +    Duplicate the code for outputting the signature and it's other
    +    parameters for commits and tags in ref-filter from pretty. In
the
    +    future, this will help in getting rid of the current duplicate
    +    implementations of such logic everywhere, when ref-filter can
do
    +    everything that pretty is doing.
     
    -    Add "signature" atom with `grade`, `signer`, `key`,
    -    `fingerprint`, `primarykeyfingerprint`, `trustlevel` as
         arguments.
    -    This code and its documentation are inspired by how the %GG,
         %G?,
    -    %GS, %GK, %GF, %GP, and %GT pretty formats were implemented.
    +    The new atom "signature" and it's friends are equivalent to the
existing
    +    pretty formats as follows:
    +
    +            %(signature) = %GG
    +            %(signature:grade) = %G?
    +            %(siganture:signer) = %GS
    +            %(signature:key) = %GK
    +            %(signature:fingerprint) = %GF
    +            %(signature:primarykeyfingerprint) = %GP
    +            %(signature:trustlevel) = %GT
     
         Co-authored-by: Hariom Verma <hariom18599@gmail.com>
         Co-authored-by: Jaydeep Das <jaydeepjd.8914@gmail.com>
    -    Mentored-by: Christian Couder <chriscool@tuxfamily.org>
    +    Co-authored-by: Nsengiyumva Wilberforce
<nsengiyumvawilberforce@gmail.com>
    +    Mentored-by: Christian Couder <christian.couder@gmail.com>
         Mentored-by: Hariom Verma <hariom18599@gmail.com>
    -    Signed-off-by: Nsengiyumva Wilberforce
         <nsengiyumvawilberforce@gmail.com>
    +    Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
     
      ## Documentation/git-for-each-ref.txt ##
     @@ Documentation/git-for-each-ref.txt: symref::
    @@ ref-filter.c: static int subject_atom_parser(struct ref_format
*format UNUSED,
     +  return -1;
     +}
     +
    -+static int signature_atom_parser(struct ref_format *format UNUSED,
struct used_atom *atom,
    -+                         const char *arg, struct strbuf *err){
    ++static int signature_atom_parser(struct ref_format *format UNUSED,
    ++                           struct used_atom *atom,
    ++                           const char *arg, struct strbuf *err)
    ++{
     +  int opt = parse_signature_option(arg);
     +  if (opt < 0)
     +          return err_bad_arg(err, "signature", arg);
    @@ t/t6300-for-each-ref.sh: test_expect_success 'git for-each-ref
with non-existing
     +GRADE_FORMAT="%(signature:grade)%0a%(signature:key)%0a%(signature:signer)%0a%(signature:fingerprint)%0a%(signature:primarykeyfingerprint)"
     +TRUSTLEVEL_FORMAT="%(signature:trustlevel)%0a%(signature:key)%0a%(signature:signer)%0a%(signature:fingerprint)%0a%(signature:primarykeyfingerprint)"
     +
    -+test_expect_success GPG 'test bare signature atom' '
    ++test_expect_success GPG 'setup: signature gpg' '
     +  git checkout -b signed &&
    -+  echo 1 >file && git add file &&
    -+  test_tick && git commit -S -m initial &&
    -+  git verify-commit signed 2>out_orig &&
    -+  grep -v "checking the trustdb" out_orig >out &&
    -+  head -3 out >expected &&
    -+  tail -1 out >>expected &&
    -+  echo >>expected &&
    -+  git for-each-ref refs/heads/signed --format="%(signature)"
>actual &&
    -+  test_cmp expected actual
    ++
    ++  test_when_finished "test_unconfig commit.gpgSign" &&
    ++
    ++  echo "1" >file &&
    ++  git add file &&
    ++  test_tick &&
    ++  git commit -S -m "file: 1" &&
    ++  git tag first-signed &&
    ++
    ++  echo "2" >file &&
    ++  test_tick &&
    ++  git commit -a -m "file: 2" &&
    ++  git tag second-unsigned &&
    ++
    ++  git config commit.gpgSign 1 &&
    ++  echo "3" >file &&
    ++  test_tick &&
    ++  git commit -a --no-gpg-sign -m "file: 3" &&
    ++  git tag third-unsigned &&
    ++
    ++  test_tick &&
    ++  git rebase -f HEAD^^ && git tag second-signed HEAD^ &&
    ++  git tag third-signed &&
    ++
    ++  echo "4" >file &&
    ++  test_tick &&
    ++  git commit -a -SB7227189 -m "file: 4" &&
    ++  git tag fourth-signed &&
    ++
    ++  echo "5" >file &&
    ++  test_tick &&
    ++  git commit -a --no-gpg-sign -m "file: 5" &&
    ++  git tag fifth-unsigned &&
    ++
    ++  echo "6" >file &&
    ++  test_tick &&
    ++  git commit -a --no-gpg-sign -m "file: 6" &&
    ++
    ++  test_tick &&
    ++  git rebase -f HEAD^^ &&
    ++  git tag fifth-signed HEAD^ &&
    ++  git tag sixth-signed &&
    ++
    ++  echo "7" >file &&
    ++  test_tick &&
    ++  git commit -a --no-gpg-sign -m "file: 7" &&
    ++  git tag seventh-unsigned
    ++'
    ++
    ++test_expect_success GPGSSH 'setup: signature ssh' '
    ++  test_config gpg.format ssh &&
    ++  test_config user.signingkey "${GPGSSH_KEY_PRIMARY}" &&
    ++  echo "8" >file &&
    ++  test_tick &&
    ++  git commit -a -S -m "file: 8" &&
    ++  git tag eighth-signed-ssh
    ++'
    ++
    ++test_expect_success GPG2 'bare signature atom' '
    ++  git verify-commit first-signed 2>out.raw &&
    ++  grep -Ev "checking the trustdb|PGP trust model" out.raw >out &&
    ++  head -3 out >expect &&
    ++  tail -1 out >>expect &&
    ++  echo "" >>expect &&
    ++  git for-each-ref refs/tags/first-signed \
    ++          --format="%(signature)" >actual &&
    ++  test_cmp expect actual
     +'
     +
     +test_expect_success GPG 'show good signature with custom format' '
    -+  echo 2 >file && git add file &&
    -+  test_tick && git commit -S -m initial &&
    -+  git verify-commit signed 2>out &&
    ++  git verify-commit first-signed &&
     +  cat >expect <<-\EOF &&
     +  G
     +  13B6F51ECDDE430D
    @@ t/t6300-for-each-ref.sh: test_expect_success 'git for-each-ref
with non-existing
     +  73D758744BE721698EC54E8713B6F51ECDDE430D
     +  73D758744BE721698EC54E8713B6F51ECDDE430D
     +  EOF
    -+  git for-each-ref refs/heads/signed --format="$GRADE_FORMAT"
>actual &&
    ++  git for-each-ref refs/tags/first-signed \
    ++          --format="$GRADE_FORMAT" >actual &&
     +  test_cmp expect actual
     +'
    ++test_expect_success GPGSSH 'show good signature with custom format
    ++                      with ssh' '
    ++  test_config gpg.ssh.allowedSignersFile
"${GPGSSH_ALLOWED_SIGNERS}" &&
    ++  FINGERPRINT=$(ssh-keygen -lf "${GPGSSH_KEY_PRIMARY}" | awk
"{print \$2;}") &&
    ++  cat >expect.tmpl <<-\EOF &&
    ++  G
    ++  FINGERPRINT
    ++  principal with number 1
    ++  FINGERPRINT
     +
    -+test_expect_success GPG 'test signature atom with grade option and
bad signature' '
    -+  git config commit.gpgsign true &&
    -+  echo 3 >file && test_tick && git commit -a -m "third"
--no-gpg-sign &&
    -+  git tag third-unsigned &&
    -+
    -+  test_tick && git rebase -f HEAD^^ && git tag second-signed HEAD^
&&
    -+  git tag third-signed &&
    ++  EOF
    ++  sed "s|FINGERPRINT|$FINGERPRINT|g" expect.tmpl >expect &&
    ++  git for-each-ref refs/tags/eighth-signed-ssh \
    ++          --format="$GRADE_FORMAT" >actual &&
    ++  test_cmp expect actual
    ++'
     +
    ++test_expect_success GPG 'signature atom with grade option and bad
signature' '
     +  git cat-file commit third-signed >raw &&
    -+  sed -e "s/^third/3rd forged/" raw >forged1 &&
    ++  sed -e "s/^file: 3/file: 3 forged/" raw >forged1 &&
     +  FORGED1=$(git hash-object -w -t commit forged1) &&
     +  git update-ref refs/tags/third-signed "$FORGED1" &&
     +  test_must_fail git verify-commit "$FORGED1" &&
    @@ t/t6300-for-each-ref.sh: test_expect_success 'git for-each-ref
with non-existing
     +
     +
     +  EOF
    -+  git for-each-ref refs/tags/third-signed --format="$GRADE_FORMAT"
>actual &&
    ++  git for-each-ref refs/tags/third-signed \
    ++          --format="$GRADE_FORMAT" >actual &&
     +  test_cmp expect actual
     +'
     +
     +test_expect_success GPG 'show untrusted signature with custom
format' '
    -+  echo 4 >file && test_tick && git commit -a -m fourth -SB7227189
&&
    -+  git tag signed-fourth &&
     +  cat >expect <<-\EOF &&
     +  U
     +  65A0EEA02E30CAD7
    @@ t/t6300-for-each-ref.sh: test_expect_success 'git for-each-ref
with non-existing
     +  F8364A59E07FFE9F4D63005A65A0EEA02E30CAD7
     +  D4BE22311AD3131E5EDA29A461092E85B7227189
     +  EOF
    -+  git for-each-ref refs/tags/signed-fourth
--format="$GRADE_FORMAT" >actual &&
    ++  git for-each-ref refs/tags/fourth-signed \
    ++          --format="$GRADE_FORMAT" >actual &&
     +  test_cmp expect actual
     +'
     +
     +test_expect_success GPG 'show untrusted signature with undefined
trust level' '
    -+  echo 5 >file && test_tick && git commit -a -m fifth -SB7227189
&&
    -+  git tag fifth-signed &&
     +  cat >expect <<-\EOF &&
     +  undefined
     +  65A0EEA02E30CAD7
    @@ t/t6300-for-each-ref.sh: test_expect_success 'git for-each-ref
with non-existing
     +  F8364A59E07FFE9F4D63005A65A0EEA02E30CAD7
     +  D4BE22311AD3131E5EDA29A461092E85B7227189
     +  EOF
    -+  git for-each-ref refs/tags/fifth-signed
--format="$TRUSTLEVEL_FORMAT" >actual &&
    ++  git for-each-ref refs/tags/fourth-signed \
    ++          --format="$TRUSTLEVEL_FORMAT" >actual &&
     +  test_cmp expect actual
     +'
     +
     +test_expect_success GPG 'show untrusted signature with ultimate
trust level' '
    -+  echo 7 >file && test_tick && git commit -a -m "seventh"
--no-gpg-sign &&
    -+  git tag seventh-unsigned &&
    -+
    -+  test_tick && git rebase -f HEAD^^ && git tag sixth-signed HEAD^
&&
    -+  git tag seventh-signed &&
     +  cat >expect <<-\EOF &&
     +  ultimate
     +  13B6F51ECDDE430D
    @@ t/t6300-for-each-ref.sh: test_expect_success 'git for-each-ref
with non-existing
     +  73D758744BE721698EC54E8713B6F51ECDDE430D
     +  73D758744BE721698EC54E8713B6F51ECDDE430D
     +  EOF
    -+  git for-each-ref refs/tags/seventh-signed
--format="$TRUSTLEVEL_FORMAT" >actual &&
    ++  git for-each-ref refs/tags/sixth-signed \
    ++          --format="$TRUSTLEVEL_FORMAT" >actual &&
     +  test_cmp expect actual
     +'
     +
     +test_expect_success GPG 'show unknown signature with custom
format' '
     +  cat >expect <<-\EOF &&
     +  E
    -+  65A0EEA02E30CAD7
    ++  13B6F51ECDDE430D
     +
     +
     +
     +  EOF
    -+  GNUPGHOME="$GNUPGHOME_NOT_USED" git for-each-ref
refs/tags/fifth-signed --format="$GRADE_FORMAT" >actual &&
    ++  GNUPGHOME="$GNUPGHOME_NOT_USED" git for-each-ref \
    ++          refs/tags/sixth-signed --format="$GRADE_FORMAT" >actual
&&
     +  test_cmp expect actual
     +'
     +
     +test_expect_success GPG 'show lack of signature with custom
format' '
    -+  echo 8 >file && test_tick && git commit -a -m "eigth unsigned"
--no-gpg-sign &&
    -+  git tag eigth-unsigned &&
     +  cat >expect <<-\EOF &&
     +  N
     +
    @@ t/t6300-for-each-ref.sh: test_expect_success 'git for-each-ref
with non-existing
     +
     +
     +  EOF
    -+  git for-each-ref refs/tags/eigth-unsigned
--format="$GRADE_FORMAT" >actual &&
    ++  git for-each-ref refs/tags/seventh-unsigned \
    ++          --format="$GRADE_FORMAT" >actual &&
     +  test_cmp expect actual
     +'
     + 

Kousik Sanagavarapu (2):
  t/lib-gpg: introduce new prereq GPG2
  ref-filter: add new "signature" atom

 Documentation/git-for-each-ref.txt |  27 +++++
 ref-filter.c                       | 111 ++++++++++++++++-
 t/lib-gpg.sh                       |  21 ++++
 t/t6300-for-each-ref.sh            | 189 +++++++++++++++++++++++++++++
 t/t7510-signed-commit.sh           |   7 ++
 5 files changed, 353 insertions(+), 2 deletions(-)

-- 
2.41.0.rc0

