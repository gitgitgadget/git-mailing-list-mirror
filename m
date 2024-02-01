Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF6E3EA87
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 22:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706825214; cv=none; b=bsixmOTOK6laUQvYVQdC0ozeERusiU54JxdQcPWhFNrsBEv0GaJw0uwvAAhb63jDjBBBAh4igqOkexlRoB525e7W7OCjJDmAnyJDDa8SUfko9yTbIfpdsmdrFxG74F0pGZ3cAVXUp8wYwZOrhtuaU8zMFO98xxFmhUY2tXIbH/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706825214; c=relaxed/simple;
	bh=fxU5ifYQVL8R3cCIciVa8DzTra/n7n6lqC9ViGxtsiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eoVbIHNXiZFl/ofWr4AAPfLZv8MT3kJfiNvqujOaElsflpNef2BHTbzvtBs22ombsJB7+VEfx9L26xj+3SZyKD6XuILna+FfQ1IJp8is9sY55XNTuVjdAkxgJy3m9CPCU9519rWlPnq6/LxQZlSl5vlc2FWsPPm3whud6XLSpvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QWXw3qd1; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QWXw3qd1"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d958e0d73dso1385575ad.1
        for <git@vger.kernel.org>; Thu, 01 Feb 2024 14:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706825212; x=1707430012; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qJLEIbP1iU4ymqx92YCOLFAHDW2cB83Sp1lyUbXfvF8=;
        b=QWXw3qd1nEZieBmNt9PI8QWppfd9AlL28l9Mg+rDyHiLUdzz2YIIxXAqjK/9uQ5yu/
         o6zY7/7WUkiRhC0Gh8a4c/RTblNCVxUSapH6OS3TVGXIKakUofSoN0fi6lyXFzU/+O3M
         yynGdhcHYCMTr99XsiFpaRv0FAXCBYleNL4ogx8d7HZrXAPFeY71zF9pNkkNTzMewVrk
         X7wosTd1uSZiXuIvVVPi25LufA5itSOpB/5tg0NvS4Kf/zPA9enGUqXCoXAmm9pHdgQ4
         vChtyrhtnyp2Vi9KcdFtdG8+VO2MZnRNxPdwmydtAIHj5fQaU61v8XQ+xcGgKBm6qL8u
         hXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706825212; x=1707430012;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qJLEIbP1iU4ymqx92YCOLFAHDW2cB83Sp1lyUbXfvF8=;
        b=RloQr1tqrMBp2A4sthuWV+rKyYIKHFnn/IpI7XjGcRiX7oDFlFk9braQhnCIWt8ghZ
         DcBK1H4A0DpbhUqNXrxr2byY2dYmdAClOSU6pfE2yVMfTFE3aZAX9RT0zjdDqwSwU7/c
         EXN0oX2aPvGSZucDQR9KqOpjWJYL6SQ9EuWONRHjVOyJhlc6rgDWyhxIiGqC5WiGqzJ2
         BtUvX2whEVUKM8YZ/OI54wUvw4EjqRc4rcuVIovo+mM0O4hqy03H7xFo0TbPVOzMhKBz
         dha+JSlSiyMrWtFSBuNDW3Jcjfsu7lmfdN5Wo0J2E6EB+GzblcXH2/neHvv1/Da0Llbl
         Nz/g==
X-Gm-Message-State: AOJu0YzLoymw7vWu18F5syTtCp63NrPZsjjjf3Arg1UceZnrQNqRyah4
	VEXxrapnR0MjSi3NKw0HODisEl/tha+Y7A+uEB+BLXm5hz0fXQZify7avLN53A==
X-Google-Smtp-Source: AGHT+IGlx5+oT2/wMzPQZw1xsG0iIDfBofQfoz0ItPWvC+W5YjFpj84P3p822tAhuTWqnGbvH51+MA==
X-Received: by 2002:a17:902:c952:b0:1d7:55cf:856c with SMTP id i18-20020a170902c95200b001d755cf856cmr456847pla.23.1706825212153;
        Thu, 01 Feb 2024 14:06:52 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWjScXBChM2rJp59vSg7QdnD52+oQEP1H8llUsI8QvW34MwZZwBGrSKO9ZRQmqE6DVxCwmfyV+ZQhEJVi7uhD7BVZIG2QzM0XAtnrjQTMPdEV7IEftusGpUoJFUau7J7QRsL4avuAkzzClUbfE+SsJpfL+VjlU=
Received: from google.com ([2620:15c:2d3:204:a0cd:4622:c199:928e])
        by smtp.gmail.com with ESMTPSA id ji7-20020a170903324700b001d8be6d1ec4sm314522plb.39.2024.02.01.14.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 14:06:51 -0800 (PST)
Date: Thu, 1 Feb 2024 14:06:46 -0800
From: Josh Steadmon <steadmon@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de, peff@peff.net,
	phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH 2/4] test-tool run-command testsuite: support unit
 tests
Message-ID: <ZbwV9iGsTWZ3ddfn@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	johannes.schindelin@gmx.de, peff@peff.net,
	phillip.wood@dunelm.org.uk
References: <cover.1705443632.git.steadmon@google.com>
 <5ecbc976e6216b941e760e096e166ab432ee7784.1705443632.git.steadmon@google.com>
 <xmqqv87sx3y2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv87sx3y2.fsf@gitster.g>

On 2024.01.16 15:18, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> > With these changes, you can now use test-tool to run the unit tests:
> > $ make
> > $ cd t/unit-tests/bin
> > $ ../../helper/test-tool run-command testsuite --no-run-in-shell \
> >     --no-require-shell-test-pattern
> 
> This makes me wonder why we want to do the readdir() loop ourselves.
> Instead of saying --no-require-shell-test-pattern there, wouldn't it
> be simpler to say "*" right there, and have testsuite() run the test
> programs named from the command line?

It's speculation on my part, but I wonder if it has something to do with
the number of shell tests? Google tells me that on Windows, the maximum
command line length is 8191 characters. Which is actually a fair bit
smaller than expanding the shell test list:

$ echo t????-*.sh | wc -c
25714
