Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1673117BD8
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 23:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708646282; cv=none; b=kX9YcuZJd1qisc2+IWwZYa/0onOpUsuTazYvKBui3FuE0KBsu0EgGSwt80Y4Ou1+CvDk4Tr31QS745BO0bdXzyukMKsViviNPbWnMc3C9SoAmlJhCpWUZMH7ffT2uL+4dWveEjhTWlYC9DwvTziS7bpsIB/g91D/Ehj/xvF8tIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708646282; c=relaxed/simple;
	bh=j1jbl59WF+UkJkFItegepZxb6UT57neCiQSiVNn8FWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aDtQYgQN5SXOkB3VK9o+KT/A93RUFVwMt4RLy3qUWfcZPLy1tjpNph/8fgWM3PlFphf8MhPr+nYVJC3ORLGYCsPOaRZ9sMjQU3ElD71TXDxe6LPc7ppXKub3xpRLpcDzxKKVieSNoC0ZymTGV5pl+MasD2RBRHSmmY13m6uizYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4x+VdMDh; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4x+VdMDh"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e32a92e0fdso117174b3a.0
        for <git@vger.kernel.org>; Thu, 22 Feb 2024 15:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708646280; x=1709251080; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aJYtnnaSV+/2cX6gnAnaNn1VYmPr78C6lEEv/Bb4Efw=;
        b=4x+VdMDhLiNgpbIH+m4b9NMEmc/UDYjeDoZxuZnvc/Ibi11H4wClMflBq4HX4pIOCa
         /wvTEEHSYKiUbboED8hzS3yCZxbP+LCcT1G3YT9WW5zPLBJdq45cGF8GMjW1Y6vg5AWD
         BQaauVY5KEFGp/urrJSB8bpI+nTRWbXJIJW15KBNwl+bRYJ8sqxPtkd03eVKBBJAMswf
         07hIHxEuavUGR9xZt28xWqwyzbKR46hzElOoFQtqeJooz101Y9ejv+pGeVxAQI1jjYot
         P+8Bnh9BDn+QatUB4E4CGEfltfkONsgItbG52VYBIXB5AVHxnkTrMr7vlLceJvDJFW5+
         1nwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708646280; x=1709251080;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aJYtnnaSV+/2cX6gnAnaNn1VYmPr78C6lEEv/Bb4Efw=;
        b=Srsa1kx1ykJcIalq4Rejfg+LyrejtiE94Rm2yNy4hWKWXz4ylnq3+ez3A/tcosprim
         sAEduwjowDUYUh1ZiVh9Ut/f3ZTgn0HuXRv6Nra5ALTOCldI9X0OOijpTjMRUVl55Bag
         r/opIgaHYyo+Vp5sdivQ3hTGIQCpk1Cd054g5AUq5IED6ZOSvWfQpz+O4DjJIY9zDVcA
         0UIpAkW38YIods80KGar1GpJNC8wTwyE8tNFd7w9zeXOGqFskazPvhfgFtiHDg/zeOEC
         TYDd8kxof3Ds2ERHlquJgQMjptjy7e/aqLo/w5i2PnoCH7vEfyEUMJtI82GedwMcgy4E
         5RxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqCZkwD0AJ++6eUskAZ6bX0tRHgk/tQp28reGxxlEmv5WdWEmRR2DhRt5hlvCqs//ROHcO6zT6DY05Diagi6pVNgFt
X-Gm-Message-State: AOJu0Yz57aqKC8GO/qCnzyWnZ0Q9DEZpqXKxay03I12OPSQcnMU4PrAO
	QQ3LcImLEKUis4vPIN7t/DePCn5re6YsBf7xauP6TzhKmSCh5JXTQpPo9N1EdQ==
X-Google-Smtp-Source: AGHT+IEpAWW9JTeSA0+Ppum+QTgZKyl1zlfbEJqOFnYZyDYeLJmLpOa2Aub1HygxuDD0pr7de8mb5A==
X-Received: by 2002:a17:903:2448:b0:1db:e494:4b3f with SMTP id l8-20020a170903244800b001dbe4944b3fmr565611pls.0.1708646280133;
        Thu, 22 Feb 2024 15:58:00 -0800 (PST)
Received: from google.com ([2620:15c:2d3:204:4ac4:71c0:92c1:4c83])
        by smtp.gmail.com with ESMTPSA id c24-20020a170902d91800b001d9eef9892asm10409542plz.174.2024.02.22.15.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 15:57:59 -0800 (PST)
Date: Thu, 22 Feb 2024 15:57:55 -0800
From: Josh Steadmon <steadmon@google.com>
To: rsbecker@nexbridge.com
Cc: 'Jeff King' <peff@peff.net>, 'Junio C Hamano' <gitster@pobox.com>,
	git@vger.kernel.org, johannes.schindelin@gmx.de,
	phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH v2 1/6] t0080: turn t-basic unit test into a helper
Message-ID: <Zdffgzf74eNeNBnF@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
	rsbecker@nexbridge.com, 'Jeff King' <peff@peff.net>,
	'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org,
	johannes.schindelin@gmx.de, phillip.wood@dunelm.org.uk
References: <cover.1705443632.git.steadmon@google.com>
 <cover.1706921262.git.steadmon@google.com>
 <da756b4bfb9d1ce0d1213d585e72acfbf667e2a2.1706921262.git.steadmon@google.com>
 <20240207225802.GA538110@coredump.intra.peff.net>
 <ZcqFOVuR0sxFDDUv@google.com>
 <xmqq34tx5q6o.fsf@gitster.g>
 <20240213074118.GA2225494@coredump.intra.peff.net>
 <016c01da5e8a$1ada8fc0$508faf40$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <016c01da5e8a$1ada8fc0$508faf40$@nexbridge.com>

On 2024.02.13 09:36, rsbecker@nexbridge.com wrote:
> On Tuesday, February 13, 2024 2:41 AM, Peff wrote:
> >On Mon, Feb 12, 2024 at 01:27:11PM -0800, Junio C Hamano wrote:
> >
> >> Josh Steadmon <steadmon@google.com> writes:
> >>
> >> > I see this line in the docs [1]: "As with wildcard expansion in
> >> > rules, the results of the wildcard function are sorted". GNU Make
> >> > has restored the sorted behavior of $(wildcard) since 2018 [2]. I'll
> >> > leave the sort off for now, but if folks feel like we need to
> >> > support older versions of `make`, I'll add it back.
> >> >
> >> > [1]
> >> > https://www.gnu.org/software/make/manual/html_node/Wildcard-Function
> >> > .html [2] https://savannah.gnu.org/bugs/index.php?52076
> >>
> >> Thanks for digging.  I thought I was certain that woldcard is sorted
> >> and stable and was quite perplexed when I could not find the mention
> >> in a version of doc I had handy ("""This is Edition 0.75, last updated
> >> 19 January 2020, of 'The GNU Make Manual', for GNU 'make'
> >> version 4.3.""").
> >
> >Likewise (mine is the latest version in Debian unstable). The change to sort comes
> >from their[1] eedea52a, which was in GNU make 4.2.90. But the matching
> >documentation change didn't happen until 5b993ae, which was
> >4.3.90 in late 2021. So that explains the mystery.
> >
> >Those dates imply to me that we should keep the $(sort), though. Six years is not so
> >long in distro timescales, especially given that Debian unstable is on a 4-year-old
> >version. (And if we did want to get rid of it, certainly we should do so consistently
> >across the Makefile in a separate patch).
> 
> I am stuck on 4.2.1 and cannot get to 4.3.90 any time soon. Can you
> want on this? It will take us out unless we can suppress the $(sort)

Hi Randall,

I'm not sure I follow here. The change in 4.2.90 is that wildcard
expansion becomes sorted by default again. So adding the $(sort) back
shouldn't cause any problems in 4.2.1. Or did I misunderstand your
point?
