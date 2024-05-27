Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD427383
	for <git@vger.kernel.org>; Mon, 27 May 2024 00:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716769331; cv=none; b=Kzkt5ahNz1wM1rBOdpJusvvZbqvQpD7H6SBeliqH5v0hjLLhxovX3K2DJ+nEb5M/HUS0R3BsPChwEoSYu+TAGyx0pU4iks2+GTYD+KQAziMc82V0iy+ukA01aih0ZJoFQpYO3A6SVU6RPUnsXMIaiVs1+c1Nu6zLp0LuiDJ7sBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716769331; c=relaxed/simple;
	bh=Jl5lZc9EC1za0+g94FYfl5wRKPdNtJUkmiY+fRScylc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pog32GpAbnnVpBIrN/dbMJO9A25aCiCgEXA29SHBa0cDPHOwU7qNuTF2F4zAzlUhFfk3Lq3tqZJVVFGmIFL18mWVoaXO/nXYZ7HjSMV68CnaiySmQl1kDJcPF2IL7Jnsn0FrBh2R0lM9tRI2n5KB/vG8RCCoggRlNhgRUyxbVVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q0Y8akJt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q0Y8akJt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716769328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e2r2rqlH4QZrnMSjw2zHevyzYzliUtEBbfyC1UOh2xU=;
	b=Q0Y8akJtCnVHDC6s/t4ls1sxua9XdyJvBh305PUvjeovML8MohVMpqw6XP73SkZNl/oDYl
	ioFv3RdPt9Y9lYGY9R4MWJ37/6XE7/PiYwBztMD8RIftCgcRv+2mO9baOuSuMNlSi/Wm9V
	fi418ebPPJ2DDTk9Lk9rluxej3VXQAc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-4UmH_e36NFaFIGeFfpZXbg-1; Sun, 26 May 2024 20:22:07 -0400
X-MC-Unique: 4UmH_e36NFaFIGeFfpZXbg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6ab95e5eedcso32675676d6.3
        for <git@vger.kernel.org>; Sun, 26 May 2024 17:22:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716769326; x=1717374126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2r2rqlH4QZrnMSjw2zHevyzYzliUtEBbfyC1UOh2xU=;
        b=By/0L/RFmKjdIKZKfq+j1rPZhrzT8tWQJ5WlLLTr9nYiB8QYVyNRWnfGB2bnkkrr9F
         szFSEJSQIPboHM7d1gaCVoQtKBtyC46AoUsAtEkhYo4TOxwn0zyru98HL/XZt6cIr1H7
         vXoQaHgsbosOfmdEHIf8uqgxA59+sU4Fb+1xnG4vmw0/oAd5kcapLnW7UIHtyw9+E9bp
         VZYfjgf7GT9qW5pFOlDYzCy1eJxE8c+44i5YN9uyWK/ykp5Id+Qq85TivH876bu6PsAu
         ZeIcGsLMs5I3y47NX5ZSw9kGP9RnjA8ps0qixS02NQZKkWqPzRT6Oa8SaD5nUKz8WT1m
         4Vmw==
X-Gm-Message-State: AOJu0YzEPX8Vw1WrmPz5TVhWB6ipN+6fQTicgQpDD4kLg+cBE8FJLhag
	/Jivxg7roYiK9kC8RMO85wg9cIHkvcMXe6ttlVPL+ONKZ20y65qf2J1rET0a4+mbsW5rYJriRP1
	+Xt2kThjsBfS+4t0uSK8eS1IaP8I17njuNkdphavaPVqR/LpzaGFG4/JwzQ==
X-Received: by 2002:a05:6214:469f:b0:6ab:8fea:9bc1 with SMTP id 6a1803df08f44-6abcd0fbf17mr120684616d6.53.1716769326168;
        Sun, 26 May 2024 17:22:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbCokWDrL4K/3Cmoa/ibg6H7KpLiytpTaChuSNQdSDcEGdH2bE0Kcr1Fu1jHuNdv+Ji2voLw==
X-Received: by 2002:a05:6214:469f:b0:6ab:8fea:9bc1 with SMTP id 6a1803df08f44-6abcd0fbf17mr120684376d6.53.1716769325669;
        Sun, 26 May 2024 17:22:05 -0700 (PDT)
Received: from fedora19.localdomain (203-12-11-234.dyn.launtel.net.au. [203.12.11.234])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43fb17fa2b5sm29017581cf.48.2024.05.26.17.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 17:22:05 -0700 (PDT)
Date: Mon, 27 May 2024 10:22:01 +1000
From: Ian Wienand <iwienand@redhat.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v6 2/3] Documentation: alias: add notes on shell expansion
Message-ID: <ZlPSKfzHejm-Z5Pn@fedora19.localdomain>
References: <20240525012207.1415196-1-iwienand@redhat.com>
 <20240525234454.1489598-1-iwienand@redhat.com>
 <20240525234454.1489598-2-iwienand@redhat.com>
 <xmqqa5kcduis.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa5kcduis.fsf@gitster.g>

On Sun, May 26, 2024 at 04:26:51PM -0700, Junio C Hamano wrote:
> As I keep saying over multiple iterations, the above three bullet
> points stress too much on the minute implementation detail while
> failing to tell readers that the end-user alias receives the rest of
> the command line as arguments.

OK, I can agree that perhaps I've been a bit to fixated on the
addition of "$@" and the mechanics of this.  I will propose again with
this trimmed.  What I didn't have to help me at the time was the full
command in GIT_TRACE, which I think is probably a more appropriate way
to communicate these details of what's actually hitting the exec
calls.

> Of course the simplest one-liner, if you had the "one" script
> already stored in the file, is to say

So the reason I fell into this, and I wonder how much this plays out
for others too, is that shipping these workflow bits as stand-alone
scripts would mean no !shell tricks required, it's all very logical
and I would never have looked at any of this :) However, when all you
have is a hammer ... since a git config .inc file was needed for other
things, it has been overloaded into essentially being mini
package-manger that avoids having to install additional dependencies;
one-liner shell script at a time :)

> You can do one of two easy things.
> 
>     $ sh -c 'echo "$1" | grep "$2"' -      1 2

Ok, I think "sh -c" in ! aliases is a bit confusing, personally.  You
end up two shells nested deep, and you really have to explain what's
going on with $0; it's very easy to miss.

>     $ e(){ echo "$1" | grep "$2"; };e      1 2

This method, which is used elsewhere in the docs as well, I think
makes the most sense.  So I've left that in as the example.

-i

