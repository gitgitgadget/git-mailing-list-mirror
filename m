Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4658327711
	for <git@vger.kernel.org>; Thu, 23 May 2024 04:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716439197; cv=none; b=SrEIeJHmB8wqVOhqOSmLO70h4nYuVU8MSzLa+2DCW6qmZ+iZ0rnExQW+x9o/XXhoA2oRDytUzbqftlLlYdX68fRKxXDBg0K++RwEcWMBp/j78t+FFQZo3e6rwpjW39ezIAnK9ltPt7RGnYKejrKD0aJ9TCCohSqwKkOcNWySVo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716439197; c=relaxed/simple;
	bh=pVg237N10/JkWGHZ83CrTCCrmHhs88F9n2DlukP1nVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CL7wHxF3GIW8n48mKSlI9n62UodOLOCUTRHuG9N4k6O4667oq0I7mPirBusGIR/hnOJIiQCIlUrwYf6A6XVpGb2ucr4VfLYxnfwwykM1RUNP16oJqWQRUJz8p4wiPMtgBmFYFRslySajwVLolhK7fq2HYkZ7UflLq0g16gdyAGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SDQOtxCN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SDQOtxCN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716439195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JYyrqCF0vGTMc5zXP7ahN+b2dqtg/fiwnb3R5R3hgJM=;
	b=SDQOtxCNPPyehhuEBUxYeNInRLTQEaD46rmRc/dLGRrveWIIXT/qtaIvXJuhC+MrjXOuh8
	ayqSklixGGOPuJHKig4vC171dQZqunrN6rBGPz0vVQ1svmjlHNivBKhQKF0kcZkkNYbt3o
	EAz4/d65XqADPuHIUMlFUXE9OoIMkyE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-bZJUWYeWPDqISpfrRLJTjg-1; Thu, 23 May 2024 00:39:51 -0400
X-MC-Unique: bZJUWYeWPDqISpfrRLJTjg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6ab8852d34dso13400186d6.3
        for <git@vger.kernel.org>; Wed, 22 May 2024 21:39:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716439191; x=1717043991;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JYyrqCF0vGTMc5zXP7ahN+b2dqtg/fiwnb3R5R3hgJM=;
        b=IYp1VZsL5xNJUgjpCj6sAtdysPhjTkbQl9vFwtUA7AF2OksxNMlueN3JI6fs3K50PL
         Rg7qYdyqhbJEdqPTQfWQmCIRmne2rnKAsZoIBm9amVVZ0ODZemgT4KX/roE4JRVqua/R
         LSwlOMGclT0cRvVrsDwx68jI69T2vJiRm96F1zwzw+mBPUHGpB3UuU4Or90Kk+95FhtX
         KBLO7royYCiZJAezJfFeift3W1c3e37GkyO3QCpvkfsSys+mo8eXtZ0IJMJ+K13Rm/Ur
         UrS6iXKwSfQiJslo6/keaWB1zHIEhfpYdjJ8rQHFJV98Uctz25lrJh2mzggQbFA4MkYs
         Nz1w==
X-Gm-Message-State: AOJu0YxSguzDu1a7+UjqhtXa7+8gwj9vJLZGukhOgCITtUdjDEfE526Q
	Z75NtSt9fk2epVesjME3JXmLVm1fqxB2Qyn0vfNkdpc0ERqdtVIS5nppFCxVEsp8Nsit2ZB698R
	9gte9ECG3DM3km64XWrGIWfLbfHLpjOd8WOd0kNyfOPP86G9EIw==
X-Received: by 2002:ac8:5888:0:b0:43a:c04c:e3d3 with SMTP id d75a77b69052e-43f9e0e1325mr52462701cf.34.1716439190705;
        Wed, 22 May 2024 21:39:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNiec3ohvi+scVHkIPEYtDkVdSr5ww/znD6SiXTmC0BD/KrBgM6gPh6YnY8cmtZ2EpPDOcQw==
X-Received: by 2002:ac8:5888:0:b0:43a:c04c:e3d3 with SMTP id d75a77b69052e-43f9e0e1325mr52462481cf.34.1716439190091;
        Wed, 22 May 2024 21:39:50 -0700 (PDT)
Received: from fedora19.localdomain (203-12-11-234.dyn.launtel.net.au. [203.12.11.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ab90e54239sm2813636d6.88.2024.05.22.21.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 21:39:49 -0700 (PDT)
Date: Thu, 23 May 2024 14:39:45 +1000
From: Ian Wienand <iwienand@redhat.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/3] Documentation: alias: rework notes into points
Message-ID: <Zk7Ikeo_bc9AIHgm@fedora19.localdomain>
References: <20240522024133.1108005-1-iwienand@redhat.com>
 <20240523042143.1220862-1-iwienand@redhat.com>
 <CAPig+cTPmiF_f-fsdNPF4A5NoSWrmp6sMPSNY1JFoxipyr7qgg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cTPmiF_f-fsdNPF4A5NoSWrmp6sMPSNY1JFoxipyr7qgg@mail.gmail.com>

On Thu, May 23, 2024 at 12:27:17AM -0400, Eric Sunshine wrote:
> On Thu, May 23, 2024 at 12:22 AM Ian Wienand <iwienand@redhat.com> wrote:
> > There are a number of caveats when using aliases.  Rather than
> > stuffing them all together in a paragraph, let's separate them out
> > into individual points to make it clearer what's going on.
> > ---
> 
> Missing sign-off.

Sigh .. thanks sent v3

-i

