Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67089190664
	for <git@vger.kernel.org>; Sun, 12 Oct 2025 14:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760279034; cv=none; b=Aw9qlyckd2KuPtW1XBKsiile7N/aXX+A1ySsXIniqkVkF/7wzigRwyRS+8nHV5t7zUV5eRuPxslaWOZF/q0ej31STmjMOcBy/sES2mfgTZF4ZDBFItU//e/ZI7faGFzxtCqsUZBbFKl3pB1CrjbFFB7Mi1eCwHgUrmzDY0xGapc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760279034; c=relaxed/simple;
	bh=j5iDgZXB6IXamJXKOX5TESObulf3z1fF8nS/CKkfUhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZOX4ShYy8YcqUMb+ggR3raSLYpi3MyYDbBuVFpgrwL/EEyioNKES/2BIOL27RgxpBLL0IXhoCss1yzfpza59P/xELwT22PGXL23812RoIZt6/k7ElscTAJkatwreP501QNxeREvQH+H9NyktpYh5vgCoD4jarDXOPikk1hzCgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NafXIu/K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V/jGR4qm; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NafXIu/K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V/jGR4qm"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 835A6EC02E8;
	Sun, 12 Oct 2025 10:23:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sun, 12 Oct 2025 10:23:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760279031; x=1760365431; bh=I/WJ693+sQ
	j4BPoyQbas+E79Jdc+ChzatS7BJMZU8yw=; b=NafXIu/Kc1jBrKYEY7X+oHxG9g
	JsPNBRnK1R681qr6q38l8IKi59tJCR5CVVmM83V9x/FJ6uoK8dXwBTsXBBi8KlMY
	E59Ra4e4PbfEh6XH71q9ug5tr8uI1SQ4Uy0mck4hmZSJCg9D6ku6/5eM/o81pJlL
	/GiZhG2ITl0gZEvEK2uDaZWHaOpzl/C/3UefRVi0oFjta9hmRtPHgraycg80PUTA
	+T6LTO8QoAm+Re/ee5cZEfHTeM8SvPA9TmV8bISxeKpXygGywdwnrUPwzjDOsrtd
	AnQ1i3WCyU2xvvJ7CefAjRlofqATUOJlJqGgceiYUXeC+mjr5RWUiUKjktvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760279031; x=1760365431; bh=I/WJ693+sQj4BPoyQbas+E79Jdc+ChzatS7
	BJMZU8yw=; b=V/jGR4qm8Tp+ZowTYXHv6ZePlHJhjebE+hLLvizzk9a/fqgPOqR
	GfzKfACqdbZ1blQ+woyhfBdqFl31eqEnV4AsCckUrDlzk63BOwH93rMLg4kgRNUK
	8si1XDNS71NAuWulYoHk0vf6LfcrUvqiUWr43ByqhJAbuWKY5z0Vf7QP61NFfWOG
	kGbP/H3mX7VfFLAUh2W/yPrQqEuW1NsajaDSqwKgSCa1X2EzJ+XP5oqC/4loWb9m
	aXhq1I22gUi6EezK3UkQlLzdUIMnOnp5GCPAVo6DoDxZo8FiEPM2ZYqtN0REFYuy
	OHNKi2uDLLuSWVYEbMSRRlV98W2OancagNg==
X-ME-Sender: <xms:97nraEbCdHkleSW8ymtIG2k5q2ueMh-bvji_FR2QmehvhGbxKZRGDw>
    <xme:97nraGZc-Mwl4XnaqoYXQOcvkc_bhAOIxKBOZMUe3oZgNlAlMZMt7Q6ul4k4l_Mix
    dyseZH4ArW0HWHQEMbxqsgSZ1Uqi1EqXHIwM68oKmKwSML68g7Aqg>
X-ME-Received: <xmr:97nraD8JtXh-608KyudbIDAv4RWjIiywxCTmH7hlkCTe7_T1cLzHEJ45cnilPbT8muX7WVF_004Cag13grrgDdzYErqtCj0bPQCm0VZW-vUD8kGotywN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudehtddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefvohguugcukghulhhlihhnghgvrhcuoehtmhiisehpohgsohig
    rdgtohhmqeenucggtffrrghtthgvrhhnpefgveefveeihfehhefhgeethfdvffehfeehue
    elheeiffeuvddvuefhveffiefgueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehtmhiisehpohgsohigrdgtohhmpdhnsggprhgtphhtthhope
    egpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopegrlhhgohhnvghllhesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthht
    rgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:97nraNiXlwxyX8DGhcoMRi-gQHOVxLBeFp2AYezAnV4tAVyGMAIx7w>
    <xmx:97nraLfsWId08Q_2Oz686in70xOhJq6vfP0yxXKGSSSl14Qybhp5xw>
    <xmx:97nraMqB075t22nPfks0rl90RALb1gmBK2VsFCgGfrFRlpj_2oakkg>
    <xmx:97nraIDSzKBnoLjo19ms7eqCf9EGbB-Kq8TJZ0VrzzVElnFRoXH-NQ>
    <xmx:97nraCftNTR1f0qfd-klHypm7EEPJYO6wm68SHAd9IqgvFFeyUPOUjt0>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 12 Oct 2025 10:23:51 -0400 (EDT)
Date: Sun, 12 Oct 2025 10:23:49 -0400
From: Todd Zullinger <tmz@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Andrew Kreimer <algonell@gmail.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] t1016: make sure to use specified GPG
Message-ID: <aOu59eVs7tK6pCoF@teonanacatl.net>
References: <xmqqsefq7947.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqsefq7947.fsf@gitster.g>

Junio C Hamano wrote:
> c348192a (t1016: clean up style, 2024-10-22) fixed a coding style
> violation that has an extra space between redirection operator ">"
> and the redirection target, but at the same time, replaced the use
> of "git config" to set a configuration variable to be used by the
> remainder of tests with "test_config".  The pattern employed here is
> that the first set-up test prepares the environment to be used by
> subsequent tests, which then use the settings left by this set-up
> test to perform their tasks.  Using test_config in the first set-up
> test means the config setting made by the set-up test is reverted at
> the end of the first set-up test, which totally misses the point.
> 
> Go back to use "git config" to fix this.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  * The commit in question was from October last year, and I didn't
>    notice it until I looked at how the test script evolved.  It is a
>    bit embarrassing that we didn't catch it during review.

Interesting.  And well-spotted.

This _does_ seem to resolve the failures in our CI and in
the Fedora build system.  I was able to run a few test
builds.  With this fix, the tests were successful where they
were not without it.

I remember suspecting the gpg calls were not using the
wrapper command in gpg.program.  I even tried forcing the
--faked-system-time for all the tests to check that theory,
unsuccessfully.

Oddly, I ran into test failures after fixing the GPG2 prereq
long before c348192afe (t1016: clean up style, 2024-10-22)
was in place.  Perhaps I was hitting a different issue
initially?  Then, when I looked at it again I didn't think
about gpg.program again, since I'd already tried to force
the gpg wrapper which sets --faked-system-time.

It's both annoying and embarrassing if it is that simple and
I missed it after looking a few times, to be sure.  But I'll
be happy with the end result all the same. :)

>  t/t1016-compatObjectFormat.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/t/t1016-compatObjectFormat.sh b/t/t1016-compatObjectFormat.sh
> index 8341a2fe83..cb6d308f1d 100755
> --- a/t/t1016-compatObjectFormat.sh
> +++ b/t/t1016-compatObjectFormat.sh
> @@ -116,7 +116,7 @@ do
>  		git config core.repositoryformatversion 1 &&
>  		git config extensions.objectformat $hash &&
>  		git config extensions.compatobjectformat $(compat_hash $hash) &&
> -		test_config gpg.program $TEST_DIRECTORY/t1016/gpg &&
> +		git config gpg.program $TEST_DIRECTORY/t1016/gpg &&
>  		echo "Hello World!" >hello &&
>  		eval hello_${hash}_oid=$(git hash-object hello) &&
>  		git update-index --add hello &&

-- 
Todd
