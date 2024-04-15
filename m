Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E55285C43
	for <git@vger.kernel.org>; Mon, 15 Apr 2024 17:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713200839; cv=none; b=VyXJ9iDk+pPlnkN/++mj10YusobPbhnpUcE6dmc8ngb7BOBlEBwD1+fNOj/Xbgoy7bPdWsxrAjSBIQUSZjwmOjiy0ob9FckxaKbq6t46dVBnoS6PDzGc4+2/aO21lOhZJrY9s801R3snfCPplszjjhnesNefK/8WSCjmjZ7jP7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713200839; c=relaxed/simple;
	bh=3sL+3/+YwTSZhdKQkOBt+OrPgOc5UQnoKcHsgvWiEsw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=HiQ4yemBuMJYHWpSHRthUwZe/5uvhnyPhS85ejgEt1vaBLMWLQc9fCCg+I1uJ4dHFMEE++uv1o6TtWc8vCPE5DExJHo0MtdT9OZttq6dpO8QyCltXkuKUJDSNJF3F0f8DVtClYAk4ZG+NCISMc/SROXb0Otn/3Ju+k7rrvA55lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EfH/60xD; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EfH/60xD"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3455ff1339dso2369317f8f.0
        for <git@vger.kernel.org>; Mon, 15 Apr 2024 10:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713200836; x=1713805636; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HuENDbKltOkmCub1ZaPmkWGfXHq9Isntn3xu4gofvKs=;
        b=EfH/60xD1Js0naWo20PR4xWeRxSYf09QkARTZzuy6zCA/uEX+QBnYnWwyQ67pwamJe
         Aay0+E+n3AXP3BQ+zk9Tj6/akfQG1isLw6Ti6lmVXJg7YM++w55GlX/UnvLCuE1k4LH+
         6vCEQxLISPlSWgHdgSGTEnHt71HSvPvD9nCpowk4YkHkrLzNsPFH5Ra+lxpqEj95y0lK
         m3g7/X6JB2yrY8zATeT3IaykW5XZbl3+O++Q4a8x0NYb9V3LdOZu4Umj1qUzr2mFuA3i
         DlGmTzgpwBNpmj8WXqsN6ndSTtOiZ8b8C265CYPHs/Tgl8Qy5Y5cLzwhv5c0GDUkGNl8
         M/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713200836; x=1713805636;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HuENDbKltOkmCub1ZaPmkWGfXHq9Isntn3xu4gofvKs=;
        b=HE6v07Cv008gl/zuHusAcN5/CSsX8rE8f+m4EbQDlu2w0ow8rxCeUtxFIndLXHHZUo
         /uV0EPKx3MVcCdypKSPKBQuaTIZm9bHWAVfUQiUez/ije0LjCctGL2MTMqn6aQokDEij
         HgSd7Oq0HGwlWHFVtyEzh7FMBaU/WiWUt5fXzbRI/nJc78e1VDzgV/gbLlCaDlXiK9SX
         bcbwUv5WPbOMzcZeXnvBkXsOXiDeNnkJxQIIAs8/MnM4WBoJqWVsVtyThQ4+gJEi5uJ0
         WXjmEVE9iXiCNZkDGBGiG77zSHfB2FrAMrhzEMAShx1IjeLuQE7nTdUGNI1Z6mPh/c5V
         n8rA==
X-Gm-Message-State: AOJu0YyqE47sNfqxIxsnDcSnHvjJd8k7lHvEgFZjslZ565s0LvA1UcnS
	w6kFcfdDG3znMd95NpqeqrsdH/9wBLeynyH0VKYIhljs//TOGjHhp4wLmA==
X-Google-Smtp-Source: AGHT+IHXIA5UQAVmDo99JYOcz5BGrBJp8JXCRHVwXSHiLXmXOjdwYsPWJVc5rDVNiRN+hxaJNwShVw==
X-Received: by 2002:adf:db46:0:b0:346:b541:8022 with SMTP id f6-20020adfdb46000000b00346b5418022mr7398396wrj.63.1713200835673;
        Mon, 15 Apr 2024 10:07:15 -0700 (PDT)
Received: from gmail.com (91.red-88-14-45.dynamicip.rima-tde.net. [88.14.45.91])
        by smtp.gmail.com with ESMTPSA id e3-20020a5d5943000000b00346c169362esm12153150wri.23.2024.04.15.10.07.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 10:07:15 -0700 (PDT)
Message-ID: <8ef912a9-78f2-411a-a055-f86f69d78b90@gmail.com>
Date: Mon, 15 Apr 2024 19:07:14 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] launch_editor: waiting message on error
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Cc: rsbecker@nexbridge.com, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <e60c1217-aeb6-48ce-9aa5-7c0b13396e33@gmail.com>
 <96bef5f9-1286-4938-99ec-6beed13ee68d@gmail.com>
 <0258a583-a90a-4434-bb4e-a1672d574b9c@gmail.com>
 <ccbd77a1-d334-4d8f-8de0-b542c79330fd@gmail.com>
 <e208da74-8f16-44ae-912e-ae968da82057@gmail.com>
In-Reply-To: <e208da74-8f16-44ae-912e-ae968da82057@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, Apr 14, 2024 at 09:39:44AM +0200, Rubén Justo wrote:
> When advice.waitingForEditor configuration is not set to false, we show
> a hint telling that we are waiting for user's editor to close the file
> when we launch an editor and wait for it to return control back to us.
> We give the message on an incomplete line, expecting that we can go back
> to the line and clear the message when the editor returns.
> 
> However, it is possible that the editor exits with an error status, in
> which case we show an error message and then return to our caller.  In
> such a case, the error message is given where the terminal cursor
> happens to be, which is most likely after the "we are waiting for your
> editor" message on the same line.
> 
> Clear the line before showing the error.
> 
> While we're here, make the error message follow our CodingGuideLines.
> 
> Signed-off-by: Rubén Justo <rjusto@gmail.com>
> ---

The changes since v3 are:

- dropped [v3 1/2] because, as noted by Randall and Phillip, it is not a
  good idea.

  The message stays like:

	$ GIT_EDITOR=falso git commit -a
	hint: Waiting for your editor to close the file... error: cannot run falso: No such file or directory
	error: unable to start editor 'falso'
	Please supply the message using either -m or -F option.

  The "error: unable to start..." at the beginning of the line makes it
  less prone to confusion than the other error message considered in
  this series.

- term_clear_line() is now used in all cases as it is unlikely that any
  sane editor emits an error message without ending it with a newline.

  This:

	$ GIT_EDITOR=false git commit -a
	hint: Waiting for your editor to close the file... error: There was a problem with the editor 'false'.
	Please supply the message using either -m or -F option.

  becomes:

	$ GIT_EDITOR=false git commit -a
	error: There was a problem with the editor 'false'.
	Please supply the message using either -m or -F option.

