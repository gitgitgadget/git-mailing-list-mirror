Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD7C446BD
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 18:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712946278; cv=none; b=O0kQb937QeAWaXKBfQOKhhhQqcPAvmu6zQeavORFl66KUFb2AYiwVh/iU8CAlLmeIPY3lKFkC2f7rZaxt8pGc5GiVwKxRYjbKBauH5mxh4hEEhsTSKZk9s5jbku+No9EpXe5y8Pd5IvL7cioCFPfstLn/dblBOnsePaxl/Ggf0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712946278; c=relaxed/simple;
	bh=irNqlkEXYh68KU1nJdGnA8IrnUv8N6ceWUbeEzQCDtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=te1ldc+33stWp7MS05EhVe2GPxc4dg2IBrhGtlXbYxt6zedxTf2cpbYDc8r1PGLAfxsq7uPR2emj3SnDAjL2fjDN42UHor6DaSLOKdAFPtwxjtiKfJZ+3hhUOTyqR5Csso2GFKvFdSUcXHmVzLQAiYugXTZgpxbPqo5eYkQ12B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MnXZ/E6k; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnXZ/E6k"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-417c5aa35f6so8764605e9.3
        for <git@vger.kernel.org>; Fri, 12 Apr 2024 11:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712946275; x=1713551075; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RxN41w+++QY3S6PS4Rm5uFHt4xMZp8AsUgK1vqTHOWs=;
        b=MnXZ/E6kFH8rAQMTWbbQ3k2IugpGL4ypZJu2GdhOpRVeOo/JK7X37zBzaJxLZyUAGy
         HC2hd7u+Kbvb/MGNDPVXy5h5/Z3kMDoFcQlosgv87TZSQiwUGwS4tRLTm02WtJxWZYg1
         u3kBPhehmxKTMya5dutL7/lJ7giASAdO33yRaCqlMKoprd+EBykZj9D/sCe1XJMkz+6t
         02DmU7E5F+nqVRyyZo6fV3trLDwupWZvhlxxpNuhOLul0jr7HQKZrGGyJJzzHEWAe4+P
         H2WLJPWPFVYA0FeDoMJ2oA+dIaFhf0ji4ZFjSyLYUMkEAChWRrsMMcTYX+Eok9QQjzal
         H+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712946275; x=1713551075;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RxN41w+++QY3S6PS4Rm5uFHt4xMZp8AsUgK1vqTHOWs=;
        b=A+h8uE6DYybtYQ9+WRrAj+r9Y4SuA9AGI4PT39QWTaG+vEhfY6Lbv7I5hwXqag5xCu
         i1JVUMVhIs5WdgDHB8wRfk12qqRup8H/TZOYAu+/EOG25OV2s18jigobwEEHJL81qb5O
         0PCPc/7WxUdR3q+/E1xlNv+7bripUyZRgHPFN4/L1zVR+pICEYiTtpnRZf5jC5W+lKYP
         DV2+nZiW8dDlgKKAQwkTmfJ2BHe5b0eTzRmLqqXYOQONoC3hou6/3unTc2oXR4VXjOkw
         Az2rx1kdcoV4QA4/VSQc5bhSwcq5bwFFTO/Jv10Jtqd46ERIk7FiS8g6CslSbJfyY9LU
         PaBw==
X-Gm-Message-State: AOJu0YxWK+S5iJEN3dztceCnjq2Zxl0qCP0PIh3X5ZutduiEiD0hr+d4
	zSL1a11YjhBJI7aQNl1VRddLv7PhzqSf2JZ8I1yhhy7D0SIvdHlC
X-Google-Smtp-Source: AGHT+IHKaenedlMSQjF/YAIPj68byCRkjImOf9MJeCuIMYaY06i661+uzrmM3tIfYwSQbMd2xS/DaA==
X-Received: by 2002:a05:600c:ccc:b0:418:16c3:45d with SMTP id fk12-20020a05600c0ccc00b0041816c3045dmr467739wmb.23.1712946274616;
        Fri, 12 Apr 2024 11:24:34 -0700 (PDT)
Received: from gmail.com (188.red-88-14-41.dynamicip.rima-tde.net. [88.14.41.188])
        by smtp.gmail.com with ESMTPSA id o4-20020a05600c4fc400b004170e0aff7asm9219804wmq.35.2024.04.12.11.24.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 11:24:34 -0700 (PDT)
Message-ID: <701c23e2-ed88-4ad8-95b6-1ce73e671709@gmail.com>
Date: Fri, 12 Apr 2024 20:24:33 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] launch_editor: waiting message on error
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>, rsbecker@nexbridge.com
References: <e60c1217-aeb6-48ce-9aa5-7c0b13396e33@gmail.com>
 <96bef5f9-1286-4938-99ec-6beed13ee68d@gmail.com>
 <0258a583-a90a-4434-bb4e-a1672d574b9c@gmail.com> <xmqq4jcb495u.fsf@gitster.g>
 <54dcd4f1-5a79-47ba-9650-7115b7170a84@gmail.com> <xmqqle5lxlwm.fsf@gitster.g>
 <d485c4cd-f963-45b7-9fa6-801738c7c066@gmail.com> <xmqqwmp2posk.fsf@gitster.g>
 <40075168-24d8-4c46-89fb-30fe2ab2581b@gmail.com> <xmqqbk6emql1.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqbk6emql1.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Fri, Apr 12, 2024 at 10:35:38AM -0700, Junio C Hamano wrote:

> > Yes, but I also see it from another perspective;  I don't want to worry
> > about a possible inconvenience.  And since it is perhaps an unexpected
> > precaution, for a future reviewer, hence the explicit comment in the
> > code.
> 
> But then the comment should say it only matters if the editor left
> its message incomplete, shouldn't it?  If the editor did the right
> thing and terminated its message before it exits with a newline, the
> extra LF we emit after it will only waste the vertical screen real
> estate.

Not sure if that needs to be noted in the comment.

This, and the other point raised by Randall [1], certainly makes me more
in favor of using the advise_if_enabled().

Instead of "Waiting...", using a message such as "Started..." can be
just as good for user guidance and less prone to error.

I think the v3 I posted is an improvement.  But I believe we should
consider moving towards using the advise API here, at some point. 

 [1] https://lore.kernel.org/git/96bef5f9-1286-4938-99ec-6beed13ee68d@gmail.com/T/#m906fca9d24baf343326e134ac08370a77d69a603
