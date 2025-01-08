Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F1112DD8A
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 18:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736360205; cv=none; b=oPIBKwNLqmEpG88L8BmqtRtoHfET/QIGXTBKOstB0LdUqoiByllTKFtNO4rj9EufVXXkcMZZXDRuocrjtp6iAhPU2BpEPPgi+uxtJZWhol4EOlboQEwQ/fiRSGvOR3i/djwpsru8RBmf6LnMz2IeLAq6FOTa9V/RPdxT9qHSqcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736360205; c=relaxed/simple;
	bh=SFr7mUKpmDZfPZ1PftaIqpGHFI5/Gz2GRmga+yQ8Egk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TWBlfenMTNiFQrOpdnHfPRN8Vboz1CIcebkEwIy6TIjTUuPLEKXcoR6IO7/agkmMGBFq0DWm/5seeoeKXmppNiIuQHDBw1s5UOOAwLxVuXfjZw0Pm60V/vqPdF3d447XdNCwxCnOfCRyI1tXceUZJYHNR5ijwclPOqE4+Iyv3rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=k6cMj/aF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qPdILPkj; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="k6cMj/aF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qPdILPkj"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 874D4114023E;
	Wed,  8 Jan 2025 13:16:40 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 08 Jan 2025 13:16:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736360200; x=1736446600; bh=6By0Sqkaw6
	53arblBqKSG5mXBygfkZKbm97Zj8vmOQs=; b=k6cMj/aFIfWF+bJIuieZTscD0Z
	7dB5H/Ul8lMGxgsyunGeglvgcNd7Dn+7PVuWCDSnPQyEzqC2m2Dpmksh9ACwof0Y
	7H940HnlzTYHb8WrMk32+6CJ1kGS7Et7Dx6t1k3lTGqTKPrkvqLQbrqnYKkav60v
	dH1bPE/MMA4cFcVWUYa2LKSpauaZ1pgNaLQ69k8EIhsli9MK3VKvb55ZqFF6KswV
	OS4pIpOSjftcPPT5xLnDKK39UbkEh9lA7sfeaiJs0A8MYXQCYUvPLJB0isELBNks
	XDrDkwEWd0iA38WKPJmGBQgSZtA4KdzH1fURkgX2tpVsay2uCBpJnnf7qkMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736360200; x=1736446600; bh=6By0Sqkaw653arblBqKSG5mXBygfkZKbm97
	Zj8vmOQs=; b=qPdILPkj28WkbfMXOb3fMvNAzB4vUdXqVhKsqkTp+2efANogyBq
	DRltTJu7Kv0VbN2WqrpiDs1HSg2HCiXYr2sQuOZLe02HuV+wGQFDiKYK+4omrvtF
	L8V/+OAJ18fZeE86VrVnQWLHu5DwugsKPjYR814mpklDgxNn/W4mFYRdbYn6qTgQ
	zUz6wIghpV37cuS70iBvlbO2nNL5mh3AxvJ8eBG8s3uZkxCsl9LNTZQmG2Vkila9
	80jUTjsr5TWVfR3YFavwzJi4FNaGU+PCv/X++zjsLRgB57Lsa9h3rAbcngNYjI/f
	QrN8l3cnOURNuC8GdIkAAHR2GzfriHqmAUA==
X-ME-Sender: <xms:CMF-Z-mSKgkra_tuekUZP5vITk13Qz9qY9oxz6aPC2oAueiUpvJp_w>
    <xme:CMF-Z13_3-vFWvfOYuYI8fR9sVn_NJFTj5wZhq_6AIC-sScdEhQlZWxOYxbRKzZRH
    qwpSSsKQ21jgL6OMA>
X-ME-Received: <xmr:CMF-Z8qg6bRcS-gYlKbsXDaEgaF3TkD29rLeXVE0QdBJBr3mWWdqnMMuAJeB1PY3Y3Mg4pR_LU5ymWnj2dvjlCNP6wNDdj9gwZQ-WG6sVI9I7g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeggedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkefhteegffeikeejjeeiuefhueejffeuvddvleej
    hfekheeugfffleeludekieenucffohhmrghinheplhhishhtrdhnohifnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdp
    nhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheprhgrnhgurghllhdrsggvtghkvghrsehnvgigsghrih
    gughgvrdgtrg
X-ME-Proxy: <xmx:CMF-ZyleCpnHRpQB3cSdLu-ZsaTiYeTzOeNNLF9B1k78Y4pgvGw3rA>
    <xmx:CMF-Z82xEhLEA_EdQnUNIu0m4YWncKhpmag-33TPa34_DYMrQTqhfQ>
    <xmx:CMF-Z5t-lq1XBksZ2s76ITSDMQFNKIGUz9QxBNe3S_fBQawec98vBQ>
    <xmx:CMF-Z4W7VLKdx1b-uGlB9ZTqZSIHGONwOypri6_JmoCp_XKbTa_JFQ>
    <xmx:CMF-Z5z8F1DjSWVcwu4kpUoja_RG0XB8qYt6J-UVd4FKsONpZGU5htX6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jan 2025 13:16:39 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b1dc09ed (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 8 Jan 2025 18:16:36 +0000 (UTC)
Date: Wed, 8 Jan 2025 19:16:35 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "Randall S. Becker" <randall.becker@nexbridge.ca>
Subject: Re: [PATCH 2/2] reftable/stack: accept insecure random bytes
Message-ID: <Z37A_d9mAnKtGNcU@pks.im>
References: <20250107-b4-pks-reftable-csprng-v1-0-6109a54a8756@pks.im>
 <20250107-b4-pks-reftable-csprng-v1-2-6109a54a8756@pks.im>
 <xmqqzfk2qr62.fsf@gitster.g>
 <xmqqv7uqqqu9.fsf@gitster.g>
 <Z34gfa-_dSbWD19h@pks.im>
 <xmqqr05dnwli.fsf@gitster.g>
 <Z36l--QUjaYYb6Uf@pks.im>
 <xmqqo70hmcet.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo70hmcet.fsf@gitster.g>

On Wed, Jan 08, 2025 at 09:40:58AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Hm. The problem is when Git dies in the middle of a transaction:
> >
> >   1. We write the temporary table.
> >   2. We compute the not-so-random suffix.
> >   3. We write the temporary "tables.list" file.
> >   4. We move the temporary table into place using the not-so-random
> >      suffix.
> >   5. Git dies before updating "tables.list".
> >
> > Now we have the temporary table moved into place, but "tables.list"
> > hasn't been updated yet. When the next Git process comes along and wants
> > to update the table it would result in an error if it computed the same
> > suffix.
> 
> Here, I hear that we _do_ depend on the suffix being relatively
> unique.  Once our random number generator decides to give the same
> number twice to cause collision, the reftable data gets corrupt?

No, there is no corruption. We may fail to update the stack when there
are colliding files, but that's it.

> > The reftable library knows to clean up such stale tables when not
> > referenced by the "tables.list" file, but it doesn't do so on every
> > write. So this would likely still cause issues in practice.
> >
> > I already though about this scenario when writing my mail, but didn't
> > really think about it as "correctness". But I guess it is.
> 
> Hmph.  I am not sure how I should feel about this.  Our reliance on
> hash functions (which can be made to collide) not colliding is one
> thing, but is it sensibly safe to rely on a cryptographically
> unpredictable random generator not to yield the same suffix twice
> during the lifetime of an previous invocation for correctness?

This is why I've been hesistant to call it a "correctness" issue, as
there is no corruption involved here. It's more of a denial of service
as you may not be able to update the stack anymore until you remove the
occluding file.

But turns out I misremembered from 9abda98149 (reftable/stack: fix use
of unseeded randomness, 2023-12-11): things indeed work alright. To
demonstrate, let's update `format_name()` like this:

diff --git a/reftable/stack.c b/reftable/stack.c
index 531660a49f..b7422679df 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -659,7 +659,7 @@ int reftable_stack_add(struct reftable_stack *st,
 static int format_name(struct reftable_buf *dest, uint64_t min, uint64_t max)
 {
 	char buf[100];
-	uint32_t rnd = (uint32_t)git_rand();
+	uint32_t rnd = 123;
 	snprintf(buf, sizeof(buf), "0x%012" PRIx64 "-0x%012" PRIx64 "-%08x",
 		 min, max, rnd);
 	reftable_buf_reset(dest);

And then we create an occluding file and try to update:

    $ ~/Development/git/build/bin-wrappers/git init repo --ref-format=reftable
    Initialized empty Git repository in /tmp/repo/.git/
    $ cd repo/
    $ ls .git/reftable/
    0x000000000001-0x000000000001-0000007b.ref  tables.list
    $ touch .git/reftable/0x000000000002-0x000000000002-0000007b.ref
    $ ~/Development/git/build/git commit --allow-empty -mx
    [main (root-commit) 08d02ef] x
    $ ls .git/reftable/
    0x000000000001-0x000000000002-0000007b.ref  tables.list
    $ git show
    commit 08d02efa88f085f02c31285bf909d8d3a25c70dd (HEAD -> main)
    Author: Patrick Steinhardt <ps@pks.im>
    Date:   Wed Jan 8 19:03:46 2025 +0100

    x

So the stack gets updated as expected, no corruption there.

But this _can_ be a problem on Windows, where the file cannot be deleted
in case it was still open. This is also documented as the reason in
"Documentation/techincal/reftable.txt". That should've gotten better
though now with the improvements I made to our rename-emulation, as it
now uses POSIX semantics.

That being said, I still don't think that swapping out `git_rand()` for
`rand()` is the right thing to do. It does not solve the issue, but only
a symptom thereof. Git can still die whenever the OpenSSL CSPRNG fails
as there are other uses of `git_rand()` or `csprng_bytes()` in the
codebase.

So this change would regress something that works everywhere but on
NonStop and make the suffixes predictable. The ia64 machine in question
is being EOLd end of 2025. And the fact that this has never been a
problem before v2.48.0-rc2, and that the machine was rebooted for
maintenance immediately before running the tests, indicates to me that
something fishy is going on on that platform.

Patrick
