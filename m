Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6163A4749E1
	for <git@vger.kernel.org>; Tue, 15 Sep 2026 08:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789462445; cv=none; b=Xv/pO/ELqxu8C9uIBgESwQtuwsd84czX5eXbCezRm+tRGnEhAUVBn/daF3GKQ/Ni689wVv/acR8acJTJJ9wC+zXHBQGO+S/Y3kiALI/6umgk+WxwFpOYDTJhjsP+iustL22kCWfDs8yAgl/08x/MkQjptPhSxvv5gvxuLUUIrS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789462445; c=relaxed/simple;
	bh=XmvFvcewaQI/D2VslL12ei5rZeVQ7uQ7FqqkDaCLHFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QxxmwHzc6PHe2mlcfrkqVBTKyWt0pj5oW2DrSaqs8wA8L7YJn4cEpGVtz55PYVe1FqMOEGMu5BkFXSRpZfnrZRWXvgnAEDFXDM802dL0B1tDCJoMPiu0C2U6tbUy6jcesBnb/YANfTiFhPNym8UpanjVrOoUu5xhvcme0Ec2Vos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H31UnlMK; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H31UnlMK"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-398a147688bso24703a91.1
        for <git@vger.kernel.org>; Tue, 15 Sep 2026 01:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789462444; x=1790067244; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+Lw8vGQd27L03dbV0jlQXUPsApyWOwz39MvDk2IuaBg=;
        b=H31UnlMK9trMNV6dzZfntiR62AXcnnZ2cSdMh0aWWSfoE/2gWexobrTEMMY4oT2170
         1J8JG+1xC65UHrtwX2Snsv3ZKOLmg1pu0s9t1i3E22KgvpihsE7IbRqINpe5fIpSOjzg
         XKDy77dDXlHWmE+JXGIsyi8LSby3kq96ef1mwcE1m+3iBTUthX2dgcOREQkbnrC0z4LX
         9iqI41hExX46GVV6KPVtf6TvmF/wCq+LHCFzz+vOGgZLas6sWgu5bVIp8WzYLuAErCTu
         ZVlhSMAjPQwIkHRzcQg2EQCXUUER/gx1iyolaCeUp+JRK+B0w9NkiYX9SdBRoQ9ZECc4
         JFhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789462444; x=1790067244;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+Lw8vGQd27L03dbV0jlQXUPsApyWOwz39MvDk2IuaBg=;
        b=MGh50kfkbmCiPZhQAymXug+vImgwm2FbzPMe//RSvi5feDS2vCrbhr+I285lFF5vGt
         TsohbEOJo5Po6Tvoe+ureftqtitn9GN4ykuELkovnCv1UkGvWN/pv+G3iixOtC3XClpI
         Aq2A2MBpvjYSqM81P8RMN3l9TYAyvf4FEX82HWnj6ufF8b1EKB3uHpiQ2z17vtnaJvzs
         /EXCYzQxTAhVX0QQYB3zf3F4m+p3l0U4uXuXo1oA9iwBnE6BUSzN18NvtmrwJ0jFMf9t
         wyjsuc7cdn4T5laWfJrDT+0ZTv+sUUFe+zZH/V85QbJI0UK89UlGE1fvWr+NklEXWw5r
         uJIg==
X-Gm-Message-State: AFuF++m2lze8zsNVPJCPBDuniOFmZr2lsqvzTw0uI9iVI2nK2PgAumYE
	ncntG8BBH3pQRuJpVYoiW6q7d/2GmqJy/4IpoLsJdH3ONET7s2X+T33DD1gCCEOz
X-Gm-Gg: AYBFou0B+NYqLO1o+RDEVpQjJ5fdhlsY/Fce8iIFh05iG3jDVRRuZRVEZRs4cAq5AMM
	sQIjDris4NGPKIxWTfWC886J7LiNCeMbDiYi0HQCP4v/eanouh5TIcLZBQmZonwAST5Uz3S/hcN
	ixSLFeMbmj7RVHjUuXDHDICQ9pUH8jcXeUFqJySb8TjOlYzvh2ZwLsW6S+mIcJc51J/OGKRNcce
	avEdjd1N4JIj87nAODsGBKBaHZc685Ebx9rgNt2PNGtQ6nzqaiHPly1d2HiwkRIUCy9h1L6odCB
	UGhC3T8z0uHWzsb+Tu6UWAU9ybD77YjZOscb9L2bmZyxOdvi4AiwBN5vVLNCPJOpM8/IpDvnd5m
	V8RyGjmVP422H7NwgvZ+K+eHwHbgtNAdZa/kM7+ybJwOScG55k366zoUEgOBfmeblu8tSfTXdMj
	zX5zAwRhOs8tUBHTMWsKjZ2BxWYipL4fr8E5To11PSRaCNoSLs0uykrOkgVTxmnIbuRYI7i5xoJ
	4W5LRU5jnz6J9xHuNjoBuq7lW8u
X-Received: by 2002:a17:903:2288:b0:2da:eba4:b640 with SMTP id d9443c01a7336-2dd837dbe9emr2561105ad.6.1789462443586;
        Tue, 15 Sep 2026 01:54:03 -0700 (PDT)
Received: from localhost ([2600:381:bf13:b4f1:fa05:dff4:a430:6b5e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33be92873b7sm4042308eec.21.2026.09.15.01.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 01:54:03 -0700 (PDT)
Date: Tue, 15 Sep 2026 03:54:00 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH 1/2] object-file: lift ODB reprepare out of packfile flush
Message-ID: <aqkGPcJdw3QagN0B@jtobler--20250820-SHC54>
References: <cover.1789328612.git.jltobler@gmail.com>
 <cf14416f224f48475dfc9f79d8ec62756b9fdedf.1789328612.git.jltobler@gmail.com>
 <CAOLa=ZQBo5ZyHtx4yLvjJXzJYgGieeuX2g0mycPKOPt+VqJ93Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQBo5ZyHtx4yLvjJXzJYgGieeuX2g0mycPKOPt+VqJ93Q@mail.gmail.com>

On 26/09/15 12:40AM, Karthik Nayak wrote:
>Justin Tobler <jltobler@gmail.com> writes:
>> @@ -1260,6 +1260,7 @@ static int odb_transaction_files_commit(struct odb_transaction *base)
>>  {
>>  	struct odb_transaction_files *transaction =
>>  		container_of(base, struct odb_transaction_files, base);
>> +	int have_packfile = !!transaction->packfile.f;
>>
>>  	if (transaction->objdir) {
>>  		struct strbuf temp_path = STRBUF_INIT;
>> @@ -1293,6 +1294,9 @@ static int odb_transaction_files_commit(struct odb_transaction *base)
>>
>>  	flush_packfile_transaction(transaction);
>>
>
>Earlier this would unconditionally call `odb_reprepare()` within, now we
>only call if needed. Which makes sense. Would it also make sense to only
>call `flush_packfile_transaction(transaction)` if we have a packfile?

`flush_packfile_transaction()` already returns early if there is nothing
to do. We could make it more explicit here, but I think it is probably
fine to leave it as-is.

-Justin
