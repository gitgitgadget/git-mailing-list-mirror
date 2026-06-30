Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C6D2673AA
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 08:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782809150; cv=none; b=HYOXVeLih/xwdOiwZsJe2XlTtzliySL5oWLMJNkh4Sc5SQL21Bg7CWvPoew0Y3AryHuWLBtXYvgSRmJLndhe4Ip2JFQrHpMqJLCoTMDvxK/940LjMPcIigJBvAA27CqDkJ4tQ6rK+OcitWUnwecU43cLWV4x6JfTFhSFly+E0/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782809150; c=relaxed/simple;
	bh=sUn1gcPe6TbrJT2abJ56EjV+/52ZS4XubA7rOE9EmP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ze4N0XuV6XcqSTc/bXLC6TYj0E+cwHcer7pjRS/86hywUpeou6DYrmc0Kl5aZiUZL66brF/v00x0RyxVp36j51r5bfUCKv4MTG4NTaxU+iRMGyj8f3t8WI5RB6xG8OFgFxiOBE8mfTA4YmcOUXDi1gz2jAgKnKaLXD/53870rz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=H8ooYt9y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vtef+YSL; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="H8ooYt9y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vtef+YSL"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 863971D000D6;
	Tue, 30 Jun 2026 04:45:48 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 30 Jun 2026 04:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782809148; x=1782895548; bh=8Fh954yAmx
	UaHgiDGqs4tETEd8toC13wwCIN6OTT/Ks=; b=H8ooYt9yck/BK+0CHfvl/ngCvy
	6iCQMyvZs2kflIR5PmwgRDdDJ517UjkhH4hHCdWtb+ML/68KSwTlhmwyOqqCWFCz
	0fJ1uz6J/hsCHvGydSHcV8v9ujstNQ2/gfH83MqGIYyZ+GohHhndJIR7FezyNIm+
	7Lj3C9RNz2y7HIoJAjVcNZ+5czL+dUh+vQsn4Zh2/5UPyjDcRlEH8H0q1Gq5s3uO
	KDJS9QJyhltgL+fHwUWy2vdWFy1Fpjhtpmke9MQJmbTQQuxAVdVJN5h2+wkWN4xd
	RbQHIjvTyy/SXkyPKVKOvJC0sEq0k/Z/1gYoPIon9p207KX6GsyfRgMIA8ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782809148; x=1782895548; bh=8Fh954yAmxUaHgiDGqs4tETEd8toC13wwCI
	N6OTT/Ks=; b=Vtef+YSL9XxVkd4ILkfigej0GyWgYab9mbAIViSSTxkvfKv4fmk
	1HE/eUma7CY+T72DNlP6lx3lkDkkNZL/kt5ttox/7Ja3D6szLvAeScDYhZWeZBTi
	WWc4lAYhlPPaaOFzqEYTHqLbAu0lFh5fU41zGgBoj5VCd2SoeVjZ/ao71Ay+EjO5
	dJk/mY1WiUJkXsGyBB7/dEuVqAUhePrH1AZielZBW/KKbhxVBnXWR57trazf1udN
	2ZI9lyqP64zRuYljt/p2k+jMvw/Zah6nU0CcdQpv0AtT04FoNKXZFgHagOQVbup/
	alBlH36+wtc2X2+y/Fbj3PZ9y92NhRuMBtA==
X-ME-Sender: <xms:PIJDasjmUy0VNH9uxGTP5JyRMt2UYOXO5k7I2cwcHxD7kWF4CNpYdQ>
    <xme:PIJDarCSBLfO46-M3tsiLiVixqlPuXvbNZyCx6fh5TexTk-fgjBD-5dE2NzrS23Kk
    Vz0x-w7Kfh4e78S1Ff7ErhQ6M_V8REklPGkQh8DoRgGO8ZbYeLXCg>
X-ME-Received: <xmr:PIJDahuLRRcoY_yy5kjqkjj9x0gCrtNwA2W6E_2aT08GlShIh2CuJAo6UVeRay6y6726wkaXC3ZoaAmWx7x7x9Z6R3puTLtw182jhC0eICO0Zg>
X-ME-Proxy-Cause: dmFkZTGc7sxv2TGyzY2QPNUj0p4U40BkcTr0mOHVuNfYZjooiKFk72DOzzS16x8anVv2ps
    RoqpSxFiiJKKE49lhe84SSY/u8FOif5Ttc5Ig1j8Z2LfeJunDtnxFgNsyNxyvE1Ob8OR25
    f/WBhEN3ZibgEqwNCOSS0IhW/6a27vuxx9NxHS90NLXSKnFG1e0yg7pVcIONe6/exuGOrH
    XXFDheDF49zUNS4EWKniXgJ0Hd2zSThRkHxgBgIVnvcS8Jb/btQbtLmbs9HWOpl85AB0tH
    5kEt99HUbNJ4MdBA5k7FX7lE5EVH7h/Sxdvmh0C7HbfLkgBrPqG4qVxSZ5oNWZaNHRoOWm
    VlHjoK4pSoEX3oHk363bArQFeeBANKsIEqNPBqgHhd2YFLRxA4hd9OOSyszCxJVF9FR0KK
    NQd63uib7YsHnsyDSOh4BT1EsCv0TdDxYSdYYpFaZHzTExF35NzHOspz8Lnxh6jb/z/825
    kCGUDbuJSAafWmO8snlluSaX+GvYemCFxaMc+w0mE9L+W1UNsi/WNrK/5/yPeDb8bQjeq7
    op5eChIgiK/WLQnNXYX+6bP0Q0QMfX/vFQ8WJm3xU+R560g+jmnsG9nfLKD6uYPrIswdtf
    tRQCuBLDt3W5v0kzsTKIfsZ9KeOXtDiob/3SVfkiWpqQNkHryaTjySS9zwOw
X-ME-Proxy: <xmx:PIJDaobFVDIsWkhj-oITNoWIK_mpjO5MupgrzHLWzsDIj94x2E116A>
    <xmx:PIJDasX73MwijT4vhfE1zYlbZGwDVZsz6fgjTNld5JWOr3cjwFqnGA>
    <xmx:PIJDak4cflGqNs2fao8xjlXAiG_1W3YVB9afcE4oPY1Dfe02x1PF6g>
    <xmx:PIJDavjTnJezF4ldgtIGT6xWuuYjh6Q9r-fOEPre-iRA7I_mLacFVg>
    <xmx:PIJDakQOPn921DlyyEBpdFGhb90QWfwg5goF4qt67Athh45yKdVnhcVX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jun 2026 04:45:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id abd71412 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Jun 2026 08:45:47 +0000 (UTC)
Date: Tue, 30 Jun 2026 10:45:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/6] object-file: propagate files transaction errors
Message-ID: <akOCODgg02A-2Bys@pks.im>
References: <20260624041920.2601961-1-jltobler@gmail.com>
 <20260624041920.2601961-3-jltobler@gmail.com>
 <aju-7Z-ecJG_ORow@pks.im>
 <akK1roQJknYstX0u@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akK1roQJknYstX0u@denethor>

On Mon, Jun 29, 2026 at 01:58:54PM -0500, Justin Tobler wrote:
> On 26/06/24 01:26PM, Patrick Steinhardt wrote:
> > On Tue, Jun 23, 2026 at 11:19:16PM -0500, Justin Tobler wrote:
> > > diff --git a/object-file.c b/object-file.c
> > > index a3eb8d71dd..18c2df75fb 100644
> > > --- a/object-file.c
> > > +++ b/object-file.c
> > > @@ -499,7 +499,7 @@ struct odb_transaction_files {
> > >  	struct transaction_packfile packfile;
> > >  };
> > >  
> > > -static void odb_transaction_files_prepare(struct odb_transaction *base)
> > > +static int odb_transaction_files_prepare(struct odb_transaction *base)
> > >  {
> > >  	struct odb_transaction_files *transaction =
> > >  		container_of_or_null(base, struct odb_transaction_files, base);
> > 
> > By the way, is there any reason why those functions are still hosted in
> > "object-file.c" instead of in "odb/source-files.c"? I should probably
> > know, but I forgot.
> 
> There are currently a couple spots in the "files" object write path in
> "object-file.c" that still reach into some of these transaction function
> that are not part of the generic ODB transaction interface. I'm hoping
> in a future followup series to detangle this a bit and be able to get
> all the "files" ODB transaction related code moved into
> "odb/source-files.c".

Makes sense. I also revisited that code a couple days ago, and the
answer is "it's messy right now". Hopefully this will become easier to
detangle as we make progress on pluggifying transactions.

> > > @@ -511,11 +511,15 @@ static void odb_transaction_files_prepare(struct odb_transaction *base)
> > >  	 * added at the time they call odb_transaction_files_begin.
> > >  	 */
> > >  	if (!transaction || transaction->objdir)
> > > -		return;
> > > +		return 0;
> > >  
> > >  	transaction->objdir = tmp_objdir_create(base->source->odb->repo, "bulk-fsync");
> > > -	if (transaction->objdir)
> > > -		tmp_objdir_replace_primary_odb(transaction->objdir, 0);
> > > +	if (!transaction->objdir)
> > > +		return -1;
> > 
> > Huh. So previously we just didn't handle this error at all and just
> > continued to tag along? Did that result in anything sensible or was this
> > just YOLOing it?
> 
> Good question. Previously if there was an error, we wouldn't end up
> creating any tmpdir and would instead continue to use the primary ODB to
> write objects in. This change would make it a hard error if we fail to
> create the temp dir. This matches the behavior that git-receive-pack(1)
> expects, but I didn't consider that the existing callers could
> transparently handle there being no temp dir.
> 
> I suspect we may want existing ODB transaction users to continue being
> resilient in the same manner. In the next version, I'll maintain the
> same behavior.

Honestly I'd say that the change is a good one. I cannot think of a
single reason to just blindly not create the transaction and proceed.
But it certainly is something that should be documented as part of the
commit message.

> > > @@ -1670,27 +1678,34 @@ int read_loose_object(struct repository *repo,
> > >  	return ret;
> > >  }
> > >  
> > > -static void odb_transaction_files_commit(struct odb_transaction *base)
> > > +static int odb_transaction_files_commit(struct odb_transaction *base)
> > >  {
> > >  	struct odb_transaction_files *transaction =
> > >  		container_of(base, struct odb_transaction_files, base);
> > >  
> > > -	flush_loose_object_transaction(transaction);
> > > +	if (flush_loose_object_transaction(transaction))
> > > +		return -1;
> > >  	flush_packfile_transaction(transaction);
> > > +
> > > +	return 0;
> > >  }
> > >  
> > > -struct odb_transaction *odb_transaction_files_begin(struct odb_source *source)
> > > +int odb_transaction_files_begin(struct odb_source *source,
> > > +				struct odb_transaction **out)
> > >  {
> > >  	struct odb_transaction_files *transaction;
> > >  	struct object_database *odb = source->odb;
> > >  
> > > -	if (odb->transaction)
> > > -		return NULL;
> > > +	if (odb->transaction) {
> > > +		*out = NULL;
> > > +		return 0;
> > > +	}
> > >  
> > >  	transaction = xcalloc(1, sizeof(*transaction));
> > >  	transaction->base.source = source;
> > >  	transaction->base.commit = odb_transaction_files_commit;
> > >  	transaction->base.write_object_stream = odb_transaction_files_write_object_stream;
> > > +	*out = &transaction->base;
> > >  
> > > -	return &transaction->base;
> > > +	return 0;
> > >  }
> > 
> > It's still somewhat fishy that we have this ODB-level transaction, but
> > that's a preexisting issue and thus outside the scope of this patch
> > series. Ideally though, it would be possible for there to be multiple
> > transactions, and it would be the caller's responsibility for juggling
> > these transactions. Just as it happens with reference transactions.
> 
> I completely agree. One of the current problems preventing this is that
> only a single instance of tmp_objdir is allowed and stored globally.
> This is done to keep atexit() cleanup simple.
> 
> My plan is to eventually convert all existing tmp_objdir callsites to
> use ODB transactions which should hopefully allow us to remove the need
> for a separate tmp_objdir system. At that point, we can also work to
> change how temp dir cleanup is handled at exit.

Great.

> Another problem is that there are also a couple of ODB transaction
> callsites that require to know if there is already a pending transaction
> for the repository and the transaction has not been wired down to these
> callsites. My hope is that this can be addressed though as we expand ODB
> transaction usage for object writes.

Yeah, agreed. Making the use of transactions explicit feels sensible to
me.

Patrick
