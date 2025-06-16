Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CAB2B2D7
	for <git@vger.kernel.org>; Mon, 16 Jun 2025 03:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750046026; cv=none; b=jAqU1vTtkXafULjGw46OCreQEiPyvep7Cu+5vDSpWsI5y5qBZScZG55Vgv4UJ+tWWnL2JuY8SUmhTWvmWSoHWwmg0YMflNcPdaKVkN7oz33ylyvATyOq4QlE3vqeO2c4PmLEg2tE+ujSSQJC93lUOBlwG/OrajtthILeOq+Npho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750046026; c=relaxed/simple;
	bh=TL8bTeA/rbc90jJUCPv89ay4R0Qk+Jnk0u6rZgoDXes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DKvn6vkPnMlzsnEbTkMeY2LV8l7DkATsBUD/ZVOnnIFeQreSZT/aNUQ+xP1bQzS84lrEe5SaTlMkd0twA/IrHMYYtlfxbURMOumyPPbQHC/iag3ioUR5ZRq2a3k+vd4aUYTY3hM4XuZnHzrpFsKEehnIzvKwDHYGnVsLrVfyUt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WWL4gmYi; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWL4gmYi"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-235f9e87f78so41611835ad.2
        for <git@vger.kernel.org>; Sun, 15 Jun 2025 20:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750046024; x=1750650824; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=okRXQlEfgbYBH93EsJRoTvAdi83VsrNt2YjWYxoyu/s=;
        b=WWL4gmYimwGBc7dx74K5otRxqTHvq/lkp2t/iX2oFDRRlxS0apZPMhtRsSZxxJ4L+n
         tsrQV1G5JJ2QSYHCFYb8egqIvOl68upXVJqv31567mPN7aq6wunsqsj7mcMVlFNZ4itX
         Up2YcMBcTRXQaICruTP5/94B40nysgIYcjbfWRd8RQuSYf2qI1ZH5ZW195fz2dsdD0hp
         Rg5a3QOJNhdwVLGcgPVl6SV/Gvx2AHrFBlPdIDJX3yGxZo5NVGNSau9DqLMOXEv9URKB
         1Hb76MV5k5N3kHUkY8XR3quSwqB9KFhR0nbJ5usal9i8jKlxZteeNTHxbii/d1zZoIh+
         jxmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750046024; x=1750650824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=okRXQlEfgbYBH93EsJRoTvAdi83VsrNt2YjWYxoyu/s=;
        b=kFapGgCsbAEwtBXhCAADcDJEfa1g8EW08SlcJYHHGJk9UuZeo7Wc1E7yVkKQthCKg2
         H6hgcs+I+BGeZ9s3ZTKybFjlFTucTX+nIL1J0/wkSEmUCRiDTAtk4kSQVdsUpExP251I
         qEPb1K/cGgz6HBNmxTZWCVNykH8mtgFLq3iqfJNsnizDJzUkuRjqAv1MpjDrophLw5c/
         +0LXKYKiVivjX12ewO3v4be4q901Z3jZa7Bj7+Tbi0iroSQbYfk2Jv6vEG0z9/KXUzRn
         gspa+ZqgC1Wjicf5mh1exvsVHtfLFTSQOAuU6ex8d/Yh/7ZH1lZSU3YtafCSZLpIJhzH
         ZwHg==
X-Gm-Message-State: AOJu0Yz9lCoRDjMEO29xLletcLjkZDAVk7vmsJZXtp2NIm3IhDXibvxH
	qb2NnGohYFIFg8cmmWkvZUnvhPaHifGd0wqcSky5Q6qfpb1wr7ez/9NgQhClzQ==
X-Gm-Gg: ASbGncsc5BHJnL0IQyy5UrQ8T0FZ1zGKIMVSPGIzsOmtimJXc28F6l8aXbj0SrZYzWe
	FlD/deZuuIATIwHS5wgQUu1nSosUCNzRrfu2m1QbGIK9UU3e06PoxOUEm8WGc2qakiETCmU2LkO
	BIQJF3ctYSk0PrXFXx2RjUxQkE1OlMPL8X/aPKoIUZX/czhNAIBwXe45J1lAsy3ya96USd39kCP
	OxJA+8ZaAXVt2pC2vr2ontTE4hIGV6MOObKa/hLOnWRgwth3NJ7Gfvjif0VBFurFS320CDMzy2T
	2SRwu2yvQDA446fnoOu46wFuvpXDfJuLBwCAIh/dmzQ8I+Er3DVf3rV3jVU8Jlsv36eoCnVlKem
	Vf0CzBzf3956rekOl+/zt010=
X-Google-Smtp-Source: AGHT+IGZfrtMBjnRZE0TD9SAh2WkATQ/Nv4Mme9rxhiMl3ZjWA0HpAVOyy8030v9hwxkXY91AIUbyw==
X-Received: by 2002:a17:902:ccc2:b0:235:f70:fd39 with SMTP id d9443c01a7336-2366afd37d4mr137722065ad.10.1750046024228;
        Sun, 15 Jun 2025 20:53:44 -0700 (PDT)
Received: from Carlos-MacBook-Pro-2.local ([2601:640:8e80:3680:61cf:f4c3:aee8:3fd0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365d88bf61sm51319675ad.22.2025.06.15.20.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 20:53:43 -0700 (PDT)
Date: Sun, 15 Jun 2025 20:53:42 -0700
From: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To: Rodrigo Michelassi <rodmichelassi@gmail.com>
Cc: git@vger.kernel.org, icaselli@usp.br
Subject: Re: [PATCH] replace 'test -[efd]' with
 'test_path_is_[file,dir,executable]'
Message-ID: <cioavyfxwgdhfzuodb7dnwzmvsui4xcxi6mljnlszjwebogajg@taejma43hgtx>
References: <20250616020827.10820-1-rodmichelassi@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616020827.10820-1-rodmichelassi@gmail.com>

On Sun, Jun 15, 2025 at 11:08:27PM -0800, Rodrigo Michelassi wrote:
> From: rodrigocmichelassi <rodmichelassi@gmail.com>
> 
> 'test_path_is_file', 'test_path_is_dir' and 'test_file_is_executable' are modern path checking methods in Git's development. Replace the basic shell commands 'test -f', 'test -d' and 'test -e', respectively, with this approach

Splitting this long line, into multiple lines of about 70ish columns is
better, see the relevant documents in Documentation/ for useful suggestions.

> Signed-off-by: Rodrigo Michelassi <rodmichelassi@gmail.com>

This certifies that you are the author of the code, an therefore should go
after Isabella's, who might be the original author which you improved upon.

> @@ -474,7 +474,7 @@ test_expect_success 'local clone --shared from linked checkout' '
>  
>  test_expect_success '"add" worktree with --no-checkout' '
>  	git worktree add --no-checkout -b swamp swamp &&
> -	! test -e swamp/init.t &&
> +	! test_path_is_executable swamp/init.t &&

this is not acurate translation, `test -e` is true if there is any "file"
with that name, the equivalent for that helper function would be `test -x`

Carlo
