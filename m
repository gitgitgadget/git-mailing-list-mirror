Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC16C217F24
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 19:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757447222; cv=none; b=IbBV9bijy0ex3URfo1zZFKmjFhlEOJp1fnFxTmFg/wV4x5B8V3TNaezWB5ipecLzTpVIeya+u2xSyg4FEtqcfrcZ1I9ZdzYbW4cBuiYcPc0OiNSwDiA6uvfPVHeA8vlLGGgiOvRMfXWLubJJiCsSXdTzycsvUP+nVCd3/fB1050=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757447222; c=relaxed/simple;
	bh=MrtGBo4js2Ps2Um6/3duiI/tQAa1orXzuPjTEHRvqTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nOQIpMyWYKtn/LIAGxFG5mN74PpoX/QY1xKViamrtzqo9U3uWwvkTZowpydQcsFP91QkYtSE3LtfqStFHYjABicEBzSXQbvGCpiKLJ0JAI+OxU/MT2jgRPMY64noRr9R/TlcIvz9GltDQZt9/tuzLmMGE7dufSBTBKM5XBlrOrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=YWH/Rviy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VATZR3CP; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="YWH/Rviy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VATZR3CP"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E6C5314000A9;
	Tue,  9 Sep 2025 15:46:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 09 Sep 2025 15:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757447219;
	 x=1757533619; bh=v7ux1V6cn9+g6eFm1EYDn/IpjjTZmf6bIBxsuXSD+Z0=; b=
	YWH/RviybJH+6TfNU7PQas7iaKqwwR2eVyuIHafeS52OZbeK5/4jbhiSyL9AaBNa
	0ZWBxGtcD3m3L34LDD3FDQnX6dOdiWpsBPtRn9+0ngtWCsuBTaHaLNiShXbrLIZg
	h/ctpLq3E55Giu5FF5XhigNxKgZqTTYOCgdCzxBEbKHxvMpYpuYykl7kEazd2iVE
	STkun1v/4nvXGIPNfPi1qDM0nbOFMFGX5PzYTII/W7RiI7UyuCzynMD0VwKWM10y
	9BvR2bEqBkp9YmHN0wAzCWr9zlA+XZmPHOe98CxMhhhmWIea1zWPULVNbhKZIwM4
	86rhTTzA8rDrjYI+gnB0bA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757447219; x=
	1757533619; bh=v7ux1V6cn9+g6eFm1EYDn/IpjjTZmf6bIBxsuXSD+Z0=; b=V
	ATZR3CPXC0xsyWDE4b12kgkbLhqH06VyN4b+0H72y+qGe2KpHkI+o5gTwUcxWzaV
	K3U8tYE+BZ1Ma6Si+CeuhLmbcYDsDl2YXN6PAFWScTLkzI47yY9/9YZfCU1BSKGk
	//Dojnaxss5dwaWPi6QWh8HHoWXU7wcN/BP0olWFNUibWU9GNTSQcqqzAbqtf9VC
	8RtLgX3127RFUjdbqiuEf/qnczHgRiKW4cUSxk9iQJRCf6KZpQOLuPGvRhzyiDKX
	KgkORIocgOiArChwDjQ2Kn2Zixt2vJhrTRQC3f/CJrT7b6pSoLhvGCCsumqL59WR
	YUK8iSa2rx4EzgPtSHVeA==
X-ME-Sender: <xms:MoTAaB7_bRUif4vlCcnwolPK_EfHnCvhhoRXSYusnsTud3cSn5WK5js>
    <xme:MoTAaKYmxcmwQOcvrupKlOuWCBxb7jHi4_59a2J4qDcc0M8QDZOr-HzOUAOaMzyEg
    KUS7beaxmWGj3NEXw>
X-ME-Received: <xmr:MoTAaO7CUyTe8tyQe9OKVnFallcMr0fauDHYQvXg87ZZ5YcN-pR2Gdk2Qe5JQkRvznNpwtUnZRiZJZ2ZiiW8aLIWRPzcHFN6tAmXEnq15yvjX2FCketcgGaIEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvuddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvg
    hrnhepudelgfeuieeuteekleeifeegudefheetkefhjeffkedvueehtdevhfekieekhffg
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhk
    sehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehsuhhnsh
    hhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepphgvfhhfsehpvghf
    fhdrnhgvthdprhgtphhtthhopehpshesphhkshdrihhm
X-ME-Proxy: <xmx:MoTAaFCQSQWoFRqHaxsxTmau0bILv6jdKgoePsNETfJ6CTdqiRX4mg>
    <xmx:MoTAaMertsUT74dVQ9D9XYUP9jmzPlFt_oK5KEhWmDQgTgJtmf2UmA>
    <xmx:MoTAaMI1yZA2Cz3r08i7oQ0t59hVv-qwvDOYYzy7cprvWuZrW1YhsQ>
    <xmx:MoTAaP1wQS453W3PXGpupxljGPj6RWJH3IR4x0QLGsO5viwlQ4Tvtg>
    <xmx:M4TAaKdK-dEc7b579KzUFIlnuw4ABmZqly5-Zq5d_PG1uVLcB8Sv8VDp>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 15:46:57 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Eric Sunshine <sunshine@sunshineco.com>,
	peff@peff.net,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 2/7] git: allow alias-shadowing deprecated builtins
Date: Tue,  9 Sep 2025 21:45:52 +0200
Message-ID: <672253e0e7167c40290d1fef6d5076adfbe25d80.1757446619.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.16.gcd94ab5bf81
In-Reply-To: <cover.1757446619.git.code@khaugsbakk.name>
References: <cover.1757345711.git.code@khaugsbakk.name> <cover.1757446619.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

git-whatchanged(1) is deprecated and you need to pass
`--i-still-use-this` in order to force it to work as before.
There are two affected users, or usages:

1. people who use the command in scripts; and
2. people who are used to using it interactively.

For (1) the replacement is straightforward.[1]  But people in (2) might
like the name or be really used to typing it.[3]

An obvious first thought is to suggest aliasing `whatchanged` to the
git-log(1) equivalent.[1]  But this doesn’t work and is awkward since you
cannot shadow builtins via aliases.

Now you are left in an uncomfortable limbo; your alias won’t work until
the command is removed for good.

Let’s lift this limitation by allowing *deprecated* builtins to be
shadowed by aliases.

The only observed demand for aliasing has been for git-whatchanged(1),
not for git-pack-redundant(1).  But let’s be consistent and treat all
deprecated commands the same.

[1]:

        git log --raw --no-merges

     With a minor caveat: you get different outputs if you happen to
     have empty commits (no changes)[2]
[2]: https://lore.kernel.org/git/20250825085428.GA367101@coredump.intra.peff.net/
[3]: https://lore.kernel.org/git/BL3P221MB0449288C8B0FA448A227FD48833AA@BL3P221MB0449.NAMP221.PROD.OUTLOOK.COM/

Based-on-patch-by: Jeff King <peff@peff.net>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v4:
    
    Better `is_deprecated_command` implementation.
    
    v3 (new):
    
    Prerequisite for telling the user that they can alias `whatchanged` to
    `git log --raw --no-merged`.
    
    Link: https://lore.kernel.org/git/cover.1756311355.git.code@khaugsbakk.name/T/#md434b0968f499263262fb1805d82b788b8349d9a
    
    > I think that is good advice, but... it won't do anything until we
    > actually drop the whatchanged command, since until then we'll refuse to
    > override the command (even the crippled --i-still-use-this one).
    >
    > We'd need something like the patch here:
    
    ❦
    
    The
    
        test_file_not_empty expect
    
    is here because the git(1) command could fail.  Make sure that it did
    indeed output anyhing on stdout.  (Or if a previous redirect to `expect`
    outputted something it should be completely different to `actual` in any
    case)
    
    I don’t know if this is just a waste.

 Documentation/config/alias.adoc |  3 ++-
 git.c                           | 19 +++++++++++++++++++
 t/t0014-alias.sh                | 17 +++++++++++++++++
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/alias.adoc b/Documentation/config/alias.adoc
index 2c5db0ad842..3c8fab3a95c 100644
--- a/Documentation/config/alias.adoc
+++ b/Documentation/config/alias.adoc
@@ -3,7 +3,8 @@ alias.*::
 	after defining `alias.last = cat-file commit HEAD`, the invocation
 	`git last` is equivalent to `git cat-file commit HEAD`. To avoid
 	confusion and troubles with script usage, aliases that
-	hide existing Git commands are ignored. Arguments are split by
+	hide existing Git commands are ignored except for deprecated
+	commands.  Arguments are split by
 	spaces, the usual shell quoting and escaping are supported.
 	A quote pair or a backslash can be used to quote them.
 +
diff --git a/git.c b/git.c
index fca6ebfce3d..b3aafebfe4c 100644
--- a/git.c
+++ b/git.c
@@ -801,6 +801,12 @@ static void execv_dashed_external(const char **argv)
 		exit(128);
 }
 
+static int is_deprecated_command(const char *cmd)
+{
+	struct cmd_struct *builtin = get_builtin(cmd);
+	return builtin && (builtin->option & DEPRECATED);
+}
+
 static int run_argv(struct strvec *args)
 {
 	int done_alias = 0;
@@ -808,6 +814,19 @@ static int run_argv(struct strvec *args)
 	struct string_list_item *seen;
 
 	while (1) {
+		/*
+		 * Allow deprecated commands to be overridden by aliases. This
+		 * creates a seamless path forward for people who want to keep
+		 * using the name after it is gone, but want to skip the
+		 * deprecation complaint in the meantime.
+		 */
+		if (is_deprecated_command(args->v[0]) &&
+		    alias_lookup(args->v[0])) {
+			if (!handle_alias(args))
+				break;
+			done_alias = 1;
+			continue;
+		}
 		/*
 		 * If we tried alias and futzed with our environment,
 		 * it no longer is safe to invoke builtins directly in
diff --git a/t/t0014-alias.sh b/t/t0014-alias.sh
index 854d59ec58c..89bedb9f73b 100755
--- a/t/t0014-alias.sh
+++ b/t/t0014-alias.sh
@@ -55,4 +55,21 @@ test_expect_success 'tracing a shell alias with arguments shows trace of prepare
 	test_cmp expect actual
 '
 
+can_alias_deprecated_builtin () {
+	cmd="$1" &&
+	# some git(1) commands will fail for `-h` (the case for
+	# git-status as of 2025-09-07)
+	test_might_fail git status -h >expect &&
+	test_file_not_empty expect &&
+	test_might_fail git -c alias."$cmd"=status "$cmd" -h >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success 'can alias-shadow deprecated builtins' '
+	for cmd in $(git --list-cmds=deprecated)
+	do
+		can_alias_deprecated_builtin "$cmd" || return 1
+	done
+'
+
 test_done
-- 
2.51.0.16.gcd94ab5bf81

