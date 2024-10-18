Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CC820264A
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 18:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729274613; cv=none; b=TAGiYLh1zvRM3IsoQBCMjtux0USbzAnAoagAHw/y0zaDZMhuRs8MmER5RTMD+2JLDEWa1G46stfv8bSd1V7IEVG9+O5bY8CxKCjMsNL/tzS50ZEvhQyXHp2tkkkZ1jeUgkoBZRnDxtw4O+B6JXYccCHrHoR5lDD+T9qIr+1qTqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729274613; c=relaxed/simple;
	bh=bFfI1Vq6bPCc3NCcFsVgLFQFl87PMDjydMi48Xszqy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TFMA5maLL10i+96s2Zgdwgh5LC9qBfkRG/WnGnYmE5c1zSN2b9Pw2YcN99ohVhIP38CkVXVi3TrnNF907IO/G/whiotpG7A7wOl04lp/TLiV1oAdZHPiKiLa1nGw+sj5+efHHPaZQOxC+H4kem2duWgEvLCzZKPMvMi9j6xxdLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=INhbn+0L; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INhbn+0L"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c97c7852e8so2988272a12.1
        for <git@vger.kernel.org>; Fri, 18 Oct 2024 11:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729274610; x=1729879410; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kmL31F7gDQ7L6UZdroACqcbzO+yrGlYpN4O80/02DvA=;
        b=INhbn+0LI/Y/5SjucIh94rLTPHluwaWysl9YQESVIlle0XG5aJKwoug3+UJedP2inA
         hlpHnTWhxUSaDkxbqPaQDmXfTgheflvOczFLkbzvnehrBVw2kaQE9tlaaoxG3OVB2mzk
         YuGx8kfR67DM2p0BaB/WQqyX0pyqLYZNT5xd0HCE6DcDTSM4Bt89R6h5eJ85ivQBcam/
         D8s4uhFCGVhYiyZKNSP65snmfXQFIfMERkADayz8u5ZXmSVzeTWP5xzf30abOXchl38Z
         6o6GoQz+U2qTOBR7b0EyBCHN5yMlBv5qPn3kGSOHULhrAgPCg4SA8ZMYMOj5leEWVI7c
         p3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729274610; x=1729879410;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kmL31F7gDQ7L6UZdroACqcbzO+yrGlYpN4O80/02DvA=;
        b=HDBZn88WI06y5uJ9pL9N/ySR9lc//SRETigVhrxJ/n6YUX93gf+7n64Ea3Y09ePA5P
         u3qnZTK6v4XSh/C0cmsSLaoKG512/iZtwAGGkySWZpKdCerFRRHTeBmZ5sK45DlVKHSS
         gELF+t9/Z20uYe24Cbpg/o7Xi46vrlLrkSpIj9QVbI5GTzqcs3jn6zTeaxLt3ACd85ef
         pU1HDHxF/8L5YtkbvCrrYjCulf9uhNkzKAmsWi+g5XVZPGUVIz/ODYvp/rDd4mFRzWlf
         ZPCsiGVgwljwj2NFja99H6vsrb3WMTW7Zui5wf9j3GcQH9hxlfGrqxZJBDVQmAtzY6XB
         blQA==
X-Forwarded-Encrypted: i=1; AJvYcCURXxfeyYkR8OkoU5LBQGLlFKKwB3WV5JsMZmZRw+l1rCzTtmP0wbPvRdH6QQ5bwHxHveg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbc+lnv1JaJpGVxWtqwPZAU6CIZtqL2jUaDvo5AysF8SkORsla
	+9GMzx0wYgH2OZRsdVIgO0/MTGXkN6O1kzhypzaVw8tKwHgXeYgO
X-Google-Smtp-Source: AGHT+IHXJVXUT+dP1mDK3KcBAWWI8hZw7nIIXdziCEQgtfisR7VxjkWLvqj5N7hQ5V4vN/rtkldgaw==
X-Received: by 2002:a17:907:7e86:b0:a99:ffa9:a4cd with SMTP id a640c23a62f3a-a9a69bab63emr311253666b.30.1729274609723;
        Fri, 18 Oct 2024 11:03:29 -0700 (PDT)
Received: from void.void ([141.226.12.132])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a68b11731sm123147566b.93.2024.10.18.11.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 11:03:29 -0700 (PDT)
Date: Fri, 18 Oct 2024 21:03:26 +0300
From: Andrew Kreimer <algonell@gmail.com>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH] t: fix typos
Message-ID: <ZxKi7qn6tEWyBXsd@void.void>
References: <20241017112835.10100-1-algonell@gmail.com>
 <ZxFyKXDCJkRZYYQY@nand.local>
 <ZxKSFBl_pV2r99dY@void.void>
 <be0c95ee-1d9f-4e97-9710-0ceba9c3aaed@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be0c95ee-1d9f-4e97-9710-0ceba9c3aaed@app.fastmail.com>

On Fri, Oct 18, 2024 at 06:58:48PM +0200, Kristoffer Haugsbakk wrote:
> The code style says that redirection operators should have no space
> after them.  See Documentation/CodingGuidelines at “Redirection
> operators”.
> 
> -- 
> Kristoffer Haugsbakk

Thanks for the clarification, will address this one as well.
