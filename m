Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA473009EC
	for <git@vger.kernel.org>; Mon, 10 Nov 2025 14:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762786491; cv=none; b=XdGJogBLzHSHGSljV4wEemBAv0uYMEdC9bicBYbuTflnb3YMedzyWbvfcH3Q9m3ImYwI/0XVJVX1ucPM9z59wS+WH03HIJdxO6ZSukqILzr9JiYpW7/2BoDt6ND1wIoiFTVj+XEyGovpsFIcGp7N9XMBGtQe0o0p9f/RfdM/LxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762786491; c=relaxed/simple;
	bh=B3jiSp7jteNthCVPrAzX0xRzFstw66VTq4fuyXlgbQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=aTdXMuH9TtTpFFitLqtDqDlXiKd/PN762FohFS34lxUcHkrfT3Z4ZvfZciZw9BjoqMJ0S6oLkwKsvIp5fl5HMYedjDj1elBhQ0+FTfYndcZ43LHQxomg2ShSZufi9erhxZI2iZ8l7yIAq43q5vESZKXN/hZKMqfAy0TURVm58gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IEySzXY4; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEySzXY4"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42b3ac40ae4so592517f8f.0
        for <git@vger.kernel.org>; Mon, 10 Nov 2025 06:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762786488; x=1763391288; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=e4EEtLvm8FtxaQwcVYaKExyk0h8PynY3KWnC1OAgYDI=;
        b=IEySzXY43vB6NdnIX3ZV7O83IFE/xWCks9/V3pkRs+xMKfbXphZY42C7tWO6GzhLzv
         O5OVmL3sFKmlc1i8strap9c9Q+ApUVb3ToQLrCcFdWxfgrXxq0PSKKDuxqlMrBeyvRLP
         zdPaWq+YNU0vt8gx+RAp1on/ORvK8nCt+ySx2h0aw8XPQ5zmRrAQuVFaNz4TqQN301Vy
         amZ++0J1MR4yq2pxf070WE+O3CPbyGOySiCB3OMrK97PZGIwfuZrpgsOV51jkHwStLF2
         oZmIaFIbYDzdxHxc3dKoMGCc+0ISbVTrUvg4+txRymOkGCy+9ifH2Cg5fV4hYDN/q7GW
         0R7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762786488; x=1763391288;
        h=content-transfer-encoding:in-reply-to:cc:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4EEtLvm8FtxaQwcVYaKExyk0h8PynY3KWnC1OAgYDI=;
        b=krNyBIckgKL9Y4PVFJlwTUadOVM96L07FTCMz/DVX6BujD9Rq5sGTbuIWpVVIt3Ih+
         4lVeEmfGcHFSgGYLjoDwCtbBkwynTtrpyL7TF9I4dkWWWdlaDAM++yX4gKIn8wnTQRES
         KZ/r5S/8tf/6vhCDXDhq2WNfL0k/5yXsmyQ9t9OT3hhYJj5FFwldGBqtrTaSY0NY9EaB
         j+s4d2viuv13l7tpU9A4QMdUHwT4ASWTkJxTthm3aolZ5v616LJBYjZRY2ZI/z4PWzH2
         IvlPJvr8Gw7xLQIP5N7MfhTI5NqiXf+pFTMUQn0WLVMQgGfTOTVJvJkNesoUHv65B5et
         mDLg==
X-Forwarded-Encrypted: i=1; AJvYcCXKdj6tXXQmsUnVs8LHkpzcIsztRtUJ2CWOOaNz3uI4N+Gzs3x1ActabvfmcLnrui8U32E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3jx1vHBc8ysZNxNbQvpYGvwyk1iAcP9DpG2Qnzmw//feXHpCn
	l+jO8IAO0+jDZzdADzeElJijO58XGRZdDUxMr9PlA5mg0CXaqa6lu4W8
X-Gm-Gg: ASbGncu4+qGPdJlriqgbpRmZNhpp3VEkOImfi88g7CH8TizU2EbQKiPqeN5F9CpovGB
	O4XPhapx5gSJhPr3WOiqlyXAoSccYOu1aWMVsedUAD6cMiROEiasq8FCFRjPjpbZmRxKRyJlysi
	lNY3ZqklQZDPelVBg3MRhM9ATmhOOUrLeEJWJTabD3U/UCCaLzFvt9UBAcG/MvGRSQBsZbsYQE8
	07dknZ9IXq8Nlc82T+K44KVlr6GKujcFfdpl/vUys7Nj6Af9Y9g+F8nS1K1ejkC+/PxoV+c7XoS
	eJHlBCi0gqyn+GAPMzP1K2uGguPa0jO2/3Vr5c9pTR9HcDwp5mgbOa1+Nx++E8KfSFsqXHysmyS
	j9WutJkPgDc5u+mF1IwFJo5d8zAAlsQhO5VopLr5aRyzcS1ehm7MjNYWdqMvjKT/BM0IsojpWPI
	ZpZbE/OchWclwxIZ0vXFOp62kTynQzfLu1PPJDQFC4LO2fkDN+OqwamwqLAqcWb8acHDqwXfqrZ
	A==
X-Google-Smtp-Source: AGHT+IEqwROzDk4ofpggKHOWqinx6LkTPZZGVKqOyIyYJ/N4znizeYZmtHsAUfC5CzYu3vKRqMeKjA==
X-Received: by 2002:a5d:5f95:0:b0:42b:31a5:f065 with SMTP id ffacd0b85a97d-42b31a5f4c6mr5084579f8f.28.1762786486649;
        Mon, 10 Nov 2025 06:54:46 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:658:8901:ced:8495:73eb:ebd6? ([2a0a:ef40:658:8901:ced:8495:73eb:ebd6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b30dd4d86sm14109271f8f.26.2025.11.10.06.54.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 06:54:46 -0800 (PST)
Message-ID: <0b0181af-e63d-4e5a-9e3c-822f866df88d@gmail.com>
Date: Mon, 10 Nov 2025 14:54:45 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 07/12] diff: update the way rewrite diff handles
 incomplete lines
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20251104020928.582199-1-gitster@pobox.com>
 <20251104020928.582199-8-gitster@pobox.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
Cc: Patrick Steinhardt <ps@pks.im>
In-Reply-To: <20251104020928.582199-8-gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/11/2025 02:09, Junio C Hamano wrote:
> 
> Revamp the way the complete-rewrite code path feeds the lines to the
> output layer by treating the last line of the pre/post image when it
> is an incomplete line specially.
> 
> This lets us remove the DIFF_SYMBOL_NO_LF_EOF hack and use the usual
> DIFF_SYMBOL_CONTEXT_INCOMPLETE code path, which will later learn how
> to handle whitespace errors.

This is a nice cleanup

> @@ -1786,22 +1777,36 @@ static void emit_rewrite_lines(struct emit_callback *ecbdata,
>   	const char *endp = NULL;
>   
>   	while (0 < size) {
> -		int len;
> +		int len, plen;
> +		char *pdata = NULL;
>   
>   		endp = memchr(data, '\n', size);
>   		len = endp ? (endp - data + 1) : size;
> +		plen = len;
> +
> +		if (!endp) {
> +			plen = len + 1;
> +			pdata = xmalloc(plen + 2);
> +			memcpy(pdata, data, len);
> +			pdata[len] = '\n';
> +			pdata[len + 1] = '\0';
> +		}

I think it would be clearer to refactor this as

  		endp = memchr(data, '\n', size);
-		len = endp ? (endp - data + 1) : size;
		if (endp) {
			len = endp - data + 1;
			plen = len;
		} else {
			len = size;
+			plen = len + 1;
+			pdata = xmalloc(plen + 2);
+			memcpy(pdata, data, len);
+			pdata[len] = '\n';
+			pdata[len + 1] = '\0';
+		}

Thanks

Phillip
>   		if (prefix != '+') {
>   			ecbdata->lno_in_preimage++;
> -			emit_del_line(ecbdata, data, len);
> +			emit_del_line(ecbdata, pdata ? pdata : data, plen);
>   		} else {
>   			ecbdata->lno_in_postimage++;
> -			emit_add_line(ecbdata, data, len);
> +			emit_add_line(ecbdata, pdata ? pdata : data, plen);
>   		}
> +		free(pdata);
>   		size -= len;
>   		data += len;
>   	}
> -	if (!endp)
> -		emit_diff_symbol(ecbdata->opt, DIFF_SYMBOL_NO_LF_EOF, NULL, 0, 0);
> +	if (!endp) {
> +		static const char nneof[] = "\\ No newline at end of file\n";
> +		ecbdata->last_line_kind = prefix;
> +		emit_incomplete_line(ecbdata, nneof, sizeof(nneof) - 1);
> +	}
>   }
>   
>   static void emit_rewrite_diff(const char *name_a,

