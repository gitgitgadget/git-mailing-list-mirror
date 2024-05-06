Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4426B15921A
	for <git@vger.kernel.org>; Mon,  6 May 2024 19:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715024175; cv=none; b=X1nFwonFGjOLXB66nqe/BGc8OS2VMEgO4rA5C0NVzXNGZWjClUNeAL2weR5gTQVicxar2WsFFS1N/YypL0N5yRRuXc4HGC5OHoqd3zFUPYkVKnlMJYkzka2bHWody4vxqowIjGudLS3O0OvrIFJtg1mXVs3eG2Ghi7WcvOgMj8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715024175; c=relaxed/simple;
	bh=DUZcCR73FF11z+aQQvmbIk8O/ZaVVVWIkZDVXRdeNpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=glby+i+WDFqwXSfB8x1BWN2HCo6B5Q6C0bj3IqMcZIFfC3Cqp7e62DGpY1PVpsp0jByuHYIb1nj7CeJDqN3gx3fOzMunkaNndyQj0uX2g4uzYV+ybFvfPVya5U7+v3yARlDcBInI0nFTIEzam/MkAmX6SFdnCCQkN48oH+GI/k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KWHGDbo2; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KWHGDbo2"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5b22f818a24so164614eaf.1
        for <git@vger.kernel.org>; Mon, 06 May 2024 12:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715024173; x=1715628973; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RNT5nbyVvY/SD79nt35U0I0RZgxm5NkjQ1hRvjCLRkQ=;
        b=KWHGDbo2+ZuaBc6lZ6AuNXw6ICp/tbXhtYlatTkwFlQAK/ZcObOEoEbefpEaB/OmfX
         9ZLHdexIMA9rZvfULs1YhYVv7U/vXBferwOlEbHqwH2DeMjPpnQ+dVv0Xyj6Hwz6935d
         T2JFawKrhQQlPnu0bH4P9T4ycNfX8BM4XVyDeIvhkGpPgG5i7OzJYw4HVuDyhj4cLT81
         K0NPqlr1NZYvHfy1uA8uXSqDKibcX7oWgPtZgn2YrZRyvJuuffBp/+Rbb03pNk4x90JB
         /GjnKXC85n5hYt1Z6ur8YU9o5IAi6U57RJLg3vuoQfNCcLePvoRjaHV7NE3qcepJGBCT
         EeAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715024173; x=1715628973;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RNT5nbyVvY/SD79nt35U0I0RZgxm5NkjQ1hRvjCLRkQ=;
        b=UPf4I6DZUnCt7vkjdVpYOj0SdhpB5zPGjEQRfioPFi+qh0f9CIUAaNl2ManBrA7LUC
         qlrmkJJzW2iWPHQP8JM2f+MTAKzn1STBuyVaLTcv/htWiVn7t6SxAGb6MScw5kt99uQe
         c33SqDshLeA61e2AXxA8O+O3k736PTw6Br4EUizWTMK5gREdMiQxcX/QfyhPruJ5ELPw
         hMF2h75oKSpjfWrRNr8Q9YyZmtW6c35pI/j2o4DQXysDgtFFd8N/ZRJJP43PBaBxDDhF
         I4KRYix+M0iJDPLrST0Zg73LvnNEOiIr+FURlq3Su+WmtRZTU6hRVG3FvBhUgeoKZCr3
         2VIA==
X-Forwarded-Encrypted: i=1; AJvYcCU5c5PWU+yJyu8sHOTPKNwN7J+p0aR7XlU6v76bcK+LkUDwcPTB+TAz8VNWcfU2UbozgytOXdyMID1JBypmtCMUuzE2
X-Gm-Message-State: AOJu0YxyHnguorp21IguJE9YyuUmfuClNUGgbKKhp5yqu9WUlJFpKAEh
	tNOI+IOhP8olFKxgl6ojlukRPUE5yFJ+Y53DXI89cBJF7WCjsyLP6Woalz0r7A==
X-Google-Smtp-Source: AGHT+IH8JIqwouIdeS9Qn54eABFVOAFvjlsA52RfmqZYgOX4rj64BKAZL9z3Tg1cTIbXHkY5UBb0TA==
X-Received: by 2002:a05:6358:9046:b0:183:d2fa:ff5c with SMTP id f6-20020a056358904600b00183d2faff5cmr12261525rwf.12.1715024172867;
        Mon, 06 May 2024 12:36:12 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:cf3e:6b4e:994:dc81])
        by smtp.gmail.com with ESMTPSA id e7-20020a63e007000000b005dc8702f0a9sm8439753pgh.1.2024.05.06.12.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 12:36:12 -0700 (PDT)
Date: Mon, 6 May 2024 12:36:06 -0700
From: Josh Steadmon <steadmon@google.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	avarab@gmail.com, christian.couder@gmail.com, Enrico Mrass <emrass@google.com>, 
	Emily Shaffer <nasamuffin@google.com>
Subject: Re: [RFC PATCH] doc: describe the project's decision-making process
Message-ID: <mdgbdajenbv23r63hreieemielgdtdkwjzb65pdv3b4rylyyxi@4d3eeymtjvva>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	avarab@gmail.com, christian.couder@gmail.com, Enrico Mrass <emrass@google.com>, 
	Emily Shaffer <nasamuffin@google.com>
References: <b2ef74c1b0c7482fa880a1519fd6ea1032df7789.1713222673.git.steadmon@google.com>
 <20240417163244.651791-1-emrass@google.com>
 <xmqqr0f47wp9.fsf@gitster.g>
 <xmqqseyzar96.fsf@gitster.g>
 <CANq=j3u5ZHYbJQjhwtnq05GocOE_AVrHodjPOqVCNN7OZHwVsQ@mail.gmail.com>
 <xmqqfruy7oq8.fsf@gitster.g>
 <ZjU7CWdwb+xKubul@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjU7CWdwb+xKubul@nand.local>

On 2024.05.03 15:29, Taylor Blau wrote:
> On Fri, May 03, 2024 at 11:08:15AM -0700, Junio C Hamano wrote:
> > > Yes, sorry for silence on this thread. I am working on a V2 but
> > > probably won't have it ready today.
> >
> > Don't be sorry; the message was not addressed to you, but for wider
> > community participants---especially the ones with more "clout" (or
> > "long timers" or whatever word we would use to describe those whose
> > opinions are trusted by others and count more) need to buy in if we
> > were to first agree on that it is good to have a set of written
> > rules, and to then agree on what rules to adopt.
> 
> I have been meaning to respond to this thread since I was mentioned in
> it by Emily, but have been unsure of what to say.
> 
> On one hand, I think the document basically outlines the status-quo of
> decision making for issues that are larger than the scope of a single
> patch series (think "should we use Rust?", "what is our platform
> support policy?", or "how should we approach libification?" not "is this
> particular patch (series) correct?").
> 
> So in that sense, I think that the document is a good starting point,
> and I think that it reasonably captures the status quo.
> 
> But I wish that we didn't have to have such a document in the first
> place. In my opinion, I would much rather see decisions like "what is
> our platform policy?" made according to discussions on a patch that
> defines what that policy is. That way such decisions can be treated in
> the same way as ordinary review is today, and we can avoid the need for
> a separate process.

How would you feel about a doc outlining how the process changes as you
go from: A) small/medium patch series, to B) larger discussions with
(parts of) the proposal recorded in patches, to C) large discussions
with no patches? This is the structure I'm leaning towards for my V2
draft.


> (For what it's worth, I thought that the SHA-256 transition was a good
> example of this. The RFC was posted, and the discussion was had on the
> patch series itself).
> 
> Another way of thinking about this is that I would be extremely
> reluctant to see a similar document proposed for reviewing at the patch
> series level. In my opinion, the system of reviewers and participants
> discussing the series and the maintainer solely determining whether or
> not consensus has been reached is a good one, and I would be extremely
> hesitant to recommend changing it.

Sorry, I'm not sure I understand why you wouldn't want the patch series
process documented? I'm just trying to capture the status quo, not to
propose or recommend any changes.


> And I would advocate for a similar approach to decisions that have
> implications beyond a single patch series.
> 
> Thanks,
> Taylor
