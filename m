Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234DC43CED8
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 18:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781031279; cv=none; b=i5DHrKUtv222TQEsmlWpNYbpGMMeckPPTkE2z2rr4v6VyD4CScDHBOLKQyEG+jiB84efqYB2vm2kJVc/ybzwdhx1/gDTrHHDV5gDp8Tx2govIVin9EEeu3KGHfz96fbQemAUOaDj2Ccn1CL2HSlYBQ/Sefsrpy6VXIMt3hUMTOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781031279; c=relaxed/simple;
	bh=n4oDNVbl53wIuSsaVB1HWG56tugigoBM0kO8x2GK5oQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kP/jk4Qicl8XvQ5rlbIeTwrU1wcyNa4jPnixsb6B+AKYYJcpkqMj0YLPbhl5hUP8kYlneucvgBx9cCAuBcf6b2xlA8PedFLKf1mQC0XkrE+ES0XoUvSMTWAd7qv5rn3qXuSn+ESxJVFbjEFz6ENIwX8ARaVhs8JsxNzgBh19m9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=d0Z/z3/G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SQuZ+754; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="d0Z/z3/G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SQuZ+754"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0D1C27A0128;
	Tue,  9 Jun 2026 14:54:37 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 09 Jun 2026 14:54:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781031276; x=1781117676; bh=lqH8xqKK5a
	+h6DIuhXclqXkghiInqV+2W2O6QGmngNQ=; b=d0Z/z3/GQEVBZtgT1/jE1Qb+xO
	bn9XZpDnemVq/+jow3uKGFgNax4Vc5O9n6X9jYGngBHXWjjmx14IlhZILtVX7qOS
	kJYJsJTzX6Gaw/O4gSCYYgdHx4IQTYEbcIsQpRdiBKpZIiW/ZW0hJ22EtB6yfJlw
	4MdXe6pXqTwmoSJJ3Djw1SD3/BjF6ef0NKU09xsm3jP/yWprpFnhi7e++555cyMr
	zc3x5Bee3FYWsF2qnjFv/o16Yke19NOjTKjmZK1OOMxKqofAWMt16P44sh+TqMsv
	uLG+tuB7GtOMs3LPvCY/yFXaI1bU9eNSroMmPFiYmwQEdj927mqYNI/1UJpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781031276; x=1781117676; bh=lqH8xqKK5a+h6DIuhXclqXkghiInqV+2W2O
	6QGmngNQ=; b=SQuZ+7542GLWUkFdH+AoNxt0GEC19OzWAa4rFQe4UvYnjlBfI+y
	6azCk5KvCoeDB+RVhWYRQFhSrbzBr9A6h0VEh+dyuPHNEMLdpG4ZnezABcyS7LZI
	hqRioJPp2xcbnSfVdatCqCFHGZLJNYGu2HJu0YTlfE/x2HF/BxK+VEin2KWdNYYW
	43ws/oTnbR/U9dgBdBnAwwNxk1btns3ehyhEBd/IQ1dvGb0M3HjjN0orLBWE+IEU
	Uazm+06yukIrALawpb3WW94D8PFiJTLipicDSlO2kJRqI3fuenaN9yHLV2EYXxVs
	BQOTMtgxVx3eiECQ3StwSF9W0WrbLSeTJ+A==
X-ME-Sender: <xms:bGEoagVbpkkaekvGbDDTrYQJzRYu0MK1Pe3x4Lm_-nAY7GnSN84nEg>
    <xme:bGEoasxPqdL2ZxqcxxYZIFjmbMGL05gLaePSpbMum8LGlsQhyJe_RMfLsKfguQJWV
    vFMgb2YRyjMb83Ukjsbw-LTpACqCxp_PSkCYZZQstryVEpUWfV0WQ>
X-ME-Received: <xmr:bGEoav8DU9GRi8haLc0g-kBhqgHb0Bv4BhV1KD_IL208PtvB3cmWrWpzUUDoM1hlqzekl5AikH7UirtgboNOk6iJ26yOposwhSnp>
X-ME-Proxy-Cause: dmFkZTE0vwkE/58cjRn7bErEVF6TcpuA+ZbpprBNiloV5SvedogoN1DbftpgszRg+Ayt6d
    jzbSv/TEfVR56dpNtjKXnee37mw+jO45VKQBrcFhqtJ5tvkL5Y5BZ3mTH9KeuZrOLXdhRV
    0gbNoDlLyX+GK1LPYhaHPljTLptiSk65B3Ec2EkGd0BLHyZhpwyYTJju+v2UnBWsBMz0f8
    naPi6tUJJkFEVWllYVFzl9nB3znFXiVHh1g7U+pdfu7TRF3/OrNi7urGNBManR0PGeDvqi
    nt1ZnEifEgEF4LfwYCpxEsesgoCrx1wYw92VKFXM04B9My+24bvoSDtTCqOKaiSLlM54bf
    u78DteN17BP63NTOWf7FJfeL40Y3L5JpydiDdT197/v4DNxTdvBMc93dglp3eA17EuiXbC
    Flp49kKR7+ipbxFl9VAyZ2B0IXFbc7T+GjMup6wFWlW8xjTOsxPF51LtvZdqfJ4T0fhdlv
    nwXHllvyRcsTtzMTM3BL5nvhlu1dlFHYUwv1AVa52CEyV1iiRXPLXoHOaHy3+Blripgodc
    BTbvGVDjH0t6cZpJqzlrwZihhI/yU2ag3gn2dthq0dw+oLFT+UE2WJEMwNNnCWr5/Fbdmb
    cGw2nDl2OTATZ/zdPL07mFqEQaJ93uPZSuHY0wt7n3WCqYfN9bCOvYoZyrXQ
X-ME-Proxy: <xmx:bGEoap9TfOlemiTEb0bcLJLlbdSqsZ-sP6GQwOytpL8B_9yUquyH4g>
    <xmx:bGEoamW48gzO-l1a0lb9SjJ0st0W0H6yE5MY5C-HWUg2xKbPY5Ti8A>
    <xmx:bGEoaucTBB-j0_LoVRXia_z8YKgd5TadKprH6Ql4zPGiOeB8Nz0LIA>
    <xmx:bGEoanYeXVkzHUVzlHLWWKnCz2E3YeakulmYi4htep7x_3CUL2RNxw>
    <xmx:bGEoah6R0O5tPyLkDqMyRj_tLDI0QtUBtlI-_kPlshevdJScTAfz_-ch>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 14:54:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: Pablo Sabater <pabloosabaterr@gmail.com>,  eric.peijian@gmail.com,
  calvinwan@google.com,  chriscool@tuxfamily.org,  git@vger.kernel.org,
  jltobler@gmail.com,  jonathantanmy@google.com,  karthik.188@gmail.com,
  toon@iotcl.com
Subject: Re: [PATCH GSoC RFC v12 12/12] cat-file: make remote-object-info
 allow-list dynamic
In-Reply-To: <CA+J6zkQ22en2HgH03EedKOfC+jLcHH2UbwpH0h_bDEAHR6B2pg@mail.gmail.com>
	(Chandra Pratap's message of "Tue, 9 Jun 2026 21:02:13 +0530")
References: <20250221190451.12536-1-eric.peijian@gmail.com>
	<20260608-ps-eric-work-rebase-v12-0-5338b766e658@gmail.com>
	<20260608-ps-eric-work-rebase-v12-12-5338b766e658@gmail.com>
	<CA+J6zkQ22en2HgH03EedKOfC+jLcHH2UbwpH0h_bDEAHR6B2pg@mail.gmail.com>
Date: Tue, 09 Jun 2026 11:54:34 -0700
Message-ID: <xmqqfr2v1r4l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Chandra Pratap <chandrapratap3519@gmail.com> writes:

> On Mon, 8 Jun 2026 at 15:45, Pablo Sabater <pabloosabaterr@gmail.com> wrote:
>>
>> The static allow-list in expand_atom() is hardcoded to only allow
>> "objectname" and "objectsize" for remote queries. This works because
>>  ...
>>  }

You just forced readers to skip over 200+ lines of quoted material,
looking for something interesting you have said in response to
comment on the patch in vain.

>> diff --git a/fetch-object-info.c b/fetch-object-info.c
>> index 51a898430d..425929a269 100644
>> --- a/fetch-object-info.c
>> +++ b/fetch-object-info.c
>> @@ -39,6 +39,12 @@ int fetch_object_info(const enum protocol_version version, struct object_info_ar
>>         case protocol_v2:
>>                 if (!server_supports_v2("object-info"))
>>                         die(_("object-info capability is not enabled on the server"));
>> +
>> +               for (int i = args->object_info_options->nr - 1; i >= 0; i--)
>
> Isn't args->object_info_options->nr of type size_t? We should probably
> do something
> like:
>
> for (size_t i = 0; i < args->args->object_info_options->nr; i++)
>
> instead.

This is a valid observation and a careful reading like this is very
much appreciated.  It is unfortunate that it was buried by 200+
lines of irrelevant material before we find it.

Thanks.


>> +                       if (!server_supports_feature("object-info",
>> +                                                    args->object_info_options->items[i].string, 0))
>> +                               unsorted_string_list_delete_item(args->object_info_options, i, 0);
>> +
>>                 send_object_info_request(fd_out, args);
>>                 break;
>>         case protocol_v1:
>>
>> --
>> 2.54.0
>
> Other than these, the patch series LGTM for now.
>
> Thanks,
> Chandra.
