Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED6A2D97A1
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 20:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756325585; cv=none; b=Ck81zbsfw8pUEgCLzBEnZOTxnMnawR+3LujtCcnztmomd8Dlvcebi3Sl9QJNvVN37gmSPlRnAJ8c8zYx2t90UzXLpWgw2uIUB7M+HBQ9/HcyK/L5Bj+YSocw9j4I6SrMZwq8//ssA8KD4H8hyybZSfhNFCVROkkPO7Mo2dMU5H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756325585; c=relaxed/simple;
	bh=o2iIJbV/+due9dE3XCvRxE82Rr8bozYJbm57fabHX8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQP3wZGwBpyhUIRguv+9I3QVeO8dEd09u/SLQL68YjqD9cFtLxNSEg+nHpo+TWV0IwHrQc4RZMurC196UPPsCZN6kP+aRo0WGDpolKZm9f8Qfm1qHwCqC3qevNX0mnFP/ZimQx971pChINyVWCWmI6qhYvL8qCduqMxZIeZOIdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=ltowRCah; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="ltowRCah"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3ea8b3a64c7so936585ab.0
        for <git@vger.kernel.org>; Wed, 27 Aug 2025 13:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1756325583; x=1756930383; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o2iIJbV/+due9dE3XCvRxE82Rr8bozYJbm57fabHX8g=;
        b=ltowRCahaQmRhL5LFdg8mWMjVqd8P8Iy1Db2yZY6krr6C1mEQsgnN/Hqm7JAfGPK4j
         +zPxI+9wugfXsBkeWkRJ7SU29hD9EwKBQpfj4B8yU/kZkd/LCvSoWYr7kI2FsEzoFJss
         6fXJYJutGCeebQwCunf49sAAEYVB2USdQP2aW35gX63lp85/IDD/icjZ4xDLqsT+X6Up
         ACTdIf2QZ00gYupYViUz+Z++RJijt75MRG+dSN3BzbXROZjuXUBdtXrSxhIPnft4Jcxx
         G32X4ymtwjmFA9u3ggFGUs0aqIcafiZRo39ikCZW+Yf42eASBXYOM3CWGXkUWQG53XO6
         G8tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756325583; x=1756930383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o2iIJbV/+due9dE3XCvRxE82Rr8bozYJbm57fabHX8g=;
        b=ghSQ9iN5v4MIy+HRf30+LLtUJHervrTxKDR7z8puXNrm0nEg+W7t/TX7B051b/t5t+
         YV2h1aCS61p6cT7RPzk8YBOqQpVA1km3VpuhXknnsZl8n4I3LaP6TLePQbAlR7Kooue+
         2a5VDn9CdApJ6eOKCG3NDTdcNPKTqI0XKT1UYRRcVSAaNMCFQpYJsAkO6V9UGXCFcZwd
         kyDZgKqDhI1SBZX93i6joTIhkd5vCTR3LFCNwp90wpWqTHYoPcLWhIlgH80nTHy88KKj
         jXruoqwR3xztMdd965JZsp5dbOA7w/5NdbkznaB2GRYyimKQLLkk9P6LHNMTSkG99yHd
         /wew==
X-Forwarded-Encrypted: i=1; AJvYcCX06q+gxP2JFck7Dj7xeoFW34hOO2PKnfGkSU2WwA1xJUw8iYu6AIyuIHiVazdfKkEBdww=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXDIileRw2q5F+ud0D6WZqcFVAiV7sn48jFDbFK2CecYHskn/D
	9ESo5PYBE8biJppODA9GJuT6CxBNsNDK533ZuvbS94K/QWNBrUMDAaoVYoJX/66hokQ=
X-Gm-Gg: ASbGncst0Mg774RfZJbkDD13Vu06TtXpVM8cIBCvW6dKZgyal4dKRgns3gR2pvTOmfx
	Zyhwdh41/cUYBs2GRzRHXsNAVTchbDz9RcdWEwSFUul3o3JN4AHq8jDRwjgVmemgCXCS52bfLD+
	+3QZCa4S0xrPJ26nx30YLawoOSxtNrA1Zata3Xl9SE9qA7jgnsf9FnWghs8+34mzKEMfSOZJOzN
	rLdr4Pxd/TevYB/vZXxWclP3XdhQ7Rnpq9ArJNx1A+JtPh6Y6FVlI1Qv6W4rAsbgUuvOa+nOHLu
	2SumZ/MJjtXxk0Ze+HpFFmhcrhVzMEs7HWwJQeGBI22iygE8CxL0aoM4j/KcMYQsODc5Pu0krHc
	fpEoU3evEk0KHQxkmSvdOwvze7iyQXmT35EzlxpRE1ljA3O1RFQA17bg6xd0dG/YIQeuy/rrJ28
	3zE+9qd3BiSNR2uu45h0Z8LaZaR0tlm1KORp0QeX0iadHfnK8=
X-Google-Smtp-Source: AGHT+IFM2qjV1sM9S5n99K6Xl0m4xNyIBd2C/xT1wu3dR+m9NyfJFEDTYiFNMp07WW20skoU0O0mwQ==
X-Received: by 2002:a05:6e02:2502:b0:3f1:4d69:f856 with SMTP id e9e14a558f8ab-3f14d69fb6amr603975ab.13.1756325582778;
        Wed, 27 Aug 2025 13:13:02 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id e9e14a558f8ab-3efd7129eabsm19048035ab.43.2025.08.27.13.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 13:13:02 -0700 (PDT)
Date: Wed, 27 Aug 2025 16:12:55 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: rsbecker@nexbridge.com, 'Elijah Newren' <newren@gmail.com>,
	'Kristoffer Haugsbakk' <kristofferhaugsbakk@fastmail.com>,
	'Josh Soref' <gitgitgadget@gmail.com>, git@vger.kernel.org,
	"'brian m. carlson'" <sandals@crustytoothpaste.net>,
	'Christian Brabandt' <cb@256bit.org>,
	'Phillip Wood' <phillip.wood123@gmail.com>,
	'Eli Schwartz' <eschwartz@gentoo.org>,
	"'Haelwenn (lanodan) Monnier'" <contact@hacktivis.me>,
	'Johannes Schindelin' <Johannes.Schindelin@gmx.de>,
	'Matthias =?utf-8?B?QcOfaGF1ZXIn?= <mha1993@live.de>,
	'Patrick Steinhardt' <ps@pks.im>, 'Sam James' <sam@gentoo.org>,
	'Collin Funk' <collin.funk1@gmail.com>,
	'Mike Hommey' <mh@glandium.org>,
	'Pierre-Emmanuel Patry' <pierre-emmanuel.patry@embecosm.com>,
	"'D. Ben Knoble'" <ben.knoble@gmail.com>,
	'Ramsay Jones' <ramsay@ramsayjones.plus.com>,
	'Ezekiel Newren' <ezekielnewren@gmail.com>,
	'Josh Steadmon' <steadmon@google.com>,
	'Calvin Wan' <calvinwan@google.com>
Subject: Re: [PATCH v3 02/15] xdiff: introduce rust
Message-ID: <aK9mx2XemppIaKVI@nand.local>
References: <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
 <pull.1980.v3.git.git.1755921356.gitgitgadget@gmail.com>
 <03939951256baaaec3fcc690cfa38ee12fb553ce.1755921357.git.gitgitgadget@gmail.com>
 <030a01dc1433$ee3e2510$caba6f30$@nexbridge.com>
 <4dffd698-9d3c-41c8-9d3f-0d3750e683d3@app.fastmail.com>
 <031601dc143f$7a9a25d0$6fce7170$@nexbridge.com>
 <CABPp-BHdHQFv74GDbe=pJBFBALAMZoGsJDhSGqPbT3Daadnd4A@mail.gmail.com>
 <aK5mJI1NfVQDmDXN@nand.local>
 <01f101dc1760$5eef42b0$1ccdc810$@nexbridge.com>
 <xmqqsehc1ypi.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsehc1ypi.fsf@gitster.g>

On Wed, Aug 27, 2025 at 10:06:17AM -0700, Junio C Hamano wrote:
> <rsbecker@nexbridge.com> writes:
>
> >>So my impression is that the main contention here is a concern that worsening the
> >>portability will make it harder to push out security fixes in either direction. But I
> >>don't think that's necessarily the case. Even if it is, I would again hope that the track
> >>record of the folks on the git-security list would suggest that we'd do the right thing
> >>and not abandon users on older platforms the moment Rust is introduced into the
> >>codebase.
> >
> > This is indeed my concern and hope, Taylor, as the maintainer for a platform that is
> > feeling abandoned. Please note that HPE NonStop is an actively maintained and
> > vendor supported commercial platform based on x86_64 POSIX, just not a
> > Linux/Windows machine.
>
> Thanks for a friendly conversation, but I would have to say that
> Taylor's "we know we end up having to support both, and we will do
> so" is way underestimates the cost to do so.

I don't mean to imply that doing so would not be costly or require
additional effort. I was trying to highlight that I believe we on
the git-security list have demonstrated a track record of supporting
quite old release tracks when new security releases are cut.

I don't mean to suggest whatsoever that adding Rust into the mix would
somehow not have an effect on the costliness of maintaining support for
older versions, just that I believe we have show ourselves to be up to
the challenge.

(As an aside, I mentioned in my earlier email to Randall that I have a
suspicion that Rust code will have fewer security issues than C code,
and so the likelihood of needing to backport a security fix from Rust to
C seems lower to me than having to simply patch old C code. Time will
tell, I guess.)

Thanks,
Taylor
