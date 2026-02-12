Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0046296BD2
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 06:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770878354; cv=none; b=DvgFydSgInRHWQX6ZSjx66vAHImIEqoLJiGedkOJJiHBSvtam6qP6XLp2n0ZAdhhNloCXwhwg7udsULed03KYpdgd0C15//UkrX2TWDybKlYfpRV+W4iot6va3oVqsJBFWXLgYVk8lL/ucls8275+eHUgbHiMdqBiEw1rWO3xsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770878354; c=relaxed/simple;
	bh=kuaNeYDxX2iNWDUtrq60Uvos4TRV7+tTDDprLVmkdbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rrz2kF1DYszGamZIwNF1eigYUAnacJLW3TXsQPFAcwZE0zxP+0QnobyCfq80h0aypUivTk3bGh+qvEScZcknUulr5zhesc7nNbghQIA1Tb8oavr+xH2PRtE+rycchPS/VSlocsbQGpClqkeSj5M0fnB/wsH2MQrEJEfr4c5lj8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nwKqNd2L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TjtlD+XR; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nwKqNd2L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TjtlD+XR"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D92EB14001EB;
	Thu, 12 Feb 2026 01:39:11 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 12 Feb 2026 01:39:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770878351; x=1770964751; bh=xMDplIdmLu
	7n6tbId2KyxFX/Yhup1KjWx1CNYKhRoYk=; b=nwKqNd2LUmb892wYYLjmEfyfA/
	XrKhWhfMwG2OHDp31gHizoVSgWbzRAXeTicaBFnAM+FL/RBIhC+qDKftbV0tMJpM
	eGIqIgne39hrg/q/ALtOhwo/sLZ8xIWs8j2p9w9z3oNpbyye2xOYnDvulx7v8YT+
	URd9KX8EGo61ISNytvk0sbCVMT1N0NTFBip2qVshVX6H+UPjnhXpLeKNBYenyOPU
	o4ysOlNH5kWVn9p1pQNxSFc9p72Cdb0psSylOIc3Uv27A7uYaWgVnssqWPHGHIET
	OoWf0IdgxscYnNy6xMXeuBq1ls4bmG/li8S7jtBQPOrpOSsUCZ2geh9sm0DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770878351; x=1770964751; bh=xMDplIdmLu7n6tbId2KyxFX/Yhup1KjWx1C
	NYKhRoYk=; b=TjtlD+XRRgQyBkFYWkYfRU+cZyPqCnj/sE2uFcC0vvmLqqdp2Yf
	9jusscr67m/TKnK4UO48IbdFoymkudpw7j2YZbYxUwJsZV7BqoYuiGVrwKMR+7Lb
	gi0Xi53ufsvT0Mp/qihoSsTxJtIaYmmrNfUPWiqyK2efxuHJu+L9lHFAVni8LjIY
	ivY2w53+lTjgunGICFWRsFN72uTCs0uc3wfOpGF6yK4WlSX1Fw9XAVvgf40iP253
	OWSXExuzO6CkjfAqQgzzA75P3AA/1IkXFIjERX+X0kG05NSA2JREzGhuiqITHv2G
	bE4LrmB05JBf0/Jdzii2gI3QZoHSeA4xvkg==
X-ME-Sender: <xms:j3WNaVtAXywLBp4fQHrNZgkuk3WHe_6hhKsYgyah6I-QqC2_e7XT-Q>
    <xme:j3WNadgjrUQNBdGEx4EuLrNESNMG3YIYovNROvpN6MOzttVH_83cXi0c_unnkRR9l
    OvIUOTmZnTT9LHIXi1i_HCDWH9Nw5Ysh8FW4FH-oVrRJMSIAYqq4A>
X-ME-Received: <xmr:j3WNae8QmboaMhT8I2DEdtN6UHNdwfWDX2kdHg8aSB1wbeM67CVoc46-u5EoDY7SxcTHFDTgyvV3fIl7f6YLNznEUpk0P6hSJxv6zdIvYlQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdegieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougdu
    vdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihth
    hoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrg
    hsthhmrghilhdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdp
    rhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrh
X-ME-Proxy: <xmx:j3WNaYsNoEus8YCGEHoin6kdQ6xuNQLcnuHNCuE88O8NJBkNHTxLMw>
    <xmx:j3WNaao0sy0_MKFzIO39mFn5rvqwbteXLEka2YVFatO4Ukra8yNxSw>
    <xmx:j3WNaUomDlC6WATmCRx9C-RUoLx6eRujPpCnuQDp_ghW1KXbAe50Iw>
    <xmx:j3WNaRYaaMfPPa-C2tJEsTqKifh02K97XrkBQjTapYgrpzOnZ5dHgQ>
    <xmx:j3WNadGbqVLNFZNsip1OJw2bN6vNCI3G2JU9ytZoAZBvz3I7xaUgo0N->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Feb 2026 01:39:10 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 906b1e07 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Feb 2026 06:39:09 +0000 (UTC)
Date: Thu, 12 Feb 2026 07:39:06 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee <stolee@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, gitster@pobox.com,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH 5/5] config: make 'git config list --type=<X>' work
Message-ID: <aY11ikm_sgDlneV7@pks.im>
References: <pull.2044.git.1770698579.gitgitgadget@gmail.com>
 <e27d52c4a5970f774e324b0a9c0badb0532bf3d4.1770698579.git.gitgitgadget@gmail.com>
 <aYxyeAQ_-9KXxI-L@pks.im>
 <1fb94c08-c36a-445b-b613-dda33c238d6e@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fb94c08-c36a-445b-b613-dda33c238d6e@gmail.com>

On Wed, Feb 11, 2026 at 12:49:19PM -0500, Derrick Stolee wrote:
> On 2/11/2026 7:13 AM, Patrick Steinhardt wrote:
> > On Tue, Feb 10, 2026 at 04:42:59AM +0000, Derrick Stolee via GitGitGadget wrote:
> >> diff --git a/builtin/config.c b/builtin/config.c
> >> index e69b26af6a..c83514b4ff 100644
> >> --- a/builtin/config.c
> >> +++ b/builtin/config.c
> >> @@ -363,21 +363,12 @@ static int show_all_config(const char *key_, const char *value_,
> >>  {
> >>  	const struct config_display_options *opts = cb;
> >>  	const struct key_value_info *kvi = ctx->kvi;
> >> +	struct strbuf formatted = STRBUF_INIT;
> >>  
> >> -	if (opts->show_origin || opts->show_scope) {
> >> -		struct strbuf buf = STRBUF_INIT;
> >> -		if (opts->show_scope)
> >> -			show_config_scope(opts, kvi, &buf);
> >> -		if (opts->show_origin)
> >> -			show_config_origin(opts, kvi, &buf);
> >> -		/* Use fwrite as "buf" can contain \0's if "end_null" is set. */
> >> -		fwrite(buf.buf, 1, buf.len, stdout);
> >> -		strbuf_release(&buf);
> >> -	}
> >> -	if (!opts->omit_values && value_)
> >> -		printf("%s%c%s%c", key_, opts->delim, value_, opts->term);
> >> -	else
> >> -		printf("%s%c", key_, opts->term);
> >> +	if (format_config(opts, &formatted, key_, value_, kvi, 0) >= 0)
> >> +		fwrite(formatted.buf, 1, formatted.len, stdout);
> >> +
> >> +	strbuf_release(&formatted);
> >>  	return 0;
> >>  }
> >>  
> > 
> > I wonder whether there is a good argument to be made here that we should
> > keep the old logic in case no "--type=" parameter was given. In that
> > case, for example the following output would remain the same:
> 
> If no `--type=` parameter is given, then this new implementation does
> the exact same thing as the display_options use a string format (which
> does not mutate the config values).
> 
> >> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> >> index 9850fcd5b5..b5ce900126 100755
> >> --- a/t/t1300-config.sh
> >> +++ b/t/t1300-config.sh
> >> @@ -2459,9 +2459,10 @@ done
> >>  
> >>  cat >.git/config <<-\EOF &&
> >>  [section]
> >> -foo = true
> >> +foo = True
> >>  number = 10
> >>  big = 1M
> >> +path = ~/dir
> >>  EOF
> >>  
> >>  test_expect_success 'identical modern --type specifiers are allowed' '
> > 
> > I'm not really sure whether we want that though. I actually like that
> > this also leads to some code duplication, so maybe this is fine?
> 
> The change you highlight here is a difference in the config file _contents_
> and not the expected output. These changes are to help demonstrate that the
> bool and path types make meaningful conversions when listing these values.

Ooh, right. Completely missed that, thanks for the clarification.

Patrick
