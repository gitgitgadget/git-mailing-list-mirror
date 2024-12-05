Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470611D5173
	for <git@vger.kernel.org>; Thu,  5 Dec 2024 09:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733392221; cv=none; b=ZaBkCjX+LSOe1QJIJN34l38MWrISl3WlqWDxquuOfJIH8wuHRnkBOI7eb0MMuDJmCZNhA/nS9r2J4Ffsm2q9X3wFEWPRs33VnSVOOaN/g358xp8aFqIwkLxlt9aFuOnTe2lYkR6MAC1vYXOz5sSafu/Fc5xU5tJVVwHQg7iMTbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733392221; c=relaxed/simple;
	bh=aV6PMWgMVtf/nouqg+Y1BJlefdCjNrUf03tH9Hjv+9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVwlSHG0qfF7O3SXO8FOj6Y4vXduyzcuqS8vR8xNpXB0WnTQ5cYtqXzAwtzpHa2NnfnIh3fbrdfjrm0zpdhD8E1TdhiwxJiCv/ojhyDM6X+0F1TG7hHkYMk/2VHrB3awIvrmHb8z28+qYyCJpvRTGuLX0PAtyrqeEDGhxl7Axiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vZgaj8xP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qMfko+Nf; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vZgaj8xP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qMfko+Nf"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 5D7891380CB1;
	Thu,  5 Dec 2024 04:50:19 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 05 Dec 2024 04:50:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733392219;
	 x=1733478619; bh=zAjM6KHPhXMpeO/C379qoqeqYA6H2qkB/qm8P7fNt1E=; b=
	vZgaj8xPKdQBtsTrHSHDmPQd6dOjQp/i7nrd57y2MdwF0e28Qlqctpk4LpRk2lL/
	0sfHf8TDFCQKliGUJOvt6dFVliPmUVMf7LbUk3aOQs7uObbkJkba+dQqFD78rkMM
	Qshpbp6qhcsD3KTmsQ2aZmCICExL/gn+9gXB1frCnftry7c9Cwdfhrgnj+qrlWHU
	gA42smr2gHqp5+Ebj6C6khwL1AebZGN+ymK/1d3sllXOEw62OS4fsRWfzXIlS6dn
	rVgbh+45scFELy3TPnS5GjJ/hVtq7AD9W9/b4Y8nDr+530huY4DMqHuiKthK2TYy
	Bgu/5KbOwz2ByOBKVHONUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733392219; x=
	1733478619; bh=zAjM6KHPhXMpeO/C379qoqeqYA6H2qkB/qm8P7fNt1E=; b=q
	Mfko+NfMOZzkVtNYKA1ALapUYzxPqW7Op1WhRJKVWPE3YzueHT4XRHHpjYvy2Cih
	YxYEYhM3CLuyon0dvxXjaOK+XtTjSN4MmD2kr/8IjTXtZw5XqcBQkrqYyTO7/AzX
	rwwb18yN17zECYbJrrJtfiiFeSNgnAk42yuZzKqpYqRybDhvr8Q5sd/AbUiDQFur
	groFfzXb9KbPmN1l0hq7gtGk86z3b2zUhrVfSXkwib356QXWNggxdKavo9fnrf0t
	HM/1+por8T3cgtRlfgsYmD3bzZSa+aHP5gFornjUEY1e2aQwBJeUKgLF1p/D5VjL
	f9QAWwhfzWL0NZSa3vpqQ==
X-ME-Sender: <xms:WndRZ5JaBxXCp5nUEAibFz2PqXw_OmZICZ-WBknCq_CCmFkMUG0tUw>
    <xme:WndRZ1LYDvK5LNxUJ0fujzJw2ovs9jI2xKfrkpQhegBVL33WcS68QO3nU21IDHWWL
    ycWqbNcxGdOdDQ_Sw>
X-ME-Received: <xmr:WndRZxsfpOW2XwgY6Os2RkcfVlJac23WQNPXSdS6oaEdLWMn_3TkvZwQK7kc6VqFkfZ3w5FTJF_fT3ypQbpEKs7xXN7I9nb5TQJVCD3f5ZhUSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieejgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuf
    fkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeejtedtuddtte
    evgfeffeffkedtteevleeludehffegueffgfffveefgeevveejffenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgpdhgihhtqdhstghmrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghp
    thhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptggrlhhvihhnfigrnh
    esghhoohhglhgvrdgtohhmpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghm
    ihhlhidrohhrghdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprh
    gtphhtthhopehjohhnrghthhgrnhhtrghnmhihsehgohhoghhlvgdrtghomhdprhgtphht
    thhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdr
    tghomhdprhgtphhtthhopegvrhhitgdrphgvihhjihgrnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:WndRZ6bsmpZwH2Yggk4RPxm2oW3Ibs02xlYWuiTK1VDNOa83a4eSdw>
    <xmx:WndRZwar36k8wJGyhwuAlRhnAKIkmDVWILqpxkP1QuGfZEFWiG3O3Q>
    <xmx:WndRZ-DRUaY1H-No7dUE_owZ7VmhSsRlTXSjirOcpA8KlDlWvewAYA>
    <xmx:WndRZ-Ytg4A3zsyXd1NJ6FbNUhgPw1QDW79HGiLbZCqqOpLSuUW4VQ>
    <xmx:W3dRZ2ME1QboS_LB0jGS7k_AJ1-R5O-h8UDSqMieDZdJgiJCxcIHyHZO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Dec 2024 04:50:16 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7b7b6159 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Dec 2024 09:48:53 +0000 (UTC)
Date: Thu, 5 Dec 2024 10:50:01 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Peijian Ju <eric.peijian@gmail.com>
Cc: git@vger.kernel.org, calvinwan@google.com, jonathantanmy@google.com,
	chriscool@tuxfamily.org, karthik.188@gmail.com, toon@iotcl.com,
	jltobler@gmail.com
Subject: Re: [PATCH v7 6/6] cat-file: add remote-object-info to batch-command
Message-ID: <Z1F3STEa_bsE82Cc@pks.im>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20241125053616.25170-1-eric.peijian@gmail.com>
 <20241125053616.25170-7-eric.peijian@gmail.com>
 <Z0RIrw2PszaY2Way@pks.im>
 <CAN2LT1C6mZrhWiK8x27yOPjRt=v8f_jnYwc6g_LtxhVGy3bQaQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN2LT1C6mZrhWiK8x27yOPjRt=v8f_jnYwc6g_LtxhVGy3bQaQ@mail.gmail.com>

On Tue, Dec 03, 2024 at 02:23:01PM -0500, Peijian Ju wrote:
> On Mon, Nov 25, 2024 at 4:51 AM Patrick Steinhardt <ps@pks.im> wrote:
> > On Mon, Nov 25, 2024 at 12:36:16AM -0500, Eric Ju wrote:
> > > diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> > > index 5db55fabc4..ad17be69b0 100644
> > > --- a/builtin/cat-file.c
> > > +++ b/builtin/cat-file.c
> > > @@ -576,6 +582,59 @@ static void batch_one_object(const char *obj_name,
> > >       object_context_release(&ctx);
> > >  }
> > >
> > > +static int get_remote_info(struct batch_options *opt, int argc, const char **argv)
> > > +{
> > > +     int retval = 0;
> > > +     struct remote *remote = NULL;
> > > +     struct object_id oid;
> > > +     struct string_list object_info_options = STRING_LIST_INIT_NODUP;
> > > +     static struct transport *gtransport;
> > > +
> > > +     /*
> > > +      * Change the format to "%(objectname) %(objectsize)" when
> > > +      * remote-object-info command is used. Once we start supporting objecttype
> > > +      * the default format should change to DEFAULT_FORMAT
> > > +     */
> > > +     if (!opt->format)
> > > +             opt->format = "%(objectname) %(objectsize)";
> >
> > Seems like it isn't stale. Hum.
> >
> 
> No, this isn’t stale. As I mentioned in my response to Junio in
> https://lore.kernel.org/git/CAN2LT1Cmsw3RB1kbRBvoeLs8WaQeZWqrG96EQfMkMe_jdKaO4g@mail.gmail.com/,
> adding type support is planned for the next patch series. Based on the
> documentation at https://git-scm.com/docs/protocol-v2#_object_info, it
> seems type isn’t yet supported on the server side either. My plan is
> to implement the logic for both server and client in the next series.
> 
> Unless the reviewers feel strongly that this must be included now, I’d
> prefer to stick to the original plan.

The problem is that you cannot introduce a different format first and
then change it in a subsequent patch series because that would be a
backwards-incompatible change. So if the follow-up patch series would
implement that you cannot revert back to the default format, and
consequently the behaviour would now be inconsistent with the non-remote
case without a good reason.

Patrick
