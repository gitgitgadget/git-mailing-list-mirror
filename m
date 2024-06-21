Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F851DDEE
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 13:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718976249; cv=none; b=E1kMxatGy80kXqGxfH3t2oRYsKWfyItkJOUZrxqyCsfh0IrXPdf3Cj2iYCH4IWO5kaEhVusYhZ1Iu0mrLZoyTSzmJ6ggrrdE9xITLBXjy8efC1nw256lGldY+4+2kVYz2sc5U6nJjNQnJPiu+IAc9lGyzhqRTIHu8ssCr4GNe4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718976249; c=relaxed/simple;
	bh=tP3Rrrsml+hfMNOgIDOo72/K16MkWdV9FeNAO/sT/8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KsHaRDmimF3F2aBp/7KawrOe+SG069qJ8Dxdvp2s2nAbBPyo+X+Ybu4uEnBXqcUd3vKOK0OipBA/Q9Wc1QzrXw3rIrlUh9unJ/oyxK1l7ie3JJB5m7mBlOsaQ3DhcxAJuVZ8PlBXhqhhZfwPH1cZgJd5ugUSFGW60PPtA1dqzxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JmsuavHm; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmsuavHm"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4217c7eb6b4so19025655e9.2
        for <git@vger.kernel.org>; Fri, 21 Jun 2024 06:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718976246; x=1719581046; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Wykz5d/QIgGwVbkU3E/FXs4PChmkLFFS+rk9aOZgaTo=;
        b=JmsuavHmZwI/hnEkFdIFvkoZ8n6CiD6kiJPRFi7zE0S7hQeQNp8++crxkJelLNnHGe
         DZ50wn23EhYKwPvm6cROP92dbGAA2lSrJ3iNs+nU2QkuKN+j1M/77rT9cbpkqFsZtOoV
         CQUVUh2W5kXR+ggsc05fcn0Xa//f8vo4+Eb+3c8KBkvkm2C7+HFJW9sJOzyWjuQUYB2O
         qiwAMY8he6J0XnWvbXp2OrqC8nDEi70ZnA3TSJbNjB9DBFsq5hI6SMMxe4j3lM6cEWT+
         UiVPoLH5GGGNCCB0Kk7YlN7bNOl5bwYOtRf+KWPwo+lnmWr0ZD6QlZgl4hWMQ/YNkDu4
         G3uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718976246; x=1719581046;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wykz5d/QIgGwVbkU3E/FXs4PChmkLFFS+rk9aOZgaTo=;
        b=iU2z1It1bLaYQAWhbF0qeyDLx+vWkqihMkC9BXh6rsHELLQgBUnHm0s1NAiAm7P0k+
         kCXiIxkZkMU+6DFrKCZrFgCjhUnj+eVIuKJjyIQ3zVFdufS+Lj6bpQ/Ze0nJY24i4mMY
         O9VHcvfz1eI1pWfLjtUfab/QnvkN7xgpFQRjX7fU/sqEW/Nf+rsZzaBvBUTLU40iMwI2
         LPyHLXRd2lmcYPirtsDBwxJv3aQWjEE6XzkQIR3Km10c8vjClkn9jJGWsQ7YKzn3Yh2B
         0edQ1gYm6U4Tk/oM9y/+Em3iY8TIITjuXEKaYw4WPgxzb6fk51GQUTcMRQBxBGaHLLdB
         8Clg==
X-Gm-Message-State: AOJu0YxC5oiGuFdhxmN6bWjzhELUAUQ2BP0ViW0Jk1oDg1JN7l8Yodk/
	keWV33eaaaVTvtzppvcFWQO6XqBCrZsHyKY/yhuqoHzLG66mMgJiHmX5/g==
X-Google-Smtp-Source: AGHT+IGUtEA7y2tLF71UQ9cpv+G0Uxw2DKVgPpP2GMa1+quO68IMJ1wOeSsxadbJ+pheTPDvjimcdQ==
X-Received: by 2002:a05:600c:3653:b0:421:8e64:5f72 with SMTP id 5b1f17b1804b1-42475182acfmr56247605e9.18.1718976245857;
        Fri, 21 Jun 2024 06:24:05 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:64f:8901:d2c6:37ff:fef6:7b1? ([2a0a:ef40:64f:8901:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4247d208e4dsm64477225e9.33.2024.06.21.06.24.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 06:24:05 -0700 (PDT)
Message-ID: <3d43023c-ceb8-4e5c-9607-8448509fb599@gmail.com>
Date: Fri, 21 Jun 2024 14:24:05 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] cat-file: reduce write calls for unfiltered blobs
To: Jeff King <peff@peff.net>, Eric Wong <e@80x24.org>
Cc: git@vger.kernel.org
References: <20240621020457.1081233-1-e@80x24.org>
 <20240621062915.GA2105230@coredump.intra.peff.net>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20240621062915.GA2105230@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Eric and Peff

On 21/06/2024 07:29, Jeff King wrote:
> On Fri, Jun 21, 2024 at 02:04:57AM +0000, Eric Wong wrote:
> 
>> While the --buffer switch is useful for non-interactive batch use,
>> buffering doesn't work with processes using request-response loops since
>> idle times are unpredictable between requests.
>>
>> For unfiltered blobs, our streaming interface now appends the initial
>> blob data directly into the scratch buffer used for object info.
>> Furthermore, the final blob chunk can hold the output delimiter before
>> making the final write(2).
> 
> So we're basically saving one write() per object. I'm not that surprised
> you didn't see a huge time improvement. I'd think most of the effort is
> spend zlib decompressing the object contents.

If I'm reading the changes correctly then I think we may be saving more 
than one write far large objects we now seem to allocate a buffer large 
enough to hold the whole object rather than using a fixed 16KB buffer. 
The streaming read functions seem to try to fill the whole buffer before 
returning so I think we'll try and write the whole object at once. I'm 
not sure that approach is sensible for large blobs due to the extra 
memory consumption and it does not seem to fit the behavior of the other 
streaming functions.

If the reason for this change is to reduce the number of read() calls 
the consumer has to make isn't that going to be limited by the capacity 
of the pipe? Does git to writing more than PIPE_BUF data at a time 
really reduce the number of reads on the other side of the pipe?

>> +
>> +/*
>> + * stdio buffering requires extra data copies, using strbuf
>> + * allows us to read_istream directly into a scratch buffer
>> + */
>> +int stream_blob_to_strbuf_fd(int fd, struct strbuf *sb,
>> +				const struct object_id *oid)
>> +{
> 
> This is a pretty convoluted interface. Did you measure that avoiding
> stdio actually provides a noticeable improvement?

Yes this looks nasty especially as the gotcha of the caller being 
responsible for writing any data left in the buffer when the function 
returns is undocumented.

Your suggestion below to avoid looking up the object twice sounds like a 
nicer and hopefully more effective way of trying to improve the 
performance of "git cat-file".

Best Wishes

Phillip


> This function seems to mostly duplicate stream_blob_to_fd(). If we do
> want to go this route, it feels like we should be able to implement the
> existing function in terms of this one, just by passing in an empty
> strbuf?
> 
> All that said, I think there's another approach that will yield much
> bigger rewards. The call to _get_ the object-info line is separate from
> the streaming code. So we end up finding and accessing each object
> twice, which is wasteful, especially since most objects aren't big
> enough that streaming is useful.
> 
> If we could instead tell oid_object_info_extended() to just pass back
> the content when it's not huge, we could output it directly. I have a
> patch that does this. You can fetch it from https://github.com/peff/git,
> on the branch jk/object-info-round-trip. It drops the time to run
> "cat-file --batch-all-objects --unordered --batch" on git.git from ~7.1s
> to ~6.1s on my machine.
> 
> I don't remember all the details of why I didn't polish up the patch. I
> think there was some refactoring needed in packed_object_info(), and I
> never got around to cleaning it up.
> 
> But anyway, that's a much bigger improvement than what you've got here.
> It does still require two write() calls, since you'll get the object
> contents as a separate buffer. But it might be possible to teach
> object_oid_info_extended() to write into a buffer of your choice (so you
> could reserve some space at the front to format the metadata into, and
> likewise you could reuse the buffer to avoid malloc/free for each).
> 
> I don't know that I'll have time to revisit it in the near future, but
> if you like the direction feel free to take a look at the patch and see
> if you can clean it up. (It was written years ago, but I rebase my
> topics forward regularly and merge them into a daily driver, so it
> should be in good working order).
> 
> -Peff
> 

