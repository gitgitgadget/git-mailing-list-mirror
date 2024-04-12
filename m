Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B80554F87
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 17:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712941410; cv=none; b=jpzY0dSY4Pb6cwcW7j6yTGJW+XszyVTj5h5WIYVuW40h4SRivQizx4p/+uXH92R/D6vTjq+NhvF0AYjDAp4ecY5pdh6u2VuizaM0Eb3EWIgRN2uuq7Z9Fd2GRAM1YU2+CoYBsvqJ7MwpQ+iIScO9vUq+4s29dIs95waFfiom/ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712941410; c=relaxed/simple;
	bh=ANKg6o44KVLgwzV3MPe7Vl5935ege09fgSpxKFbNQwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A62nqs523bLE1SpptKw7HoRONOq8OM9D75GK6AVdF2WDbV33cyrSFiryBQyorBHqUltGobtu5/MLTVFhwcKJlcNdf3OTyMJcL2Ht5fxOZTKLcIFSVNmdfrtvY1HFNduBb2O+5+gpt1xHANvt/OVAZZxI+jGQlYfwi73zHgPk3Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hGky4HOX; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGky4HOX"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-417f81ef467so6986275e9.2
        for <git@vger.kernel.org>; Fri, 12 Apr 2024 10:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712941406; x=1713546206; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=keF3soFjA7bcGf9SNGnZT7eYeCH17coSnQV4YJIf6Fc=;
        b=hGky4HOXBEOthLqJNk2J5FGFjDZv/xuBFWS+lH92VVQ2LM7Dug5/n/yUTAfae2xU9c
         g61xbDBb7B8RtUDtp+45D8G8E4uWFsURvy831SYY9ebPZiVEA6dToUjAnm5ehW7zkyAh
         Pv5hyGW3YzGPiCZb8srMiBuOZQVF8bucCGucvufigf1pmFJsTbj8MQTdG8DvCKjCt7fp
         DBhlF7ua/nlNdO/Y+L8zNU7H2cv334QGlqmLaoTagRaLDNOBnNKilWRMNzkSuU4RzA2e
         T1G7CcvPfwHrCAyHHf/fLciLadGfueRBdIYtvPH6s3KeCM5HxTnvj7BFIkeruj2RtAhR
         K+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712941406; x=1713546206;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=keF3soFjA7bcGf9SNGnZT7eYeCH17coSnQV4YJIf6Fc=;
        b=cZopczPdLzMHq0ZPD3ao2KGhnJN8bz80my3BsgLcSsi+DkDSlN6kv4fOjM2SM4O/7/
         0yGJGWWx/A2OdB3SO84xNkQ89v9+MtGyA7Wo3ct1vNAHHRNRO8JsHVW77rYuQs4s4h0d
         JoWdOgTkxms6RqQ1UERkeafQazYpZMB8tSoBo+WB1YXzYX4gDmNowvnoPOs/Xwh6vegO
         jM8A+LDWi3EsKSfQmON3A2lAEFW2o/+hPZjjd9/Tba5lJbbd/BLYyUszPaKkTkyeuyxL
         qTYXtiVzfYKgHefQOB0IPtncKgIEyzbkI0aHNl2W5lJMcFuTYxir9EPbfBMFILE5D8PH
         2RRw==
X-Gm-Message-State: AOJu0YzB+VwooatSByBoqq+4oA9oq15DNuKFZyIV28CYZZXvxZpnky6G
	oBfi2BFcMwa/zy2MIK/4UTjOXnWNjOL52rbyUufc3axPVewGWWcIEHYbLA==
X-Google-Smtp-Source: AGHT+IEpUaAxz6oft6Ax6otXCLYaOIO6HPQR23SRCM+vrcYpGJqUOJeFvvNQz1hTMXg0JeFSsuc+vw==
X-Received: by 2002:a05:600c:4506:b0:417:fbc2:caf8 with SMTP id t6-20020a05600c450600b00417fbc2caf8mr1673437wmo.23.1712941405724;
        Fri, 12 Apr 2024 10:03:25 -0700 (PDT)
Received: from gmail.com (188.red-88-14-41.dynamicip.rima-tde.net. [88.14.41.188])
        by smtp.gmail.com with ESMTPSA id t8-20020a05600c198800b004180c6ab70fsm1460399wmq.5.2024.04.12.10.03.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 10:03:25 -0700 (PDT)
Message-ID: <40075168-24d8-4c46-89fb-30fe2ab2581b@gmail.com>
Date: Fri, 12 Apr 2024 19:03:24 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] launch_editor: waiting message on error
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>
References: <e60c1217-aeb6-48ce-9aa5-7c0b13396e33@gmail.com>
 <96bef5f9-1286-4938-99ec-6beed13ee68d@gmail.com>
 <0258a583-a90a-4434-bb4e-a1672d574b9c@gmail.com> <xmqq4jcb495u.fsf@gitster.g>
 <54dcd4f1-5a79-47ba-9650-7115b7170a84@gmail.com> <xmqqle5lxlwm.fsf@gitster.g>
 <d485c4cd-f963-45b7-9fa6-801738c7c066@gmail.com> <xmqqwmp2posk.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqwmp2posk.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Fri, Apr 12, 2024 at 08:46:03AM -0700, Junio C Hamano wrote:

> >> It happens ONLY when the error message the editor itself emits
> >> (which comes later on the same line as "We are waiting for your
> >> editor...") without terminating newline itself.  Otherwise, we'd
> >> have
> >> 
> >>     We are waiting ... THE EDITOR SAYS I FAILED
> >>     _
> >> 
> >> on the screen, and the cursor is at the _ position.  term_clear_line()
> >> would not clear anything.
> >
> > Not with a careless editor:
> 
> That is why I said "Otherwise".  Of course, a broken editor would
> give broken output. What else is new?  And more importantly, if you
> wrote such an editor, would you release it in such a buggy form to
> the outside world?  Does it still look like a problem worth spending
> our brain cycles on?
> 

Yes, but I also see it from another perspective;  I don't want to worry
about a possible inconvenience.  And since it is perhaps an unexpected
precaution, for a future reviewer, hence the explicit comment in the
code.
