Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909226EB51
	for <git@vger.kernel.org>; Fri, 24 May 2024 07:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716535139; cv=none; b=UyzlHvj1wd+pl6u3/wNe+GEOsogCJ7Wrvmc/6dKU3Fnr+opfaJ0A45lDwcrxjB3e0id1mxfkBxOa15yJH+EVTXgdDkcYYCDV/5Ygu6ZQ5HdwJTNhREouNSAG71fnB1QK1x6ys3GkwBHfy3rnueuPN7UWD2agA0sC0o5Zzn3UODA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716535139; c=relaxed/simple;
	bh=iiG1yakMEKpADatrcrhyMU27T/AmeI+eq2pDCgVewzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RfjYfKBpkijEDCUibL97nLUtTxEJO8ziQSOk2/CiR7rFEzcnRgwwvEM4uWP7APXgwgpPYt30tqbmSbali4jv3RL40GWJ3fjY8AdisKU7Zs7KDw9YH+NLN9A9WGDIg3T/Wn0rR6awGDnif7admaXJP25fttjurwAx9xaB4hnB5KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GyAvHbFS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GyAvHbFS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716535136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x0Mj3o9dSNPL5J6/GLfaQxByuTh+zFx0uR8M/Hijud8=;
	b=GyAvHbFSOXms9SlEZU8DVL2lvGZ7gUAODHXFhBO8CU0rTyT7unADhxgM2ZElsd/C6o5hfJ
	bz4ZHF10LI0lRnA6yeBubmzhWiSVOI2Jo77J3G/nqNc9SO4/kRhKGA88fvHMQ3xr1xIm8g
	vnou/E0xaE61kGR/MvynjS+8RyKEN1s=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-FFjAXsjvP6G0kEXd_GzhpA-1; Fri, 24 May 2024 03:18:54 -0400
X-MC-Unique: FFjAXsjvP6G0kEXd_GzhpA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6ab8852d34dso10924506d6.3
        for <git@vger.kernel.org>; Fri, 24 May 2024 00:18:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716535134; x=1717139934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x0Mj3o9dSNPL5J6/GLfaQxByuTh+zFx0uR8M/Hijud8=;
        b=DG7wn690g2WNTW+afxETEGTr1QI0s4769nWX5gXW5LIZ30aDx7jWk9AdPG8f3lFP+X
         1UMV03lO1QzFjIPr56RsPPlCNEk4OzKjcRE+dwkolXRAanHFbsbG7cegHAf8Af2VC5v4
         SEVFC/hGiUQTKCGDGYPcD+6NPiN8sp/n2IeZ2lxPhy+aPIyc+94H2Fyz+MpmxsLVxbOd
         4gyMDNwybVlXAgiAYkmvl9VRc94fAoKU5QBTIrVcGOieoHe4foZ6fcKxp/HEwwwJCh6B
         gheyoUaSIC0/lKe6Jlh46SREJ/BuwiUGWURXXQHzYQnEUAj2OZNigBLEJZ0iTrAMqFk9
         vTFA==
X-Gm-Message-State: AOJu0Yys/CZrWP3aeEGDtJSH1eWLAVkZX8bZR+vikarxArDm2A6Mpacf
	17Rns7S+LedaJZAC14RlThMXIKcO3qJVOI1Uvodi7YCRRPR+8cv2ZylreAr9aueJz7Em3QORJ0h
	Pty3LbGFJsKCBHNR/yr19xagO3Ne9MMhEu8lB+K6CSIwOU1O/9GyfFoyUHQ==
X-Received: by 2002:a05:6214:5781:b0:6ab:8cbd:b953 with SMTP id 6a1803df08f44-6abccfb437emr23708466d6.21.1716535133587;
        Fri, 24 May 2024 00:18:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpZb4l7hjT7fZcG3mxeO1nkZJPjgSqW7fHgYSXZIgu4saoP1I4I4uwNu6G09P9alBHzCIlMg==
X-Received: by 2002:a05:6214:5781:b0:6ab:8cbd:b953 with SMTP id 6a1803df08f44-6abccfb437emr23708246d6.21.1716535133186;
        Fri, 24 May 2024 00:18:53 -0700 (PDT)
Received: from fedora19.localdomain (203-12-11-234.dyn.launtel.net.au. [203.12.11.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ac162ef7d8sm4673546d6.101.2024.05.24.00.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 00:18:52 -0700 (PDT)
Date: Fri, 24 May 2024 17:18:48 +1000
From: Ian Wienand <iwienand@redhat.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 3/3] run-command: show prepared command
Message-ID: <ZlA_WIn1y7Oo_D88@fedora19.localdomain>
References: <20240523042143.1220862-1-iwienand@redhat.com>
 <20240523043806.1223032-1-iwienand@redhat.com>
 <20240523043806.1223032-3-iwienand@redhat.com>
 <xmqqpltcwnqm.fsf@gitster.g>
 <xmqqttiop05y.fsf@gitster.g>
 <xmqq4janpwqq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4janpwqq.fsf@gitster.g>

On Thu, May 23, 2024 at 11:09:01PM -0700, Junio C Hamano wrote:
> So with this applied on top of the topic, 'seen' does pass with
> SHELL_PATH set to say /bin/dash, but this still fails CI jobs on
> Windows.  

Sigh, it looks like windows uses prepare_shell_cmd() instead.  I think
it's still probably valid to dump the full command there for the same
reasons, which I'll add in v4.

I've reduced to the check to just look for the trace prefix.  This is
enough to ensure we don't regress by removing it; the exact details of
what comes out really isn't the main point -- it's that the log is
there at all to help you debug what is being run.

> Oh by the way, I just noticed that there is an apparent leftover
> debugging statement that accesses outside the test playpen.  When
> you reroll the patch, please make sure that "cp output /tmp/output"
> is removed.

Done

-i

