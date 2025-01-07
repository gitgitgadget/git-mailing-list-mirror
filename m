Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C096A1EE032
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 11:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736251170; cv=none; b=t1dpnQokXLCniaxXBJLyCRF2UnucTEj/k5MCEwo35HEQpqd/JG/wTm5GDoN+YAnwc8u9xKuJLI0c7eF/9o9Qj566zhaGDWpJnIpIIeVMcucp0kmVLsZOQpqIQYZ/9tew1wR9hXWTTWS6MUxI3Lb1yi9hEC3C/xceVHPFz61Lyug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736251170; c=relaxed/simple;
	bh=8SZXfo4O/lOC4rIAxKHWrn5AM0JbsC57pwsx6yUNam8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fqyngeMCz/F/WSs5rugkXxx7pLstxuyMXMKffp260f5OqhJ8mldC7hFOXo5piKCPINwmPSjKLwpp/hiqBM+uRJS1sIDg3EJ6oMOVjhXeW1BN+GdfDlJ+79Rrf7XjYEmYHYPl/q49PQWnf+iH52P+pY3kmSXiT8yrCLi59H8Rt5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PnGiLiWv; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PnGiLiWv"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2161eb95317so231576645ad.1
        for <git@vger.kernel.org>; Tue, 07 Jan 2025 03:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736251166; x=1736855966; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O5tQahSqKH6jHVDIVxCIvnML/8cMHMYbSd9aRCbxX+Q=;
        b=PnGiLiWvPvSpuuvJQhYPesUvZTWRo32IGKqrvGZKIhqmv4qhMvKbIv8s9XbP/gp7/b
         brfrOY8u3bdDu54BJFMXSQ+JHdS6BxDPvqDVvSDfyJ/vtHBAMQ1t/meQ6cMRMjySmx0d
         6Gn5m45msQ9jx9yKQ/hYmYI41tyuUTW6DdBrzQxoyTXXt6wJSqSwV4TrGEP6HITGdNsb
         Ie2/AVquJDEi95uRQ8fKyVcERLZc059CGdaUWvuQ5BlrMFnBt7nAZ/5PyKQCAgqSYekg
         8I1VKGkmqidCOv+NlK0AqeGtYfHKfvrSoZUFvx8rEIQZLhupQDHA0j8mzQ9S8bGjhfAr
         Fdnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736251166; x=1736855966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O5tQahSqKH6jHVDIVxCIvnML/8cMHMYbSd9aRCbxX+Q=;
        b=XZox/CY0pF2j/NGpWJbTlmt9vxFGExYCj8k4OBA70++6hG+YwVSJxwJU3AQL0ZM+9o
         8A31CjKKFoA+d4Ujl4V4kiOYILoLOgx/9K6eeKsTF5qTQQs16FXfNty73ECZdLlUbkPJ
         IXz6N/2siRSJM+fs4sPadadQhYNXgWXf/LyMaQqDYowbOoG1L82+5e9zUpxkWuLOtLlp
         Z1l4XQJoL21suokZrFVoIaIygfSTRzRHwC1zdoarH1vz5zOc1qWX34+1Jh21uOOwKA7y
         d4Ep+4HlKtIX42Fxi3oRCxRUVvPOz4BVa/2DKC7OCGtX0q6GCvU0QBRehaht3NsGaBSg
         hdsA==
X-Gm-Message-State: AOJu0Yz8NPcx5d8GOxmgikjyScJx8NZucJ4wXLEwPVcPXhYt8sj+abOU
	/KdUefGdtmik4RAh+oKAI4/u5xH7DJFSZgS9wqE47yiGMU0EbIHh
X-Gm-Gg: ASbGncu8lZcHeSpO/JyGSHxT1VcvFt5YtI8mQQTEPx6ZeUY1gVuvoy6jbfm5LXMHaeH
	cWqUOa7CMhEmEgOY3KY8Bysjnbg2c5lD68OPI3OA9nf1JKgBK0qcRwmOoOWf1NUYehe5pM9qp0l
	DpghDCNTySWWOOW4m6u8vnf+BK/wRyoodURBpHfT7Id5ro6vF3NHzSvazyGj0VvA0LB/D2krRqq
	DQjKb9UqMuYpzXawAPfFnLBfC1kKN8dqOE=
X-Google-Smtp-Source: AGHT+IED1NCRe9dMCLciZvgS7pJXaWLLwRsrYhl32m5gJNTLzEqSlU4fMh5F13T7RzURzl+zwoJLLg==
X-Received: by 2002:a05:6a20:8412:b0:1e2:2e4:6b2a with SMTP id adf61e73a8af0-1e5e044af7bmr93792857637.5.1736251165755;
        Tue, 07 Jan 2025 03:59:25 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8315adsm33081841b3a.51.2025.01.07.03.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 03:59:25 -0800 (PST)
Date: Tue, 7 Jan 2025 20:00:28 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, a@archlinux
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 10/10] builtin/fsck: add `git refs verify` child process
Message-ID: <Z30XXCel6Fd7Thp9@ArchLinux>
References: <Z3qNUizvHJLgMx1y@ArchLinux>
 <Z3qOM5M1ioZ0Px4T@ArchLinux>
 <xmqqv7urwpu1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv7urwpu1.fsf@gitster.g>

On Mon, Jan 06, 2025 at 02:16:22PM -0800, Junio C Hamano wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> >  builtin/fsck.c | 28 ++++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> >
> > diff --git a/builtin/fsck.c b/builtin/fsck.c
> > index 0196c54eb6..a10e52b601 100644
> > --- a/builtin/fsck.c
> > +++ b/builtin/fsck.c
> > @@ -902,6 +902,32 @@ static int check_pack_rev_indexes(struct repository *r, int show_progress)
> >  	return res;
> >  }
> >  
> > +static void fsck_refs(void)
> > +{
> > +	struct child_process refs_verify = CHILD_PROCESS_INIT;
> > +	struct progress *progress = NULL;
> > +
> > +	if (show_progress)
> > +		progress = start_progress(_("Checking ref database"), 1);
> 
> This had an obvious semantic conflicts with a topic in flight.
> 
> I've resolved it in the latest integration after pushing out the
> 2.48-rc2 this morning, so there is no need to resend, but please
> remember that it would be a possibility to rebase on top of an
> updated 'master' *IF* the other topic graduates to 'master' a lot
> earlier than this topic hits 'next' (IOW, until that happens there
> is no need to rebase).
> 

Thanks for the careful notification. I'll watch this.

> Thanks.

Thanks.
