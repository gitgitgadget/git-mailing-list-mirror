Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE531843
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 01:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714441653; cv=none; b=gPnKxNri5Qz1I+yOOaCXCeG3+M7NNT+DTzPdTUqQEDntpDD/6nLGx+J2WrM2bW1CJfDTLtB70U2G5y0I+g/ONtjaih4vw4J9VTZfzrcnipMTcynbPkYseVJepg3Q8RbAfcyv3EnlDVkVRvlmYzB0rXr6b1TlAVuYdMtEqxVlcQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714441653; c=relaxed/simple;
	bh=GDMjkR9qrnDrHJpEhFLzG8xD7vKjd+bfYO+OGhE09AU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JPuT5V48uijODKhsqJFmLBQsWG7Govs2LkDnts9uyT9iY3F5xf8qgw/vukq+9HvQpR6cojYWE1iRbmBh+u6aPdH7j3Ksf06U5nTX/oV+eQ+FjLNcmn0fO+pPLPfCKai/aWRi1VlC0ZwrrkbxktWOZtxyLVBJfMPc8WLWfBf1r1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io; spf=pass smtp.mailfrom=jamesliu.io; dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b=e3C/n2f2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MwcjiG/P; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b="e3C/n2f2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MwcjiG/P"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id C5D56138014F;
	Mon, 29 Apr 2024 21:47:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 29 Apr 2024 21:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jamesliu.io; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1714441650; x=
	1714528050; bh=x+trdz2FvbXPfqtQoCzsxozYLYVQsejbOm8EJDYEsw8=; b=e
	3C/n2f2dOR0TLf9rdiZHkCfVWzOAPDs3SIRiEgUAYzN5da4USgMS9qAzOmCDQEcs
	EMyYfb0nmKnakV1eHFFCnhGWPvOmUlRf0E5FlAgOkihU2++d+RPkAUVu0d42iLqR
	1/Rz4gmv0RIryh2QnTRxHPbHmc+VRwQJBCMvw1qcK6aGeMycQ6nPfjjW7ZqO+e6h
	jnaoQ/u3ulst2SS5xVgyBSzvIAp1gUXDjZ31CUJhh1O+QIHrjSGJd8A4vpgZIxxg
	JjLy6GEzDD7US1YaoENj/AS0r/lYaPA82uc4XqXOYMkhZ1w8RME63VrPxcMvsfok
	hPcZoi4SCAHiH4KcwKf4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714441650; x=
	1714528050; bh=x+trdz2FvbXPfqtQoCzsxozYLYVQsejbOm8EJDYEsw8=; b=M
	wcjiG/PdIiJ1hfMz9uSjRoesNf4RxjdudYR0E1b6kmveBMYyu+PhY01fY3zsJMvD
	GtJYOIn2lSJp1WmjiLHipalFPQzs7OYRwTaskTxYZ9BoISLYndKXtdd9/5wS+HLR
	4TqsymgbakO7/wklHIhL5Cb2mxgUNhjJbSNpvDApw2uP/xBLZupq/nhRc3nDjlVL
	uqhsTKexBX3QCdR+COIWA3t5NFvzqXlu3tqxkrNZmvFZfcxNNe7Jfszgcg4TUdWD
	jjr77PUnoUNN8lzyVJyABqlZeOgOc2xfim08NMQWO0B9ywQdzC16EMfYPJ+NHXQy
	GYdvhj9jiWAS9VDyusYMw==
X-ME-Sender: <xms:sk0wZoQA5idF_FXlh6mBNGn9VF6x-jyfO81C3KHAWO3O5N0CSAkgfA>
    <xme:sk0wZlzsCtuf3blv1xcPXW5mb362722LHCqRMnBMV6yjBmkzRvZWu9-rrkaSMI2xJ
    Ex0v6ocXCLq_d3CfQ>
X-ME-Received: <xmr:sk0wZl2jMbiI8khkm1KA63DV-OMpeqSBbYVeokGQAukESE0CCHUnJLB94q3kicQ6E-WQ6pswjyMxtQoPIjIXsDRmsvc8wExMiuAL0JiRbyfhAAFHbpWrwdMN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduvddgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeflrghmvghsucfnihhuuceojhgrmhgvshesjhgrmhgvshhl
    ihhurdhioheqnecuggftrfgrthhtvghrnhepleejtdeuudfgteegfeeiudehleeutedvhf
    euueeuheevleejkeelteetfeevhfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepjhgrmhgvshesjhgrmhgvshhlihhurdhioh
X-ME-Proxy: <xmx:sk0wZsCIh4og7Q14-FL7xPzrL_W9YxPamaGL0SO2nEw234SvIDRDqg>
    <xmx:sk0wZhh-1Y1W68XDx8WRMLJeurduLTKgz3azbWwoJP_Bmt9xSCjz-Q>
    <xmx:sk0wZorcNsJ_NohpLdqLu5XW9qolN4-_PoEpDU2L8ynsqfK8xuKDGg>
    <xmx:sk0wZkh0VWlsQX2ZPIEVaZfvwZxwSVum8HsSn7aEdDIHBPPjiu2Q3Q>
    <xmx:sk0wZks2GcCQek7-bC5ebf9mvoCvEs2tpqhnRcAzrehBbDWfZON6pW6P>
Feedback-ID: i93f149ec:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Apr 2024 21:47:29 -0400 (EDT)
From: James Liu <james@jamesliu.io>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>
Subject: [PATCH v3 0/1] advice: add --no-advice global option
Date: Tue, 30 Apr 2024 11:47:23 +1000
Message-ID: <20240430014724.83813-1-james@jamesliu.io>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429010925.93205-1-james@jamesliu.io>
References: <20240429010925.93205-1-james@jamesliu.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is v3 of the patch to add a global --no-advice option for silencing
all advice hints. The environment variable has been renamed to
GIT_ADVICE and marked for internal use only, and the conditional in the
advice_enabled() helper has been adjusted to use git_env_bool().

I explored the idea of adding another test to ensure the configuration
is propagated to subprocesses correctly. This would use `git fetch --all`
as the trigger, however it appears that advice is only printed when
`fetch_one()` is invoked, which I don't think spawns any child
processes. With that said, since this is a common pattern, I believe
the existing additional test case is sufficient.

Cheers,
James

James Liu (1):
  advice: add --no-advice global option

 Documentation/git.txt |  5 ++++-
 advice.c              |  8 +++++++-
 environment.h         |  7 +++++++
 git.c                 |  6 +++++-
 t/t0018-advice.sh     | 20 ++++++++++++++++++++
 5 files changed, 43 insertions(+), 3 deletions(-)

Range-diff against v2:
1:  0f2ecb7862 ! 1:  55d5559586 advice: add --no-advice global option
    @@ Commit message
     
         Add a --no-advice global option to disable all advice hints from being
         displayed. This is independent of the toggles for individual advice
    -    hints.
    +    hints. Use an internal environment variable (GIT_ADVICE) to ensure this
    +    configuration is propagated to the usage site, even if it executes in a
    +    subprocess.
     
         Signed-off-by: James Liu <james@jamesliu.io>
     
    @@ advice.c: void advise(const char *advice, ...)
     -	int enabled = advice_setting[type].level != ADVICE_LEVEL_DISABLED;
     +	int enabled;
     +
    -+	if (getenv(GIT_NO_ADVICE))
    ++	if (!git_env_bool(GIT_ADVICE, 1))
     +		return 0;
     +
     +	enabled = advice_setting[type].level != ADVICE_LEVEL_DISABLED;
    @@ advice.c: void advise(const char *advice, ...)
     
      ## environment.h ##
     @@ environment.h: const char *getenv_safe(struct strvec *argv, const char *name);
    - #define GIT_OPTIONAL_LOCKS_ENVIRONMENT "GIT_OPTIONAL_LOCKS"
      #define GIT_TEXT_DOMAIN_DIR_ENVIRONMENT "GIT_TEXTDOMAINDIR"
      #define GIT_ATTR_SOURCE_ENVIRONMENT "GIT_ATTR_SOURCE"
    -+#define GIT_NO_ADVICE "GIT_NO_ADVICE"
      
    ++/*
    ++ * Environment variable used to propagate the --no-advice global option to the
    ++ * advice_enabled() helper, even when run in a subprocess.
    ++ * This is an internal variable that should not be set by the user.
    ++ */
    ++#define GIT_ADVICE "GIT_ADVICE"
    ++
      /*
       * Environment variable used in handshaking the wire protocol.
    +  * Contains a colon ':' separated list of keys with optional values
     
      ## git.c ##
     @@ git.c: const char git_usage_string[] =
    @@ git.c: static int handle_options(const char ***argv, int *argc, int *envchanged)
      			if (envchanged)
      				*envchanged = 1;
     +		} else if (!strcmp(cmd, "--no-advice")) {
    -+			setenv(GIT_NO_ADVICE, "1", 1);
    ++			setenv(GIT_ADVICE, "0", 1);
     +			if (envchanged)
     +				*envchanged = 1;
      		} else {
-- 
2.44.0

