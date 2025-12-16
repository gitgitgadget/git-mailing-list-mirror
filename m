Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F3434029C
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 14:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765895823; cv=none; b=lRLJs27WTpIUChjjsYu3a1iaSqyGtW1woSYyzT8oQOWz/J7m3seb4sCz6BXvJ0jwylU8j5EkFHdH6Qesg0H5w5up1LcyJEAwdqlb7dhWFn1Q0+I4KADT1aNU7hjH53KJjnT6cOxMJ8EkhhNjTvKM4yMTnpgYRUZMkzisucAYTvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765895823; c=relaxed/simple;
	bh=Givq0dKCsi3ZfLagWH9emOp501JXGFAzaBE3XhPUfz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FylwzEbTxXg7vFL/f/uLbynGsl15bJ0ig8NQ7lVYUduWPTpNRTnDZINpWaotRgVAGvp07aSjlFpF48++6uos2xtrEFxi3NqyjjcP2AZYcH5rsWtTQruGlavSTdPjYSmcrCmXBKE2lfTRQr30VLEW6QdReBG/NefEp250KYP/Bu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7/AqGGu; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7/AqGGu"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-657523b5db0so1400614eaf.2
        for <git@vger.kernel.org>; Tue, 16 Dec 2025 06:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765895820; x=1766500620; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dgmE4xo26OphsSg5R0Y0gi3EqQKo6tD97MPoghMAwKw=;
        b=P7/AqGGuQauA2WxthEYxGRc5Ys3q4ttyR0UBt/9zMuRBa0NqGGW+h2GyveZDsecrVp
         iY6EpOqbjHExYyhnUNLNIeNPMibgI0SToBXTdt1pPdZfrqDf/jml3gNM0Am46JvI6tym
         BQphFowevWCCLoOD73dCHHzjpbyLRCpsr6ks/wukMc+HSquMJ6sXX4W7NSCyPudr/+o3
         tprNCoqZYlarLNce78skD8LR6DtwPiNCUMT9cd96V4zFDNDi+bwpS5+R7hjc/PqX4qsD
         1XrcG5vF9ByKJh5TS7pPyShQSnz7fyHoIV0Jqa96cITPeZLlyRorGi40QKYw38Vh0sdv
         DJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765895820; x=1766500620;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dgmE4xo26OphsSg5R0Y0gi3EqQKo6tD97MPoghMAwKw=;
        b=JFMzFhHX+sZUpYDH/JNm7i2LPEUNGJhgksWOnwQqK3xdrUH5VnyypOwGc3JUp+fyxw
         YULqMr8+80GsF+sfLgjkk5/S0/wCEleMHHZR78g33Ck2WnbleXXCgZmSUbSHGUz6y+bP
         Osk114KekrFkYbbxO027h9llrUlYkyQoyg5P1ori9DXW994ViEUe6e6P77ijkJ10XIzZ
         bMPFDx87VNCQGsEulyRY6A1lnZqIU1qJMgPyVHV4ShBppW+REMVxNDeQcUmEM/KbVnYc
         E3V3l0DjF9EhR2HdXm4vpDZZcX3kbbBEZOEMs+dX8feMFZFk/hreGnXQCmZVPJnzq70w
         norQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqJavnZiFR1T37BdkPeREleVXBU83L2YoDQHH93YA21nq5240VTNcz5xFF8OXH+Ue3fcM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuWteSR+YAQ6+J9kBtI6MOdi/1oeRrfsVrzmY7mKJkL6OKdu7S
	fnoGLDk3L8XhUKlmj5ty5IH2ecHPv8R2iDqVpjWNgVTeZIqnWYXCotCJ/6xTXw==
X-Gm-Gg: AY/fxX7VLaIjm9974IWTqHOwrIcXZne4g8NSDaFxASlzV1/m1B5VhXYP1Hdfzc1ooVl
	yRmFpqbdfbkwgoYOd1n1F+YCkyAsU9ctiXFX9eCJZ4C4yHZWHOdfAqjlzit8Q+AGTUHX/nuksrF
	3KUK0Jqf+M0BUkeB9qCmQ3svzY7Efy4jTiSohasA3ny2FfhH3RWEuCAeSkK/YassX7J0eAiC3nA
	hegWDLCpslPoMF2ZIZ0IdW1JsGmSexLPd2/jg8IoYyfwVkmldDl8a3cva0QJ+dLO9bI7gvzY7+u
	Yfb+3IoIitIY2Bc71Q0jsVP0rNZjMRnyScIV8vBYUa/boe+I37D0le3uzskQLfRnQ7/V1z6kwKS
	T6ozWmrV//Gw80g2HE7HGQOPJ6vdst5o2fk85q4AKYpQsEIBaOpVoL5/oEr+8J2KF677trSpoHB
	hvBkSu
X-Google-Smtp-Source: AGHT+IFpVcUmXsi9lqQbIvhgVBcoX5bVMHfXSS18BhFSXNd55OhwcM1FIUvJwmHPTQiuBFTbDzzuuw==
X-Received: by 2002:a05:6820:1892:b0:659:9a49:8de3 with SMTP id 006d021491bc7-65b4519161fmr6976051eaf.37.1765895819895;
        Tue, 16 Dec 2025 06:36:59 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f614be6be3sm6571231fac.7.2025.12.16.06.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 06:36:59 -0800 (PST)
Date: Tue, 16 Dec 2025 08:36:56 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] docs: clarify git-rev-list(1) --filter behavior
Message-ID: <xnstt6myzzfyq65w73xuqg7cfso3bdw6tw33shrery4e4gi2zy@pfxq2pjmb2hm>
References: <20251215200512.2694155-1-jltobler@gmail.com>
 <xmqqwm2n5ivh.fsf@gitster.g>
 <aUEUfQDJyPf6Mhtw@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUEUfQDJyPf6Mhtw@pks.im>

On 25/12/16 09:12AM, Patrick Steinhardt wrote:
> On Tue, Dec 16, 2025 at 10:13:22AM +0900, Junio C Hamano wrote:
> > > diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
> > > index d9665d82c8..453ec59057 100644
> > > --- a/Documentation/rev-list-options.adoc
> > > +++ b/Documentation/rev-list-options.adoc
> > > @@ -983,7 +983,9 @@ to name units in KiB, MiB, or GiB.  For example, `blob:limit=1k`
> > >  is the same as 'blob:limit=1024'.
> > >  +
> > >  The form `--filter=object:type=(tag|commit|tree|blob)` omits all objects
> > > -which are not of the requested type.
> > > +which are not of the requested type. Note that explicitly provided objects
> > > +ignore filters and are always printed unless `--filter-provided-objects` is
> > > +also specified.
> > 
> > The above documents the status quo correctly, so let's queue, but it
> > is unfortunate that we need an extra option to do this.
> 
> True. I didn't feel comfortable to change the default to also filter
> provided objects when I discovered that we don't, hence the new option.
> It's not great though as it certainly is surprising behaviour, but I'm
> not sure whether we can really change it without breaking existing
> users. Oh, well...

Out of curiousity, are there any known use-cases where a user _would_
want the provided objects printed along with the filtered ones? From my
naive perspective it almost doesn't even sound useful and appears to
just be a sharp edge. This maybe not worthing worrying too much about
though.

-Justin
