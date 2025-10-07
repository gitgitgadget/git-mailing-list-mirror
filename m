Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF99D1C27
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 21:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759873791; cv=none; b=GjyObUdwQvDS92lCbtoIFR65rQuFanCZfUMIoavIH7B/WzpOsSpor9hm8NCTSw+epO3uiGsn8r/+MrJYXihYQotCqtJJGpah6vi+phsiuYfxXl9GlQ1W3DD1OSBGtC+O/Nq6xuXj6ahbwoeJGCo4zdZjDbBdSyif6QtWNIgRDBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759873791; c=relaxed/simple;
	bh=297jXYa65CExQ2r48JuCMEd4dyPFDpOY+j4Af1Hmypc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LUTqH1USE9wHvygIMBw7gv+np6OCvIWmQo7vZmjsKYZDXa5BA2owBdJZzIVhbBUf+3YRbDH5nDqjrqSECiI0yQDyU7wCSPkFxycUj4CGlvUjvqctNcVkF4XSD5tJQiDCvjUF7jYuBmwQs+Vk1p3bjXv1p5q2HqMN2tLU/l/L9QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=p7+BFcMI; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="p7+BFcMI"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-93ba2eb817aso372333539f.2
        for <git@vger.kernel.org>; Tue, 07 Oct 2025 14:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759873788; x=1760478588; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=297jXYa65CExQ2r48JuCMEd4dyPFDpOY+j4Af1Hmypc=;
        b=p7+BFcMIasVC7yQ7Bm2khpluMVbr/x0iF1u31JfKfsoyL2r5rDdg5tixofXuq8qMEb
         D13F/5fhdMzZ5rwUL4YMGfsXxxJEauQhBHTYQOwxCSvyVdK3F7Zlf9HdGbw1NNUObGec
         IbD89hpRB+qaPsEpm44ZEZHurbQel1ZuO5kiCiw0Ugjk8yIXFMFnBAUQYlbdsbvy/kZ+
         3K8/puge6FfYB9hDtTTciyDEbKavgec1tnkNeDq06kdEoG7s+lByl2bliLWc2l9+TSa6
         +8EKLuwFZ9lhyHnp7A7EEOAJzcJojRQ/b3cJa3vWtin4JQqVNtSyDKKmo+QO06HGS/03
         Eneg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759873788; x=1760478588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=297jXYa65CExQ2r48JuCMEd4dyPFDpOY+j4Af1Hmypc=;
        b=WsZ8q/B/Jb9XzXF/SZxyPGKNbSbXmBFhagiNC8ffnDaxfD3GloESRZIVnSZsT4ShKf
         uhDn5lULX2jtVcs+UEv1vc7fG6xA0QmotOZzmPq32QFWxZEx8GIu80kGEHy1Tngw6mGW
         M6cL4PluG4tOcOGLYmlhu9je8u2q8fxFvg93Ugg2v3I0C6r1scABbZ0lD4do+9Dk1E8P
         uSsPgG1S/KcqirxAKEeoH7UxyqkN2dK4f6DytZ/Kht0HgSrnwNyLowE6k9vtGCrKRaNj
         P/f4+UmX1SicwQsAgjE0tLs/V6zL6u/jBg3s8HDdKSwQcI/rxWiKvS29i3gzGQycaQ1R
         Kqzw==
X-Forwarded-Encrypted: i=1; AJvYcCWw8oV0B3RWiaQZSOObu+b6ccaakLR365JvCvJW9tl6mlhWSo9vSJPm9M1cE9PYXHHIAzM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yysc/JaJnzRE3eUcl69qbyI9yQoVrr7R2f4ekpM4WSZ5cdNxMXT
	DfQQN+pzs2cZbg/CICzHv/gdQFqzS7cQLO4vyN6HJaD5yGsiaMIQ1ZgHuMWX9tukNxk=
X-Gm-Gg: ASbGncvZjnWOxjBctfbuGqMhsT6E1AcyxiD/c8ZzspY4+yWxEcYsWzXnPzP8dZp4USw
	ZfHexuMZDcQR+RQAvHzLM0ohZ4WisMOBgwxhcrhTK38zj4tgqa1tCy1RHbvYApMNYYSxPhlyW2B
	/01UaDpztXkBREprvINzin08Us8QCcHIgOfhFsST79o4P6EWgsDDisQqQ3xQwt6A+qqlgUZwZ0T
	49GfG/iabswyoFe00k/Hveu05ldqRghnhNhKc3777iZQRcWYc/w4Fdri+XZz6ATHfDVHYp9J2ah
	asu5swq2u1ONM6dXG4Jwb7+WJTxUxC8oElfBhzWjdVLRwH08yIasK+uRdGEdX2uKTUVMt9+DqIv
	cu9hwpO3zzH+Qhl/BrJnf2fCmu9j66zJ9g1DWeebyKDHKuaZOtXYqKszs6/DZv8pFYH/FwvyMD1
	uEYwM09lXVcPxNIEogq+7J6LlikKUiIdOHV6kzvdPDehcrRerTaA==
X-Google-Smtp-Source: AGHT+IFO+Ty8usxjnYIWLe24d1nmrjsSibr35zpdre+UaFNZ9VuHwdSEdmE7ZSiMI1m0SLRgNvR1GA==
X-Received: by 2002:a05:6602:3fcc:b0:936:dfca:f7b with SMTP id ca18e2360f4ac-93bd18b1c94mr104855639f.8.1759873787881;
        Tue, 07 Oct 2025 14:49:47 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id ca18e2360f4ac-93a88961d74sm630989639f.22.2025.10.07.14.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 14:49:47 -0700 (PDT)
Date: Tue, 7 Oct 2025 17:49:45 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 00/13] refs: improvements and fixes for peeling tags
Message-ID: <aOWK+aWlGvzEqpRf@nand.local>
References: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
 <xmqqsefuig0n.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsefuig0n.fsf@gitster.g>

On Tue, Oct 07, 2025 at 02:00:24PM -0700, Junio C Hamano wrote:
> This seems to match the manual resolution I just made, except that I
> line wrapped overly wide line ;-).

The resolution looks good to me as well. Thanks, both.

Thanks,
Taylor
