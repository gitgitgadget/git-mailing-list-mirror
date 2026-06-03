Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E57A3B0AD6
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 11:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780484869; cv=none; b=fVKzVqvlg+RyqCLlDXRFKigPS60O7/W/BkvJhrkV7rTur1aITIEYVSZqZaCMGBnH5BfyzxLns3T1x0yXvHA0qwiyf/BNBKbP3EvisZ9B4sz+TmWP4EJGL8LNm0pnX3aLCZlWRR0rGAI1MSI3onfTKB/KbDuS+ip8adFa0rMahR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780484869; c=relaxed/simple;
	bh=JyWa66Vef878Kq1iV/jjUY+zY0pPq8hAe2SHhfa8Xcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eMkiTTEW8TDfSlLKmVL4knC1NI/Jgtw4/+xa/FecmckrmkdPP8kaL7FIrS6qbvUfD33/O2gkX2Gi/0AOcmAJFa0V8w9y2SFQGviyK/sFE8CTrtSuWyxnwpxdW/xax3QscCO9jAPQdHG9NiC/I+3/OleIKMvZgZwn7VFdooYCJxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pi6U7O0U; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pi6U7O0U"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490b915ded5so4128025e9.3
        for <git@vger.kernel.org>; Wed, 03 Jun 2026 04:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780484867; x=1781089667; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zNtO3oqeeRWDW8XLUtOg9amOzPHjIP3NVJiniXesNRw=;
        b=Pi6U7O0UeVDcunENXexzMsJMUm1UUMc7DPrIeHsuOLmICvcbCZ8h+xQHt94PlpAMkI
         jtLjE/49G585Y7K+zAmVT+ggdWE3CmTBJdDVLufOmg6l4sMub+YxPGPZi+qbKjh67AXe
         svI9GN8/iITcDrgN2LC98PBAsugO9xaEsSa+31VEv+vLk9m15NdZPegCfiaY9ZqhcUYH
         G28lzrdc4FS7jZmeRxekXwB+I81c12gY/MHSFqu9iAHnF68uscXNdE6UhOFBB/LSJFcD
         8+UIwNDMc7agf0t2k6q/eZLpIS6wrZiikhJiKwElBB06od0Tp2oyTKj0hpACGXHWDJ4D
         MjOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780484867; x=1781089667;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zNtO3oqeeRWDW8XLUtOg9amOzPHjIP3NVJiniXesNRw=;
        b=f5x/Ijunf35MR7d/CoPvYt835lis71yPQWy2e5ku5WkgY9IMmnQ0J4u/eVesHBCXHQ
         28QdnqRuDT8XOT161euVLrXSkv3BitSHVTMsa+SeGrUapgjuU+w92oApKSgf1zUQYTqV
         HoACmDhOgJ12dvUjL6OaLg0UeR85rDVBl1ekFuL+pH7O6ZcHsu58WK3JpubPKc3ZXAqU
         7eIp1nDRITrsZ+K0FAQsuzrLyK/CKtozNp9evAbTCBgQnJXYW3LA3pBi2z2iqmYaHCQh
         4wi7qKCkCC8MMP97vJN8SmyPnZWuIVvGyCUizppFOlFuOTMbqM/P7PQDR4USkPqFmJes
         O0JQ==
X-Forwarded-Encrypted: i=1; AFNElJ806S29pD/yjXRR4S4/a+YfRYGaSNu7O8uQv9lgeMjnuF04z/sVtQx8hLd75AS+r6dhrdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkYXGG/yjp0dNiqz5vG/6bU5EYDlDqwiDg2yZo1SZmX7U1kxjL
	fRbMsv34vNI/OslA8108YVNThb6EfRW4fYg+laObGNx/vwmev571Jfzf
X-Gm-Gg: Acq92OGOJFlN+bDnEcqyDeaBrbu9m8ZaYxukyUtdX9BnTnPV4debgv5kaWA9xnal7tF
	QvTinSyNROSXq15JRcGdAtCYydq1sHEcMrNMysNDHAXnYqFvoxyQ6nSrJhjq/U2c783vZf+KNGn
	q0mQkoPpFR+exqn0Yq1oIcxyoBfqKsl6gKYJuV18nYmXnaznQa7PeSwQzynf5ip9ZWHHND12d9S
	BLMs6ds43doLbYhlgLrGVJNRC9WvVsqUY/PDCI5X0QOWdzyMSbLgG6C7XdEaRg8xPYZRaJhmz+V
	+FcGOovoni8HrKv8GWA7Pk8oGPM3UrW0P5HjrrkkfV7NqS1ptYzNvaImYzVOMyqEgyuVbooMPHf
	kkb6XLoVfG7E3+PNS2J81LFRWrsztCkP2Sp1iL+03uazksuK+tHVTrheMEW/PjkEuVXytjdJ4al
	6OgXLXXeGxr8/zyj9raJsxR3QhAgldYUhxf2gAqLlu13ElNvduZXqeV4h4BkaoRlZkNw==
X-Received: by 2002:a05:600c:5288:b0:489:5022:39a4 with SMTP id 5b1f17b1804b1-490b5ec053amr46096005e9.9.1780484866435;
        Wed, 03 Jun 2026 04:07:46 -0700 (PDT)
Received: from localhost (94-21-58-4.pool.digikabel.hu. [94.21.58.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f35ee64sm8250847f8f.30.2026.06.03.04.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 04:07:46 -0700 (PDT)
Date: Wed, 3 Jun 2026 13:07:33 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Weijie Yuan <wy@wyuan.org>, Tuomas Ahola <taahol@utu.fi>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] b4: introduce configuration for the Git project
Message-ID: <aiAK9eLvew+mgWt+@szeder.dev>
References: <20260602-pks-b4-v1-0-a7ae5a49e9cf@pks.im>
 <20260602-pks-b4-v1-1-a7ae5a49e9cf@pks.im>
 <20260602170955.Z4b7y%taahol@utu.fi>
 <ah-Nhr2PboWUq6eU@wyuan.org>
 <ah_PyDwO1Sffr5yq@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ah_PyDwO1Sffr5yq@pks.im>

On Wed, Jun 03, 2026 at 08:55:04AM +0200, Patrick Steinhardt wrote:
> On Wed, Jun 03, 2026 at 10:12:22AM +0800, Weijie Yuan wrote:
> > On Tue, Jun 02, 2026 at 08:09:55PM +0300, Tuomas Ahola wrote:
> > > Huh?  Doesn't MyFirstContribution speak *against* shallow threading?
> > >
> > > 	        [...]  make sure to replace it with the correct Message-ID for your
> > > 	**previous cover letter** - that is, if you're sending v2, use the Message-ID
> > > 	from v1; if you're sending v3, use the Message-ID from v2.
> > 
> > I don't get it. Doesn't shallow threading means every following patches
> > are replying to the cover letter? Replying to the previous one is
> > --chain-reply-to, if I'm not mistaken.
> 
> Shallow threading basically means that all patches are sent as a
> response to the current cover letter, and the current cover letter is
> always attached to the cover letter of the _first_ version.

No, in Git shallow threading means that all patches are sent as a
respose to the current cover letter, period.  It has nothing to do
with whether the current cover letter is sent as a reply to the cover
letter of the first or the previous version.

> So this quote is definitely at odds with the configuration I have
> proposed. It's actually quite surprising to me that we recommend deep
> threading -- I personally find it extremely hard to navigate as the
> nesting eventually gets way too deep.

Deep threading means that every mail is a reply to the previous one.
Again, it has nothing to do with the relation of the current cover
letter and the previous cover letters.

Therefore, we do not recommend deep threading.

> You know -- I'll include a patch that changes the wording there to also
> use shallow nesting, mostly to kick off a discussion and arrive at a
> decision there.


