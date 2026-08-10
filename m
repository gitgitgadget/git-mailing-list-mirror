Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E7F329E55
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 15:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786377417; cv=none; b=GvdNz6rU3m9esQw7OEYDdDJfhAce80KfLtAspoVJRsEOABTGMWtUnW/uSuYnVifMKG+UrgqTkOWzEAtjdGhATU/KpSLjA/mmt10+JnYuR2cAvmgGeu0vK9AFHptR4J/vDybANm4MCLW8/bI4Hm6APFomPK56aWpYQsOMnA37oCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786377417; c=relaxed/simple;
	bh=RdbwSVpJ2gS9yCSjOh2zmlxh5HlOgPqwvlMMpFhHa/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kxlA0uAYkG+H1U5qK5Rlhv3HpavR9h+I01PvAmvUqmX/sUgy3SFAIsNCtOgvqbRwLZ3QrjbIn3kXvJb5Bw/oJ4IuBN/R9NG3H0hLL/e/bQqeVyHINFTHGkO74mZ9Egq0DVhNTIAakZtSqvb6RKHX80tnTu080FAJQvzNy0NBJvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=dTnOIONi; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="dTnOIONi"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-80cebd41372so28624177b3.3
        for <git@vger.kernel.org>; Mon, 10 Aug 2026 08:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1786377415; x=1786982215; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RdbwSVpJ2gS9yCSjOh2zmlxh5HlOgPqwvlMMpFhHa/I=;
        b=dTnOIONiD8WDCsjnXuqATTNYAASk14t6LcKEbW9/t+WJelDsNhSn0B3ralL+RaP01Z
         InTLmxwGSRmH15DCxmKdbTuvRHq5ORyQQ7bEtacJ+X7eay9FFESSU4MUvdyUuNw08J3e
         H6aWTLQHtNk3GkrrUwvCzgHxhqPs8zvXjNQOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786377415; x=1786982215;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RdbwSVpJ2gS9yCSjOh2zmlxh5HlOgPqwvlMMpFhHa/I=;
        b=AOHLiDbk6By6fW0HzB8UFDiNY9riaQ8ZdFk5GNo38R7DeMyHHVPyhSdnkAGBO3r5s1
         CD/9IyM38MlyXTJ1vUDQRcX5NEm6/M6OM/dzzfVlb/3CQPtRTL/KaUaV9ceW7YcJiRC3
         vp4S5774PvGreppJGpesp61RDp0ttG1/icJhSYVrdbmMHuDqOvZAHVPCIotQ0GG/7pdB
         sp5EidQNF26s3i7oOQTUxeQmws5+qKbAA2Ui3r+F0JTJDTnPywOQM1ksbXBN5EXg2fkk
         SGxc+trypYWmVkBFeilMOyImciEkinVMe5yE0B13QVwg4NKP2chGtJT49IGq+eaAG0Qt
         SeDQ==
X-Gm-Message-State: AOJu0Yycmhh9Ip0F00Il5SybOuJIyTshrEDcLK3nb6hALhLHHn3AwGQJ
	jR6rGyhflyU2Fucn+IkPTQY9P0FseRofebC9LOor4RHcgHeQa5Xjz/1Ueu2u1VB1nUo=
X-Gm-Gg: AR+sD12fQW2aaqOvStkEHl3E8TanRTQC2FxGd/nfT3Ek72ceoJzVJvY8yAJNy41riak
	5bHaTyON3t+Pmbdr6aLaS8rGxbcJ3CBFMajX3ivVhWUKGcKNvqsTi4RuHWbP8TlcnKhZdN2xoIY
	YzJDj1Cq47EyYtkElHORGM8hrZgmwS9PAZVcXbBjURAO2VlAn53y4M8tKnkYpHUuAOnqEJU74rE
	ezLVwOZajVoza0bpjTrt7+Gs958iVeKv16vfUAnGg3zlfsrMogrRCyE9lJFo9bt5LBdpE/ndk9R
	0rAP/TGeJlcIq0b5T64FfJSQjhFab+DTMVUBOn6onmWbxja25Lpjo1O29R6ADcTwEDkrBcw58Wq
	JhR1T3f3sFiGw8piwmATGGPdVcv2xmesq5vuHremnx7w8iJcFyofzAxDr6KTF/P65MCpSvQ0ROd
	pgi7pTiJyYM6A6kdXcgrIGgjyxY3viH5P0yRAzI4oQBEPHI2KAMkdU56MceF4wnbP7PJjOCRpjP
	m0FOPy+O/wXLPKZtiUKFRXeni9h95gsczTlVNxQveKDJ56qdb3Q0w7g
X-Received: by 2002:a05:690c:4d0a:b0:80d:c9d9:e1a9 with SMTP id 00721157ae682-82d2d7794b3mr16588757b3.27.1786377415322;
        Mon, 10 Aug 2026 08:56:55 -0700 (PDT)
Received: from com-79390 ([20.98.136.114])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-823efa03ca0sm58888827b3.3.2026.08.10.08.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 08:56:54 -0700 (PDT)
Date: Mon, 10 Aug 2026 10:56:49 -0500
From: Taylor Blau <ttaylorr@openai.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Ted Nyman <tnyman@openai.com>
Subject: Re: [PATCH 2/2] maintenance: trigger --auto for promisor rollups
Message-ID: <ann0wdIUxB0O6Scx@com-79390>
References: <cover.1785902237.git.ttaylorr@openai.com>
 <dc2fffc37cead551f8036c9ecab5e52a4cbee37b.1785902237.git.ttaylorr@openai.com>
 <annqKRGoh4-S91VE@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <annqKRGoh4-S91VE@pks.im>

On Mon, Aug 10, 2026 at 05:11:37PM +0200, Patrick Steinhardt wrote:
> Thanks!
>
> Patrick

Thanks for the review!

Thanks,
Taylor
