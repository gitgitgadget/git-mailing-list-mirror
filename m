Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C1C1EF385
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 15:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740756375; cv=none; b=M5sRY8j0ibAkE84EpsoEXpX4Ohq1CHfskAAunOC+bvDXs/dQRAgJxuQJ0TbhgZtp5hoz7elfs53u5MKjZySkwRNQ1OvIZUYu4yjEWC8pKgG+MCUo+Dd7nMS4nZJpGMS7msiDzp/mlpZHKVl5JY08YoXWvQ8y52ko6NpQju1qTFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740756375; c=relaxed/simple;
	bh=1dfEJ8d2imnUwhxLa2+4ZBO5wTFEmX07mcQdFnawe6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oEHP01WbgvowRssfSEQnJ8eXV3qJ+mEHN2N0RxRKTSBMF4OMWolipRpJiNczcfG7uy4o3EKDxeMV9nPbi2CsuYtKlMTpW7JEPvlPL0p/0A+4eLE2ge7WnOSFZ8KEPlfhj+WNOu9WpznFOkxV1wMBlpOpxqHzYsbguwJoFgjyedU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=S447GZ88; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KdlV+iZq; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="S447GZ88";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KdlV+iZq"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1B8462540131;
	Fri, 28 Feb 2025 10:26:12 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 28 Feb 2025 10:26:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740756371; x=1740842771; bh=01OPBQszZE
	Al+Z4w2DxA5DowFRIoxvus498nx5kRW3M=; b=S447GZ88kQ4PXcunYDoY7qCM0A
	owqL1zvCa910jH2U3ZnJLSCWXOT14Psajg1yAYKLYimjnnXOp0wXfES+TkWUvrFf
	0RpuzQ+LVjBe+gn3V0PhlvaDzYJh1HN3takczL7uS6L06AGjX5diD5iJbydupJql
	5HN8E6McWi5BXCaSS8Xi307g0RpRZDnWcaRKIEq86mYoaFmgu6kIBjF2mkHgNwF4
	def0F0m2K4CgShF0hyUheZ6V/aZ0mqXwa/ai9kLcacB7xxNPNmMirCBf9UQTHpwo
	buL2FX7AigvhcXy75pb3O60NiUgMXo/6tw18U5s1OwwMy8qJA09njgx2oIEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740756371; x=1740842771; bh=01OPBQszZEAl+Z4w2DxA5DowFRIoxvus498
	nx5kRW3M=; b=KdlV+iZqNHJkcN2SFlCxXxzhdbPbvqM6BM7nL4lELMJIEq9fCO3
	uxc/h6CPd/30dWYjWpCUt+0n5aL6kXqCPTGRuyx3DpGVI8Q0sU/BoT1ctYPOS8F+
	gI41IuPLkjQfgm7z1lehWxP4NF4C9PXNosLH3Tv9nNAonjurPgSADaFX8/Mo4N/+
	D2bAXSLnB7aVRfXECRKRZO2symzkKe3HY0eowuHj0UG5dYwDDF18IBodBpIGFtHR
	k0k9rXvA67s/BhZCiN/0vyMdPcJI8ahl6fOngf9wvB2mFDzmoK8GcDT6FY67gB5o
	nNGNBLQw+2mLeQWbbY5LW7PZSPpp102wpaw==
X-ME-Sender: <xms:k9XBZxKDjo6HzdhDLR60y0sTkNBGAXXdIAZIu1CsCm652qJdJx4ypg>
    <xme:k9XBZ9IW_nQlanYmmYVXU0NDh68xsQfL9rfwEr-15mx3rcb4qrHHn7cMkBYN1PfVc
    poo14MTIszHALbfMQ>
X-ME-Received: <xmr:k9XBZ5u7qDVVNBGOK4abtbUpv9ubTzWDxHnr9R9zhhpajFM_Mi1getSn8jBDC8SnzHNHBgxBosifonzb4UI7rBp9phtDHj-wI_xWyQr6YeDj8EDoF9Ek>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeltdejgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefvohguugcukghulhhlihhnghgvrhcuoehtmhiisehpohgsohigrdgtoh
    hmqeenucggtffrrghtthgvrhhnpeejffeljedtgfffleeuveeiuedvteekvedvgeefffdv
    keetgfetfffhueekheeuleenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhmiiesphhosgho
    gidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehfihhvvgdv
    fedutddtfeesghhmrghilhdrtghomhdprhgtphhtthhopegvsghivgguvghrmhesgihmih
    hsshhiohhnrdgtohhm
X-ME-Proxy: <xmx:k9XBZyaPLBOpID2f0paPFNgHQMlsHoUnlC6AaehaTrDqJmYdZh7RiA>
    <xmx:k9XBZ4bb4Fn-g-WfoQqPgR9sd0NSDfznitnSnCyT5rqM2Om0a1CUCw>
    <xmx:k9XBZ2B4Zl69BHfYn279i_Tp-itmKraspHw6zSWGLIQuUJFWM_uryQ>
    <xmx:k9XBZ2YS5ezgeLLQllgvqZFmeuOKPR8IhmsWhPerlVAohPDDoQGtoQ>
    <xmx:k9XBZwGKgbvElXLDeAbaLKNMhhdVRGA2Bmb2O0qqKvfWfPU2P6cc3nDx>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 10:26:11 -0500 (EST)
Date: Fri, 28 Feb 2025 10:26:10 -0500
From: Todd Zullinger <tmz@pobox.com>
To: git@vger.kernel.org
Cc: Kousik Sanagavarapu <five231003@gmail.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 0/2] t/lib-gpg: ensure GNUPGHOME is created as needed
Message-ID: <Z8HVkqqD054QGPIE@teonanacatl.net>
References: <20240703153738.916469-1-tmz@pobox.com>
 <ZoV8b2RvYxLOotSJ@teonanacatl.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoV8b2RvYxLOotSJ@teonanacatl.net>

Hi,

I'm following up to an old thread because this test breakage
remains.

I've intended to dig into it further over the past few
months but have not managed to spend enough time to work out
the root of the problem.

I hope that someone more familiar with these tests (or
perhaps someone with fresh eyes) will spot the problem.

I wrote:
> I wrote:
>> 92 of the 202 tests in t1016-compatObjectFormat.sh are skipped due to
>> the GNUPGHOME directory missing, e.g.:
>> 
>>     ok 5 # SKIP create a sha1 signed commit (missing GPG2)
>>     ok 6 # SKIP create a sha1 signed tag (missing GPG2)
>>     ok 8 # SKIP create another sha1 signed tag (missing GPG2)
>>     ok 9 # SKIP merge the sha1 branches together (missing GPG2)
>> 
>> With these changes, they are all run (successfully). :)
>> 
>> I presume that they have been skipped in the Github CI runs as well,
>> but I don't know that the logs show enough detail to confirm that.
> 
> D'oh!  I spoke too soon.  I'd run the test suite on several
> different rpm-based hosts (Fedora 39 and Rocky 9).  Waiting
> for the Github actions to run is what I should have done.
> 
> A number of these fail, e.g.:
> 
> https://github.com/tmzullinger/git/actions/runs/9780387020/job/27001952643#step:4:1871
> 
>     Error: failed: t1016.173 Verify commit signedcommit4's sha1 oid
>     failure: t1016.173 Verify commit signedcommit4's sha1 oid 
> 	    git --git-dir=repo-sha256/.git rev-parse --output-object-format=sha1 ${sha256_oid} > ${name}_sha1 &&
> 	    test_cmp ${name}_sha1 ${name}_sha1_expected
>       
>       + git --git-dir=repo-sha256/.git rev-parse --output-object-format=sha1 5d70155cc40e4c16515c89ad0b11d8c691436fc4a4d3ca246669a4c21f07e454
>       + test_cmp signedcommit4_sha1 signedcommit4_sha1_expected
>       + test 2 -ne 2
>       + eval diff -u "$@"
>       + diff -u signedcommit4_sha1 signedcommit4_sha1_expected
>       --- signedcommit4_sha1	2024-07-03 15:11:05.597537579 +0000
>       +++ signedcommit4_sha1_expected	2024-07-03 15:11:05.553537766 +0000
>       @@ -1 +1 @@
>       -9179ccc5b15588bc3a45c5cc75bdec380f8ccb86
>       +c6c46f92bc2cfda57ad6bf7981fa654825376b24
>       error: last command exited with $?=1
>       not ok 173 - Verify commit signedcommit4's sha1 oid
>       #	
>       #		git --git-dir=repo-sha256/.git rev-parse --output-object-format=sha1 ${sha256_oid} > ${name}_sha1 &&
>       #		test_cmp ${name}_sha1 ${name}_sha1_expected
>       #	
> 
> This seems like it's just exposing a pre-existing failure,
> as I can't imagine how creating GNUPGHOME would cause the
> actual and expected SHA's to differ. :)
> 
> Perhaps the intended gpg wrapper script which sets
> `--faked-system-time` isn't being used?
> 
> I'm not sure why that would differ in the Github actions
> from my local builds, but I don't know what else differs in
> the Ubuntu images and/or environment used by the actions.

I have run a good number of builds with the patches applied
and t1016-compatObjectFormat regularly fails for all of the
tests which use the GPG2 prereq.  A recent Github CI run is
here:

    https://github.com/tmzullinger/git/actions/runs/13570544425

I think this test flakiness should be fixed so that we can
apply the patch to fix the GPG2 prereq.  As it is, we're
skipping _all_ of the tests which require GPG2.

Cheers,

-- 
Todd
