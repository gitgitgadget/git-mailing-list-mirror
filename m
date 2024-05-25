Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15528D512
	for <git@vger.kernel.org>; Sat, 25 May 2024 23:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716680997; cv=none; b=f/Y3r3CHV4A8/L72ljYuH/mJhlqEGonOwyjA6zvQ8dEiMym1PRUBcL+Bynid45VH+DNlRpNKXArf8hWbzZ5N9V5/dqX02069VouU5RAoailjxjG6I2VJ+6b4XTCPgp3AjQEGGyHUYB7fO+WncaksCo+kygnnke7Iqz1Nw4T1fQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716680997; c=relaxed/simple;
	bh=54ga/Hzgi3s6oPjv2g13jDa2mtc6mV1y5R7pd71Z83I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qqHr6ivAmsBcj4qDCv6DennIXW/1EjeZTVtWIXUOuqUjrss4s1+gigj8y/5gl6gxlBFlZp1Uy4rBjOenVXcfhSoEAhAe/ANz/jnGfq6JOnFLd7U/5BG7hZ1GoUM1bZPYJcDliW1CWlAWl1yx4LuLxY8M/1DTOZX8cBnqU9BSyCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OWlMNMCw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OWlMNMCw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716680994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c55ho2+X8Ur5iEZ5r/JKBDKnUnWavDJAKxLe9HjhXiE=;
	b=OWlMNMCwj/xBjETRSVO5/tU9S8O01X1AetwMwVdNjDKr5FPM23hqslvibKzcv7jFm7twRV
	vzUU8MaAiuEHEGjEppf4Bv4HrFrij/xgMIb2lj/RbH7JWyTmaP5P0EnfhGzVnHw2uZYL5t
	C+gfI6XwYcTtkt73UDaQqjlZ49QIJzs=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-mlS0LMvdOau_kR5OHBYa8w-1; Sat, 25 May 2024 19:49:53 -0400
X-MC-Unique: mlS0LMvdOau_kR5OHBYa8w-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3c9c4a2ae6aso3910383b6e.2
        for <git@vger.kernel.org>; Sat, 25 May 2024 16:49:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716680992; x=1717285792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c55ho2+X8Ur5iEZ5r/JKBDKnUnWavDJAKxLe9HjhXiE=;
        b=hYDnVnhV7JfDyz5/hy9/s9p7Rr58RwSqEwxnSuH5V7dsXyEdinsnq+gk/gEOyI0VAv
         31Ige+AIHk6OZ/j+Tydp1gvH7EexKmlK/d9m0K4TfHCYZ2jNwz+DAQfhhjst6CZa1NpA
         H/oAPv1ymqgEshFclDhk3Q8lq8IoKTtQw5gydwgoF4Hq0Tbox+ldR5BPHaoJzP9ZKsF2
         Q5zGDfj1ZenxDjuUjnjlpTbS+oZG92OClQghX8D96iHB+phOOocniw7AchvUz8oe1Y4g
         QaRreXZuvq6CFHnvO/3PGLXtZ3SaT4IMiV1PssZgpvt7lS5b/UcUL6uefWpzxPMAyDcL
         gAkg==
X-Gm-Message-State: AOJu0Yzh6m5MH9tJi8grvTq0zehJwE0b+sDZtC0GgFoGI6ce8BgmBqw/
	L332ej+VcaGRDHacBRNdyOxhFcDwxpxThPo6sZdrlBS95x16FERpCKPQ4FpId2ciKbrbGwI1ewN
	oue6AqtZURfPEFxqE7YgoiA3kUc8MIEfJLgcI2NskIwexh/e6prtBnld3hg==
X-Received: by 2002:a05:6808:2381:b0:3c7:3106:e2e1 with SMTP id 5614622812f47-3d1a538cc4amr8049007b6e.8.1716680992433;
        Sat, 25 May 2024 16:49:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0QCD23Z+am1nY912g2brZER/eBd4sgvHGFurltE8kCm0Vj64LW9S3ilQwE1xwzTu4Xpr3dA==
X-Received: by 2002:a05:6808:2381:b0:3c7:3106:e2e1 with SMTP id 5614622812f47-3d1a538cc4amr8048998b6e.8.1716680992066;
        Sat, 25 May 2024 16:49:52 -0700 (PDT)
Received: from fedora19.localdomain (203-12-11-234.dyn.launtel.net.au. [203.12.11.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ad77d335a1sm2875576d6.46.2024.05.25.16.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 May 2024 16:49:51 -0700 (PDT)
Date: Sun, 26 May 2024 09:49:47 +1000
From: Ian Wienand <iwienand@redhat.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v5 3/3] run-command: show prepared command
Message-ID: <ZlJ5G5CT5ZPoGAiY@fedora19.localdomain>
References: <20240524073411.1355958-1-iwienand@redhat.com>
 <20240525012207.1415196-1-iwienand@redhat.com>
 <20240525012207.1415196-3-iwienand@redhat.com>
 <xmqqed9qifxl.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqed9qifxl.fsf@gitster.g>

On Fri, May 24, 2024 at 11:06:14PM -0700, Junio C Hamano wrote:
> A sample run of CI job with the above change (and others I sent on
> the list) can be seen at:
> 
>     https://github.com/git/git/actions/runs/9233329671

Thanks for this; I had in my head that the pipeline wouldn't run in a
personal fork, but after I enabled it, it does ... I don't know who's
ultimately paying for it but I'll take it :)

 https://github.com/ianw/git/actions/runs/9238552513

is for the v6 version; I'll make sure to run it through that from now
on!

-i

