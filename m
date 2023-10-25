Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143CA156E5
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 15:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="DQ80j7mf"
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B41A131
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 08:39:49 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-41cb76f3cf0so35770801cf.2
        for <git@vger.kernel.org>; Wed, 25 Oct 2023 08:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1698248388; x=1698853188; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=44GaEUmlVdbLLkP3V/i3j0JH1UyEZoDhBYraAo6oAGE=;
        b=DQ80j7mfUwXylD87653S2SIY7s6Klrn5OzyxhnxT1iAEqJ6qWzEAelrUDvpftqsdce
         PjUnV430yaDD49UtRVLbTXqQ0PIqKYjrb+90FwLUgAhRu5j4t7epUW2B4bLg4QFGWciM
         ejIxU1iHf+x/prmFD+NqoH/tfBeBlNKbIFCFnGM0abR7pUxcALGd5k4q529IsN7gOE2W
         nmbNjis9nvAOYuUnycW/KTrk7PGak9mBmylL0CqG9x1nsMujhNbpWx1MngqP8FKQP5G4
         L6dECctwdu7mjkY4Aa0L0TbNDtcDvySAVSKrgFJ++L6cw4sph0cStFBwX2PhVQr88DC3
         hsuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698248388; x=1698853188;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=44GaEUmlVdbLLkP3V/i3j0JH1UyEZoDhBYraAo6oAGE=;
        b=hMvEbJc7eTGY47LHJWAWyU7UBr4eLz5A3lPc9RSNrXLEZCcOkFB1lLo2rVoA4GgE0L
         cul78kL/MMmiPsGDqUFeyVQillmbV/QMqQmYVPQ1yd74UVoXaPc85MEGFOG+uD+BYott
         ModgMoh1+k3+z5Mmo9P0+LSPDibPQvde0+Gycz+AXP30jqq9T1diImjFEH0Iw0IQb5g7
         +rc1FtXrTqwNDedNjgTFZVJ7Au79UEQ3DaeGPikS7GsRBJ3vo4b3rsncStyBVD0ZGkR9
         3uLGpaEeFyNmOGwRTYvKF3ut88lP/8sPBD/LsLVGBS9zKb4XLueILCDi4OKiNPSW4NOZ
         ccdA==
X-Gm-Message-State: AOJu0YzYpC49ve7Vubqm/C7csi3ist9U7mS2hpbtL77vBkAtPXU1K7g9
	fMikBAC0WVmnTPNo55bve7Epmg==
X-Google-Smtp-Source: AGHT+IGRjka42kIDliT0VwMCis5gC4wChKowGf3SOXKkzsjVPkYEkk60p3kvcRW0aTzsgzlryVED0g==
X-Received: by 2002:a05:622a:1313:b0:418:1f52:1421 with SMTP id v19-20020a05622a131300b004181f521421mr17205551qtk.9.1698248388536;
        Wed, 25 Oct 2023 08:39:48 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g7-20020ac87d07000000b00417dd1dd0adsm4321851qtb.87.2023.10.25.08.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 08:39:48 -0700 (PDT)
Date: Wed, 25 Oct 2023 11:39:47 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v5 1/5] bulk-checkin: extract abstract
 `bulk_checkin_source`
Message-ID: <ZTk2w6rV2y7ZKfQh@nand.local>
References: <cover.1697736516.git.me@ttaylorr.com>
 <cover.1698101088.git.me@ttaylorr.com>
 <696aa027e46ddec310812fad2d4b12082447d925.1698101088.git.me@ttaylorr.com>
 <20231025073736.GB2145145@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231025073736.GB2145145@coredump.intra.peff.net>

On Wed, Oct 25, 2023 at 03:37:36AM -0400, Jeff King wrote:
> I don't mind this in-between state. It is a funny layering violating
> from an OO standpoint, but it's not like we expect an unbounded set of
> concrete types to "inherit" from the source struct.

Yeah, this was exactly my thinking when writing up the changes for this
round. Since all of the "sub-classes" are local to the bulk-checkin.o
compilation unit, I don't have grave concerns about one implementation
peering into the details of another's.

Gotta stop somewhere ;-).

Thanks,
Taylor
