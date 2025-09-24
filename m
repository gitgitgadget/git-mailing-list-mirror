Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4662877E2
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 21:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758750978; cv=none; b=DgQWcPX9Pl05apSFzpHp+FRusz3axBpnwqjAK3cySpaycC8ibT5MawSLCJJcvSbF9+B2cV/JXHX3FVa/nmfBUyGRoqou5baNiQvHCglebAUt/M0cnlBA5MoiEJlvWQA5rCTUvD49X0aKccs5dmzMEmUS7ak36/WAXcBnxWvn3MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758750978; c=relaxed/simple;
	bh=udB0hvTmrsA3OUdl4piI52aF+2q7y0nZppZYdFJdR5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DfAuW0liUBEOu8/amjtIOBVTR2goNOpNL+DLL37/wH8gqjVO5ORKRT66xB741dtyCb1HpyN3ofsPtdfAlWtXGOZo//mEzwixXkXQlLBII/viOBLX6JpnumLurBRJdI26+nONQji9icg1YPhJVpb3Ts58kiWoae5nVhx0lbU6BQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QG866t5S; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QG866t5S"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-34207c1bdaeso111364fac.3
        for <git@vger.kernel.org>; Wed, 24 Sep 2025 14:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758750976; x=1759355776; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NQ5aCaK4rXmUCTaHLnlX1Pnk/eMFDNxh+GCpD3xI+C4=;
        b=QG866t5S2gZ/GeVDnXbisFE4b9Fs7AutLWMR0PqF3e1tufL7HnqAcq/RpJ668qagqj
         SOEKH2JYmXIMge2ogDVs3Kq47/GHncNOunAz4AziTcLfHO7kY3qyQWsD8+wD4lexSy/2
         7lGgNQSArgY1GP4eIeYDpq/i7Ehs1uWWIbc+j9zMKMv9Q9rRGra9Dkp+HrQ7plNz+9BA
         oCyu8rCL19HaFnc3KJYlqt4jpVbSd/U53vaoG4UqDzD5CegMOU0w3iSZdZ64GzGAAYq4
         9HuJEAJx0VELl8/rT7hE3RBekTxpnXaadOG3Fri767ZGcJMLodOGK5097HF9QqJqg9v5
         UuqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758750976; x=1759355776;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NQ5aCaK4rXmUCTaHLnlX1Pnk/eMFDNxh+GCpD3xI+C4=;
        b=AFIbGFgbHcOyzEM51HMZnhx+MrKtYfGkjWEfS7Psu5irMPvxEXehiRx4erbm4NQbMi
         YjYswBxSgs/HMDd57X2tZfTuNaEt+Sf9w+JuT4gVuWQGrKf/UbT8vCUZDWG7GiH3fowX
         pnEssI9nqbwPov+ofl2sdn1VjWaG/P16X79fSiJRS0a4r7R+m8/bgSPYSZbm/GLI+VT1
         9h5l7gUxeqwUG5lta0o29JSoforGA4ScLCb5/e4TUctEpr82b/GznU5WHSE3XJxjLzn+
         bY0g70AkY9pjXkhN1I26pUp1csQOUR8tQvurtI2MVIKbcmCGn2nM4LFajZI0iW5QQfM3
         EmFw==
X-Gm-Message-State: AOJu0Yw/8xjbCYQt2pkyEMpLHVqGYTLI5HQjVGwa67oOiiN02mjfLSTo
	614Su6QyVPxqXDhNX0p9KT+TbIxmKJ/bzQcDRmE6iHFH609vjZO0Q24y
X-Gm-Gg: ASbGncv1th8aOU13fUwmoxUauUWcu51VcVoq17qjNz4qXAvKrQ3mvfydaPP9MGl1AiZ
	gWEatDVGZ+UjSh9MMyhJOUiPioIL5FE+lxBcDxXWFToERaF83QubZA1F3HFigxKgSgHH0LVyOmi
	YzY9q/YuPRpCGy6WhgITKulZ+AwREO7hc/fxEV7WZ2dXBLClDJPGsMvfbhyzNpza49GLrugwoIX
	8kqIF2Ap9YIosZDxcZ6NkXPMiz87VCEuzqnHXWuw9X4TLaixoSlPyiiTm3zhI4ekZtR5Ntwcacq
	jSHVelXKobEhH1hq3bpV14ZO+bNzYZVVT8W4wG3HfanwhGRIdK5NYBB1/YAKbU+ecQlI0+qZC55
	hy2G1Q0wvck3H8A2O
X-Google-Smtp-Source: AGHT+IEn7ECswZksVLgkgK/lzm6V8VNgx94fQ7r/iFU7Jn+BztPRtM0WbnRGk+SgLVw2UlCysdmUVw==
X-Received: by 2002:a05:6871:3605:b0:331:1139:3ce6 with SMTP id 586e51a60fabf-35eea76218emr601245fac.48.1758750975701;
        Wed, 24 Sep 2025 14:56:15 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-363b51637a2sm22169fac.29.2025.09.24.14.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 14:56:15 -0700 (PDT)
Date: Wed, 24 Sep 2025 16:56:14 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>, 
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 01/15] packfile: introduce a new `struct
 packfile_store`
Message-ID: <hl3dmtfdoeb37mftepcvxbfkh3szfkuztuaqgsjnorhwq27nbd@glwgt4dao5r5>
References: <20250915-b4-pks-packfiles-store-v5-0-d6340350934f@pks.im>
 <20250915-b4-pks-packfiles-store-v5-1-d6340350934f@pks.im>
 <hez25mocjub4zswsptv4j5etgygavllfai6zb6h2tdln2xhmo6@kjvvzrbjmilc>
 <aNJpw1uJuhmpsCQ9@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNJpw1uJuhmpsCQ9@pks.im>

On 25/09/23 11:34AM, Patrick Steinhardt wrote:
> On Wed, Sep 17, 2025 at 04:26:52PM -0500, Justin Tobler wrote:
> > On 25/09/15 10:54AM, Patrick Steinhardt wrote:
> > > @@ -91,6 +91,7 @@ struct odb_source {
> > >  };
> > >  
> > >  struct packed_git;
> > > +struct packfile_store;
> > 
> > I find it a bit suprising that we already add a `struct packfile_store`
> > to `struct odb_source` since it doesn't get wired up yet. I suppose it's
> > just acting as a placeholder for what's to come though.
> 
> You're probably misreading this: we don't add it to `struct odb_source`.
> This is only a forward declaration so that we can include the struct in
> `struct object_database`, which happens in this same commit.

Ah, I was indeed misreading this. Thanks for the correction.

-Justin
