Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5213938D
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 06:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771309338; cv=none; b=RwOSqemJt6XCbPxKiQghsb6lSXEEdQs8irHMzXbyC/M88e7eK0t8KlW+5qJka/+LJziClsNw+kH2iG9Ffxob50GKb08BiAU5Cyb3YpYJdv0VdbzaYiMNchzj4Wsbn9uB0B3X3xeu4gU4KBPGeRTjzfK0Nw5gN7Z73On5azvCiko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771309338; c=relaxed/simple;
	bh=HbVjuXAsEoIoDwXScZLGqaoq9rBi6OFUMCAuGXpqtGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lb7sKGjd2It2zlwFvCvIzWfieFKiWXIsVpSfTqSqWNpEXLW4r41zYrEWGMo9b5xWVE2dD+LvKqK5HliEZ9UztxPi1o6WRO1Tuiw0qyeDn5ye93SLmwqXoyQEDHM4LpYjLnTrqfynC3Cq/RCmGFeSzVBZcPG2R5l9fDCrSZQUV1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=neW/KVex; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iQmL9Cw9; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="neW/KVex";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iQmL9Cw9"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id E6D911D001C7;
	Tue, 17 Feb 2026 01:22:14 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 17 Feb 2026 01:22:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771309334; x=1771395734; bh=DrJn/Prbl7
	9cViWIjnwFpe27B5McTVPsKuc6RP0JwUk=; b=neW/KVex3nfz0ozQr/BfqA2DHC
	9KBOdldA9AWlCMKQt7KR1CQQSCWco/h9dVKlE7PhdQ9DKKcfyJCUchOLTGbR88iK
	EKPCWBmiFHFKmVqjh/xseVHorhlSDA1W4GHZJeOd0p63OMaX0OHFSc96aqZXnM4M
	CpBrZYld8RLXcZH+4lhNnf1tQ78ec2Daq42BnHxVtmuYlCLCfLzY9iE7QTMg8RFX
	P9xY4tAvSzZV5SYKh64Fr6GBur3k5Sisraa7waYhrWkgAem5lQdlKGaFSPm4zmn5
	r043Rxdm6eD9SlDLbjKfR8bzpaUbHxba7E0rQ7Hu+02P2tU9cwN+Y9Xw7H6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771309334; x=1771395734; bh=DrJn/Prbl79cViWIjnwFpe27B5McTVPsKuc
	6RP0JwUk=; b=iQmL9Cw9D/tWAFR4XqFdXa2EBAS1Jzde1eFDpo1uA2xj6upJBOV
	FwvVyX1kpX5QcA/swSizmiNb819JQiOiiwieEMJ4fZcmnn2F3sksothTVYiHFVLY
	bgW98+4dyM55LHduaTWvmuE2Oc21SscrwSCelEPXrhlZ0SzyJNnv/pkLXX2lkPbA
	1YLFVtdzcDqdrWFukL4lGdobcBb+UP8v3w7uCx3/qSlDKQ/Xuc2QfuslgAt7rK+0
	l8tdSxlGeRaLKZx1T2Lxq3xtI6pKXjrUmntINwygxDS5zDRWg4/3piKCUwYRqn0j
	scygqVUDQhHBFqenkZJ8F7Ybq3n/4rcvI4A==
X-ME-Sender: <xms:FgmUafmLgpW84X9JeCEPWMW8ezMJ4nCiUZ900vlAmEttIOp5AE_xIg>
    <xme:FgmUaaRGtZv6HbxNA5kFjOxDGjZ8euMOl2M_9IBxYeLCqDL6QTTyF1au_ziE1XMY1
    frd9Tt0rW0_TEmJtTcmO-aGgC41u11YlhosAtuk6qZVCSiRxU_IMnU>
X-ME-Received: <xmr:FgmUaTB0VLXVdWd3nB-y0AfulJr_Q5CG_l4TE99Y5GjAkdOGvebAgBFO10xKsfEWFXXQhSifIL9otK1ggqHcjuT7wfPdzbDsyXxov2g8Ow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudeltddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepmhhrohhikhesuggvlhgrhigvugdrshhprggtvgdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:FgmUaRQcY7pimerXJ1XORSyQXolrMdDchI0nK0PM94-kG5n1QjODCA>
    <xmx:FgmUaRpoPgz19lFoNzG9Bm9ewapa_xAOb8lMNBShaJ7xMUTal7lWbQ>
    <xmx:FgmUaTwwo9a_jUuBicHQP9g-xaCLaOHP2M0kNLaTjeZ89Hu8liJNZQ>
    <xmx:FgmUaWJ79O1Z7-LcCawWjAI2BBnx1cWU-646hdJuGS6ZdPd9gBOdOA>
    <xmx:FgmUaT8TSv_rwBBMsn_n1GmPxgmWhSiUH6C0-v_Fo4nbi_ZiZy2NfJHg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 01:22:13 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 65ea01e5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 17 Feb 2026 06:22:11 +0000 (UTC)
Date: Tue, 17 Feb 2026 07:22:08 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Mirko Faina <mroik@delayed.space>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] format-patch: fix From header in cover letter
Message-ID: <aZQJEDyUyMv4_c1l@pks.im>
References: <aZAMr6XOwKkTa55q@exploit>
 <20260216152730.37478-1-mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260216152730.37478-1-mroik@delayed.space>

On Mon, Feb 16, 2026 at 04:27:30PM +0100, Mirko Faina wrote:
> "git format-patch" takes "--from=<user ident>" command line option and
> uses the given ident for patch e-mails, but this is not applied to the
> cover letter, the option is ignored and the committer ident of the
> current user is used.

I think it makes sense to apply this identity to the cover letter, as
well. After all, I would say that the whole intent is to allow the user
to send those mails from their own mail address, and of course that
would also require us to send the cover letter from that address.

One thing that made me stop though is the folowing sentence in
git-format-patch(1):

  Use ident in the From: header of each commit email.

The option explicitly mentions that we use "--from" for the commit
emails, only, and that may be read as implying that it's not used for
the cover letter.

I don't really know whether that wording is intentional, and I cannot
come up with a good reason why it should be. But I'd say that the
wording is something we should adjust.

> diff --git a/builtin/log.c b/builtin/log.c
> index d43ca693bf..42648dda54 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -1332,7 +1332,7 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
>  			      int quiet,
>  			      const struct format_config *cfg)
>  {
> -	const char *committer;
> +	const char *from;
>  	struct shortlog log;
>  	struct strbuf sb = STRBUF_INIT;
>  	int i;
> @@ -1345,7 +1345,7 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
>  	if (!cmit_fmt_is_mail(rev->commit_format))
>  		die(_("cover letter needs email format"));
>  
> -	committer = git_committer_info(0);
> +	from = cfg->from ? cfg->from : git_committer_info(0);
>  
>  	if (use_separate_file &&
>  	    open_next_file(NULL, rev->numbered_files ? NULL : "cover-letter", rev, quiet))
> @@ -1368,7 +1368,7 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
>  	pp.date_mode.type = DATE_RFC2822;
>  	pp.rev = rev;
>  	pp.encode_email_headers = rev->encode_email_headers;
> -	pp_user_info(&pp, NULL, &sb, committer, encoding);
> +	pp_user_info(&pp, NULL, &sb, from, encoding);
>  	prepare_cover_text(&pp, description_file, branch_name, &sb,
>  			   encoding, need_8bit_cte, cfg);
>  	fprintf(rev->diffopt.file, "%s\n", sb.buf);

The changes here look straight forward.

> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index 21d6d0cd9e..cb04a9c47b 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -1472,6 +1472,18 @@ test_expect_success '--from uses committer ident' '
>  	test_cmp expect patch.head
>  '
>  
> +test_expect_success '--from applies to cover letter' '
> +	echo "This is a test text" >file_to_commit &&

This file isn't used.

> +	git format-patch -1 --stdout --cover-letter --from="Foo Bar <author@example.com>" >patch &&
> +	cat >expect <<-\EOF &&
> +	From: Foo Bar <author@example.com>
> +	From: Foo Bar <author@example.com>
> +	From: A U Thor <author@example.com>
> +	EOF
> +	sed -ne "/^From:/p; /^[[:space:]]$/d" patch >patch.head &&
> +	test_cmp expect patch.head
> +'

We're not only testing the cover letter here though, but also the other
generated patch. This makes it somewhat hard to verify that the test
actually works as expected. Would it make sense to maybe use something
like the following instead?

  test_expect_success '--from applies to cover letter' '
  	test_when_finished "rm -rf patches" &&
  	git format-patch -1 --cover-letter --from="Foo Bar <author@example.com>" -o patches &&
  	echo "From: Foo Bar <author@example.com>" >expect &&
  	grep "^From:" patches/0000-cover-letter.patch >patch.head &&
  	test_cmp expect patch.head
  '

Thanks!

Patrick
