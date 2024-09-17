Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AB615B551
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 09:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726566760; cv=none; b=s0prs05TakCZPnke/XV4keNEoTDfKrG/4LnmpmH3Qxh6DWwNVCvXl/71Hek7L8Q9oQzw/ibdssMDbsvUPXwOxp41JW9WqcGL1oDx4nI64rTvLBXwYcHz0P+MWuvugWJjQm8CFj3cbFXli7CNoDZe75Wo7ZLZ7go44a3cYPqWU5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726566760; c=relaxed/simple;
	bh=+PlEEZUXuHxwOWzhilMH38GKpI+zNma3r733wz7toS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dnX1FUsMPG1gfV0CWo7w2bNbHGzqhTnntgc6MyNZz4Qw1rFnPWVHQQ3qK3Bo6whIAvXVJ4mvRFMyE4NyoR9qDulUtXfU5lL3osDFKhp5Yyh1iod7Jw65J/IfMGoA5lL+ad5hiYyPpGSVeoSirXDuugcaETTTcu1Bmu4oIP3Om80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=qN43wL1j; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="qN43wL1j"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-82cdadeeb2eso169903439f.2
        for <git@vger.kernel.org>; Tue, 17 Sep 2024 02:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1726566758; x=1727171558; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+PlEEZUXuHxwOWzhilMH38GKpI+zNma3r733wz7toS0=;
        b=qN43wL1j+gqb8WT8DTZDPHtXBz44BlzqGL20XXLcwycWaJvbJRjUH3OOmCvUp45puq
         t/uz9Ka5zkcaOSlJZa8Uoikdn5uSQ1MoZOpAu34anQ94dTXosxXjmdQ9eBYEH2e4zNkh
         iJPGsN7ziXQEE4Ao09lMIBvlEdN4u7ngB82TliSRlZsiLaMiNbt9CDhc+/6BSfM8X/Cy
         x420Mn6gF7v1HPtCbLUUJKA28N3VW7IIvQCsE0G3IECZleJxwUNtViZiwXhSZ7OtKaoQ
         ZrazDWWKpq8UAX6JsTdThUQujQndAoHGFdynsOLBn/3cggOUkMImjcYLELBeOI54lOS9
         R3lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726566758; x=1727171558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+PlEEZUXuHxwOWzhilMH38GKpI+zNma3r733wz7toS0=;
        b=i8yx3/13GPkkNH+z8n+/OUgU/+h03nL9hqKFxUfvjRSgCYFbiOoBhhZ7PaQmWBVilC
         NswgIgag0wHTUUhlZaIkRJ8/AYAuhIMJJLx+r1fJL28LcSU9EmL7bS28idFQYzWCX58m
         AbjNgHJPdK5+En8WmIBk4nTKLBQQmjiAAPzUkWQoXNXaoB6l0yHdQKHIS3KUtQI8xCGo
         LUN18iYNCqr5sU2oByUsV1659z+GRG0gAAy4pBLnA3KU3TqZgv+tQcI+8jc6ec7li5Q+
         vBGGy4Z2aU+Ys+QVC33V0w88kD5QQ3sE8OcnIpX/ABomEDAjj1U2bmFlt8eI9ZLUPlyo
         9JNA==
X-Gm-Message-State: AOJu0YyFRCnaUyXLskYsfLUflGpBISLwL3ISVCY+idSTrkIarA3MWUra
	N6wQHeSTJdQjMQAnhzQ/xXytf4LpPpqE2EtbofquStb14Jg5pS0HIxoNpST3BNmeqJ1WSOrMEnJ
	kxF+c5A==
X-Google-Smtp-Source: AGHT+IHmNJ7Cn9AYgcvF1PCPUREMF+c/LyV1ketXw8z64BQXMyacuNJwDYc1Dtrk0iW4VJKKdDfzbg==
X-Received: by 2002:a05:6e02:1d06:b0:3a0:a26f:7669 with SMTP id e9e14a558f8ab-3a0a26f77bdmr54642615ab.7.1726566758254;
        Tue, 17 Sep 2024 02:52:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a092e1c0f8sm21383605ab.47.2024.09.17.02.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 02:52:37 -0700 (PDT)
Date: Tue, 17 Sep 2024 05:52:34 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 1/6] refs: properly apply exclude patterns to
 namespaced refs
Message-ID: <ZulRYg98ehjPLr2c@nand.local>
References: <cover.1725881266.git.ps@pks.im>
 <cover.1726476401.git.ps@pks.im>
 <7497166422ea702aabdf4159b0d7780f1422ba13.1726476401.git.ps@pks.im>
 <ZulIB7k18+4CzwZb@nand.local>
 <ZulM4BU7zSn_NHMl@pks.im>
 <ZulOK5GAWYbPlYeO@nand.local>
 <ZulPhat5pavpiuXT@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZulPhat5pavpiuXT@pks.im>

On Tue, Sep 17, 2024 at 11:44:44AM +0200, Patrick Steinhardt wrote:
> I think the important thing to realize is that we're talking about two
> different things:

Wow, I'm sorry -- I completely misunderstood what was going on in this
diff.

I have to say, that is quite embarrassing having written this feature
only a little over a year ago. Sorry for the confusion, this patch LGTM.

Thanks,
Taylor
