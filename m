Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA37E495AC6
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 12:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790597619; cv=none; b=WPn9Vl0r+Ga/0YBehs03fSGy7flY2bk8aLE5W6a+fxdkCzG0Ecnwj+73PfFIJri3fwrQfR+IN+Thf04voelVZULcRD66m4sMsiEiLs8EHS9HH+B/DJR6585eZhUYTHNUSSiWnBYJQ+H8TrhIIXMdSLhPu+VlYkfQn+yDt5tviL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790597619; c=relaxed/simple;
	bh=O2Uspt758lv7OpSv7i0t7sOFuoEfgRf2xJVLUyF3H8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hq18EAAxuLP6lVl82TC0SKDMPbOBpolsLIAnemXbgJuVAwlZW4wPBW0ALdKhDOpYGRQ8mdcPWeOmn0kUFtBinYtcnq5XtHU8bIRH4OU3T9RhqnUZXRhqrvnxqWmqI37ylMABVx0d+aVAT63Ca+N0nhMSAjRp6bHCLl21mc15iwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RVhsLe7g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OZAd0Sqr; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RVhsLe7g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OZAd0Sqr"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 2CF791D000C2;
	Mon, 28 Sep 2026 08:13:37 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 28 Sep 2026 08:13:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790597617;
	 x=1790684017; bh=aQ68DmMyg8OK2AI8geg0OX1wSk9J1gpc8o9l/H60Yn8=; b=
	RVhsLe7g3mgBlJnmQWrb4yu2WHzWn028KDgx/41ThC5EdL1TIkX1qIAqfCz9f75X
	C+fjzbQuQScHgr31Ti/VmAZ622vk3RZTK28FnzpaD9E+ZEBsn1zHKSoXRl45Fztd
	A4wKrRK4K8bn/fZwdF+VbraGtaWkNXUPVCrp1z7Vq7n5nWymKAuOxnZoDZrcRarH
	z5UMyvFlmEPuVZIsTNUXWTbvvk8tD2iKmwejUQl28YKIestj6IBGler8gGJIXdKd
	XR4atM4nHLionJ0HlVA9aQbQs5ZOcNhNHnYRo3MdEfLGq0Lz75phaVtYF0mv/HCp
	dh4EMC/FyrJ5fcXM/uoICQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790597617; x=
	1790684017; bh=aQ68DmMyg8OK2AI8geg0OX1wSk9J1gpc8o9l/H60Yn8=; b=O
	ZAd0SqrSIJAE/iO6DLO5a3sUpfvaJ740Izb39ELEaXiN6x9Sb2DwCyPx41kQPDud
	uYNueAO+7PcbxK3dcBIqr2nuqKNQdhFeGPxEjizH7tpg5Q+SnXiwTdY8kY1BCV0Y
	32wX3/bnAhI/2XpepKM2eNxiX2PcVdQsvvSaQr+lIxiQcqvFRGb/82dIEvmjNrTw
	ojuVLV2dF0BbAfNA9s0Yo2cPbOFMxtRJXfA2R6HM3P3b5YvgRXVbapu5ByfUnbmy
	OdcD9MH/kYuRFEsr7IhXcArn6bj/TcP+XQChdH0vSSPCFn8DG7vnJAeOzCaaNwmf
	ia5HVdQLrJhr8jh3xFy8Q==
X-ME-Sender: <xms:8Fm6aotm-79lVilc_oyKd21EbyfUoXNF5_0igq6pkmOVKmJzVC5U7Q>
    <xme:8Fm6ajbUKdY7Wfgt3p2kTsj4sP0A8KWFavKcAP33r5l0oq1PaKiL9gLDeZXkTKLqK
    YUyIGYA_kdgtx-_3qd41CnwXGFb9K_pPmvIOUGUjthvg8niP3iNqBA>
X-ME-Received: <xmr:8Fm6arVcBiTRc7aAwdcVIC3sWcdWhlLuky1QRQwiFuKeQDkFEq2lIQ>
X-ME-Proxy-Cause: dmFkZTGdYKmw0RHFmQJEzfoq84JEC52Obqs19Ti2uh1PxjML8wiU08Fay3w0zK8gIKgyaI
    L+52jlduWu8hZ4/zGBDjimlpaVdfNKjEiFj7aynqGsD1Xs4cLmb3x6UPJq+GzXQQ/WAsQ2
    k0fqU3rhkNNbyfngwHh4dPozf6ZbWaeJ6iIZeR4PZh/Lkk5ipgGy++SjjNao9+4gALW5DO
    A+fjhU+ALn4gETd2YPiichuku4vo01uwkAR8FIXC2OcT9vA1PHe/dK5RG9dtEkJFUQm7SH
    O59Gzk8MIhOe/eaO0kqft21Erp/sPW6sTqUboaYGy1VxKUYiDtq9hxrdgd7Jm3K9HoAOA7
    uZJoX1TWfQjZUVD7iBQvm02Bfe6+COTK2hk9OTH4WI3hz5YQrdGse7c1bJQtjWTAduVZ0C
    L4mTdr2pRzg+DUuCABEzNJ4GXXZMHaNOhhXW1boCnHAg4VcHRVC1id5fLIyeHvKfvBDz/q
    RgxNQL5m587AMnoLBu2tAB60GD3rXppXzQwm4qeyhy6HaE6YHskKbXhVhHcUHVrFBGkFvW
    xwgJnJu8aFOSWObPMDMCzIIR82ST/qAuuLAPyWP9gGI++j9ir7HRheLL8k75LEjR7Q2E0k
    FJ9yr+L4icyoS/akpXg1L72nJD3vnEJpFtEy50kJbWD0EmXzrt/FiyyJ8Mzg
X-ME-Proxy: <xmx:8Fm6an4CdBgYtUK5VcXjah8o3nilH_PYRQ4QGECQcZmUkbxiLV1XXg>
    <xmx:8Fm6amj2Xg8j2BL81LWuVOcfbOuErzL9ebf7bQXTQOu2BaIFSUuwYA>
    <xmx:8Fm6audRguYOPG8zqdvJkTKfB-bB_zF3Kl2Pe0Ol8842l77Jq0BAlw>
    <xmx:8Fm6ardxhEKOIStbC2H63a_iHb8GjYdEUYLteDoofXTxhQiOy_-cJw>
    <xmx:8Vm6arrxh8r3dsvDVaF12dzgqK2YBPCUMZ9MYlatfLowaFhCPThTXqbV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 08:13:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fe449ffb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 28 Sep 2026 12:13:34 +0000 (UTC)
Date: Mon, 28 Sep 2026 14:13:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Josh McKinney <git-bugs@lists.joshka.net>
Cc: git@vger.kernel.org
Subject: Re: Reftable reflog timezone encoding differs from specification
Message-ID: <arpZ5xCwFXc9ikrj@pks.im>
References: <85f7daa8-d60b-4348-ac2f-b1a68628af7b@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85f7daa8-d60b-4348-ac2f-b1a68628af7b@app.fastmail.com>

Hi,

On Mon, Sep 28, 2026 at 12:00:43AM -0700, Josh McKinney wrote:
> Hi,
> 
> Git 2.55.0 appears to store reftable reflog timezone offsets as signed
> HHMM integers, whereas the specification requires signed minutes.
> 
> https://git-scm.com/docs/reftable#_log_record states:
> 
>     "tz_offset is the absolute number of minutes from GMT the
>     committer was at the time of the update."
> 
> The specification also gives GMT+0230 as an example encoded as 150.

Oh dear, that's indeed the case. I was able to reproduce the issue, as
well.

> I reproduced the discrepancy on macOS arm64 by creating a SHA-1
> reftable repository and committing with this date:
> 
>     2026-09-27T12:00:00+05:30
> 
> An independent Python/zlib inspection of the resulting reftable found:
> 
>     Stored timezone bytes: 02 12 = 530
>     Expected signed minutes: 01 4a = 330

Yup. It's plain wrong the way we store it.

> Both HEAD and refs/heads/main reflog entries contained 530. Git reads
> its own entries back correctly as +05:30, so its writer and reader
> appear internally consistent, but disagree with the specification.
> 
> Here is a reproducer using only Git and Python's standard library:

And here's a Git reproducer:

diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index fc49fafc34..e3cfb6a3fa 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -103,7 +103,16 @@ static int dump_table(struct reftable_merged_table *mt)
 	if (err < 0)
 		return err;
 
-	algop = &hash_algos[hash_algo_by_id(reftable_merged_table_hash_id(mt))];
+	switch (reftable_merged_table_hash_id(mt)) {
+	case REFTABLE_HASH_SHA1:
+		algop = &hash_algos[GIT_HASH_SHA1];
+		break;
+	case REFTABLE_HASH_SHA256:
+		algop = &hash_algos[GIT_HASH_SHA256];
+		break;
+	default:
+		die("unsupported hash algorithm: %d", reftable_merged_table_hash_id(mt));
+	}
 
 	while (1) {
 		err = reftable_iterator_next_ref(&it, &ref);
diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index 35e98b43db..e1d714077c 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -1163,4 +1163,19 @@ test_expect_success 'writes do not persist peeled value for invalid tags' '
 	)
 '
 
+test_expect_success 'writes do not persist peeled value for invalid tags' '
+	test_when_finished rm -rf repo &&
+	git init repo &&
+	(
+		cd repo &&
+
+		export GIT_AUTHOR_DATE='2026-09-27T12:00:00+05:30' &&
+		export GIT_COMMITTER_DATE="$GIT_AUTHOR_DATE" &&
+		git commit --allow-empty --message "Timezone example" &&
+		git refs optimize &&
+		test-tool dump-reftable -t .git/reftable/*.ref >table &&
+		test_grep "log{HEAD(2) C O Mitter <committer@example.com> 1790490600 0530" table
+	)
+'
+
 test_done

And yes, the test-helper for reftables is broken, so we also have to fix
that.

[snip]
> Is this a known discrepancy?

No, it's not, I wasn't aware of it at all.

> Which representation should interoperable implementations use?

We should use the one that we have in our specification, so in my
opinion we should fix Git itself. This is also because JGit, which had a
reftable implementation for far longer compared to us, implements the
specification correctly:

	private PersonIdent readPersonIdent() {
		String name = readValueString();
		String email = readValueString();
		long epochSeconds = readVarint64();
		ZoneOffset tz = ZoneOffset.ofTotalSeconds(readInt16() * 60);
		return new PersonIdent(name, email, Instant.ofEpochSecond(epochSeconds), tz);
	}

You can see that we indeed treat the integer as number of minutes there,
as expected.

> If either the implementation or specification changes, how should
> existing tables be interpreted, given that values such as 330 are
> valid under both interpretations?
> 
> Given that Git consistently writes and reads HHMM values, I suspect
> the practical resolution is to update the specification to match
> existing behavior. Are there other implementations or compatibility
> considerations that would prevent that?

That's a very good question. Given that JGit interprets the value as
expected my take is that we should fix this in Git and keep the spec
as-is.

The question is how much we really lose by "just" fixing the bug. Sure,
timezones would be wrong in that case. For example, if we had an entry
with original timezone of +0200 we'd now interpret that as +0320. It's
of course wrong given the original intent, but is it the end of the
world? I dunno. Overall, the amount of damage is kind of limited here as
the discrepancy is limited:

  ┌──────┬──────────────┬────────────────┬───────────┐
  │tz    │HHMM encoding │correct minutes │divergence │
  ├──────┼──────────────┼────────────────┼───────────┤
  │+1400 │1400          │840             │560        │
  ├──────┼──────────────┼────────────────┼───────────┤
  │-1200 │-1200         │-720            │480        │
  ├──────┼──────────────┼────────────────┼───────────┤
  │+0530 │530           │330             │200        │
  ├──────┼──────────────┼────────────────┼───────────┤
  │+0000 │0             │0               │0          │
  └──────┴──────────────┴────────────────┴───────────┘

We could of course retroactively declare that version 2 of the format
uses the syntax that Git uses right now. After all, JGit only knows to
read version 1 of it anyway, so that could kind of fix it. But for any
repository that uses SHA1 we used to write version 1 anyway, so this
does not really buy us anything, I'd claim.

In summary:

  - We have an upper limit in divergence of <10h.

  - This only matters in the context of reflogs, we don't use these
    anywhere else.

  - The risk for data loss by a change is limited as our default grace
    period for garbage collecting reflog entries is 30 days.

With these points I'm inclined to call it a bug and just fix it, without
handling backwards compatibility.

I'm very happy to hear alternative takes though.

In any case, thanks for your report!

Patrick
