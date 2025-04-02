Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FCB232368
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 07:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743578202; cv=none; b=FGIlkjfe7IHB0crs9A1F0tH+Amx1NRUV96AekYcUwQHJGrCc3NZ9GXaKGOseVlukucmSwcj95QifZLIaF9c4200luUCP3YEDIWYu0k9VWqJsnYy5O0uGOQmAaOGmt3uN9NmvoEKKBxShMiQHHjnnT3V52K3QzdV7LXpBVbZ/TR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743578202; c=relaxed/simple;
	bh=8L5aqFjX1EQxV+3Tn0PmIqcs5ptke39hLuInlXxY3y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DhoAQrOmQiEfoFjZRohIywSxIYArD8SWxISA0Bf0TaDtUsfXIg9wt55cqp06yK8Q2VhovwAh/iFvdSf7Gq1BBrSemjYwk0DOCjWbEqL6YZ9Pbv591RSRT+HPskkId04rPJwtkoppdtRn2iwmXtiK66bQJsih6M8UKI6ns1mmeI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iQtyuxNg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g0sxccMl; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iQtyuxNg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g0sxccMl"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id B0CA21140152;
	Wed,  2 Apr 2025 03:16:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 02 Apr 2025 03:16:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1743578199; x=1743664599; bh=ZY+bSJv602
	HdQDC+bOwsdnoTh/nm9WfDu0pKHNqNf9A=; b=iQtyuxNgySpuhMMzUvXdbJNDsi
	6hxSCnmZL65sAe11ISk6cYasplPDNm0RG0XICk1R/u5z9V9+64wQQOzZSmeqgJPx
	T9A+A77FY5LdEaYBEGFCNdXSDI0UTdrE4jbXEBUjYhhk2QqemrVZCEYwN9IsrO66
	3YKdJjACpRQ+yJbRhxhUcry8B3/ZRNmh0BSk7QYx1zmEgvqVkD26lTzxzobR2Lac
	Serbjy+noDnHEKkX7aoaazV2wnMkP5TYgLl20FnLNZTpzf165i7q0VZ6T7Z3Ndc7
	/H1g1WAVC0FU+QHcPvEndDlXB38/69BqMoo6EgAfpmEdAAYVcQDjPseb1pGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743578199; x=1743664599; bh=ZY+bSJv602HdQDC+bOwsdnoTh/nm9WfDu0p
	KHNqNf9A=; b=g0sxccMl3AuOeBIx0u55B2qxiV5xAchkXp0w/uD80DGUBtC0q5p
	t71PxTBp5dRzZZ2nQgnbN02ln6XDbQMM+9oNWhrcKjpWLYe8sp1zXcsE/YbXebE7
	S7qVBMUXG6wP+Tt51Ue9+LF7/6PHUr+4F/w+xRa51BlG5Y9EiylMaD8gMs0KTXzA
	ALhF5++vzI7slR6szR+1fGHS8BOqGLhe/01RQVzp+Uvwk4tgY8NEDQ0nwjvVuDIj
	BTsGs94jIVyZD8u7lLmeVi9XocvtLjfzL3XXkrC26xMb6UqCmEh/AS32N8Ep0B6v
	YtO2kuKmdM9KuG4fzPG6T6D1AGal1lfcGpg==
X-ME-Sender: <xms:V-TsZ13FY9JcLzjiiatzQtjQDJCuWbh6TzcrMDBM2dq7l302v87c4Q>
    <xme:V-TsZ8GyfhedQG-hy9pnk49ZQOLMyl_OqNcJufbQa6fX82vknGEYK9PWZCZgbX87O
    nLrk6173hvWPzdFfg>
X-ME-Received: <xmr:V-TsZ17a1_SJ1cridxYvdn3qvfchbqZ_lSDxFicXjXdg8fI3NwLW2SaZYoSgi3MHNqZQDbDrTB9-3vwYmNJ6sadHY0bzraJ5aQvXe-SwNOGGjQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeehtdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhope
    hsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepjhhohhgr
    nhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:V-TsZy3ao0WRzLT0PHwPjgIirXizYPsESgUgEBG59yZW888HX3Qq7g>
    <xmx:V-TsZ4EXiEADJPbz6NNe3RCua1fmU9vpqqTFPgL8_JwX51XXtsA1Mg>
    <xmx:V-TsZz-E4si1FTZk69rBqZagfybGOhrc2SvsGYd5gLaQNjmaCCfRvA>
    <xmx:V-TsZ1l69AlpxDARxEFuGX8p-TTdjTbOx715SYfClCdJ60AdW_nN4w>
    <xmx:V-TsZ2YgqX2pabwVSTVFdYpPfqp6tZcKNz8RcRdHWPJPxaFi07hrYacV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Apr 2025 03:16:38 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3bb9aa29 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Apr 2025 07:16:37 +0000 (UTC)
Date: Wed, 2 Apr 2025 09:16:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 13/20] t: refactor tests depending on Perl for
 textconv scripts
Message-ID: <Z-zkVL8cSYEiR_T1@pks.im>
References: <20250327-b4-pks-t-perlless-v3-0-b436de9da1b8@pks.im>
 <20250327-b4-pks-t-perlless-v3-13-b436de9da1b8@pks.im>
 <9f477166-5667-a051-13d3-43d56a7a8ec1@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f477166-5667-a051-13d3-43d56a7a8ec1@gmx.de>

On Tue, Apr 01, 2025 at 08:55:22PM +0200, Johannes Schindelin wrote:
> On Thu, 27 Mar 2025, Patrick Steinhardt wrote:
> > diff --git a/t/t4030-diff-textconv.sh b/t/t4030-diff-textconv.sh
> > index c7d8eb12453..f904fc19f69 100755
> > --- a/t/t4030-diff-textconv.sh
> > +++ b/t/t4030-diff-textconv.sh
> > @@ -26,13 +20,10 @@ cat >expect.text <<'EOF'
> >  +1
> >  EOF
> >
> > -cat >hexdump <<'EOF'
> > -#!/bin/sh
> > -"$PERL_PATH" -e '$/ = undef; $_ = <>; s/./ord($&)/ge; print $_' < "$1"
> > -EOF
> > -chmod +x hexdump
> > -
> >  test_expect_success 'setup binary file with history' '
> > +	write_script hexdump <<-\EOF &&
> > +	tr "\000\001" "01" <"$1"
> > +	EOF
> 
> So here the `hexdump` script is written, basically replacing NUL and SOH
> with the digits zero and one, respectively. I wonder why the script does
> not call `test-tool hexdump` instead? And I wonder even more why no test
> case has to be adapted below this change in the same file. I _guess_ that
> the reason is that the file named, creatively, "file" is initialized with
> a NUL and a newline, committed, then a line is appended that contains SOH
> and a newline, and then the test cases verify the hunk _headers_ only?
> 
> If using `test-tool hexdump <"$1"` would work here, too, I'd actually have
> preferred that over the `tr` invocation, even if would still not be
> recapitulating the functionality of that Perl script (which, contrary to
> its name, seemed never to have output hexadecimal values...).
> 
> To be clear: I do not suggest to change the patch, I am merely puzzled why
> the more obvious `test-tool hexdump <"$1"` was not used here?

Phillip had the same comment, and I was trying to address that by
improving the commit message a bit. But seems like it still isn't clear
enough.

The reason why I decided against using `test-tool hexdump` is that it
would have a ripple effect. The output generated by that helper is not
the same as the output generated by the Perl script, so if we started to
use the hexdump helper I would have to adapt a bunch of tests in this
test file to update their expectations.

The result would look something like the appended patch, which I think
is quite awkward. On the one hand we have trailing whitespace in the
expectation, on the other hand we have weird seemingly-unrelated changes
in other tests. So I shied away from that and instead decided to use a
simpler variant of the textconv script.

Let me adapt the commit message once again and make it a bit more
concrete compared to the current fuzzy description.

Patrick

diff --git a/t/t4030-diff-textconv.sh b/t/t4030-diff-textconv.sh
index f904fc19f69..16d7fd4c5ca 100755
--- a/t/t4030-diff-textconv.sh
+++ b/t/t4030-diff-textconv.sh
@@ -15,14 +15,14 @@ EOF
 cat >expect.text <<'EOF'
 --- a/file
 +++ b/file
-@@ -1 +1,2 @@
- 0
-+1
+@@ -1 +1 @@
+-00 0a 
++00 0a 01 0a 
 EOF
 
 test_expect_success 'setup binary file with history' '
 	write_script hexdump <<-\EOF &&
-	tr "\000\001" "01" <"$1"
+	test-tool hexdump <"$1"
 	EOF
 	test_commit --printf one file "\\0\\n" &&
 	test_commit --printf --append two file "\\01\\n"
@@ -92,7 +92,7 @@ test_expect_success 'show blob produces binary' '
 
 test_expect_success 'show --textconv blob produces text' '
 	git show --textconv HEAD:file >actual &&
-	printf "0\\n1\\n" >expect &&
+	printf "00 0a 01 0a \n" >expect &&
 	test_cmp expect actual
 '
 
@@ -103,7 +103,7 @@ test_expect_success 'show --no-textconv blob produces binary' '
 '
 
 test_expect_success 'grep-diff (-G) operates on textconv data (add)' '
-	echo one >expect &&
+	printf "two\none\n" >expect &&
 	git log --root --format=%s -G0 >actual &&
 	test_cmp expect actual
 '
@@ -115,7 +115,7 @@ test_expect_success 'grep-diff (-G) operates on textconv data (modification)' '
 '
 
 test_expect_success 'pickaxe (-S) operates on textconv data (add)' '
-	echo one >expect &&
+	printf "two\none\n" >expect &&
 	git log --root --format=%s -S0 >actual &&
 	test_cmp expect actual
 '
@@ -146,9 +146,8 @@ symlink=$(git rev-parse --short $(printf frotz | git hash-object --stdin))
 cat >expect.typechange <<EOF
 --- a/file
 +++ /dev/null
-@@ -1,2 +0,0 @@
--0
--1
+@@ -1 +0,0 @@
+-00 0a 01 0a 
 diff --git a/file b/file
 new file mode 120000
 index 0000000..$symlink
