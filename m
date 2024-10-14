Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A2219E80F
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 10:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728903190; cv=none; b=WMxXHDqLLFZNvBftR82Twi3e3sdCua2ENPA9YWHf5LlFyjplwC05xmYzIfgjIWDBnj0jXrq5zkxVn5fxlXNPMG3QQ2x6czpkgBfEgCFzKntY1Xf6GteDCG/4ywGx+C6p0r3QM2sFf/tvAovc7zZS7U4vbM65SuNXn+ixZniE1Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728903190; c=relaxed/simple;
	bh=viAH8k+clCWen5vmUukqOgv9OS2bstytpy7HB9PsUHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXF0yO88b8OwdXAdjP0OzEr81tXYp8sRUqSC4aVsdz5VxAjNdPrlvBGHDWxMddIak48Tvs8Ypai5k76Sd3tfD7K+UytCSMzXxydrcT8WdVLgn+nAL5OgzLuqcQzWpthVMMP7Xdcd+IPorGetObyzeiFHfvuei603GOTxISPBsaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=A/BQiUqN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aAL09mD1; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="A/BQiUqN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aAL09mD1"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id B279713801AB;
	Mon, 14 Oct 2024 06:53:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 14 Oct 2024 06:53:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728903186;
	 x=1728989586; bh=fIH3rIz5U8xlxwpejdD6vf+zxkjYQaXxrPLrewSVtLs=; b=
	A/BQiUqN9LIi5fPOBExlW7CLJN+1//C2sqsmT5+Mgs5Qh3ZgZv9CCg3OTKweXaXs
	WsbeU7MXnDPKlovxZNIuH7CKVrfB4B12zrOc9xPal2R1ITau392BDX57NcVBav9M
	x31p69UHsRiecUzVxx1FW+aC2Pr7JxaYs2c7ebH42HrVkyVJXMEuDA9Tu7lPbKPZ
	SmM9VEOJK4bcrO302n09IVMIvOzzD97qJvyWrw/mVf5qMATMBuVP880IJlA5IL+/
	OhISgkMwBcGRbB7nveiCXzX+juu99s/5yOCMo1KIlNm4xrLIxreQM3mSyHl3kfzu
	NHiCig0PgmxFzK0nLHNSag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728903186; x=
	1728989586; bh=fIH3rIz5U8xlxwpejdD6vf+zxkjYQaXxrPLrewSVtLs=; b=a
	AL09mD1RrIdlhbCAeSDnW/d2N3QeRq3+gjfz3/TFBkIuQgLFir81eA6qFmZZNIyw
	qGM8dUs2RqUik7zPO83kYN0PVrBetgNYNyh4hl0jTGBTeENFSZsTDFsPmADJodlC
	6pXpkW0Qsmqig6PLaGivsUsgKbgZVRtsVtTJMXxmfBgZ6hC7ZVGZESTewSbUMTlN
	3jJ7IR4qg9IKP4ZMS8Pn9F9y1y+htJ4PZH22F5ds0PzQpXY52nyyYdnb6Gg7NKaF
	ykSvbbnRyAx0Yw0kJAV4vNxXEZJv0leA4pqG2l+v+QUPWXKy6RGENUmu6yxKwSNE
	SSl9iZIB4flXXdvQF6RRg==
X-ME-Sender: <xms:EvgMZzstpt1P8mumVAdm8SeeEeszc4LXV4uabM57IA4yqS7u2LT3sQ>
    <xme:EvgMZ0dgvtDAHzsf2k-rYTVRATAk__UGbjLJZJkF8NlD-3nK-ltSaMZUS4hEK_j5B
    YvMiXnmplg02IAKJg>
X-ME-Received: <xmr:EvgMZ2wgYzb3saa49DoGePmfV5TmtuNWVODM1NxuOiNiSlXMpxO-BEKj6KAspHanOvr9PL0-KbtnB0nqAKc7sDfeYgefBOJCH6CaKrVki2yNGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeghedgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeeileelleduudeuffdtheeugeduhfevleethfdtudeg
    veeitefghffhgfetheeihfenucffohhmrghinhepphhusghlihgtqdhinhgsohigrdhorh
    hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhs
    sehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepuhhsmhgrnhgrkhhinhihvghmihdvtddvsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:EvgMZyNCyQfUu7UjmXA7MYXqGAhGpdmSjIisI1Bp6N1bXfoTOeLUMQ>
    <xmx:EvgMZz9fpLDSVepsZ4tHtubSae90IcheTkCum6Mfb3JaXUcH0ziyDQ>
    <xmx:EvgMZyXEidRH6pf71E7KGcaZI5ZxaCHRp5xYgO1KYJWNFRYqp8rrhA>
    <xmx:EvgMZ0dTm599VqeZ2DUVB_-U9jSnSAhh0U0YAiw8t3HruNX0Gkq0tw>
    <xmx:EvgMZ2apljD6SBgmKGsmf90UVpOJbwfCR28ipvqOFn5oQe7IKrmyhUwh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Oct 2024 06:53:05 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 49325a9b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 14 Oct 2024 10:51:51 +0000 (UTC)
Date: Mon, 14 Oct 2024 12:53:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 3/3] parse: replace atoi() with strtoul_ui() and
 strtol_i()
Message-ID: <Zwz4B4osJnYJw6pd@pks.im>
References: <pull.1810.git.git.1728774574.gitgitgadget@gmail.com>
 <c93bc2d81ffb33a2a61dda2878fa3b9987545e0b.1728774574.git.gitgitgadget@gmail.com>
 <CAPSxiM-V1qOB9QXUY3aDh+_nGdDHBWXJZ54U9p_XxKfHoODu7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPSxiM-V1qOB9QXUY3aDh+_nGdDHBWXJZ54U9p_XxKfHoODu7A@mail.gmail.com>

On Sun, Oct 13, 2024 at 09:42:41AM +0000, Usman Akinyemi wrote:
> On Sat, Oct 12, 2024 at 11:09 PM Usman Akinyemi via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: Usman Akinyemi <usmanakinyemi202@gmail.com>
> >
> > Replace unsafe uses of atoi() with strtoul_ui() for unsigned integers
> > and strtol_i() for signed integers across multiple files. This change
> > improves error handling and prevents potential integer overflow issues.
> >
> > The following files were updated:
> > - daemon.c: Update parsing of --timeout, --init-timeout, and
> >   --max-connections
> > - imap-send.c: Improve parsing of UIDVALIDITY, UIDNEXT, APPENDUID, and
> >   tags
> > - merge-ll.c: Enhance parsing of marker size in ll_merge and
> >   ll_merge_marker_size

To me it's always an indicator that something should be split up across
multiple commits once you have a bulleted list of changes in your commit
message.

> > This change allows for better error detection when parsing integer
> > values from command-line arguments and IMAP responses, making the code
> > more robust and secure.
> >
> > This is a #leftoverbit discussed here:
> >  https://public-inbox.org/git/CAC4O8c-nuOTS=a0sVp1603KaM2bZjs+yNZzdAaa5CGTNGFE7hQ@mail.gmail.com/
> >
> > Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> >
> > Cc: gitster@pobox.com
> > Cc: Patrick Steinhardt <ps@pks.im>
> > Cc: phillip.wood123@gmail.com
> > Cc: Christian Couder <christian.couder@gmail.com>
> > Cc: Eric Sunshine <sunshine@sunshineco.com>
> > Cc: Taylor Blau <me@ttaylorr.com>

The Cc annotations shouldn't be part of the commit message. If you want
to Cc specific folks you should rather do it e.g. on the command line or
whatever you use to send out the patches. Otherwise, these will all end
up in our history.

> > ---
> >  daemon.c    | 14 +++++++++-----
> >  imap-send.c | 13 ++++++++-----
> >  merge-ll.c  |  6 ++----
> >  3 files changed, 19 insertions(+), 14 deletions(-)
> >
> > diff --git a/daemon.c b/daemon.c
> > index cb946e3c95f..3fdb6e83c40 100644
> > --- a/daemon.c
> > +++ b/daemon.c
> > @@ -1308,17 +1308,21 @@ int cmd_main(int argc, const char **argv)
> >                         continue;
> >                 }
> >                 if (skip_prefix(arg, "--timeout=", &v)) {
> > -                       timeout = atoi(v);
> > +                       if (strtoul_ui(v, 10, &timeout) < 0) {
> > +                               die("'%s': not a valid integer for --timeout", v);
> > +                       }
> >                         continue;
> >                 }

We don't use braces around single-line statements. It would also help to
explain whether this is fixing a bug and, if it does, then it would be
nice to have a testcase that demonstrates the behaviour. The same is
true for the other sites that you convert.

[snip]
> I also want to ask if this is the right way to send another patch as I
> noticed that it is showing my previous patch which is not related to
> this. Thank you.

You shouldn't ever include patches from another patch series. I guess
tha problem here is that you created all of your work on the same
branch. I'd recommend to use separate feature branches for every series
you are working on. In general, these branches should start from the
current "main" branch.

Patrick
