Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BE8231CA0
	for <git@vger.kernel.org>; Sun, 13 Oct 2024 19:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728849425; cv=none; b=OYzusB/Yfuu3iN66B17NjfetcWZXy/j2asp9OJ+oSumGdXxq7dhIuchRlcZHYEOZXNsyOjgalqLrbxf26qz7bSEl3lRtwAOsWMVufH3n86osmPxyjarRqHOLtYkI5jDjK8zLl6Tg8yHj4f5n/92BuMujAYfw3p5lVDy50eVgoWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728849425; c=relaxed/simple;
	bh=l+blrJyBeNiReo9tFA8W/9DfmjTsGxLchyrjhrtSmHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sEDNgnutejb+HezqP5t9tkSbHjahxcLdKzl4i8rXLbSy4JmHBdhF/YT6oqBVjBvJIjz3iIu3LG4CCevMOi10t7HlGrgT28ir9dFmL+OFpXPEK4GdPcEuqjK4OzxdfhTufzApZHVTqdYsFgccLu8U++dtDLu7fIcccImSAmZhE/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=R8TC2b+j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oXom/dfn; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="R8TC2b+j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oXom/dfn"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D6F1511400DD;
	Sun, 13 Oct 2024 15:57:01 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Sun, 13 Oct 2024 15:57:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728849421;
	 x=1728935821; bh=Y2OnRKUBvxLXEaxa4cfC2yjSNmoGUlKXu6I8+GZd3hQ=; b=
	R8TC2b+jRIQa0NIbESXBCgM/gdJPtgzJ7y45C+E3M7DtQJuIlEA1GZ462gnjmyfA
	2jIYEeu5opGKphqH92+njO4Xk1zx7aqadHFYVoB2xck6nqMdgjM6TvpAn3CFUdCL
	vRXmNd8GqN3oAtGUfLqDo+HuCaTqxdPa85ByEAmDl719PLjEdTqMqASk5WkPdKw7
	ZrPAAk06deyNxZ0Hi7LHl0JOlP3y8U7bmm5eKkoeF1c+8KC7sLhC4nn/cIvai2Em
	tPUp9N2vNAsnHhekIbQ2QyV4LvMA6IugY/RwKsuB/pP4yZbey87SYZ+8I1RRI7gw
	Ob12ITRYBtCvACarztrthw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728849421; x=
	1728935821; bh=Y2OnRKUBvxLXEaxa4cfC2yjSNmoGUlKXu6I8+GZd3hQ=; b=o
	Xom/dfn6pYyiLgUy63lqXi/Cvg8qtL9Ge87DbGvuuOsW/riZkiA5PBudDToNeZkO
	UpvFn+XUBjAlYc23AvxQxJkCrYLS+Y/6WAWYEYfMQ6OwLolZWovmAv/rrMhqhCDQ
	vOGhMZdP6WqgUqFtbcHKUW4D+R6AhHADStHip8gtpune8nlSryhJNiE2/lFFlDmv
	w+KOI4k9Bu+1Czz4XKKlmTyS0hTICPUyxkw6rIMGKRoTY2nX3BGL8yeGICH5kvLH
	3c/BdgD2dWJMj103bdhADqiWVDoysbKpmLTtaYYbDRhSCtST6eXKKkMU8xKk9YUW
	S7J4L8mjU1BqeZE7Nyqng==
X-ME-Sender: <xms:DSYMZ_FRJVHsfYI-HXR_LvFrFz2El7mdAJNrsbepQFiCcrMJJb1FVA>
    <xme:DSYMZ8WFpOSpNgDYhmnvQbVWA1fgoLO92ayFDgI_QR5LZM1CLVxepL6oaQ8hRdCh-
    mW6Zlxf46NV64D-Mw>
X-ME-Received: <xmr:DSYMZxJLOEkOvdQCn3ig5DktIyafeKxusV7uFcixCFKKEIsGrmdmkqrXUqNlxrj_xeZa9k_95vkD4KrkxArzYRrfgcK2rT7dYh4BiZ6IBo6Xsg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegfedgudegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepgfeifeegheeiteeltdetgeelhfevfeejtdetfefh
    keejteekffeigeelvdehheevnecuffhomhgrihhnpehmihhtrdgvughupdhunhhigidrtg
    homhdpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegrshgvuggvnhhosehmihhtrdgvughupdhrtghpthhtohepjhhohh
    grnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:DSYMZ9GO5dVP4I0jZih5nkUIi0E6Z9hcPWuI_D1Z58bb51Ycft-gtA>
    <xmx:DSYMZ1VZ_XORPBNxxkgqO1XcWqoxKMyANIw_i5iExVGfqQrzmhfShg>
    <xmx:DSYMZ4MDZJLQzADzOcqRoC2wbub0udK_8k2hqMlzSNMwiMNdJ9Q_JQ>
    <xmx:DSYMZ03CHnmmgdAOHRpTYT7sLvgSMXm9fElXEyVQkpyQ7cvQybjM7w>
    <xmx:DSYMZ4Q2qsGx6uuHqn5r-Jclpytt4p9-CDsNxd7kOlWI-pNYVgT3HQnF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 13 Oct 2024 15:57:00 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 29a5e032 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 13 Oct 2024 19:55:45 +0000 (UTC)
Date: Sun, 13 Oct 2024 21:57:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Alejandro =?utf-8?Q?R=2E_Sede=C3=B1o?= <asedeno@mit.edu>
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git no longer builds on SunOS 5.10, a report
Message-ID: <ZwwmFtF1Y30y8eoU@pks.im>
References: <CAOO-Oz3KsyeSjxbRpU-SdPgU5K+mPDcntT6Y4s46Mg_0ko9e_w@mail.gmail.com>
 <ZwoxHYD-e4qo7OyW@pks.im>
 <CAOO-Oz0+sOpF6YQHSu0ytCO5TL+Anpr1k_9vQx6hebr624WjMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOO-Oz0+sOpF6YQHSu0ytCO5TL+Anpr1k_9vQx6hebr624WjMA@mail.gmail.com>

On Sat, Oct 12, 2024 at 10:34:18AM -0400, Alejandro R. Sedeño wrote:
> On Sat, Oct 12, 2024 at 4:20 AM Patrick Steinhardt <ps@pks.im> wrote:
> > On Fri, Oct 11, 2024 at 10:10:26PM -0400, Alejandro R. Sedeño wrote:
> diff --git a/Makefile b/Makefile
> index 2dde1fd2b8..87c1f9e220 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -3906,7 +3906,7 @@ GIT-TEST-SUITES: FORCE
> 
>  $(UNIT_TEST_DIR)/clar-decls.h: $(patsubst
> %,$(UNIT_TEST_DIR)/%.c,$(CLAR_TEST_SUITES)) GIT-TEST-SUITES
>         $(QUIET_GEN)for suite in $(CLAR_TEST_SUITES); do \
> -               sed -ne "s/^\(void
> test_$${suite}__[a-zA-Z_0-9][a-zA-Z_0-9]*(void)$$\)/extern \1;/p"
> $(UNIT_TEST_DIR)/$$suite.c; \
> +               sed -ne "s/^\(void
> test_$${suite}__[a-zA-Z_0-9][a-zA-Z_0-9]*(void)\)$$/extern \1;/p"
> $(UNIT_TEST_DIR)/$$suite.c; \
>         done >$@
>  $(UNIT_TEST_DIR)/clar.suite: $(UNIT_TEST_DIR)/clar-decls.h
>         $(QUIET_GEN)awk -f $(UNIT_TEST_DIR)/clar-generate.awk $<
> >$(UNIT_TEST_DIR)/clar.suite
> 
> Or feel free to grab the entire commit from here:
> https://asedeno.scripts.mit.edu/gitweb/?p=git.git;a=shortlog;h=refs/heads/clar_sed_tweak

Thanks!

> > > The next issue was that clar/sandbox.h uses mkdtemp, which I don't
> > > have here. Git has solved this in compat/mkdtemp.c via
> > > git-compat-util.h, but clar is not using it. Adding git-compat-util.h
> > > to clar/sandbox.h feels weird, but does get us further along. That
> > > change introduced banned.h into clar, which exposed the use of strncpy
> > > and localtime, both otherwise banned in git.
> >
> > Yeah, we don't want to pull in that header. The clar is from upstream,
> > so ideally we shouldn't have to modify it with non-upstreamable bits.
> >
> > In any case, I've got a similar report yesterday where some functions
> > weren't available. The root cause is that we don't set `_POSIX_C_SOURCE`
> > in "clar.c", so with the below patch things started to work. Does that
> > patch work for you, too? At least I think it should, as [1] mentions
> > that the function is available on SunOS when those defines exist.
> >
> > In any case, the patch has already been merged upstream [2], and I'll
> > send a patch early next week that updates our bundled version of clar.
> >
> > [1]: https://www.unix.com/man-page/sunos/3/MKDTEMP/
> > [2]: https://github.com/clar-test/clar/pull/106
> 
> The listed man page is from the Linux Programmer's Manual, regardless of
> the url path. It won't be enough here as mkdtemp is nowhere to be found
> in /usr/include or any other /usr/**/include.

Okay. I assume that both mktemp and mkdir are available though, right?
If so, does the below patch work? The last bit is new, where we now use
the same mkdtemp implementation as we use on NonStop in clar.

Patrick

diff --git a/t/unit-tests/clar/clar.c b/t/unit-tests/clar/clar.c
index cef0f023c2..064ca5c2ea 100644
--- a/t/unit-tests/clar/clar.c
+++ b/t/unit-tests/clar/clar.c
@@ -4,6 +4,10 @@
  * This file is part of clar, distributed under the ISC license.
  * For full terms see the included COPYING file.
  */
+
+#define _DARWIN_C_SOURCE
+#define _POSIX_C_SOURCE=200809L
+
 #include <assert.h>
 #include <setjmp.h>
 #include <stdlib.h>
@@ -271,9 +275,7 @@ static double clar_time_diff(clar_time *start, clar_time *end)
 
 static void clar_time_now(clar_time *out)
 {
-	struct timezone tz;
-
-	gettimeofday(out, &tz);
+	gettimeofday(out, NULL);
 }
 
 static double clar_time_diff(clar_time *start, clar_time *end)
diff --git a/t/unit-tests/clar/clar/sandbox.h b/t/unit-tests/clar/clar/sandbox.h
index e25057b7c4..b499d2e1e6 100644
--- a/t/unit-tests/clar/clar/sandbox.h
+++ b/t/unit-tests/clar/clar/sandbox.h
@@ -122,7 +122,7 @@ static int build_sandbox_path(void)
 
 	if (mkdir(_clar_path, 0700) != 0)
 		return -1;
-#elif defined(__TANDEM)
+#elif defined(__sunos) || defined(__TANDEM)
 	if (mktemp(_clar_path) == NULL)
 		return -1;
 
