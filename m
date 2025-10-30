Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CC62D24BF
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 22:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761863445; cv=none; b=KsHnctHTmGFTL33UTwF+KARlmBMX51ru8xCVXfacY2QrtKoovuZ5yzCTsu5lumIzAPwRZmDaeWSal4nuOQcD/+oC/ZtOqjoDjtvifjt21hGhmcNUWCO95RWqxkDxRu/MlieTNzAVSe/WjbzafLnp6m2T2j+MW1Hp4OFtvGeAHEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761863445; c=relaxed/simple;
	bh=z+6GRMzAM73ik2TzoFjTMWKzfxcbx2zxRBIMXZaT4xA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gaFHjeKANGZ9yauUTzj8/mc0Pb8EnB++GqzAZ/4wx/aVDoryBWFTUSKH7qcybutXaHvd9TseR8EwDx1B7QH0E4VJNBVl3qGAzrdO7NjTL/LeLA3sJYvN2KARyNqp4dKzVE4veLVIdejXnVGTySyovSljMOBU36quGNwGB2B0bns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O2IWNZY6; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2IWNZY6"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b70406feed3so231454266b.3
        for <git@vger.kernel.org>; Thu, 30 Oct 2025 15:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761863442; x=1762468242; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3nTKes/Bv8KZMSKzD0iVN/jLxJeL8UD+9IkiF024YYw=;
        b=O2IWNZY6CpZu2/yOO2S3kOeHVEUnOcWZr0e38eE01+ByZp+lS6rKU0WiBy4TE308UI
         FjRTcV+ENkC2udTAnyjabG+sL5AGA5fmqu3PHy6Lb7fVsNKg56s9Yl1U3z8lm3DYQt/g
         4Qh+kQK6syFSQtb3LEsXFmwfENGBtJrr+UwcFjICwTb+5V+olqP8sxCFo7DNAXlsr195
         Xy1o9WCT0qbrhKeEiE1u6YY+/ooOdBZV2HRBetULPO+ftCzwd5AcR0MRzEvQp2HHzPXi
         7qa6anyGHoJ+SkJEzyc7rxpy6mxvC4CtubLN3yl/E0kAr1dNZf9/wHHGl2ZX8EsNKX4l
         9bDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761863442; x=1762468242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3nTKes/Bv8KZMSKzD0iVN/jLxJeL8UD+9IkiF024YYw=;
        b=EDdsMeendGx47favXVTgMfaNHfF3qv08X0eZefvTtMIZWKSci55/UNh9csSBAfRMnJ
         RGJxe+99sCIx1+DxQa0fNWEFojG/OuqcllUTJcMlzd0wGRpAKGtjIurEUrGsn85OvWwW
         nRleSxR3q2Y6oyRkznmyT3liiVhZhONv+3LLzoN715zLrL2RVdWa4CBb5+BU+Q7Ompe3
         +A+zDQO2X9TTJXSh+bzOOhTLVJYJqZOc2KhHWlO2pH5cA2WYEQEwXx7wD5d7lYYBvrD3
         sy1RC4u5zXZkJdAsPwQnLDqbA6yzZ4eA0rFAevOfWv390I6fdIpiW/H9nmyImzSHeaiy
         hUww==
X-Forwarded-Encrypted: i=1; AJvYcCV0bKGIE6OFuNY7FoS7xlpaNwp2o7XrsVLToQh7ei6CyX+cnqeKQFNjEBRx0jxaVgmfHrw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOJwVPZmZkJtUDYFVtoK5C7cMyrknMQ7HhHZCtpf0iSEAuV3cz
	KtH679jDAXJ6Wk9sDdeHd29PbliF87a1dvm4KAxuIZBir+On0Q8ROmZuNVDhsw==
X-Gm-Gg: ASbGncueA9wFXCux5vNrbQ52UrfHMspwZH9UQcVOnfE9FylnhrXvFgoi8EH9xILaDcg
	aVcIgb4trtXu6wP4Gk2/bbCPZmR4OdRz6FddX3J5N4Vhyu1pBGuTheobA87XC+YwBn8l0nkloqX
	IByC+sHk4CNWddYsMhEDCYOmCMewg6W9KvI5/wQT9MPEpyLCJcpXpn8TOgkUZlgbI/EQ56b9E/u
	7x6/e0c/N0EtrPFQOhpffh5YWfL8LYi9/Q4f6MOgtS5sVe5RUYXWGMOefGaMUtlxl9BzX/yRSro
	vbKqilY+OQ05BCJTDc1BgO/42oZjoS1ldMb6WC+G5pA+akb6KcbIA8vUaoLbZFwxiJ2epAiSeNJ
	b5c8Rj7918MjAiuVNaErg1f4OZKZv4gXbTNmLePxN3QstBD1dD0lITqL/ukzgeRZddMSX0IbFOD
	L+m/ADRtSMjDhX82JIUCnndtEtrBnPZH1lrB8PrOJK/hEHDLS9WEhPu1uG33FABw==
X-Google-Smtp-Source: AGHT+IHEILT+thA6fLGfzNVOOdGZw49GfUuWhmPU34aQxuITXvW7g/0b3bjEuhsLSL0UOi1vp1DpSQ==
X-Received: by 2002:a17:906:fd82:b0:b57:2b82:732b with SMTP id a640c23a62f3a-b70708607a8mr141028666b.54.1761863441772;
        Thu, 30 Oct 2025 15:30:41 -0700 (PDT)
Received: from localhost (20014C4D24CE560055F120778E994861.dsl.pool.telekom.hu. [2001:4c4d:24ce:5600:55f1:2077:8e99:4861])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7077cc4918sm320766b.57.2025.10.30.15.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 15:30:41 -0700 (PDT)
Date: Thu, 30 Oct 2025 23:30:38 +0100
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: rsbecker@nexbridge.com
Cc: 'Kristoffer Haugsbakk' <kristofferhaugsbakk@fastmail.com>,
	'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [BUGS] Git v2.51.2 on NonStop5
Message-ID: <aQPnDrsKLsLpaxgI@szeder.dev>
References: <xmqqo6psjq2n.fsf@gitster.g>
 <000d01dc4831$ff049500$fd0dbf00$@nexbridge.com>
 <729f9bbf-b75b-4161-b8aa-505ff906bb8a@app.fastmail.com>
 <xmqqecqk5g7r.fsf@gitster.g>
 <3dad5cb9-976b-4e60-9e6e-05c12c7d9f2d@app.fastmail.com>
 <009f01dc49e6$98c5ae30$ca510a90$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <009f01dc49e6$98c5ae30$ca510a90$@nexbridge.com>

On Thu, Oct 30, 2025 at 05:46:01PM -0400, rsbecker@nexbridge.com wrote:
> On October 30, 2025 4:26 PM, Kristoffer Haugsbakk wrote:
> >On Thu, Oct 30, 2025, at 20:42, Junio C Hamano wrote:
> >> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
> >>
> >>> On Tue, Oct 28, 2025, at 18:40, rsbecker@nexbridge.com wrote:
> >>>>[snip]
> >>>
> >>> Would it make sense for maintenance releases to have a small release
> >>> candidate pre-release?  Both of these maintenance releases have had
> >>> issues.
> >>
> >> Well, that is usually called "the tip of 'master'".  Has NonStop been
> >> having issues with the tip of 'master'?  For how long?  Why haven't we
> >> heard about it at all?  After things are merged there (which requires
> >> them to be cooking in 'next'---oh, has NonStop been having issues with
> >> 'next'?  For how long?), only fixes are chosen and merged to 'maint'
> >> to be the next maintenance release.
> >> ...
> >> I doubt any pre-release on 'maint' has much value in that anybody who
> >> are not testing the tip of 'master' would not be testing it either.
> >
> >You are probably 99.9% likely to be correct.
> 
> We tried setting up a CI/CD process for git on NonStop. The problem is that
> we use Jenkins, which gets triggered each time a change is made on a branch.
> The actual difficulty is that a single run takes more than a day. Once the
> committer adds each commit to a branch, we end up with a queue that is
> 2-3 weeks long, so end up not running a continuous process. Instead, we
> run about 1 a week, which should catch things. The difficulty is with the
> latest release is that 2.25.2 came out before our cycle and the breaks were
> in there because of changes to one test that just did not end up dequeuing
> in time. NonStop is building and testing fine now after Peff's suggestion on
> SHELL_PATH, but that was only apparent at 2.52.2. 2.51.1 did not have this
> issue with our inadvertent use of ksh to run each test script.

Neither the test library nor t7900 changed in the last two maintenance
releases:

  $ git rev-list --count v2.51.0..v2.51.2 -- t/test-lib.sh t/test-lib-functions.sh t/t7900-maintenance.sh
  0

