Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A87B3DBD64
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 22:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772661700; cv=none; b=ahqYYaTu8zHS21bGbKvZrN7mJVmiW14rcmAnlxQncjxclJmFz5O5HEMnXEAXrL1kNgh5gHTjoZGJstyJj99zpcz8E0qD0UFx7OEvyGu+/HcD40UfDmVg25MFDKz3a1rAwzISMg887H+k9pqrCMNESGDbxMKmWkWFw1DC1mI9pCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772661700; c=relaxed/simple;
	bh=y5TphRucES/bVdbQyrCcW+Y9tIA57epiIQMMfiK+7lI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GR3OaJl13ENrnvBmF6HsxkvTsVgKHhXHFRs/wjuQHvOVNo6spXabhGNAuoCEZccIdHn+vCJygq9E0rvTfW0Cp/iKb5+8yq646hIXgCkijfCczfaO4eZC7YdX3R2Bf6+TubEPbnAcT6kR3BXwsaflx5FwOp6qhzuaepBgqh0ZiII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BXk4WHpX; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXk4WHpX"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4648448e387so5047092b6e.1
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 14:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772661696; x=1773266496; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DlV7zdeteLhXtiEvhq5F0pfRZ0JS3sqjrb0REHO3l6Y=;
        b=BXk4WHpXC3DqR3SzN+EGsrKpTqFgH41TMe/EYTG2NnG68qbBfrNwiR3WqClWgnZE9k
         4rvdHUoYQ24wSnB69Fl/S+szEBwxyvegUJ9cK51anHnhHIkJAMF7aUdShi6XCtCYmfma
         lTUn4dRoeF5UCE/3VjKYYnX9N02DQ61GdKkqBTCJ2qZmB2yaVtw+XBlMfFC3frTmVNmu
         DtoxsczNQS19a6UT+EuR7IBEKOseU401juLPPZz/dlCxTuhPP5ooqkA1aLvt/IW41pte
         7kQECaV/APMvIf1OyZovRgvey/nwBy9nYLLb4xp3/ke+3LrtNpeadOCyF6/rDRwRu/9/
         vTAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772661696; x=1773266496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DlV7zdeteLhXtiEvhq5F0pfRZ0JS3sqjrb0REHO3l6Y=;
        b=VzxpbI0bgwGC48XNF7LJjJVUMOea5XNYjX1COAxwHckxwgatSCLJJf6mXzKkTfr06g
         Ybf1QnPbVqvuSUhB0/9AKhVXAjt8Cwk8DRk7fJ7E8EYmBEhl3VE3flY5DVSy+2Ypz+pQ
         d4QVX3bklCNuUgg10b9mwRit/IATt4sqvuwhnb1Qsn7qp8jykzhgPFy2SnSFNJgd38ds
         xeSoAgJXd7NNqOrFporyXal+Ln7YIw8VWyVy4/ZBo/tWgNMhvjX+UEu+Z4t+7auFhWuF
         1VSa+A5awmaG6xFp7q+hKTizA2Ve898Ev0zZh15vqd0d1iWPQm5hz7UfVGx/V7g2h5cC
         zAzA==
X-Gm-Message-State: AOJu0YyJheFaXOal6fW0SW8zlv+6ghxqjACvPuvm6FTAo9FgUXnJHbat
	DpRtgxwSHblYZ9wdlkf1K5c9OSNErl/9n3cHi+fJVKEVci1CUMPPufNA
X-Gm-Gg: ATEYQzxhXYs7y95COXOkVX8Wj976nC2ypJEpMSIKN/pclMIvnaejwOafkC8/GnDw6mj
	44kz2eySjqCrRqMzlc76OLRvAJM2zTdRXXxm8IEonZfH/JPg2DoxlynOHiuZeAHmoBXNGp4vDYN
	CO/46B4d7epoCuHcWXBCN3+RhHLIsRdmG/x9zcVorT6a2yvdLxy/XzCow2IXRu2PhyQVFlwSTYw
	0aAKfSYl40pCUc8TK328Egvkr6nrXnRjTB7rd6+A/q0uowBkLkftRbKOdDLTmMn6rAlQIkJTF8G
	iqg03i4C/jozBCU2VasSaBgiXtL3GRwse3S7XUCILwjKSfrpxELuSk0oUcCW3BvsW90QILa26z+
	Dsy+Ljn4SI5YkXubRn7ql355HYsujJluF7RlJ9RcagKLaUF7d9BFWV1ntMajRkEHj8jVjpQZ2sH
	kR9nvQZTP5+jE3FaJhr3Ww0X8sfGg=
X-Received: by 2002:a05:6808:e8e:b0:450:ca65:ef60 with SMTP id 5614622812f47-4651acd205fmr1774215b6e.39.1772661696199;
        Wed, 04 Mar 2026 14:01:36 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-464bb3ab302sm12375172b6e.7.2026.03.04.14.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 14:01:35 -0800 (PST)
Date: Wed, 4 Mar 2026 16:01:32 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 17/17] odb/source: make `begin_transaction()` function
 pluggable
Message-ID: <aaiqJlmFgi92a0iC@denethor>
References: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
 <20260223-b4-pks-odb-source-pluggable-v1-17-253bac1db598@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223-b4-pks-odb-source-pluggable-v1-17-253bac1db598@pks.im>

On 26/02/23 05:18PM, Patrick Steinhardt wrote:
> Introduce a new callback function in `struct odb_source` to make the
> function pluggable.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  odb/source-files.c | 11 +++++++++++
>  odb/source.h       | 27 +++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/odb/source-files.c b/odb/source-files.c
> index c32cd67b26..14cb9adeca 100644
> --- a/odb/source-files.c
> +++ b/odb/source-files.c
> @@ -122,6 +122,16 @@ static int odb_source_files_write_object_stream(struct odb_source *source,
>  	return odb_source_loose_write_stream(source, stream, len, oid);
>  }
>  
> +static int odb_source_files_begin_transaction(struct odb_source *source,
> +					      struct odb_transaction **out)
> +{
> +	struct odb_transaction *tx = odb_transaction_files_begin(source);

For a given ODB source, I would always expect that the resulting
transaction would always be of the same source type. This makes me think
that the underlying logic to handle transactions should also live along
side the concrete ODB source implementation. Doesn't have to be a part
of this series, but maybe in the future we should just merge
odb_transaction_files_begin() into here.

-Justin
