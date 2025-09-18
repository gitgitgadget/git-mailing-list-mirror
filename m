Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D50284899
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 06:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758176069; cv=none; b=bxsZ+2bwVWRRp81sn+lp14bl0HH+++g5hE9c596WLdQA6ZshqiaYCIhNJOZpb0V3ykbFys970L0RURboxwbwPh2Drohn8lM99xEFYSOX/n6yxJyOuLnTkq2qNRZwbwXX3OGO8ayox6PNYKK+DTqTmitXEhyUj5RHdknazG2eruY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758176069; c=relaxed/simple;
	bh=nUMTZDCnY7D8A/R/0ZXyvjZOqnb3hGCxYyXjnxtavAg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=MVe7FNIg0WM8v7H8b5nJdHqePsR5C9nXHNE7r+JzQoIqj4ChsFRA/X06CEBm5cKHRpU1N7nFq4xoO3VUpI11hXsj0rHOKQcqKS7gFfQe6mgGCqg+8xwuKgFSuINKosaTbMRm1gLycCeE/EiBYq1vwtsLabg0Mmp9X19fVu4vMS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IzdJ1uIl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eYjaGYIQ; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IzdJ1uIl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eYjaGYIQ"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 9ECA9EC02AE;
	Thu, 18 Sep 2025 02:14:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 18 Sep 2025 02:14:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758176066;
	 x=1758262466; bh=EgQMrWCAPMDZmJelhftxq8G/p/UQPVZAzREKEsEPWTk=; b=
	IzdJ1uIlj/iNCdEhLKShj+uKt75afGwine9QX/efkng8BN9RqGONV2BcievIRI1s
	6VQ5DgwKn1hwf43i49LM/Uo+LfEgjTAurTIQQ1MNZ0tRpBQ4aS3HJrg6LNW+6Q8f
	D2ASsRlrYvnk2XobgLGz1oSZKngknsnxMF0rx5raXUp3cD98vodHL2Gdk2K6QrB4
	p76IrtueyV7nejQtbRdk2Pw3EWNhQZlOvG85jFx9PtNNXfvgzgoLOMAtmzW0M7Z8
	wIllE/evYP758nZuVxRggmlu8GVM8TVVQhkCEh4pHLjYWVIhq83maNyLYj9mAO+R
	joUAfMQ5Qv6rktORqPp/ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758176066; x=
	1758262466; bh=EgQMrWCAPMDZmJelhftxq8G/p/UQPVZAzREKEsEPWTk=; b=e
	YjaGYIQGp1PPaOfkNTGOkfVRtPeZfRNZx6QeESyVZSSNCm9Hh5Fx/qNCQPdbhjK0
	CAbraXRBDUY8bEemiVOXFrOt0NzrkNOHGtKcQOkJBWoHqpPDnMXI32tL/CloUU3o
	IXALu4RhOl3kJfQ+E0FbHqlfmvFOkb6Pb09MSOMX7ZNXNjsl/7WmdSuj3XV80CVk
	ETXR90iztOzZPj7hhn4YHajeMqqG7xrVdkWHYNE2+KLIgrxjHCNRjVYRjWXsR0g0
	WxkqejqUsU76Sb6ztoAr+8ocfKsrwqIR1EGQZbS5rrtrRq0P+pouWxehkT/hWWvk
	wtOSaKs25MD8zoyg9l3RA==
X-ME-Sender: <xms:QqPLaB7AZKBASdhiFSvqKAzSmdv3Om-MAOxxXSt55aBoMhC9D7h5hA>
    <xme:QqPLaMvOSMi6vIETJ-ntmMl7PGa9Om_Vzlfjekw59JSFSvtOzzClD3iE-tH3Rqqij
    ZoRMm78KtOVZ3q9Lg>
X-ME-Received: <xmr:QqPLaC6kLwsLQEWygyJoMqMmVMTRkRollLYv67ruM04HAv2wLnbQZ6S7_9uogV8nh9b48WDPj3snUGxq8xlLFKtoIoF1mXnHW0ZO65TJIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegheehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhufffkfggtgfgjghfvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epteeuueehhffhiedtueehtddtieekfedtudehtdehfefhgeffveeggedthfehuedvnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeg
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:QqPLaHWJyB0GZAMCPwJnY6E7jnU0ZFeqkmVRn6P4ydj3JgKBNRGNtw>
    <xmx:QqPLaE-4qI_mlT4zeEobhmEWB-nn1Iv2CEdT51DJwATcFKcceFKA6A>
    <xmx:QqPLaDlabkZrpwieJ3l_vioLI2l33ywgRCdDbOZI--YXif0znhew0g>
    <xmx:QqPLaCUzql-xnbyDwpXVuphwQl3iOEdnpIS7kwbB40MinYVvHWw4kg>
    <xmx:QqPLaAQwz8wwtgWqokmI6-6MWcPWbb3rW6C1Kq2YdadWmlubd7Ff4RW3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Sep 2025 02:14:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 029300b6 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 18 Sep 2025 06:14:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 0/5] builtin/config: bug fixes for "get" subcommand with
 "--type=color"
Date: Thu, 18 Sep 2025 08:14:18 +0200
Message-Id: <20250918-pks-config-color-v3-0-08ea618cae26@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADujy2gC/32NSw6CMBBAr0JmbU0/Vigr72FcQDvARKWkNY2Gc
 HcLC+PCuJq8ybw3M0QMhBHqYoaAiSL5MYPaFWCHZuyRkcsMkkvNjRBsukZm/dhRn8fNB4a6rRo
 pFFZGQ9amgB09t+T5knmg+PDhtX1IYt3+iSXBOFNNaUvjuqNuxSmf7OkOaynJb1v/sGW28SANb
 13lhLIfe1mWN4GGHfnrAAAA
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

Changes in v3:
  - Provide additional context as part of the commit message for the
    commit that stops setting up the pager with `--type=color`.
  - Link to v2: https://lore.kernel.org/r/20250915-pks-config-color-v2-0-e4290bd8d13c@pks.im

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

Range-diff versus v2:

1:  e61278d7c5 = 1:  fdd1711881 t1300: write test expectations in the test's body
2:  e6f1ea5283 = 2:  8e1e05d9e1 t1300: small style fixups
3:  6f8257aeb4 = 3:  1ef6272e64 builtin/config: do not die in `get_color()`
4:  27a8ab34b0 = 4:  5dcf8c6656 builtin/config: special-case retrieving colors without a key
5:  259600c32a ! 5:  05d5022c1b builtin/config: do not spawn pager when printing color codes
    @@ Commit message
         to reuse the same colors as Git.
     
         Right now though we set up the auto-pager, which means that the string
    -    may instead be written to the pager command. This is of course quite
    -    nonsensical; there shouldn't be any use case where the color code should
    -    end up in the pager instead of in the TTY.
    +    may be written to the pager instead of directly to the terminal. This
    +    behaviour is problematic for two reasons:
     
    -    Fix this by disabling the pager in case the user is asking us to print
    -    color sequences.
    +      - Color codes are meant for direct terminal output; writing them into
    +        a pager does not seem like a sensible thing to do without additional
    +        text.
    +
    +      - It is inconsistent with `git config --get-color`, which never uses a
    +        pager, despite the fact that we claim `git config get --type=color`
    +        to be a drop-in replacement in git-config(1).
    +
    +    Fix this by disabling the pager when outputting color sequences.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     

---
base-commit: ab427cd991100e94792fce124b0934135abdea4b
change-id: 20250911-pks-config-color-e5b8a213e895

