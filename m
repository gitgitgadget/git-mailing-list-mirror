Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B220322DD6
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 01:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769045857; cv=none; b=E+lJDa2PX0WBEY0ZMfN27P2lZEY7gD9x4I30+uqqHeVfd6GGI/fFbsAD/wsykM8PVcFp+B/YX1DSA14hdrMxGBgf54RC7ik8Wsjzt/rtTtXz7A8Fpg8Ouib51jusoxemnxOZliHm16jcGSXLqpCUhbZNJSmVGb3icuWYojVGi10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769045857; c=relaxed/simple;
	bh=fKMFYnXVCl60wwVNh+BORTqN4mdTMDwzyZdRwa1fScQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jc6JyztYU0IDJaJkCDSjsLxZbyERhW0Vu+c7T6MXeXCnL17A6sZjOaiteCE83kZXxqtpmkNTowo8N6yAXYRY5Dw2+N9wqYEh/z7+kTuLfDe8jvoI6dJ7p9iyu8b2aVY6xGOE3sTd+sGoB4/0Iuce3Ji4n1U3GpmFsBQZG2By4ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=U1KeeiQS; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="U1KeeiQS"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6493937c342so604551d50.1
        for <git@vger.kernel.org>; Wed, 21 Jan 2026 17:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1769045854; x=1769650654; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8AySh2GGHEc1/sTvP0NJQPpg5kjCjZK5P3sGRrFAzAI=;
        b=U1KeeiQSVqSG7+HDYVI7FtL43dddoqvu63sjie1gJcWDB58t0BrZdSB7IyfCuelvd9
         ct0/5WRimqWv1HoTxvVAVtTMZQblkTPRSuK16vh8tH3O7ByydwJvQgPGffiST9veD6iP
         9bqAa/lJdH5bPKDngdnsAMKlfqhjCST4/2wNMe9Yepg6eT+J0SxHDkO9Sw/9TeKv5vfK
         ePrXJ+6yfgfLwSPIWV+mlgK0iHGUGtFsiYEsLEEdnoNgCy8rVXUladkcmjK7EBYqrpEY
         HMJvkaqbFDhdsRPTq1xh4u6rBYlTpYR14CiNwWvwK1dlcc/s7mcVDE25pH7j2Jdy8xr8
         dyCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769045854; x=1769650654;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8AySh2GGHEc1/sTvP0NJQPpg5kjCjZK5P3sGRrFAzAI=;
        b=hVFT2AfBVzLAYkuadOZqbkudXsDak6vIjw33lc5KyXu5oijbRSm9pOGNVHDDO29be8
         IJttcrSTUdfBlUj7xCDcMg/uQTizlr5Lb3/iqM3zoHcMN8X35bIA0z38jFmabxsij4Ws
         M8S1GOWVOtB2ChR/u0cZR59+HO4Y7BaRO7reRRxqXVroL7ItE5JMHEovUkcmYjtIQv9L
         ZVAMFvGVDGlFS8XhZWSCyJXCWd+1X4F6+hDpH/zniaIdIrsvE5lCSvo8sQAGNPPntW0J
         lzZHaVu/JzS4hn7cVb1plJcxIEZdaW0nxG2UnXcO19VawTMgqbSeq009BMHsYoPZVzKi
         Klvg==
X-Gm-Message-State: AOJu0Yzt8njKnxGOnz81EsCOMmYQ40EUfGExbEbwbzTiYvmbcnZBPz0u
	iGGbln7L0lJLHr5TTO5Y/Q9xrc3ILKsRsu3dG5eIDj7Tx2eiSfVYwpx7oZ6y3Eu+f6o=
X-Gm-Gg: AZuq6aLI98d78I1vtYkK+wTrmkiS7IckDz+gDQqqhX9ADxnJNPlvYPcd7dNTtNY+oJv
	5lEyKjRbD391Fu1bPNCfi4eYbach9qg+uFplVnwjNR+LeZ5JsJVZwMU0K2uYOxL810qRGnV9uyF
	8zEJMS4EfXLBI4bXb0Wa5sFEd/6h28AY7U/NTrpPVrgk/xgd6AUSLPsAXBrpLrG7m6pMXJyom+l
	L4xL5zJNBxGrISfDW2aAJ8YjLrfVTzq6CBgH8DcFbGQ2smgzTZk8WrT+gqqwM6ojf0aKu52p/Mz
	U6ak6/G33sd9mbVT+oubJdLPOt2EzB5qwTXt+P/ln6FVPKZHhL23hdyjEaNfY1R972tQ+mQCAcN
	Q8pwu7vCi6Iyrnu4K7wDgXw+JLnmZCupNBhqt5RmPa7Nt9RSaDFEKFfDK14bSIqm5CXLJ0TOz56
	DfoH5n6LEu9kj4M6Zy440p3dEZt5kc61Bvdc6pe9SvKMEQrE2V2leJL7jC1AFzTJKnF06C6s+p4
	4G8JZVbS5IzVuwbvA==
X-Received: by 2002:a05:690e:d8d:b0:647:2160:143 with SMTP id 956f58d0204a3-64917773c38mr13106311d50.90.1769045854664;
        Wed, 21 Jan 2026 17:37:34 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6495423c296sm252303d50.3.2026.01.21.17.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 17:37:34 -0800 (PST)
Date: Wed, 21 Jan 2026 20:37:33 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 05/14] packfile: extract function to iterate through
 objects of a store
Message-ID: <aXF/XfEcHA7lvyDE@nand.local>
References: <20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im>
 <20260121-pks-odb-for-each-object-v3-5-12c4dfd24227@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260121-pks-odb-for-each-object-v3-5-12c4dfd24227@pks.im>

On Wed, Jan 21, 2026 at 01:50:21PM +0100, Patrick Steinhardt wrote:
> ---
>  packfile.c | 78 ++++++++++++++++++++++++++++++++++++--------------------------
>  1 file changed, 45 insertions(+), 33 deletions(-)

Reading with --color-moved and ignoring space changes makes it clear
that this patch is extracting the logic to iterate through the packfile
store of a single source into its own function, and then calling that
function from within for_each_packed_object().

Seems reasonable.

Thanks,
Taylor
