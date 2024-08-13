Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C64947F53
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 06:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723530666; cv=none; b=KaGx54xC72fxWhFx8/d0q4MoPCAFG4iMGcxPouAhI/x7DCKgdQ0YFz+peSBTS1igCYqyFVp7qpVA85dg62ISq1O6rjwopRAIUWi2sBu863mYGLgajWU6BLOzAykabGfdFVAQ0jJhchzLxGZuQ2Q5MugqzTsKg22eFr6fzunps0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723530666; c=relaxed/simple;
	bh=Uv4o/sJk/aFpmqKGRbENos6dPib+qLpsdX1i0jao7uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bNBQZR/CYQrqjrei5k/m4L1SGTBM7evWt5RgXc3B/Z9iQfBzZx6D/kcgePRBfn5kkT+7OJXiT6H4ULcZvkk5acm2qZ5lL7iBeqZsCpPIlNP1ZPojfGC3RAeN3M2rYiSy5/tR6dH7CMTT9zAP49vSXcDEX4ppH8WKuOCKswh8+Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HgAtEUbt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JFdiCga+; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HgAtEUbt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JFdiCga+"
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id C12331151C02;
	Tue, 13 Aug 2024 02:31:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 13 Aug 2024 02:31:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723530663; x=1723617063; bh=iB+MyhSASK
	g0XYaDC/0qCMpPUvrPckIWGNOjVCIZHSo=; b=HgAtEUbt1aOaq2G23UvVxBKz/H
	zei0mjj8GNdAjx/IUuOxL4QIHDDcR4T2JVGcv2h7kF3qQTLJDBq6LhTdeKUwFwHN
	Dl2W0ScRZzc+73UKAFzj8XIVIzZbTs1WF0Gc/CzARayC6MeT9zAqDiAT0/cjl149
	Rs3Q+n7slJwqndSXsDwXwTpJuETBlnCf7OrHlvnCDo/jIhntMwF18NO62XmE+B50
	AC/0mlsbEBJY+LwUbiZcxGSBJRlO+4WTw3hqP1yrnsY9zgN6PmO1Nm5yUzwLs7lF
	b33HwEouGgII/mA4Xl1elBonszanqT2CKWi1R0ki6VDqY8YAB3CTS7+MtTaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723530663; x=1723617063; bh=iB+MyhSASKg0XYaDC/0qCMpPUvrP
	ckIWGNOjVCIZHSo=; b=JFdiCga+r55pHsr+RyMs6z4VaBBFVp4t6TeO6C2j+78+
	d5kgq0pvI9u779un4dQW1ELnGGNudL3JUn/fA0ptk9v1yzfrgVAN/jy3LCxald7y
	88RlbayANKA8CQPk1PMzXgVZ4DNbvU41D/vAFpNaGis8FcLj4SLM7SxaD4cE7PXf
	lQvRq/lBdrw65XHY8f7WpjgUwo0O0MCcoWgBftNXWWHM36Un0lZJioS4bSAqaaIF
	4Ymu9uwgsSy43b56kvYqSzwOKc1FXB4sqj0Klq4444BM/h9EDFu9a8h+4GQ5qTUW
	OIR7bJnwFMmUjbiHWZio7hXL32kdz1Npynz7xHL08w==
X-ME-Sender: <xms:p_26ZroJPTll84l6rI56hQAUeNnyIyJp3IDLzR1EQRu8yb_vgJ3HOw>
    <xme:p_26ZlpcKMH9Ad2ZwK0rjYZcqYDktDaPGZSFiJASyYrlX7Sb0PLY0N6ejQnLZJM8v
    Avo45JqRErAIAFjhw>
X-ME-Received: <xmr:p_26ZoOGgKexohCnGl1uk__IO9RVWXYFPL8TE1Mn7MXAeYzcJLlx0-RW3wZJRLjgNdT_wFqUa3d_1MizEKEN8U9SzRQKdAdgLe6gHlemiDxQkw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtuddguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjrghmvghssehjrghmvghslhhiuhdrihhopdhrtg
    hpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfe
    esghhmrghilhdrtghomh
X-ME-Proxy: <xmx:p_26Zu5jOqrVaB4RLrRqNkOck5__opjR4m2H8yq0sdD5_a5nycNYmQ>
    <xmx:p_26Zq4kULAaxsT6SkIiatqWhlfs3p1NQTANpp80dbjk8dBXV0kPKQ>
    <xmx:p_26ZmiOYki2hGaGfFdnw7CY4hxYMXbSAPUi4Bdmh3ohcdn3tjglzA>
    <xmx:p_26Zs6jZUizrr5ICvqa5zIVR1zLLdqWwUeN3OCipUU075oETIOrRw>
    <xmx:p_26Zl2ejmk5hDvMfk48DDZB4LhGXR-_T7ftnia71sdyDW9HPRVEfRmT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 02:31:02 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a4794d0a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Aug 2024 06:30:45 +0000 (UTC)
Date: Tue, 13 Aug 2024 08:30:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, James Liu <james@jamesliu.io>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 02/22] git: fix leaking system paths
Message-ID: <Zrr9oxgg3w8JyUpw@tanuki>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723121979.git.ps@pks.im>
 <324140e4fdee54fbf0054e76abb287b7212fd21e.1723121979.git.ps@pks.im>
 <ZroX+SSgTe7YnWHS@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZroX+SSgTe7YnWHS@nand.local>

On Mon, Aug 12, 2024 at 10:11:05AM -0400, Taylor Blau wrote:
> On Thu, Aug 08, 2024 at 03:04:39PM +0200, Patrick Steinhardt wrote:
> > Git has some flags to make it output system paths as they have been
> > compiled into Git. This is done by calling `system_path()`, which
> > returns an allocated string. This string isn't ever free'd though,
> > creating a memory leak.
> >
> > Plug those leaks. While they are surfaced by t0211, there are more
> > memory leaks looming exposed by that test suite and it thus does not yet
> > pass with the memory leak checker enabled.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  git.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/git.c b/git.c
> > index e35af9b0e5..5eab88b472 100644
> > --- a/git.c
> > +++ b/git.c
> > @@ -173,15 +173,21 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
> >  				exit(0);
> >  			}
> >  		} else if (!strcmp(cmd, "--html-path")) {
> > -			puts(system_path(GIT_HTML_PATH));
> > +			char *path = system_path(GIT_HTML_PATH);
> > +			puts(path);
> > +			free(path);
> >  			trace2_cmd_name("_query_");
> >  			exit(0);
> >  		} else if (!strcmp(cmd, "--man-path")) {
> > -			puts(system_path(GIT_MAN_PATH));
> > +			char *path = system_path(GIT_MAN_PATH);
> > +			puts(path);
> > +			free(path);
> >  			trace2_cmd_name("_query_");
> >  			exit(0);
> >  		} else if (!strcmp(cmd, "--info-path")) {
> > -			puts(system_path(GIT_INFO_PATH));
> > +			char *path = system_path(GIT_INFO_PATH);
> > +			puts(path);
> > +			free(path);
> >  			trace2_cmd_name("_query_");
> >  			exit(0);
> >  		} else if (!strcmp(cmd, "-p") || !strcmp(cmd, "--paginate")) {
> 
> 
> Makes sense, though I wonder if this would be slightly cleaner to write
> like so (applies on top of this patch):

It is cleaner indeed, thanks for the proposal!

Patrick
