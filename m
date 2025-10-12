Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7D117BA1
	for <git@vger.kernel.org>; Sun, 12 Oct 2025 18:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760293886; cv=none; b=H5xA2MFYsT+rXmZ8ljwpycwe6y0k/L9ezkqtPGmUQExakMvvCV1b+1EhjpUtmR5ZpqySBiNt/EXAIWkxapGR6/17cM+vg80stf49eClRyeVswg85JzlFZxnd80IfzPvHbmcEW5UKoIYkNlvkqjklZEsrjtjFuRbZ90JpJQcy2p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760293886; c=relaxed/simple;
	bh=kpj/tcvoNvgdfZj/T2ThGr6gkkR5iAJwtqw4jfPUA6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qng8+CJCDwrb3S8s9xFlYlVtwWu3ymBgqqFr5fiFChNzfwkLQS0a3meWjoIsNYhUlYaeF8Izk7DxYpHe4yjTohOmYAwYXbLejadqI3gmpnNXf/3zzJIOgA6KejCyhCObTFh07UMaz7Ppq2ba+Aq/U/FLwtVlmp24ULWFC1qBra0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IMOggJPA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mf255KXL; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IMOggJPA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mf255KXL"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 30E187A00D4;
	Sun, 12 Oct 2025 14:31:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Sun, 12 Oct 2025 14:31:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760293883; x=1760380283; bh=WywBBNmKUd
	qL7zA8z85UBmycVczc8W1eyhCOQfB0Ub8=; b=IMOggJPA0zm85N80WI30tmpGy3
	h9MngoJNU3CQYXiCPIA8gClbJdpjkXEgLjYJyQXxYF0hYOWCEzL8inKCoee2Ilrw
	c7yJo6D9SR2RxNN+kEtX7yoNnz2539ngbgNK1T5KseYIegFByI8hhA2KlwXVbF3Q
	J5gmxNOnk/IRm2O0rgpIL7IhL8Bb6OSNJdRAmQhg5VI66CXI5pfmTTYJxwbf/p8F
	gn5pDZ6p7ffdRkEagNsk5yQcppsAaZkGdG5oZlacw/GyWfeKjBKe6HBfGAlQy6uO
	gRSQRKuy0rTEqW0R40AJx3Y8rmViYjkcPLLR7lFRbcq8n6xw14ZrgTlFsklQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760293883; x=1760380283; bh=WywBBNmKUdqL7zA8z85UBmycVczc8W1eyhC
	OQfB0Ub8=; b=Mf255KXL98RBQufV1m8IwMT9tDG3X9FO94uYQBe6BXcqRbwtJi3
	ZgkF61uCMg1mdHZLQMhcQGKYuswow6Q/4Bq6goVhu0Sn2oQ4VuUCVBggKW40ocpx
	BllkVSnf9Lx22AHwoFB+uSuZs9w0i9yBKKlSPZvOAvtnnO8rWLzoItk8UHaTh14B
	YkgtCsqDyQBkxSoqvxH6Fmyv93HZNUljmNz6D+JhA3AEThW9QSHTKaP7n2s3+MLK
	x7qtxezcqg3TWRjrNTr74J0s216SwhcXwJHUn5zXHnmP2LIE3o0ZFHgs3dID1oTc
	rErpWXcqcIsw6Av+l1AvhVunmyaH26VZ+FA==
X-ME-Sender: <xms:-vPraHoaiFkS-cR_t16PngXlQ01RRu06_CJ6W9OqkBZmJUsdaG1dnw>
    <xme:-vPraIqiY_4ksFdWkVu15hij9q-hz-a4PkJS7Ya6cO42FflgfxqGEK-YrwwDYDWuB
    CWfjwzfSkFjD93CffeGmi6xuLpWUbcWCpMb9Z0m8l-rwxQZ4PfiSg>
X-ME-Received: <xmr:-vPraJM-lsWcb0BfliOnKNRK66rlpmhrHM8LvQOJlAYkRQVSU1zwkgog3zxU207hEQJ64KJL6GNn6H2Sk5wBCCjSnwAXBq_Mrok0PlKlk3UlviYSTE36>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudehhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefvohguugcukghulhhlihhnghgvrhcuoehtmhiisehpohgsohig
    rdgtohhmqeenucggtffrrghtthgvrhhnpeejffeljedtgfffleeuveeiuedvteekvedvge
    efffdvkeetgfetfffhueekheeuleenucffohhmrghinhepghhithhhuhgsrdgtohhmnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhmiiesph
    hosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlghhonhgvlhhlsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:-vPraJzE1B_NksGtlE1SvTC-Jktvp5jbbaKFUm33rS-jEi-AqQnVsg>
    <xmx:-vPraCsUTetf6xAqOzmzATd4vOa7IAYM1rM5B0otfNDkXD5cCLjTDQ>
    <xmx:-vPraC6GKqAew88sL-T3BqmFxvSPuhyNNSsfzoMMqm_bj565Pp_qmg>
    <xmx:-vPraBSJ-4T8gIWSeLJFx8LqZP9_OQijC8Gh1nL2eogYOjfKOoTfIw>
    <xmx:-_PraKk82awZ1Dit8Ej9IT78-WeFsfh0n6725zLbQNQEP7WnVaaWqAAG>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 12 Oct 2025 14:31:22 -0400 (EDT)
Date: Sun, 12 Oct 2025 14:31:21 -0400
From: Todd Zullinger <tmz@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Andrew Kreimer <algonell@gmail.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] t1016: make sure to use specified GPG
Message-ID: <aOvz-ac8JTCaRwIm@teonanacatl.net>
References: <xmqqsefq7947.fsf@gitster.g>
 <aOu59eVs7tK6pCoF@teonanacatl.net>
 <xmqq1pn85f5i.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1pn85f5i.fsf@gitster.g>

Junio C Hamano wrote:
> Todd Zullinger <tmz@pobox.com> writes:
> 
>> Interesting.  And well-spotted.
>>
>> This _does_ seem to resolve the failures in our CI and in
>> the Fedora build system.  I was able to run a few test
>> builds.  With this fix, the tests were successful where they
>> were not without it.
>>
>> I remember suspecting the gpg calls were not using the
>> wrapper command in gpg.program.  I even tried forcing the
>> --faked-system-time for all the tests to check that theory,
>> unsuccessfully.
>>
>> Oddly, I ran into test failures after fixing the GPG2 prereq
>> long before c348192afe (t1016: clean up style, 2024-10-22)
>> was in place.  Perhaps I was hitting a different issue
>> initially?  Then, when I looked at it again I didn't think
>> about gpg.program again, since I'd already tried to force
>> the gpg wrapper which sets --faked-system-time.
>>
>> It's both annoying and embarrassing if it is that simple and
>> I missed it after looking a few times, to be sure.  But I'll
>> be happy with the end result all the same. :)
> 
> FWIW, GitHub CI jobs are failing t1016 at the tip of 'seen' (which
> has this change), but only some and not all the jobs, which may
> indicate there are timeing-dependent flakes involved.  I didn't dig
> further, though.

Ahh.  When I saw this patch and checked the actions, I
looked at this job:

    https://github.com/git/git/actions/runs/18418984778

and the failures all seemed to be unrelated to the test.
Looking again, I see the ps/ci-avoid-broken-sudo-on-ubuntu
branch was merged to seen to fix that problem.

Between that initial "success other than unrelated failures"
and my multiple successful runs in the previously-failing
Fedora build system, I thought it might have been fixed.  :/

When I poked at these failures in the Fedora builds many
months ago, I was able to get the full test-results output
via a bit of a gross hack to tar it up and print it to the
build log as base64 text (only when there are failures):

    # tar up test-results & $testdir, then print base64 encoded output
    #
    # copy $testdir contents to test-results to avoid absolute paths with tar
    cp -a $testdir/* t/test-results/
    begin='-----BEGIN BASE64 MESSAGE-----'
    end='-----END BASE64 MESSAGE-----'
    printf '\n%s\n' 'test-results and trash directory output follows; decode via:'
    printf '%s\n' "sed -n '/^${begin}$/,/^${end}$/{/^${begin}$/!{/^${end}$/!p}}' \
        build.log | base64 -d >output.tar.zst"
    printf '%s\n' "$begin"
    tar --warning=no-file-ignored -C t -cf - test-results/ | zstdmt -17 | base64
    printf '%s\n' "$end"

I don't know if we have or might want something like that
for the Github/Gitlab CI.

Even with the test-results directory contents, I didn't
manage to work out what the issue was.  Maybe some
additional debug output from the code and tests to show the
environment that is being used when gpg gets called to
make/verify the signatures could help.  I didn't try to
adjust the code.  I did add some debugging to the gpg
wrapper and used that wrapper by default, without success.

But I imagine that's mostly an issue with my unfamiliarity
with the code being tested. (The hacker version of "it's not
you, it's me.")

-- 
Todd
