Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE05EBB
	for <git@vger.kernel.org>; Sat, 25 May 2024 01:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716599683; cv=none; b=F9S0rCxu1Yr4fP7gIdru7Jpik3xa3fLbegCaTLMbjyI1Ea7GYqeST6yeCKVAX7vhuVznI4XbOi3IZTpT+L0HPIwpV270uycHPhzRxILXtGdWUBBWNKcpZ3plBmUrmZ+PZDUSBKZGTep5BFSfiyRfc38TW9QbwRL/OEjE/M56cF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716599683; c=relaxed/simple;
	bh=mUcIogtKa4pTeBR6OyLVHXg9scFzCM6QSVXdeSOQcYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DyKGeJB0vEHewWtxYcR7nA6E0Gs9nno1CXeCi5BjUdvBGtgzejYrVazJqzfTQHWlavy+ieCcIE0kClhNjVrhXeOkeivsB2fsJ5RVub6go5XN+G+NNLLpluri7HnRJ+S/PN4thMIDLEz6PXZKzZX4KnZNrmVDUpnddpzv0YIWu84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sw5ancEm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sw5ancEm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716599681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EVKkDzgNZx+jgz0bRFXRdFSsotT3RI42Oyfm6y9kTUw=;
	b=Sw5ancEm5y9+50v1EEG8ionEF3pEV7ti9LR9iYZcqZFekCKkym3K9Aje7igv1MOSq/Pf5A
	HhJtyefa/HPF2v4TVkWIzjPP4SJVkgyF3Ca8LP9cjqQJGPhpJWPiuscDoxvO1g4WIXtISp
	DMkO5jnUb3SAhebhW6UCRA6l4i85KPA=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-UHWtZ9IIOSi1W-CGFYyyjQ-1; Fri, 24 May 2024 21:14:39 -0400
X-MC-Unique: UHWtZ9IIOSi1W-CGFYyyjQ-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-627f644882eso12908647b3.0
        for <git@vger.kernel.org>; Fri, 24 May 2024 18:14:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716599678; x=1717204478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EVKkDzgNZx+jgz0bRFXRdFSsotT3RI42Oyfm6y9kTUw=;
        b=HAkLyWNyamkhUzkXhBlK1rO6IwI6FSlJA54GbsYVN2ygHVawIo9BjEKctRDy3xESeV
         EVrFYKVJkco2xfUT1YXoOeS+nyWCapNBjgLXCfmo1moPnWEVd7R8SuW15ypv1tqKqCbJ
         8cwFmxhZwIrD+yZeugJEBM5sOQEJuqBKOwmTXiTFGWJagtFQKogqslaSkjsQWX0Ipnyx
         N3/a5Yjc8d4GP93wC5WbEr76Q2WfCyBun37I2ufIv0RdUm7fPGBYw2/nIwb7dLigMPyd
         VzmpWqUeWN9gm+nr4U64SKAv56lThluQfWTSNnvBP21aeihUCHgbiQkYEGfAIt49qLpw
         JnKg==
X-Gm-Message-State: AOJu0Yxc+/IGOVyboppRBz/l730zW49P4uE83SZCGfziajUkrqQaVcv4
	RmWRyKNb6VueEC/VpNlIqzjKI6BTrxOYPI1vkXaLgMBGsSu9UKB8CB6RC3g7VYYhrb/82hdCfwh
	C/IlnBhRRhyR3FQ4lEz6olSNTgABzi4GfbVVtJCsZ+4DRRBiN8PrCtQtymA==
X-Received: by 2002:a81:91c2:0:b0:620:3c10:527a with SMTP id 00721157ae682-62a08d7a272mr39469727b3.15.1716599678306;
        Fri, 24 May 2024 18:14:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGc12jDItIWQFx+dhQ32a5mKr1iP52lay+v4VTuEIMRSnuhiRt/JKqfikViHL0cC0yU1tU3yg==
X-Received: by 2002:a81:91c2:0:b0:620:3c10:527a with SMTP id 00721157ae682-62a08d7a272mr39469627b3.15.1716599677907;
        Fri, 24 May 2024 18:14:37 -0700 (PDT)
Received: from fedora19.localdomain (203-12-11-234.dyn.launtel.net.au. [203.12.11.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abca5934sm107893685a.11.2024.05.24.18.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 18:14:37 -0700 (PDT)
Date: Sat, 25 May 2024 11:14:33 +1000
From: Ian Wienand <iwienand@redhat.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v4 3/3] run-command: show prepared command
Message-ID: <ZlE7eZ_-f4SaOaPf@fedora19.localdomain>
References: <20240523043806.1223032-1-iwienand@redhat.com>
 <20240524073411.1355958-1-iwienand@redhat.com>
 <20240524073411.1355958-3-iwienand@redhat.com>
 <xmqqzfsfja0d.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzfsfja0d.fsf@gitster.g>

On Fri, May 24, 2024 at 12:16:34PM -0700, Junio C Hamano wrote:
> Ian Wienand <iwienand@redhat.com> writes:
> 
> > +test_expect_success 'tracing a shell alias with arguments shows trace of prepared command' '
> > +	git config alias.echo "!echo \$*" &&
> > +	env GIT_TRACE=1 git echo argument 2>output &&
> > +	test_grep "^trace: prepare_cmd:.*" output
> > +'
> 
> If you run
> 
>     $ cd t && sh ./t0014-alias.sh -d && cat trash*.t0014-alias/output
> 
> you'll see two "prepare_cmd" logged, because you added one to
> prepare_shell_cmd() and another to prepare_cmd().

Sorry that's a bit embarrasing that I missed that.  Reading this more
carefully, I agree that the points you've identified in start_command
are probably the best place.  I've updated to this.

-i

