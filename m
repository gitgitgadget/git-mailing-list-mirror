Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B7D21D3E2
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 05:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770961871; cv=none; b=FXffe1FQEOLgTNKWPw/+kNVsmcPvhaAtBW8EvPUzkdzvd1KGxcM/04pfyKJ9wnzruwlJbnV6nZHwihi1xhyOLWvLHExawYR4NzmZ6p7zVkdDPuaVA9l1NFA//60NlEA/OcKkcLzrQeJoHGw9yLlKv0CpaNeU7h6llTkSyYlDfuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770961871; c=relaxed/simple;
	bh=KAf1kqNV27O4B9oZetLN4n1IDa/gYuum9aJRorrmJBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YL/mUOYFMZIyoej4xETzJvrj7yY3ka/X73DCQ4xswm6BmEEp5Maoz4iTZf6gZeiKI419mg7AP3Ize5i7qyQSLOps4MsSSITMzW3oAoiGRlw8z6ATJYQRGtXcjp0/PvZrCqEbPnjCX8ERt+zAP/77HIA5LEQfyACeMrzsz9lYejM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AnJUuVqE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BxI5WYNd; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AnJUuVqE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BxI5WYNd"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id EFF151D00198;
	Fri, 13 Feb 2026 00:51:09 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 13 Feb 2026 00:51:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770961869; x=1771048269; bh=E6mN/StYvq
	K8gLJj+iCOFuOX8t2EiYOG7Zg9iVSbvRc=; b=AnJUuVqE+PaF9+zPvgoSQ0IKGu
	65PyiZySIpd3kW9YteuMsxU8wK0Pe+TMf0Nu4NERO3hzgb8jXOluCMvTMnLTr4ec
	yC5zk4vSuGW4+Iv+lQJTET7RmBQO3Ll4M+ibhTXNYMyX0IqOIc+RvXnM2JxlcmOv
	6BAbCoEQletq1kQQsTQMwUWKX9NvJiKZLThnssDFzVqvj2groz/qcd3x5kMtFk+6
	/KBUXVLLMPWJ1106bWd5rEeJyGIdyMugh9bqfTMoj8kK8pCkGSekLJnYqaHZ5x5Q
	N4tHaTd5+IjassO7RENJuxsywW84nDFFLi3dNnHAQJrLTWk4XgyyyanE2zxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770961869; x=1771048269; bh=E6mN/StYvqK8gLJj+iCOFuOX8t2EiYOG7Zg
	9iVSbvRc=; b=BxI5WYNdow33NtLlAhMK7BXvxJiKiIUQ6DKpMyopIIUxYRZQQAS
	qNJtfQPQ6lSGTf9Z3NMWQC6qeMlBVUMhCupLy2fZarpgwQWKD2c9Dcw8kuZjpogW
	yFq8HXPzzEh3iTeXZlQ7E+C8dNA0MVfPmB0+v0XuJqKyu10JU13r4PBGy/gV/THG
	9CsrhkZ4YRJEXK7vlxyFGMZADB2bQG8kJTuIWNTPjc3JBsnkJ8m0TxsORNO9WvoA
	gI/BfrY/BXJLkLGBQYdhlxbbYL65fViUUujY8BFvPjf6cAcfABh8wOEYtcRe8Wo7
	CRtoo6gaMxjBnpih1jvAWejpadVD5wr4jwg==
X-ME-Sender: <xms:zbuOaVLO7YVDqxdr4nSbPTnAip2Gb30UfGSaqke1afD-PGVHP_WLvg>
    <xme:zbuOaXIkytXWajLiHgKiI0jcGuY0V4HSPZ1Zu5yYvF7e8R3yyQophf_B_KEPfz5OO
    CY91OSStD46FQStmiQcGM2hdcLQTgU48BuW7Rz3pBTmIDwpAai8AA>
X-ME-Received: <xmr:zbuOabXmME1zv_4XkJOaVDr_Hg5OrxMY4kj-O_CbRc3UioBy52kf_kp_wfWGK5hLqys8mN7xPowRSNYtWwgVmP0m__SjHP1X3EgXQvm5js_->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdejgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:zbuOaRgiz5ltXKB0wuHlmEQkvAJSBmpK_o0ay-ORrRUTVTCNKqJMVw>
    <xmx:zbuOae-Rub35eig9vlHNqvzb_Mwxj8N32KVS5s7Uz3MyXTnfnMlklQ>
    <xmx:zbuOaTDIC-nCyrmE4Nx_BZMEKhtcOc4Xf5q8obnN-2JwxQQ6WFLrUg>
    <xmx:zbuOaTIPtNfqgVMpjPjaxEkAaM59rW0Ym5nhGmQIz6VXc2qB3F7UXQ>
    <xmx:zbuOaYhtMm31r2ieLJ_VITfg93rAWlSfUFu4Wr--eNIXIRA7GRPblJeP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Feb 2026 00:51:09 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e39d6bac (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Feb 2026 05:51:08 +0000 (UTC)
Date: Fri, 13 Feb 2026 06:51:05 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/4] builtin/history: perform revwalk checks before
 asking for user input
Message-ID: <aY67ycgnisRjeguw@pks.im>
References: <20260212-b4-pks-history-dry-run-v1-0-1ce03d631c1b@pks.im>
 <20260212-b4-pks-history-dry-run-v1-1-1ce03d631c1b@pks.im>
 <xmqqcy29ohi5.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqcy29ohi5.fsf@gitster.g>

On Thu, Feb 12, 2026 at 12:04:50PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/t/t3451-history-reword.sh b/t/t3451-history-reword.sh
> > index 3594421b68..6775ed62f9 100755
> > --- a/t/t3451-history-reword.sh
> > +++ b/t/t3451-history-reword.sh
> > @@ -263,7 +263,7 @@ test_expect_success '--ref-action=head updates only HEAD' '
> >  
> >  		# When told to update HEAD, only, the command will refuse to
> >  		# rewrite commits that are not an ancestor of HEAD.
> > -		test_must_fail git history reword --ref-action=head theirs 2>err &&
> > +		test_must_fail git -c core.editor=false history reword --ref-action=head theirs 2>err &&
> >  		test_grep "rewritten commit must be an ancestor of HEAD" err &&
> 
> This ensures that the editor is never consulted?  How?  Running the
> "false" editor would give us a different error, like "your editor
> exited with non-zero status, telling us to abort" or something?

Yup, exactly that. We'd see "Aborting commit as launching the editor
failed." instead of the above error message.

Patrick
