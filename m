Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFCFEBB
	for <git@vger.kernel.org>; Sat, 25 May 2024 01:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716599606; cv=none; b=PSO2H/Zc+285PAcpHhPNzCyfORMuB+HgY/ZJBmhRQqbQnaHrwUzqtBqM2RkKe/L3o8KWdgq6VUnLXIqnpIYNTU+v7UPVR/m2znjKjSRcLLKoD3T1rh3Yo8WwJ7JxMrjHs49nSsnwqUNExYjINQcJsRZ0sc/dYi77afZhYfKCBu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716599606; c=relaxed/simple;
	bh=lKJ8IPu2RORbt0Mc5rrjdUN2435Cg/iWrI4jE5amP+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T9FO3Fl/ZBQvAzDrlME+Nmil7B+NUUqz2OuJ3vfgvLuOPKDfMaNrg+3zOz/RZcNhVGocpNRebnT1rvbBnB0+JdM8+fxAcY99wND4C5euDqqMkKQwAit0P175syaacZ+9NeA3x1zF/1rpRlviYIuGA9i6jaTgUOskjaqMP8U6r3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AavnvicJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AavnvicJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716599603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T5uuNLH5mrnNfJOx188V86erYJbqErR8rCD113Br/Tg=;
	b=AavnvicJ2aD21UrmwuyPEefP23ChQc/dR2XudRqNFpdREap9+rgUPJykjSNs8VXM5K+zt/
	A1guM5b3JQbkPQDg3/ec6fKYIgZkXtSeOVpOuxE1eSku50ID54CSZQOBWEv05wTPwu4rQz
	KyyYmKiMeglooqPFwfEQ7LDb3gurab4=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-DIjPtZPhNo6PHjOvKJq-6Q-1; Fri, 24 May 2024 21:13:22 -0400
X-MC-Unique: DIjPtZPhNo6PHjOvKJq-6Q-1
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-df771453586so1457806276.0
        for <git@vger.kernel.org>; Fri, 24 May 2024 18:13:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716599601; x=1717204401;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5uuNLH5mrnNfJOx188V86erYJbqErR8rCD113Br/Tg=;
        b=J2m615VqiOWOCDoQav8OAcx509gvwkcqTE4swuKiO5cQbITKJgx8e2gD2S3qgEGZr+
         uBqpvDnbiGBLTL/zgMyDLfJy5Hzbe7xciJL7eZZ1DHKoH7WCKGWwEqhz6MknfXHAXwRJ
         vNvrx8K4e9wfzv1LGMNcClgQ5YLG3ZRl0xK5+I3v+9bBfFzcqGjA6GTSfO1oqdSTxQ5p
         5PpaAwO+7iPBcmzQe0I6Hcb0I9fCgMziDO1NyZGFS6sJS9C4PlVCIrHzT4zI0m3Cl177
         fLiBpSrUcmELmXs+SCNAJs5hyaWVSssQfaT87891RNRrzLZMEPFNwSXKyeQx15xWT/kq
         DhJg==
X-Gm-Message-State: AOJu0Yz5HjfvVgWPINGdtysVpKpH9+IYZKYHfVlfOb8G7i4cuN93Zy49
	fdsvwa/irCM1ZV+CH2KQ5C8F41Gg8k92FLbqDdEIz92SrURJKm9RgwFYOM5UiMVnZfQ7sjUGaR3
	6lkABhKXNjzJHeyThTXQG5rgFgx/yARXGl3IukuVWwd6usOGp9XATkqodbg==
X-Received: by 2002:a25:ac9f:0:b0:dd0:c866:ec3a with SMTP id 3f1490d57ef6-df7721885b0mr3746615276.22.1716599601225;
        Fri, 24 May 2024 18:13:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmyA2h7lzEFiIOsGm8Y+t1E9dxSKV+phXaDCqMGtZQLyH6GclGM42iH7xg9eoF9KcI9f1WWg==
X-Received: by 2002:a25:ac9f:0:b0:dd0:c866:ec3a with SMTP id 3f1490d57ef6-df7721885b0mr3746603276.22.1716599600798;
        Fri, 24 May 2024 18:13:20 -0700 (PDT)
Received: from fedora19.localdomain (203-12-11-234.dyn.launtel.net.au. [203.12.11.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ac1630520fsm12107676d6.110.2024.05.24.18.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 18:13:20 -0700 (PDT)
Date: Sat, 25 May 2024 11:13:16 +1000
From: Ian Wienand <iwienand@redhat.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 3/3] run-command: show prepared command
Message-ID: <ZlE7LBFkcio2KFoE@fedora19.localdomain>
References: <20240523042143.1220862-1-iwienand@redhat.com>
 <20240523043806.1223032-1-iwienand@redhat.com>
 <20240523043806.1223032-3-iwienand@redhat.com>
 <xmqqpltcwnqm.fsf@gitster.g>
 <Zk_ip35jHUj_5M94@fedora19.localdomain>
 <xmqqo78vksk6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo78vksk6.fsf@gitster.g>

On Fri, May 24, 2024 at 10:50:33AM -0700, Junio C Hamano wrote:
> > Should I just leave as is?
> 
> If I found as-is would be good enough, I wouldn't have been
> commenting on this.

I think this "for ... done" example from me is perhaps too specific
and weird, and not being helpful.  I'll trim all this out as I think
the point can be made clearer.

> Even in this third iteration, I still didn't see the added
> documentation talk about the principle behind the design, i.e. what
> you write after the "git your-alias" are appended to the command
> line to be used as additional arguments.

I'll send an update that makes it clearer in a separate point that for
simple arguments, the added "$@" just passes through arguments as
additional positional arguments.

-i

