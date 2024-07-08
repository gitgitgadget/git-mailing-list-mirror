Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF30146D49
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 16:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720457794; cv=none; b=kl6uViJBcSok6opY+i8BvP+m/ChCdeoJJJi+lJAHDs9w6b9q0ZhOF/gvox9t2TqTAYTK7qD08/CarV2DRxN03lNCrFFWDBq3GH865hVT8ndFzcemN+GCdTQtmMCk3YSXuNzDetjzhjKkRYw9czk/wTql4P2eyKItVS3QJjJMqak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720457794; c=relaxed/simple;
	bh=fpDt8s5QOBDi8DxhLGD+xFQ3o/QXuTXcNF9DUqHthWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DIwrpYEiN0khYQGUw8EY533OEazWfco1J9CFYrOJbQdyBg6nprRQbgUVLMvBYl/b6V1jGayDNQe2Srq0F3CPMhPV5TR8Yg2xpDmzSPQqw/+Re+x2T8bufTFV53lReo/8najgLe8oWvRWX6D4iSkOBPIxta7xWcq+SG8GMrlJIng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQngjiMy; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQngjiMy"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c9cc681ee4so2352116b6e.0
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 09:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720457792; x=1721062592; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fpDt8s5QOBDi8DxhLGD+xFQ3o/QXuTXcNF9DUqHthWs=;
        b=CQngjiMyOMsPm1e04Q7X6bPSCTu1f4jc5oPTGlzVa57hJMin+grnSQWb/s3Vwuz7SC
         wtErCPxyTTxN5zQG3q0XgmQg+KPA+Iln1uUyOAcjdbo5ESlsEnS58IV21X0Gi0dxvrne
         VxKZ6ve7X/+lJy3iPbjeVpqUHJ1Z0a7G4iiGEg9rmIuAXIyGSFPf/j0CRNbPzT8jR2bx
         rqfP+Te2Xt/olsIc6eGOloleNeHz9+5kPQVDFavW0hXizHMAf5spHfLmUqhcb24aSJv/
         efJ2wBAZqytacjdsm4v7UbXWb1wL6FRnYJeSwLH2TFB+psR0+WfI1Dmk+cilCQh35rwE
         pbNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720457792; x=1721062592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpDt8s5QOBDi8DxhLGD+xFQ3o/QXuTXcNF9DUqHthWs=;
        b=B9BsJL81Dfi5wcv53Z7GVxfqQ3XFm6GhFkuiaOCrYUZOlM1ZTpf6ptMIbD/Qwgjo5O
         3SwpH+1USGjFMHBFV9xCSgmqWTY1T7ozvo/tFw0lk1p52dlU22UeTkpq4uGZGJkH5DzT
         GfzZ/mvjTASI1SU7JnrmUh3/UNKfk6My+wQwWMnWFRnnKqYlVIrero8uaODG+r14OadZ
         5SrVhNFfK/tOl6C1o+f4Lcqh3fLY4So7ji9vl+b/gxlTccHMCfRA5LpWbw/+4E0wORlw
         Z5FbbnXfXg08JFTblvT05DTK+7PkHRcbfWA5749yogSMh0I+Q9ukeYpuYfX9/dqIDyGe
         TcxA==
X-Gm-Message-State: AOJu0YzfgEF3zYCWgtaVQzyZrH2KLtouBwcpjjp/o/BB36D/WOBdyel4
	caBtbAyytFuAN7Vzx1b449ptSM9TmTsIIFKuc3EZVvjf3LA/X8XlY/wBaQ==
X-Google-Smtp-Source: AGHT+IFn2yAyDd+5hoW2sTRuj//6wyWV8pzqL2zK5oGYsGJRUKslHRR4oy+1Pnr42FzikUxd6M8Naw==
X-Received: by 2002:a05:6808:2f10:b0:3d9:22ac:f1ea with SMTP id 5614622812f47-3d922acf2f7mr11381218b6e.16.1720457792140;
        Mon, 08 Jul 2024 09:56:32 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70374f6b5easm61642a34.14.2024.07.08.09.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 09:56:31 -0700 (PDT)
Date: Mon, 8 Jul 2024 11:56:03 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, chriscool@tuxfamily.org
Subject: Re: [PATCH 6/8] clang-format: formalize some of the spacing rules
Message-ID: <saa7uz2ovecdwg4ruhnusgebmexocq3qinlp5x5oz5sb2a3vqp@v4iupsp2ovwh>
References: <20240708092317.267915-1-karthik.188@gmail.com>
 <20240708092317.267915-7-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708092317.267915-7-karthik.188@gmail.com>

On 24/07/08 11:23AM, Karthik Nayak wrote:
> There are some spacing rules that we follow in the project and it makes
> sen to formalize them:
> * Ensure there is no space inserted after the logical not '!' operator.
> * Ensure there is no space before the case statement's color.

s/color/colon

> * Ensure there is no space before the first bracket '[' of an array.
> * Ensure there is no space in empty blocks.

