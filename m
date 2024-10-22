Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00E4199EBB
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 11:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729597314; cv=none; b=pA9lRpARLbyrXrrHKk2POT7Sa3ZPEDhNvH61jHX3bI/kE3op/LKEnaQqaahKnO+szJFtX6qzZNYxBOsOXP7p6puBc+4CNgkkqglox4lnKyyY19plZ7oqUQHfbVf3SVSrnhFbTj6VwQ+j2pBXqECeg2bkuZK32dUg+IG3mjmuvsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729597314; c=relaxed/simple;
	bh=Mj6y2LVf+SV+IY5Q1swIJoDZkMTJuReWsYXowQ2JMJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nakJoEPCCfglnMc+dl0ZvpWV95Sk6PQWWg9lu13HOcIdWolmdLipXgJnWY+Jc7Gj9klpzrK1KZP7YYq7/7wmu4Q3P9+y6ZcMpxrjxXo7zJFWG5h2vEp+hIOUywnQD2TEuOJM+TV+2gmEpnZPt6mirVtjRHTotGarF4EitzDVCNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IIJeg8YU; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIJeg8YU"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e2cc469c62so3699792a91.2
        for <git@vger.kernel.org>; Tue, 22 Oct 2024 04:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729597312; x=1730202112; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rZM2U2dTw9VriePT43m4DWGCyRBo94q/eWzv7VixFSY=;
        b=IIJeg8YUnMP1F/Ql0AyQqL4/E4j8y3NBpshLSjyHl1+8zM6hlfngOjpADcGfQgiyQO
         OPicZCxSajawOjP8lKlEpIGyicuv5xpPUJp1J9ea0o06+2p0lZWuaMTrrHTDGuSDUmAQ
         qrd1x8XXxgWu2Lc6sofz3qpb20trpE+j0vOtxRzsW4h914ID9+9WaTKAObq/FPyvzZtR
         CaZctZJ5ni5GruAt36/zHhXv7qd486HJ3rsLGH1Qfn3PO7W8eJLbtm5wauYAf3MHmLMQ
         NS4xYPqODrYmM0Ht3rDK85UITNSe7Cu7CByk+Do41Kv/FdacSmPlkaOcFkFPSdwLqhR+
         0bkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729597312; x=1730202112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZM2U2dTw9VriePT43m4DWGCyRBo94q/eWzv7VixFSY=;
        b=oRYGvaYk4nzWIpEHsQpx5rd/QqMzzGxKv1AVlMdxiL6UHPG8Bnfqvpfo/pObsNlrPS
         yy46zGRvR7hn2Frnwn/QkRxSkqbOcTVzYfA8LkgjzcjYfJWuKQTob30232GlU59gkT9g
         8+K/wXng0AeMPFcokAYmX2FcrtQ5E/qsvt90WVwlyrmnuiTo0UjrDuHRFGHVGFpelswS
         Aw9f0l10AG6gOrycEiLvr/OJy3YeLrAlD9tt2HNoM4o4p+3+hgq0kHTsdrqmh2tnmi/I
         FEVTH7U6KeFON9LsND6RqcEiPHgBa+NUhMXvC3N8aIhhGvzf9AQPA16Wk2ZMWcRAej2i
         BA+g==
X-Gm-Message-State: AOJu0Yyh89r4Y1JZFXeB/PQ8rK/bgjXdj4MPUcsaswsjO7lw8O9TfuBX
	bJ45HbEJU5zonucW9BTwbSHZumTA73fS65m/svh+cWJ8sDCPm1Qu
X-Google-Smtp-Source: AGHT+IGwww+CyrSciUdjYqKati/smTSoZNOh+mLoADLkpEn3ebkF43ZFASFdvCfLEeXSRGiugXy0RQ==
X-Received: by 2002:a17:90b:2289:b0:2e1:ce67:5d29 with SMTP id 98e67ed59e1d1-2e5617348edmr15987811a91.21.1729597312292;
        Tue, 22 Oct 2024 04:41:52 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e5ad5178ebsm5936735a91.57.2024.10.22.04.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 04:41:51 -0700 (PDT)
Date: Tue, 22 Oct 2024 19:41:56 +0800
From: shejialuo <shejialuo@gmail.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 0/9] add ref content check for files backend
Message-ID: <ZxePhMFmUd89Ibx0@ArchLinux>
References: <Zvj-DgHqtC30KjJe@ArchLinux>
 <ZxZX5HDdq_R0C77b@ArchLinux>
 <ZxZ8yNBZWNEhLgND@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxZ8yNBZWNEhLgND@nand.local>

On Mon, Oct 21, 2024 at 12:09:44PM -0400, Taylor Blau wrote:
> On Mon, Oct 21, 2024 at 09:32:20PM +0800, shejialuo wrote:
> > Hi All:
> >
> > This new version updates the following things.
> 
> I am assuming that this new round was rebased onto the tip of 'master',
> since I could not apply it on top of its original base
> 
>   b3d175409d9 (Merge branch 'sj/ref-fsck', 2024-08-16)
> 
> In the future, please indicate when you rebase your series so that I
> know what the correct base is for that round.
> 

Sorry for that Taylor. I have told Junio that I rebased the series in
the previous version. And I forgot you have become the intermediate
maintainer and didn't provide this information for you.

Thanks,
Jiauo

> Thanks,
> Taylor
