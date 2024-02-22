Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EE213BAD2
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 23:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708646154; cv=none; b=onRdGz7aQP5g4yzPLDh16MIJmV9rkIKGyn2kTVmBvCXbZCAxwKgX4RIKrLi6bXl7bHvce6Vpmpc24sgqMrjKwGbXe9SAyfRPU+2GtZEPlODk2kjOkGa20UhUW1oMyihfzqddPQPWQIsmq7vP18Zsn0fEVMAi595ypoYr0J1dmjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708646154; c=relaxed/simple;
	bh=TdCduawIb+N6+swzfBdC4dLA3vlF1Rz80vrFrzgfc7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJ/TMI09AXy7LLYA1RywlYFBbVbmo0vbWppp4izn78WfM1KdPnw3uN2QyyNdm3QnbajN9D5mGSsHQuu5cU+wRzu9+hqniqFwRq0V/75b+Qw/Il5m26jDE1tNH7QMzglLDQsrIlkSAG2YCvZHWn31oM52JIKYAKRGyuxFXQDVTpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=miuLiFfn; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="miuLiFfn"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5cdbc4334edso214574a12.3
        for <git@vger.kernel.org>; Thu, 22 Feb 2024 15:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708646152; x=1709250952; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q0wSCjU3rOQTTURs9CUmP/oqkI4zNK7O1rVwAtTU/hU=;
        b=miuLiFfnCLTSRAr4z5erooDZtVhiCoK6v0CadaEtTXTeYQCzBf0IiXvQKoesyxyMfb
         Z8yL4hlnG7qJRyTcqta9FOp9zTPYGo37BR4kUu5SizrQ4Io3B4rwGJrwPRtT2YlpKPVk
         QFO2sKJtaGg1km5Compc+HZ0lcazIbhTAW1XZ04RSpag5XEWmqgbiuF9s4fEjtvC9SUG
         ft435vwLetbNzOfUKJjxKWcuhrvWQnOW6MLnetHFbHdOar5SwnlHypaCgpszVQ5PKjkZ
         3zi1Ih3Z7a+E8tuRDRBwxdg/u3E4USkYBCsGu6P0PcfFf/VHL36TfDa3eY+Yazedu0ta
         xfyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708646152; x=1709250952;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q0wSCjU3rOQTTURs9CUmP/oqkI4zNK7O1rVwAtTU/hU=;
        b=q9Z4LcuMBujwie0gIKOes1zedQLY0zX+EsCuMgrbt4auA4B3EocM77e+zjRGKTDknc
         igOEDUK86Zxbr046BjBuy+UOqKwoQJweTA/eNVF9xWp5MQKm7r9JpgT9GAXEMwd01KMD
         6rh87n0pc85SmYv5Zl1p2Gmu+heVNiO9up4aXD9rk7r5L0/R3BvSbzQDhyZwy/QwsQ3X
         JFyN5nNqlFvW4OyovZzQ40VnOv9LBKTalBGgFXNfdFrMcNSiSy0C6QM/TpFZTGRQT+rk
         8SOPJbF1b+x09PKbyvH3B9jdre76tXjn03IQw8dvK6qpMNXYzvQGqbxBPjhZ0h5s7FGp
         GGKA==
X-Forwarded-Encrypted: i=1; AJvYcCXmdzv2H49xDyLHiLKVdMtrVaTCySBcXB2WFGR5VmaMvJ3mvim4evPe0r5xQpn9UCMVdI5G/dciC2qAqF7wg9SPMXky
X-Gm-Message-State: AOJu0Yx0689J+SeQWJjFEXuge65XPJBkWGTmcKwtpC//6p1vRiz0XCLI
	tpH3nBCQb4TNuSDShIEkW8UWP1fbaw8HqEDydLJctZ6by5WTuuWaF1pIfG0pKg==
X-Google-Smtp-Source: AGHT+IGvw5Ag0dpWbnsdV0OF7KgcALYOnh5z/WHyPvgPmNB1MQDGyDWDVC4CYdDfo9pMfxzsEyaH+g==
X-Received: by 2002:a05:6a20:d046:b0:1a0:df5b:1217 with SMTP id hv6-20020a056a20d04600b001a0df5b1217mr415380pzb.14.1708646151822;
        Thu, 22 Feb 2024 15:55:51 -0800 (PST)
Received: from google.com ([2620:15c:2d3:204:4ac4:71c0:92c1:4c83])
        by smtp.gmail.com with ESMTPSA id m20-20020a170902f21400b001d8e22d6a2dsm10526901plc.72.2024.02.22.15.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 15:55:51 -0800 (PST)
Date: Thu, 22 Feb 2024 15:55:46 -0800
From: Josh Steadmon <steadmon@google.com>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	johannes.schindelin@gmx.de, phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH v2 1/6] t0080: turn t-basic unit test into a helper
Message-ID: <ZdffAnSOX87Vmp-V@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, johannes.schindelin@gmx.de,
	phillip.wood@dunelm.org.uk
References: <cover.1705443632.git.steadmon@google.com>
 <cover.1706921262.git.steadmon@google.com>
 <da756b4bfb9d1ce0d1213d585e72acfbf667e2a2.1706921262.git.steadmon@google.com>
 <20240207225802.GA538110@coredump.intra.peff.net>
 <ZcqFOVuR0sxFDDUv@google.com>
 <xmqq34tx5q6o.fsf@gitster.g>
 <20240213074118.GA2225494@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213074118.GA2225494@coredump.intra.peff.net>

On 2024.02.13 02:41, Jeff King wrote:
> On Mon, Feb 12, 2024 at 01:27:11PM -0800, Junio C Hamano wrote:
> 
> > Josh Steadmon <steadmon@google.com> writes:
> > 
> > > I see this line in the docs [1]: "As with wildcard expansion in rules,
> > > the results of the wildcard function are sorted". GNU Make has restored
> > > the sorted behavior of $(wildcard) since 2018 [2]. I'll leave the sort
> > > off for now, but if folks feel like we need to support older versions of
> > > `make`, I'll add it back.
> > >
> > > [1] https://www.gnu.org/software/make/manual/html_node/Wildcard-Function.html
> > > [2] https://savannah.gnu.org/bugs/index.php?52076
> > 
> > Thanks for digging.  I thought I was certain that woldcard is sorted
> > and stable and was quite perplexed when I could not find the mention
> > in a version of doc I had handy ("""This is Edition 0.75, last
> > updated 19 January 2020, of 'The GNU Make Manual', for GNU 'make'
> > version 4.3.""").
> 
> Likewise (mine is the latest version in Debian unstable). The change to
> sort comes from their[1] eedea52a, which was in GNU make 4.2.90. But the
> matching documentation change didn't happen until 5b993ae, which was
> 4.3.90 in late 2021. So that explains the mystery.
> 
> Those dates imply to me that we should keep the $(sort), though. Six
> years is not so long in distro timescales, especially given that Debian
> unstable is on a 4-year-old version. (And if we did want to get rid of
> it, certainly we should do so consistently across the Makefile in a
> separate patch).

Makes sense, thanks for investigating. I've restored the $(sort) in V3.
