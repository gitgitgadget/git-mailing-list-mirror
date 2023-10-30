Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D0E1C2B4
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 21:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="km+lMfks"
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE82B135
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 14:32:23 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3b3f55e1bbbso3293784b6e.2
        for <git@vger.kernel.org>; Mon, 30 Oct 2023 14:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1698701543; x=1699306343; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5OhnAzvEpTGbLzxzDLDLs4geTUg73fRMPHCWBcxeMwM=;
        b=km+lMfksIYUnv075ppA5PUooLlYtIIYA4EBELsrrjGfinnbn3bAWD060gdWEq05Jgc
         McXu4YaafDVfE3q0/I9eEfB8P1IRCc+jGUXzB53dMvhvuiG147XnnqF3C1JQNTxcYm7H
         Ua1nBkcVM+067Z7QYam7Y2ANbjqSfwYXyVKENNmNxeVwlQZkkPu9XFdprtMQOajZcN5f
         9pzgaTIgjCjkRP9z5oqCWsXBUjKU2K9c6eGHuEWcftHsqftLZhbIVjRi+V3O3RQ+t2H+
         LtABGWf4H328QQxRolHGNSBZ+9gSzL4ayTxUzF/64xi9LOX4CFInXDfLy30dXOXMOC+B
         xuEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698701543; x=1699306343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5OhnAzvEpTGbLzxzDLDLs4geTUg73fRMPHCWBcxeMwM=;
        b=G25m/IIxHov2K6V0XhEvQZ4wpFcKVznbc6MZjppPhdUxiUsEDzm0tdqToWRhe1iiTb
         3TGRihI76Ym/6QgkzVJ0Vk2iLzmBWCNAzaR6wlMUcCdBemqkhmqTxVkg1M8RabSvXbf2
         /HPir3S3IXXVnGshf6t4bkYnLg8gLPLI0Qw88/dXDweT53w3XZElYy7adFRZrXVGw9vv
         y8dFo/iPQlQgTxzhHyY9IDWebh6T8GvPpwbLtJ2zpGk/zQIaOy5Rk31RwVznDW+I0gAP
         HLzK2jk75XBuASTU3D0fC1pJM0cIgqA4wUr/AubMxxGcqKqdcvLehrDb/yxycYA+YBSS
         Qs+Q==
X-Gm-Message-State: AOJu0YyZhwcdMWYI7fpZbbuYLpXF+d9uOKZATQ3Ei3A8XGBuH9/JVjqy
	0ieWT7hXE/lcOT4u58EcKNnxBjbe3iG/fFYXzt7pBQ==
X-Google-Smtp-Source: AGHT+IFe/86EXXMZKYxGB1BYCh0lUyXZjB59KqDf3rUp/MGvrKCrLmYEvPCQtPAoyCGO9G9PmYWNgg==
X-Received: by 2002:a54:4e8c:0:b0:3b2:e60d:27e3 with SMTP id c12-20020a544e8c000000b003b2e60d27e3mr10308547oiy.30.1698701542857;
        Mon, 30 Oct 2023 14:32:22 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id os40-20020a05620a812800b0076efaec147csm3678276qkn.45.2023.10.30.14.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 14:32:22 -0700 (PDT)
Date: Mon, 30 Oct 2023 17:32:21 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] commit: detect commits that exist in commit-graph
 but not in the ODB
Message-ID: <ZUAg5dj272mhHPZf@nand.local>
References: <cover.1698060036.git.ps@pks.im>
 <0476d4855562b677ced106a4cc7788b46434cf21.1698060036.git.ps@pks.im>
 <xmqqy1fr3kh6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy1fr3kh6.fsf@gitster.g>

On Tue, Oct 24, 2023 at 12:10:13PM -0700, Junio C Hamano wrote:
> > We look at a ~30% regression in general, but in general we're still a
> > whole lot faster than without the commit graph. To counteract this, the
> > new check can be turned off with the `GIT_COMMIT_GRAPH_PARANOIA` envvar.
>
> Very nicely described.  Will queue.  I'll go offline for the rest of
> the week but if there are no significant issues discovered by the
> time I come back, let's declare a victory and merge these two
> patches down to 'next'.

I think we're close here. There are a couple of small comments that I
made throughout these two patches, but nothing major.

Thanks,
Taylor
