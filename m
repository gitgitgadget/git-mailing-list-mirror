Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F741DFD9A
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 12:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757940777; cv=none; b=KKn0ild7ccvVu3pNWxzi0TaLGNlxRp0s9wNCUCni7ej9WVEZ8Njdbj0vXYUC9dyxn3BnhueId3WzI02D7gtPR7pFLDWna+07QL2S+yKDb7kvaFkp5QmsBQtzwIczfSddwrnWcx5i1rFU/oOJpPcF3goxRPmwaCiFzjTCRnYZ1Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757940777; c=relaxed/simple;
	bh=iCuRpYPhF/DJ4PbFgMvrJ7eLDayGOI7JXC4ljAMkug8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=V2o2RETFGp4afjPJNXNZ+eFf14I9MpsrsJz3BqSw9GjX1rXg+o+3yV5t6LfqmTuAv25BGplsSXi7mJgDsgSJz9/cIEhqNVRH+OoJo0Re2yyZ4oAzrOv1774ukYZJo6KaFPJ59kqk8Y355Ce+G4zAAwsaMlWrXJXrwy7AsIab6I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UPqCdx4e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KjvX6XMT; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UPqCdx4e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KjvX6XMT"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id EC49DEC0255;
	Mon, 15 Sep 2025 08:52:53 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 15 Sep 2025 08:52:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757940773;
	 x=1758027173; bh=66IH15hkw2tVWNB+o+2AYYI7/NdHX7aVD5OdsfoBsIg=; b=
	UPqCdx4eJdk/vR6LbjK2RFPPw9G7vEn/Hj+HQGfd2HKaSMWDNpj6Uhpqa0j0Xn5x
	HzpyahM1HXX8j27GniDfqWPt+9GaNDy5ANaZvdlLm7/fiPfcq1Ankb4f4uw12Pfw
	+amNLlfe7tRqu15h0aFAp89wrVcZFH9KpacOuhYRvqi7sp5PRgl4+27bb10Kc5QJ
	NdAxM1iRX3Nsplmrty4NCD8D8HTibAUaFw7FlJGAWCMEL9ckTmgsa+ZEbkYw/SAc
	o4QeY6/pjR75C+Pkp0ZFa+A33gcQP7YpH20AaF4yXjPOr7dFrunbLhSfnmE65eqo
	gxkjgHTv1tZBUj3bBowsRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757940773; x=
	1758027173; bh=66IH15hkw2tVWNB+o+2AYYI7/NdHX7aVD5OdsfoBsIg=; b=K
	jvX6XMTOMurf+gQ/5Wt9HcFt+IAaRWJAOt+zRspsxzq5LzDY8QYPniTCTdTa9NYD
	UYzn2jgQn4t0BNWvE/drU3zkEvXl7UywlZrPd0uiC1NYRn2+xuqfe/HNfI7l7ZwQ
	wTOBDv0DAxB558PBm1iHDZwfmFKfFI20Ujyr+jxg7pGEsC/rrfZ/rM/VAUrhuGuz
	H3DHRVK9zhO9P94uivxDljCWbON4LKpwM+iqFKd4eU83moCv2myEj+C2X3zLhTYn
	hO57cKAPhh7mWnAkNz5/r6E/YF3Pxh0TvBu4L0ynSqJH+ovaxwYPyRwVh++avvFJ
	8R4BGMqUE1Jsx9oW1j7qQ==
X-ME-Sender: <xms:JQzIaHTRWoOPKujN6gBXg0S5n2B0tYL8t8HQcMCv3uLOm8TBBOZjNA>
    <xme:JQzIaDV0s6LFrwGXLKLVMhYKJfhPT9jVNgya0bpL4WsLUCCqOVOqVybUB4ScMRJCn
    k49qqgLicyiCJ0huA>
X-ME-Received: <xmr:JQzIaJYmzHDiBklQ1aJp5BrvhuW111jrbxwQe3U3gclF5fpyONwuIIGmgUfPWI5iwwyvgw21W-Cks1IFq6tvBsjspi54T7f_Yub6LiqBFmkDdQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjeejgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhufffkfggtgfgjghfvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epteeuueehhffhiedtueehtddtieekfedtudehtdehfefhgeffveeggedthfehuedvnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeg
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshht
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:JQzIaJ1nIMXMD90Y3Lf3RFnzaqJsjQ4isAtftv8UQ5bWLIVOKO_G0g>
    <xmx:JQzIaLh5NQVHICwRSA_jbQBufXpBeQeIeOWyYAEwCxH9UtiP2FFVpA>
    <xmx:JQzIaNY2q5Awa6QHI226xt8L51SUz-G7GbAhseL6qHxJoQqxdcoECQ>
    <xmx:JQzIaLSDn6hlkIc4GPGplK4JB-R7N0_h7d9Y5kZysRvAuNtYowlh2w>
    <xmx:JQzIaOAr_5zwY2qw6l7GHjrO6jVU3zZl8eMWaROtHC3pvTTW8Jv9XEiP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 08:52:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e69c4ee2 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 15 Sep 2025 12:52:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/5] builtin/config: bug fixes for "get" subcommand with
 "--type=color"
Date: Mon, 15 Sep 2025 14:52:47 +0200
Message-Id: <20250915-pks-config-color-v2-0-e4290bd8d13c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB8MyGgC/32NTQ7CIBCFr9LMWgzQYIur3sN0QenQTlRowBBNw
 93FHsDVy/fyfnZIGAkTXJsdImZKFHwFeWrArsYvyGiuDJJLxbUQbLsnZoN3tFR5hMhQTb2RosV
 eK6i1LaKj9zF5GyuvlF4hfo6HLH7un7EsGGet6WynZ3dRkxhq5ExPGEspX/m8ev6tAAAA
X-Change-ID: 20250911-pks-config-color-e5b8a213e895
In-Reply-To: <20250911-pks-config-color-v1-0-3a7c79df65b1@pks.im>
References: <20250911-pks-config-color-v1-0-3a7c79df65b1@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: b4 0.14.2

Hi,

this small patch series contains two bug fixes for `git config get
--type=color`:

  - We restore the behaviour where we can now parse colors without a
    config key.

  - We stop spawning the pager when the user requests to print ANSI
    color escape sequences.

Furthermore, the patch series does some lighter refactorings of t1300.
That test file still has its fair share of issues, but at least it looks
a bit less dirty now.

Changes in v2:
  - Improve commit messages.
  - Use "\EOF" and "-EOF" in more cases.
  - Move a style fixup from the first commit into the second commit.
  - Link to v1: https://lore.kernel.org/r/20250911-pks-config-color-v1-0-3a7c79df65b1@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (5):
      t1300: write test expectations in the test's body
      t1300: small style fixups
      builtin/config: do not die in `get_color()`
      builtin/config: special-case retrieving colors without a key
      builtin/config: do not spawn pager when printing color codes

 builtin/config.c  |  20 +++-
 t/t1300-config.sh | 349 +++++++++++++++++++++++++++---------------------------
 2 files changed, 187 insertions(+), 182 deletions(-)

Range-diff versus v1:

1:  2920521b26 ! 1:  e58033502e t1300: write test expectations in the test's body
    @@ Commit message
         match our modern test style, and there isn't really a reason why this
         would need to happen outside of the test bodies.
     
    -    Convert those to instead do so as part of the test itself.
    +    Convert those to instead do so as part of the test itself. While at it,
    +    normalize these tests to use `<<\EOF` for those that don't use variable
    +    expansion and `<<-EOF` for those that aren't sensitive to indentation.
     
    -    Note that there are two exceptions that we don't convert. In both of
    -    these cases the expectation is reused across multiple tests, and thus a
    -    conversion where we'd move that into the first test that uses the
    -    expectation would be invalid. Those are simply left as-is for now.
    +    Note that there are two exceptions that we leave as-is for now since
    +    they are reused across tests.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    @@ t/t1300-config.sh: test_expect_success 'clear default config' '
      
     -cat > expect << EOF
     +test_expect_success 'initial' '
    -+	cat >expect <<EOF &&
    ++	cat >expect <<\EOF &&
      [section]
      	penguin = little blue
      EOF
    @@ t/t1300-config.sh: test_expect_success 'clear default config' '
      
     -cat > expect << EOF
     +test_expect_success 'mixed case' '
    -+	cat >expect <<EOF &&
    ++	cat >expect <<\EOF &&
      [section]
      	penguin = little blue
      	Movie = BadPhysics
    @@ t/t1300-config.sh: test_expect_success 'clear default config' '
      
     -cat > expect << EOF
     +test_expect_success 'similar section' '
    -+	cat >expect <<EOF &&
    ++	cat >expect <<\EOF &&
      [section]
      	penguin = little blue
      	Movie = BadPhysics
    @@ t/t1300-config.sh: test_expect_success 'clear default config' '
      
     -cat > expect << EOF
     +test_expect_success 'uppercase section' '
    -+	cat >expect <<EOF &&
    ++	cat >expect <<\EOF &&
      [section]
      	penguin = little blue
      	Movie = BadPhysics
    @@ t/t1300-config.sh: test_expect_success 'replace with non-match (actually matchin
      
     -cat > expect << EOF
     +test_expect_success 'append comments' '
    -+	cat >expect <<EOF &&
    ++	cat >expect <<\EOF &&
      [section]
      	Movie = BadPhysics
      	UPPERCASE = true
    @@ t/t1300-config.sh: cat > expect << EOF
      	git config --replace-all --comment="Pygoscelis papua" section.penguin gentoo &&
      	git config ${mode_set} --comment="find fish" section.disposition peckish &&
      	git config ${mode_set} --comment="#abc" section.foo bar &&
    -@@ t/t1300-config.sh: test_expect_success 'Prohibited LF in comment' '
    - 	test_must_fail git config ${mode_set} --comment="a${LF}b" section.k v
    - '
    - 
    --test_expect_success 'non-match result' 'test_cmp expect .git/config'
    -+test_expect_success 'non-match result' '
    -+	test_cmp expect .git/config
    -+'
    - 
    - test_expect_success 'find mixed-case key by canonical name' '
    - 	test_cmp_config Second sections.whatever
     @@ t/t1300-config.sh: test_expect_success 'unset with cont. lines' '
      	git config ${mode_unset} beta.baz
      '
    @@ t/t1300-config.sh: test_expect_success '--replace-all' '
      [nextSection] noNewline = ouch
      EOF
     -test_expect_success 'really mean test' '
    -+
      	git config ${mode_set} beta.haha alpha &&
      	test_cmp expect .git/config
      '
    @@ t/t1300-config.sh: test_expect_success '--list without repo produces empty outpu
     -EOF
     -
      test_expect_success '--name-only --list' '
    -+	cat >expect <<-EOF &&
    ++	cat >expect <<-\EOF &&
     +	beta.noindent
     +	nextsection.nonewline
     +	123456.a123
    @@ t/t1300-config.sh: test_expect_success '--list without repo produces empty outpu
     -EOF
     -
      test_expect_success '--get-regexp' '
    -+	cat >expect <<-EOF &&
    ++	cat >expect <<-\EOF &&
     +	beta.noindent sillyValue
     +	nextsection.nonewline wow2 for me
     +	EOF
    @@ t/t1300-config.sh: test_expect_success '--list without repo produces empty outpu
     -EOF
     -
      test_expect_success '--name-only --get-regexp' '
    -+	cat >expect <<-EOF &&
    ++	cat >expect <<-\EOF &&
     +	beta.noindent
     +	nextsection.nonewline
     +	EOF
    @@ t/t1300-config.sh: test_expect_success '--list without repo produces empty outpu
     -EOF
     -
      test_expect_success '--add' '
    -+	cat >expect <<-EOF &&
    ++	cat >expect <<-\EOF &&
     +	wow2 for me
     +	wow4 for you
     +	EOF
    @@ t/t1300-config.sh: test_expect_success 'get variable with empty value' '
     -echo false > expect
     -
      test_expect_success 'get bool variable with empty value' '
    -+	echo false > expect &&
    ++	echo false >expect &&
      	git config --bool emptyvalue.variable > output &&
      	test_cmp expect output
      '
    @@ t/t1300-config.sh: cat > .git/config << EOF
      
     -cat > expect << EOF
     +test_expect_success 'new section is partial match of another' '
    -+	cat >expect <<EOF &&
    ++	cat >expect <<\EOF &&
      [a.b]
      	c = d
      [a]
    @@ t/t1300-config.sh: cat > .git/config << EOF
      
     -cat > expect << EOF
     +test_expect_success 'new variable inserts into proper section' '
    -+	cat >expect <<EOF &&
    ++	cat >expect <<\EOF &&
      [a.b]
      	c = d
      [a]
    @@ t/t1300-config.sh: cat > other-config << EOF
     -EOF
     -
      test_expect_success 'alternative GIT_CONFIG' '
    -+	cat >expect <<-EOF &&
    ++	cat >expect <<-\EOF &&
     +	ein.bahn=strasse
     +	EOF
      	GIT_CONFIG=other-config git config ${mode_prefix}list >output &&
    @@ t/t1300-config.sh: test_expect_success 'invalid bool (set)' '
      
     -cat > expect <<\EOF
     +test_expect_success 'set --bool' '
    -+	cat >expect<<\EOF &&
    ++	cat >expect <<\EOF &&
      [bool]
      	true1 = true
      	true2 = true
    @@ t/t1300-config.sh: test_expect_success 'get --type=color' '
      
     -cat >expect << EOF
     +test_expect_success 'set --type=color' '
    -+	cat >expect <<EOF &&
    ++	cat >expect <<\EOF &&
      [foo]
      	color = red
      EOF
    @@ t/t1300-config.sh: test_expect_success 'set --type=color barfs on non-color' '
      
     -cat > expect << EOF
     +test_expect_success 'quoting' '
    -+	cat >expect <<EOF &&
    ++	cat >expect <<\EOF &&
      [quote]
      	leading = " test"
      	ending = "test "
    @@ t/t1300-config.sh: inued
      EOF
      
     -cat > expect <<\EOF
    -+test_expect_success 'value continued on next line' '
    -+	cat >expect <<\EOF &&
    - section.continued=continued
    - section.noncont=not continued
    - section.quotecont=cont;inued
    - EOF
    +-section.continued=continued
    +-section.noncont=not continued
    +-section.quotecont=cont;inued
    +-EOF
     -
    --test_expect_success 'value continued on next line' '
    + test_expect_success 'value continued on next line' '
    ++	cat >expect <<-\EOF &&
    ++	section.continued=continued
    ++	section.noncont=not continued
    ++	section.quotecont=cont;inued
    ++	EOF
      	git config ${mode_prefix}list > result &&
      	test_cmp expect result
      '
2:  a6a38b98c2 ! 2:  c37605959e t1300: small style fixups
    @@ Commit message
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## t/t1300-config.sh ##
    +@@ t/t1300-config.sh: test_expect_success 'Prohibited LF in comment' '
    + 	test_must_fail git config ${mode_set} --comment="a${LF}b" section.k v
    + '
    + 
    +-test_expect_success 'non-match result' 'test_cmp expect .git/config'
    ++test_expect_success 'non-match result' '
    ++	test_cmp expect .git/config
    ++'
    + 
    + test_expect_success 'find mixed-case key by canonical name' '
    + 	test_cmp_config Second sections.whatever
     @@ t/t1300-config.sh: EOF
      	test_cmp expect .git/config
      '
    @@ t/t1300-config.sh: test_expect_success bool '
     +'
      
      test_expect_success 'set --bool' '
    - 	cat >expect<<\EOF &&
    + 	cat >expect <<\EOF &&
     @@ t/t1300-config.sh: EOF
      	git config --path path.home "~/" &&
      	git config --path path.normal "/dev/null" &&
3:  b9fe7190a1 = 3:  d88e317762 builtin/config: do not die in `get_color()`
4:  1cd6acd0e9 ! 4:  6dfb71e7ce builtin/config: special-case retrieving colors without a key
    @@ Commit message
     
             $ git config get --type=color --default="reset" ""
     
    -    What this command is supposed to do is to not parse any configuration
    -    key at all. Instead, it is expected to parse the "reset" default value
    -    and turn it into a proper ANSI color escape sequence.
    +    This command is not supposed to parse any configuration keys. Instead,
    +    it is expected to parse the "reset" default value and turn it into a
    +    proper ANSI color escape sequence.
     
         It was reported though [1] that this command doesn't work:
     
             $ git config get --type=color --default="reset" ""
             error: key does not contain a section:
     
    -    This error was introduced with 4e51389000 (builtin/config: introduce
    -    "get" subcommand, 2024-05-06), where we introduced the new "get"
    -    subcommand to retrieve configuration values. The preimage of that commit
    -    used `git config --get-color "" "reset"` instead, which still works
    -    nowadays.
    +    This error was introduced in 4e51389000 (builtin/config: introduce "get"
    +    subcommand, 2024-05-06), where we introduced the "get" subcommand to
    +    retrieve configuration values. The preimage of that commit used `git
    +    config --get-color "" "reset"` instead, which still works.
     
         This use case is really quite specific to parsing colors, as it wouldn't
         make sense to give git-config(1) a default value and an empty config key
         only to return that default value unmodified. But with `--type=color` we
    -    don't return the value directly, but we instead parse the value into an
    -    ANSI escape sequence.
    +    don't return the value directly; we instead parse the value into an ANSI
    +    escape sequence.
     
    -    As such, we can easily special-case this one use case: if the provided
    -    config key is empty, the user is asking for a color code and the user
    -    has provided a value, then we call `get_color()` directly. Do so to
    -    make the documented command work as expected.
    +    As such, we can easily special-case this one use case:
    +
    +        - If the provided config key is empty;
    +
    +        - the user is asking for a color code and the user; and
    +
    +        - the user has provided a default value,
    +
    +    then we call `get_color()` directly. Do so to make the documented
    +    command work as expected.
     
         [1]: <aI+oQvQgnNtC6DVw@szeder.dev>
     
    @@ t/t1300-config.sh: test_expect_success 'get --type=color' '
     +'
     +
      test_expect_success 'set --type=color' '
    - 	cat >expect <<EOF &&
    + 	cat >expect <<\EOF &&
      [foo]
5:  46fc98e1ec ! 5:  ad443d744f builtin/config: do not spawn pager when printing color codes
    @@ Commit message
         The printed string can then for example be used as part of shell scripts
         to reuse the same colors as Git.
     
    -    Right now though we set up the auto-pager though, which means that the
    -    string may instead be written to the pager command. This is of course
    -    quite nonsensical: there shouldn't be any use case where the color code
    -    should end up in the pager instead of in the TTY.
    +    Right now though we set up the auto-pager, which means that the string
    +    may instead be written to the pager command. This is of course quite
    +    nonsensical; there shouldn't be any use case where the color code should
    +    end up in the pager instead of in the TTY.
     
         Fix this by disabling the pager in case the user is asking us to print
         color sequences.
    @@ t/t1300-config.sh: test_expect_success 'get --type=color with default value only
     +'
     +
      test_expect_success 'set --type=color' '
    - 	cat >expect <<EOF &&
    + 	cat >expect <<\EOF &&
      [foo]

---
base-commit: ab427cd991100e94792fce124b0934135abdea4b
change-id: 20250911-pks-config-color-e5b8a213e895

