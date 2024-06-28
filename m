Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0859E3C0B
	for <git@vger.kernel.org>; Fri, 28 Jun 2024 01:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719539804; cv=none; b=OcODke8OEYUmpUQipYt3Zl2GX1b9UuTHpXY9x4SX64kwFUn24KVaPDETt+xv756Sno7C/DIQJHmrOuxkyX/cVJEMJ4yIUNpZ0zRX45X25qqP8cl+qAqaFcjuyOO4Nqcnow3nI0cPQ37BuGoP398KNs1DKSIqAh/UgoSFa4J+Jlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719539804; c=relaxed/simple;
	bh=yZKoMSKA8T1BkyaMJTK1J6zr9vRGiiykqlZZC4c2eGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kLH7wkPpBknSc5a0QfJdnlSRrS+uDSiHjhUJXEHsiFggHubLl6z6qvqJaXOjybwByV7b9armbtaHEdcVBRIlsyxPInAxkesk5s+nHAIJPMYReS2u9lVMlLQg5J1ADS63NEWP+Jcl0aSmZo7Va0dKdukeB2TVKO12lQndkYyPRO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJxrjJij; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJxrjJij"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dfe1aa7cce2so74750276.1
        for <git@vger.kernel.org>; Thu, 27 Jun 2024 18:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719539802; x=1720144602; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HduWJxQZB5wwYzeWdWNB5i/Is+FSzhnpFvsTvSxZuek=;
        b=kJxrjJijJ77ePi3RxSGPuWy1Az2bkfsIfy0g4snAalu2WPT6Z10VFlT4ayLdUbjMnB
         i5FuMDUik0DHViHnVZfKxUkGd4QRQilBPKzymjqZS2m18VXF3aCqlvZVGF0ke1CB2RMg
         gog0cqZvC7+gosVHw7gYYxIF+SJTNa6KFZxY05C/953FAnQTk6MBOI3TDhtp6bOXxfXN
         H6Q+1a+esXhEoNeM4pN4VoeUytgLrT/xxR2lxbl9KZYUNcySv/aC3U9/EcqKTo2BPnbq
         YJWJqnMH1SQy1y2T9T38gKkIS9pXuYuKVZG4DDr7+2ys9nJj0iUY2Qxt5PIEuCOBDRq4
         RTzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719539802; x=1720144602;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HduWJxQZB5wwYzeWdWNB5i/Is+FSzhnpFvsTvSxZuek=;
        b=D3o+ykpYNh0a8wrN+ZCoAS7lI9YYhPR/S2+iP6fy35vzMU5wRH9zYREMNIEBCWu6xz
         OIBcZ7+k7gTB0nQWTC85aIQG0an1ZokGqddB6l8PvBZFstcPZRJyiQnqv1lRWXND3wYX
         btmkMIx68OhMKpVKfrs6WBmhXJYKa96DpRZAueopcYraxumosrWkbt6zKMKutGWQR2jO
         y2EvhAY7OQVvNsoGjqnBiZJmnDwq2j+w3EWlKaggqfVKrCrbhPRAvG5bboTr+NH40gEQ
         nOp/BpyP0PtbKwOabmSxciswi6C79KuNBbkwQje/2Anqkqhr2rKFQP+m14NzDkbYDwS+
         SuoA==
X-Gm-Message-State: AOJu0Ywf+16rjxJ9auqGuCjm+jgRgkdSVKn8QLGsub3RaKyQYXY52uv1
	1bqVSAkLzK6fZbVNAmaOdMO66FXdUaiHGxoeRVt4oOtL1sY0hGtf
X-Google-Smtp-Source: AGHT+IFrnbcOz9VwgwidRveHowW2MvWv2hRTmqqnHHilZaoXc7sLc7iGQJa7kHkK8Lq8GUV3KIJPVA==
X-Received: by 2002:a05:6902:218f:b0:dfa:fd9b:ad07 with SMTP id 3f1490d57ef6-e0303f5308fmr17935862276.32.1719539801828;
        Thu, 27 Jun 2024 18:56:41 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:5cca:8078:1e70:3d3c? ([2600:1700:60ba:9810:5cca:8078:1e70:3d3c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0353f45ebasm163897276.45.2024.06.27.18.56.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 18:56:41 -0700 (PDT)
Message-ID: <90731058-8079-45af-97e5-bbee4ec85378@gmail.com>
Date: Thu, 27 Jun 2024 21:56:40 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] sparse-index: improve lstat caching of sparse
 paths
To: Junio C Hamano <gitster@pobox.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, newren@gmail.com, anh@canva.com
References: <pull.1754.git.1718899877.gitgitgadget@gmail.com>
 <pull.1754.v2.git.1719412192.gitgitgadget@gmail.com>
 <0cb344ac14fa942f781221663e2324fd2225fb5f.1719412192.git.gitgitgadget@gmail.com>
 <xmqqy16qrsup.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqy16qrsup.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/27/24 5:14 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> +/**
>> + * Return the length of the largest common substring that ends in a
> 
> "largest" here is understandable (it means longest).
> 
>> + * slash ('/') to indicate the largest common parent directory. Returns
> 
> here I find it a bit confusing.  It is the deepest common parent
> directory between the two (or "the common parent directory with the
> longest path"), but my initial reaction was "largest common parent
> directory?  wouldn't the root level by definition the 'largest'
> (having the largest number of paths underneath) directory that is
> common?)".

I'm not sure why my brain got stuck on "largest" here when "longest"
would be a better choice.

>> + * zero if no common directory exists.
>> + */
>> +static size_t max_common_dir_prefix(const char *path1, const char *path2)
>> +{
>> +	size_t common_prefix = 0;
>> +	for (size_t i = 0; path1[i] && path2[i]; i++) {
>> +		if (path1[i] != path2[i])
>> +			break;
>> +
>> +		/*
>> +		 * If they agree at a directory separator, then add one
>> +		 * to make sure it is included in the common prefix string.
>> +		 */
>> +		if (path1[i] == '/')
>> +			common_prefix = i + 1;
>> +	}
>> +
>> +	return common_prefix;
>> +}
> 
> Looking good.  I assume that these two paths are relative to the
> top-level of the working tree (in other words, they do not begin
> with a slash)?

Yes, they do not begin with a slash. In this specific application, they
are paths from cache entries in the index. If this were generalized for
use elsewhere then paths beginning with a slash should be considered.

>>   static int path_found(const char *path, struct path_found_data *data)
>>   {
>> ...
>> +	 * At this point, we know that 'path' doesn't exist, and we know that
>> +	 * the parent directory of 'data->dir' does exist. Let's set 'data->dir'
>> +	 * to be the top-most non-existing directory of 'path'. If the first
>> +	 * parent of 'path' exists, then we will act as though 'path'
>> +	 * corresponds to a directory (by adding a slash).
>>   	 */
>> -	newdir = strrchr(path, '/');
>> -	if (!newdir)
>> -		return 0; /* Didn't find a parent dir; just return 0 now. */
>> +	common_prefix = max_common_dir_prefix(path, data->dir.buf);
>> ...
>> +	strbuf_setlen(&data->dir, common_prefix);
>> +	while (1) {
> 
> Oooh, nice.  So you learned /a/b/c/d did not exist, so check /a/b/c,
> and then /a/b/ and stop, because you know /a does exist already.
> With luck, our next query is for /a/b/c/e or for /a/b/f, and knowing
> that /a/b/ does not exist would allow us to say "no, they do not
> exist" without having to lstat().  OK.

I probably should have led with an example like this, as it makes the
point more clearly than my abstract description.

Thanks,
-Stolee
