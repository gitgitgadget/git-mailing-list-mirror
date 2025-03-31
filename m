Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758E77E107
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 12:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743424038; cv=none; b=GVoUtXl6kLJRcNn/zuQktrIfT2zdSTiHXZogmN5UALc5Sad9SE0EqZ7jpLWOhK29pY6PTZUGjc9aeEAbghZkRjqE9ByZTEI3UH4htQN7+ZGsmURWVqvc7lwcYh1JSL9r9lLukFGf3HeJMYyD9hWBR1kvhCYELuHCi2xnmpPPNCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743424038; c=relaxed/simple;
	bh=iMINfhZB2O1f6Fgidu0594iBVNc54GvV4p5RvzF61pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tIinNzGmeM+Fd+IGcclU70Cz20ouxb65JNf86uq+3cqo3cGy2T+FobnK5LHb3HL+gxwqgUa184nVr+ouCVHVoc449n62ge96LPnqBzs0zFsG3ounqEe/z2QLtBmxhvJGO1948atjtyP2/AC1KX9PD49YSslClqSaKFGvwcUg/zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hGUzABzZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vK0MlcRb; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hGUzABzZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vK0MlcRb"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 65CDF13843A2;
	Mon, 31 Mar 2025 08:27:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 31 Mar 2025 08:27:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1743424034; x=1743510434; bh=wlb6a/AVYR
	F1xaFOan20rgBldTkMxl1d4otCTCmVhpg=; b=hGUzABzZORz20SUrFr5Rqhwn2/
	/wX6xpzRql9YjPJzJIs0VsPJVY2bKl0icw8jyQnJHSisOPE6XPa8jfQ0sGXzH7fT
	TDV5AG5opwJS2WCKzU+HQgxX+DU9J/T2NVvpcw42Xfz4zJxQlWWcZ6LWLwLpO6TQ
	7JqgZq5MDuoYBf4egwAgZtTaHVMzCA/oBwQ/z1ZVnNm6rzGzMrMmzhEjKJ5PzhFL
	B/KSucspwfQA4lGEvXiXeHtdnR7qatQWyAmKF2rAM8dSbAYr8AP/GyqsZ9TAc6Wz
	hrS/V4+cC2/fDmB0h0Wm+v2z4dYST9RmwxM3CdKSxKBF4pnHtpB2MLgC5AKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743424034; x=1743510434; bh=wlb6a/AVYRF1xaFOan20rgBldTkMxl1d4ot
	CTCmVhpg=; b=vK0MlcRboMGni4w4Eavm5Vk4F1dJ8RFxoVt00yWk2TE6YmQfuHh
	skDS4odOa62tT+PHdFzi2Gt29lqcCTiByp5zt52fw4LGjOfaIad0g4z81Evhsk2R
	CIQCu7KpJg94YscWaBr4ZmbEIviCaE3Pq8Eu5Zp7/CO/yoSNIFR55AmrBQIDRp4J
	t/xYHQQKMcXPSkdhmEN9eEWB9Ors3trwsOUvI8aPiq4qPXEfOi8k6CHKO3NutZUs
	jLV5KPFU4j3fnty42+K3uW37yaiHY48jftG05nfEsaptHXbquR6RCJaeIRuFZ6t3
	G4AgwxAkcM2k6O4EwUVdpql0Cd3L5S5O+PQ==
X-ME-Sender: <xms:IorqZxHzl9-T60XpPkFwnSNj-3aO9Pnsp1Cdc9NOr5EmVgTXPhdBJA>
    <xme:IorqZ2XgtdFo5SmrSnZuH4vsPverL5RYY7I6rgZ7lsKMcT42Szhva8Cd44N0yyqFz
    WIhVQyqGmT-4TW5Sg>
X-ME-Received: <xmr:IorqZzKhhxylqTOLw_fmIifnGY4ALCAd2d9m8Swgoa8h1wZffrgt5MaU0NOkj3REczhkN818WgL_fE6Ej0XYHaEasrsEfFbQw9Kcwnl1FWhnURhk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeelleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepjeehfeduhfefuddvhedvueeuveevheffueevudfg
    vddtvedtieelheekvdefleeknecuffhomhgrihhnpehfvgguohhrrghpvghophhlvgdroh
    hrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehp
    shesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehtmhiisehpohgsohigrdgtohhmpdhrtghpthhtohepuggvrhhrihgtkhhs
    thholhgvvgesghhithhhuhgsrdgtohhmpdhrtghpthhtohepghhlrghusghithiisehphh
    ihshhikhdrfhhuqdgsvghrlhhinhdruggvpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:IorqZ3H6jTvD6op9mp2vZ58CDHqlHJW6uaLd9sKiKPGkWp9vNaNC8A>
    <xmx:IorqZ3Xs5ARHEPu6I1SvkP6k3fKdoed2IP-0g5ophdzCOV-xdqlR_g>
    <xmx:IorqZyNorLTFpIdw_Esix84Dp7hWeAbrgb-HYNX6FQv-JQ2xeO84iQ>
    <xmx:IorqZ21a2Z_q6cERJjJwNvRr0qMYiyf33P7QkUBi4hPZ7IDSIBOERQ>
    <xmx:IorqZ9zp4LMf0gx3MkXwMxS_RC7tyzgsvPxw9CYOE4hvzI2KHuPRDMYu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Mar 2025 08:27:13 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c7d0ba47 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Mar 2025 12:27:11 +0000 (UTC)
Date: Mon, 31 Mar 2025 14:27:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Todd Zullinger <tmz@pobox.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	git <git@vger.kernel.org>,
	Derrick Stolee <derrickstolee@github.com>
Subject: Re: Testsuite failure on s390x and sparc64 after 6840fe9ee2
Message-ID: <Z-qKGqpbdaW9WCrP@pks.im>
References: <89257ab82cd60d135cce02d51eacee7ec35c1c37.camel@physik.fu-berlin.de>
 <Z-R_Zmr6kxCPLm-O@teonanacatl.net>
 <Z-Zr7BZL1UGqVxKu@pks.im>
 <4276c8d0b72f11f325482756d3bc251327d0ac47.camel@physik.fu-berlin.de>
 <Z-atRMGXHilZRTEL@teonanacatl.net>
 <Z-bCNdOOLrM2Chb8@teonanacatl.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-bCNdOOLrM2Chb8@teonanacatl.net>

On Fri, Mar 28, 2025 at 11:37:25AM -0400, Todd Zullinger wrote:
> I wrote:
> > I don't have a lot of time to poke at this today, but I'll
> > make another test run on an s390x build host without that
> > patch, but where I can save the output and post it
> > somewhere.
> > 
> > For the Fedora packaging, it will be something like this:
> > 
> >     make -C t all || {
> >         (cd t && ./t5620-backfill.sh -ix);
> >         ./print-failed-test-output;
> >     }
> 
> The matches file is empty.
> 
>     $ ls -lhn batch-trace matches 
>     -rw-r--r--. 1 1000 1000 31K Mar 28 11:09 batch-trace
>     -rw-r--r--. 1 1000 1000   0 Mar 28 11:09 matches
> 
> The only match in batch-trace for promisor fetch_count is
> from the previous test:
> 
>     $ grep -e '"category":"promisor","key":"fetch_count","value":' batch-trace
>     {"event":"data","sid":"20250328T150939.623820Z-H9aa15b67-P0008f613","thread":"main","time":"2025-03-28T15:09:39.625484Z","file":"promisor-remote.c","line":55,"repo":1,"t_abs":0.001777,"t_rel":0.001777,"nesting":1,"category":"promisor","key":"fetch_count","value":"48"}
> 
> The trash directory for the test run is here, in case anyone
> wants to poke at it:
> 
>     https://tmz.fedorapeople.org/t5620-backfill-trash-dir.tar.gz
> 
> The full build log is available as well:
> 
>     https://tmz.fedorapeople.org/git-2.49.0-s390x-build.log
> 
> If you search for 'BEGIN BASE64 MESSAGE' in that, it
> provides a command which can be used to extract the full
> test-results directory.  That's used to get the output from
> the build hosts where shell access isn't available.  I don't
> know that it's got anything which isn't in the trash
> directory tarball which I already extracted, but it's there
> just in case.

Thanks for the additional information!

One thing I stumbled over: the `--min-batch-size` parameter is parsed
using `OPT_INTEGER()`, which expects the value pointer to point to an
integer. But we pass `struct backfill_context::min_batch_size`, which is
of type `size_t`. Maybe that's causing us to end up with an invalid
value?

Could you please check whether the below diff fixes the issue for you?
If so I can turn it into a proper patch.

Patrick

-- >8 --

diff --git a/builtin/backfill.c b/builtin/backfill.c
index 33e1ea2f84f..1dd0d746538 100644
--- a/builtin/backfill.c
+++ b/builtin/backfill.c
@@ -119,11 +119,11 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
 	struct backfill_context ctx = {
 		.repo = repo,
 		.current_batch = OID_ARRAY_INIT,
-		.min_batch_size = 50000,
 		.sparse = 0,
 	};
+	unsigned long min_batch_size = 50000;
 	struct option options[] = {
-		OPT_INTEGER(0, "min-batch-size", &ctx.min_batch_size,
+		OPT_MAGNITUDE(0, "min-batch-size", &min_batch_size,
 			    N_("Minimum number of objects to request at a time")),
 		OPT_BOOL(0, "sparse", &ctx.sparse,
 			 N_("Restrict the missing objects to the current sparse-checkout")),
@@ -140,6 +140,7 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
 
 	if (ctx.sparse < 0)
 		ctx.sparse = core_apply_sparse_checkout;
+	ctx.min_batch_size = min_batch_size;
 
 	result = do_backfill(&ctx);
 	backfill_context_clear(&ctx);
