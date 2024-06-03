Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B980C1EB39
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 13:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717420465; cv=none; b=qpIgsJSeekzVMr5xHnuzIONjFj8qsIdWwSri2pUg5WJFt0UxA/TkMQbJFEAJxQ50/7qMQ9wFelzwK+O5k4cMR2nCR0ql9HUlbY+x136gqPasNX7hYJuXm2ANK1VgLGPWIc3wjLnChWma0leaYuwDRtEEAqPfYl+WF1/suOEm+MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717420465; c=relaxed/simple;
	bh=pWChuFTmNlt9yQkvQLcPwqT+jGw8FxEWrw1OEXnq+6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OahNiwVMoBxp276iLJkdFENvv5pHyFMdYjbwIF3mS70tiu35+TQJ+hDyaIi7H3IrLuJzQl+7Oe3TDG7H6atckOZDD3NzpUrRZa+0iI/q0jTIIMKBWyiOqRueG6obYftb5XrIrxlJ8BYRt3ukmqmq9O+js0PHIpUPRhzCHzSwRaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TF9auEO/; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TF9auEO/"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52b92e73e2fso2309659e87.2
        for <git@vger.kernel.org>; Mon, 03 Jun 2024 06:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717420462; x=1718025262; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ARfLkRwchmVvKqTB7yjGitXYGYXMsyQ9HqpO+BtcO3g=;
        b=TF9auEO/6ygqHGYudHDZeFdYqPRWGDMD4FckgY1yNwd9OYGoqaKWa03ZT+y4nJHlMu
         FqIw7GUN7ACX2gHABwOzrHqlmzv+sGFPftMHeC7mxp0ErVeTDrbGoGMmMEhQj30ZcEGN
         gnd25XDHIqRsBGWH9KU4Pr+nABTQpoYm9zGbBQeHXJDEbfOhGSUb8u/EePyMzXaP6ObW
         qicdLjX0LTOgLh/FXm8xix5Aq3aNVLLe6zpnEBzpX3H4tsHj4z29wA8ApbyyDu6NOOan
         JsEmDYo8Y6eXRdv45XWVOiIFxvkPPioiwcus7M/PuTUcuuZU4aQXzmpROnJJq0KL5ELr
         taUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717420462; x=1718025262;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ARfLkRwchmVvKqTB7yjGitXYGYXMsyQ9HqpO+BtcO3g=;
        b=mSYyCYJ7FllaHJu7de0d7oypq5pkTlR5fJYMIZoRE5fhNepekcKwe7hUwfN7YPwhXN
         JfPFjIibd5XgQujkA4Mg6qh+N0vqFOImT1yJXaJ0DzT00w1yImeIixAfiRH4fYKtw9u3
         UqWeykKmBClVWPqY1rHtzZDlxAfICiNDzoVsA4PE2WlA55+5kjM4uTGodYlXJ6dGUV6l
         Oe97/ahSyqPpgM84zCW6NFeXjFyT/66B/tndGPNCQbsX+G3WS9CwSpLuWGF+dioFlLBy
         xabZ2zRVp//+uNtAoZIU3Bx718PuSNv7y3WgcKqjtP+F78daEpbH7l547Y6FW7S/L7lG
         MZYA==
X-Forwarded-Encrypted: i=1; AJvYcCVCFsJ+uTyrfvoZwuaen/Gctc3kaDr1HkRoBCIaeq23OJfIi+k05s7390Yugr0twfEK4mjVbL6YqGBQCs/qss5y82hB
X-Gm-Message-State: AOJu0YxmLDTl2HSU81K9H0rY1cq72WNxi5IrEdF1AP4zm4wGUyG+5Zw9
	QQkkuKMDTl7BjrgsH+2OIftlOju45f6rNLjeH7Ad/ei9r/0IUqrllW/SSw==
X-Google-Smtp-Source: AGHT+IHui+HOB2jKexj65JHwjgiDARuD5z85HPslsWzPSttkN6ZLI8JJDLurPHaM2wMOeGtbkrdeKA==
X-Received: by 2002:ac2:5f66:0:b0:524:43b2:d326 with SMTP id 2adb3069b0e04-52b8958db32mr5451825e87.37.1717420461331;
        Mon, 03 Jun 2024 06:14:21 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62f:f401:d2c6:37ff:fef6:7b1? ([2a0a:ef40:62f:f401:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-35dd04c0f47sm8751563f8f.8.2024.06.03.06.14.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 06:14:21 -0700 (PDT)
Message-ID: <758f2321-dc63-4209-8b54-99b74b6bb897@gmail.com>
Date: Mon, 3 Jun 2024 14:14:20 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 20/29] sequencer: fix leaking string buffer in
 `commit_staged_changes()`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <cover.1717402439.git.ps@pks.im>
 <48bcd0ac80ee0b60eeda2bcedf55003a5049f289.1717402439.git.ps@pks.im>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <48bcd0ac80ee0b60eeda2bcedf55003a5049f289.1717402439.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 03/06/2024 10:48, Patrick Steinhardt wrote:
> @@ -5259,12 +5277,13 @@ static int commit_staged_changes(struct repository *r,
>   				}
>   			unuse_commit_buffer:
>   				repo_unuse_commit_buffer(r, commit, p);
> -				if (res)
> -					return res;
> +				if (res) {
> +					ret = res;
> +					goto out;
> +				}

Having 'ret' and 'res' in this block is a bit confusing - we could 
delete the declaration for 'res' and  either replace its use with 'ret', 
or rename 'ret' to 'res' in this patch.

Apart from that this all looks sensible to me, it is nice to see the 
number of leaks going down.

Thanks

Phillip

