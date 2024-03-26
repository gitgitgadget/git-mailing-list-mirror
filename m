Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B672913CC53
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 18:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711478774; cv=none; b=FAIUUAtXObPJijiuLE8MAv/wO3HK8kYia7mGsbufVu6CTBxlsds3m8WIH515KeozJflO776J7NEs6PeII2xEzXqxAJIpnXqHEXQDC/9TZKY1NJV+wDeUFG99puSY0DU0VkVNWzIgFHTzN/zDIsq3RMZFTUN4RGRevWz4oa0BAXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711478774; c=relaxed/simple;
	bh=0IQF3z6R1uCpPESWOoY9xMTY7k9f3jo9YNQwGfNmIYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bloDI0mH4Ny0UVeGVxZtUJvWKd7XNgRBg/do2gUL6eMeJmEK0nEhbu89t0XEiZ5GMGvDDSwUzeg/6zbHjdUQBYSVV9cOncAsgvn6+63rETB8YCzIw6RdgOGqPo+93Q9mzvv9K9xZca/qxggHO3FdeW4Hz4YrIWjM3xPIpXIDZO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WiHR6GLv; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WiHR6GLv"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-513e25afabaso6938362e87.2
        for <git@vger.kernel.org>; Tue, 26 Mar 2024 11:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711478771; x=1712083571; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MD4BPtngQTtFZZKtTCH5+mTK6Umvnfji9D2wTlVo7Pk=;
        b=WiHR6GLviUh/2nFO42TAUCwRWYE9TuxoCB7aiAI6vXcsJgv82O8AZnARs03xr0gNZl
         vdTzPqv/sZhwNcjAWVJ1YaMYKzHnH87biuq1YmUyMd3uvH0nEZBjF6dwn/Yt9ro7tmF0
         3GduJeOIS4Y7clKBQrobi0KzHyKW+KHxMDl7mV6jn0qzsI/bUCYykwUr5ak74JyZjXbz
         Wuk8wCyEMo/oLpdXw5fFX/+xCED9Xcyjj+gNEi1LIuYA82Itn+QdCW2yPeolRnPOC7VW
         wHyaW2bi1iWaYkW6QhkKm+/efyYraXerV+Fa4BKmHlSKjSrMjX8V6dDxr4xFbeToUTVE
         1eNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711478771; x=1712083571;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MD4BPtngQTtFZZKtTCH5+mTK6Umvnfji9D2wTlVo7Pk=;
        b=RI00nvPXBRHiSx3aKm20mVXMWeB6IqwVdBSoORbRD8ighCcpgGVsHDca97be3vkqLX
         5SlsTf8axj/fJF22CWUVvPck3CT95DvoV59qjgjboHa4eEQqimXZ4r9ruj/ZCdbqlSTL
         OtK/cKxjvdFI4THZfGNSmFw+kqlrQMQIWBc7za1EVKp2HWwZJwIBvphU6nmxrGAIukBL
         vOLQZQu+8CMOSROXBaP6IH1BwbQod4xY8f14TlxwYbRUuztrgb5Fx4euM//AOZdiLYy2
         Ro10OpN9pBMXRN7FU2nv9VxLdBGjDumdRMYX3PXc7TildBsdiZh2Sqb6t0h9z/Tt73OO
         R+Ag==
X-Forwarded-Encrypted: i=1; AJvYcCUhqa6segHPJIGOl0D9BumU+7Cby250h23HlwIpS14Dhkp3nzQtFexeszUrcF8kUHHqk16L4gnQzChBdKYUl1IJtDKv
X-Gm-Message-State: AOJu0YwVAVBf5aiieHImZcWdUaQM9FIIrgZJ6ADT/ijW4sm5ZkXRtuZr
	7gkX7Pu+269A5CNwOhVWBMvubK2CLRAlySNv0t0/U3Fi+iMNGWTK
X-Google-Smtp-Source: AGHT+IF6dqXRH/R35jaeZ0xyl+KYmoOLgyfPByl68Zik1PdyPBUexVZL/XFa1EGUZeg9FpXnlvI2ZQ==
X-Received: by 2002:a2e:b536:0:b0:2d6:acb7:9349 with SMTP id z22-20020a2eb536000000b002d6acb79349mr345481ljm.7.1711478770365;
        Tue, 26 Mar 2024 11:46:10 -0700 (PDT)
Received: from gmail.com (156.red-88-14-45.dynamicip.rima-tde.net. [88.14.45.156])
        by smtp.gmail.com with ESMTPSA id bi7-20020a05600c3d8700b0041493009a8bsm153470wmb.11.2024.03.26.11.46.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 11:46:09 -0700 (PDT)
Message-ID: <db774d76-5ecb-4b4d-9ede-dce0217c324b@gmail.com>
Date: Tue, 26 Mar 2024 19:46:09 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] add-patch: do not print hunks repeatedly
Content-Language: en-US
To: phillip.wood@dunelm.org.uk, Git List <git@vger.kernel.org>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>
References: <2c99dee8-fa6b-4f4f-93b4-3f7a8e0901f9@gmail.com>
 <6f2ed406-2152-476b-b463-3010afe7e11e@gmail.com>
 <c123bf09-7f4c-46f5-aa09-48b2816bf85d@gmail.com>
 <b3c6a5dd-2d78-4149-95f4-57cf8bd1240a@gmail.com>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <b3c6a5dd-2d78-4149-95f4-57cf8bd1240a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Tue, Mar 26, 2024 at 02:39:18PM +0000, Phillip Wood wrote:

> >      $ git add -p
> >      diff --git a/add-patch.c b/add-patch.c
> >      index 52be1ddb15..8fb75e82e2 100644
> >      --- a/add-patch.c
> >      +++ b/add-patch.c
> >      @@ -1394,7 +1394,7 @@ N_("j - leave this hunk undecided, see next undecided hunk\n"
> >       static int patch_update_file(struct add_p_state *s,
> >       			     struct file_diff *file_diff)
> >       {
> >      -	size_t hunk_index = 0;
> >      +	size_t hunk_index = 0, prev_hunk_index = -1;
> >       	ssize_t i, undecided_previous, undecided_next;
> >       	struct hunk *hunk;
> >       	char ch;
> >      (1/4) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]? U
> >      y - stage this hunk
> >      n - do not stage this hunk
> >      q - quit; do not stage this hunk or any of the remaining ones
> >      a - stage this hunk and all later hunks in the file
> >      d - do not stage this hunk or any of the later hunks in the file
> >      j - leave this hunk undecided, see next undecided hunk
> >      J - leave this hunk undecided, see next hunk
> >      g - select a hunk to go to
> >      / - search for a hunk matching the given regex
> >      e - manually edit the current hunk
> >      p - print again the current hunk
> >      ? - print help
> >      @@ -1394,7 +1394,7 @@ N_("j - leave this hunk undecided, see next undecided hunk\n"
> >       static int patch_update_file(struct add_p_state *s,
> >       			     struct file_diff *file_diff)
> >       {
> >      -	size_t hunk_index = 0;
> >      +	size_t hunk_index = 0, prev_hunk_index = -1;
> >       	ssize_t i, undecided_previous, undecided_next;
> >       	struct hunk *hunk;
> >       	char ch;
> >      (1/4) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]?
> > 
> > Printing the chunk again followed by the question can be confusing as
> > the user has to pay special attention to notice that the same chunk is
> > being reconsidered.
> 
> As we print a long help message if we don't re-display the hunk it ends up
> being separated from the prompt. Personally I find the help message quite
> annoying when I've fat-fingered the wrong key - I'd prefer a shorter message
> pointing to "?" to display more help. We already do something similar if the
> user presses a key such as "s" that is disabled for the current hunk.

Yeah, I would like that too.  Maybe something like:

     $ git add -p
     diff --git a/add-patch.c b/add-patch.c
     index 52be1ddb15..8fb75e82e2 100644
     --- a/add-patch.c
     +++ b/add-patch.c
     @@ -1394,7 +1394,7 @@ N_("j - leave this hunk undecided, see next undecided hunk\n"
      static int patch_update_file(struct add_p_state *s,
      			     struct file_diff *file_diff)
      {
     -	size_t hunk_index = 0;
     +	size_t hunk_index = 0, prev_hunk_index = -1;
      	ssize_t i, undecided_previous, undecided_next;
      	struct hunk *hunk;
      	char ch;
     (1/4) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]? U
     Unknown option "U".  Use '?' for help.
     (1/4) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]? 


I think such a change fits well in this series.  Let's see if it does.

> > -	size_t hunk_index = 0;
> > +	size_t hunk_index = 0, prev_hunk_index = -1;
> 
> I found the name a bit confusing as we have keys for displaying the previous
> hunk and it make me think of that. As it is used to record the index of the
> hunk that we've rendered perhaps "rendered_hunk_index" would be a better
> name.

OK.

> Also as it needs to hold a negative value we should declare it as
> ssize_t like the variables on the line below.

Very good point.  OK.

> 
> >   	ssize_t i, undecided_previous, undecided_next;
> >   	struct hunk *hunk;
> >   	char ch;
> > @@ -1448,10 +1448,14 @@ static int patch_update_file(struct add_p_state *s,
> >   		strbuf_reset(&s->buf);
> >   		if (file_diff->hunk_nr) {
> > -			render_hunk(s, hunk, 0, colored, &s->buf);
> > -			fputs(s->buf.buf, stdout);
> > +			if (prev_hunk_index != hunk_index) {
> > +				render_hunk(s, hunk, 0, colored, &s->buf);
> > +				fputs(s->buf.buf, stdout);
> > +				strbuf_reset(&s->buf);
> > +
> > +				prev_hunk_index = hunk_index;
> > +			}
> > -			strbuf_reset(&s->buf);
> 
> I'd be inclined to leave this line as is to make it clear that the strbuf is
> always cleared before adding the keybindings.

If find having two strbuf_reset()'s in a row confusing.  Maybe it is
just me not seeing that that second strbuf_reset is "close" to noop.

> 
> >   			if (undecided_previous >= 0) {
> >   				permitted |= ALLOW_GOTO_PREVIOUS_UNDECIDED_HUNK;
> >   				strbuf_addstr(&s->buf, ",k");
> > @@ -1649,10 +1653,12 @@ static int patch_update_file(struct add_p_state *s,
> >   			if (!(permitted & ALLOW_SPLIT))
> 
> style: as you're adding braces to the other clause in this if statement you
> should add them to this clause as well.

OK
