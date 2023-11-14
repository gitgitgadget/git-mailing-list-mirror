Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792047E
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 02:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hxcgISRF"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCC312D
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 18:55:34 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id BF4322C417;
	Mon, 13 Nov 2023 21:55:33 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=WYdRlYWjKCe80HNRpX79oZP+Cz4o/bvSPJhDw6
	Poa50=; b=hxcgISRFrn2eJZhOPSsX1RjL4CKuBmZK7FAt4Xb2MyIn0bwIy6A9l+
	Q81tlS/Q/0CAWjauZXq3Crz2RX6oz03GaTLsLCV5z0bgsiS0Zi0tbO/FCxRlkktF
	G3x4MsU26i1K8TODROCCIpuahXbctPGz95NJt2XufUAQu2q7Vw/WE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id B82492C416;
	Mon, 13 Nov 2023 21:55:33 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5E0382C407;
	Mon, 13 Nov 2023 21:55:30 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Teng Long <dyroneteng@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 2/3] update-index: add --show-index-version
In-Reply-To: <20231114021839.8275-1-tenglong.tl@alibaba-inc.com> (Teng Long's
	message of "Tue, 14 Nov 2023 10:18:38 +0800")
References: <20230912193235.776292-3-gitster@pobox.com>
	<20231114021839.8275-1-tenglong.tl@alibaba-inc.com>
Date: Tue, 14 Nov 2023 11:55:28 +0900
Message-ID: <xmqq7cml11sv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4593F282-8299-11EE-A540-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Teng Long <dyroneteng@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> @@ -1181,15 +1183,20 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>>  
>>  	getline_fn = nul_term_line ? strbuf_getline_nul : strbuf_getline_lf;
>>  	if (preferred_index_format) {
>> -		if (preferred_index_format < INDEX_FORMAT_LB ||
>> -		    INDEX_FORMAT_UB < preferred_index_format)
>> +		if (preferred_index_format < 0) {
>> +			printf(_("%d\n"), the_index.version);
>
> Maybe the "%d\n" shouldn't be translated? :)

Excellent.
