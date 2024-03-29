Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FFEA92A
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 11:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711712282; cv=none; b=lnaZl9TlVumJl71FTMRTDzzrEQKQ3ETaRz1WKMVEBNWDkl6X1HMP5DoN6SXTmP9AN/KvGe4hmO0iDWR5aluVLvdm6XfrECKW/G4KgYXGGCjt9EJFwTjj8RjhDFRx1plWUIYAeCkH+cUruWhPjQKviHtjQQ8vu9J+YXvhQ40Broo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711712282; c=relaxed/simple;
	bh=9flvTW2zE/UKYayyH0NUpWsr4eJbCg0Kya3SFpzUNdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cNR2Q2LRWgaClGZmC/QBZSRt/yRI3CFTgvSNmVvk/OXi3k6GKri0mJwtLmIxh4KQPgre3DE3Hh3rOzFGym823glXQjxqh5pQT1YUp57UBSDwGSaC5V2MTQ1Wi3vavzsBys1hTtLx/DQgRv8jH5mSdO+VEeU6KtbC4rfaog8/vBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iS+YhAiZ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iS+YhAiZ"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41553f150b9so559525e9.1
        for <git@vger.kernel.org>; Fri, 29 Mar 2024 04:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711712279; x=1712317079; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OvbUYn7plc73KSSN60tk//CFC3EqNv0IenpNwI8CcAc=;
        b=iS+YhAiZI6y4zKJRS5fhmjkofuIHA375Ft3tZQn0A8g3EX3q7/4ukYQnwT7CYEdzlH
         3pbez1r5Yxnj3aKRUGDJzyAdLcMG2XD5KgFv9TO5QFth0X5I64U291wRsIg0wQZEftbk
         JpQMB/oVV2n7Wr6mxkCqB3N8rO9hxA5xGgs8Xh4tH5NRL0EF0Iw/zBs56vskOKtdAtoU
         lg3ZNy2yEctKr0yG7XSh7Euw4oEYnS5QQhioHjMoSYmSXnodsjewwJv357fDafpkx6RC
         GhSmCaZJHEDCJkGsAa/CSChgycudzVbnYHEx5B4ibIo+8EgsDUn2PivsUlUAQH0vfUfs
         YRrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711712279; x=1712317079;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OvbUYn7plc73KSSN60tk//CFC3EqNv0IenpNwI8CcAc=;
        b=kkqLTnY6VMi+BlVm5ZEv2XSO0l/m5Se1KQPXyBwCPWPmqebDiMEcbGJCDVTwHEr+IQ
         DQp7lbovZjCVHO7vgePGfn05htPmVMyKF9wTDNkpXCJPZmj8VT752jH29YGajQV0wuyw
         y8vPEACtCuiyF7ywGWyDtPkcoC8YWLZJB+2AFrwoMWp3JeG6Whc3/nj29s/tglhVblFA
         pdBGojG1YMbpod9oXZ2ueU14fkY4QjnhklpICTqNzIIRHpYtag/BReTwRzRj50KadZpT
         M7MGRSaf8ByJIkrmI9kPZQ6UDkFgmzScnvLZcmm1vDCyXgJ8rBipaM4xHzOty4rj3HHb
         NFhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkXp4SldyPMfQPYAxxQcofzmgl2ZLLYJrpXoP6GDezdlvB5hwrgTTBMU/d6nXe9m+AjE6Dgt4edH1Bdo1drKKuQlx5
X-Gm-Message-State: AOJu0YyaG5fsmxg6XOqZlszGnSTJicxwJ6Ff2fpyzd+zjViuHJ8kcY6/
	UVDSxiXxOohXeoNwtDsSaTQmA+918YlubOXtpeyPCj9Qs9QxlSEg
X-Google-Smtp-Source: AGHT+IF2oV/llRSQPxfOOSS5V2yluNO4WPkiPPrIYD6EWF1/Y38JjOFAMyPeqwEjke0LGFylzRM2Qg==
X-Received: by 2002:a05:600c:3ba7:b0:414:286:fd21 with SMTP id n39-20020a05600c3ba700b004140286fd21mr1680759wms.28.1711712278758;
        Fri, 29 Mar 2024 04:37:58 -0700 (PDT)
Received: from gmail.com (118.red-88-14-46.dynamicip.rima-tde.net. [88.14.46.118])
        by smtp.gmail.com with ESMTPSA id t14-20020a05600c450e00b004148b9272a7sm5221038wmo.0.2024.03.29.04.37.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Mar 2024 04:37:58 -0700 (PDT)
Message-ID: <05d295d7-8db1-4d07-87ea-db8725cbf5af@gmail.com>
Date: Fri, 29 Mar 2024 12:37:52 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] add-patch: do not print hunks repeatedly
Content-Language: en-US
To: phillip.wood@dunelm.org.uk, Git List <git@vger.kernel.org>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>
References: <2c99dee8-fa6b-4f4f-93b4-3f7a8e0901f9@gmail.com>
 <6f2ed406-2152-476b-b463-3010afe7e11e@gmail.com>
 <60d978d0-f69a-4b65-b4ba-d30dac8f112a@gmail.com>
 <a9c515fe-6664-4b5d-abca-d88fdd32a883@gmail.com>
 <1f737f82-9bc5-43b4-b78b-bf1b4393efc8@gmail.com>
 <11f4cba9-e12e-4804-ac04-259adee4cfae@gmail.com>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <11f4cba9-e12e-4804-ac04-259adee4cfae@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, Mar 29, 2024 at 10:41:05AM +0000, phillip.wood123@gmail.com wrote:
> Hi Rubén
> 
> On 29/03/2024 03:58, Rubén Justo wrote:
> 
> Thanks for re-rolling, this looks pretty good - I've left a couple of small
> comments.
> 
> > @@ -1448,10 +1448,15 @@ static int patch_update_file(struct add_p_state *s,
> >   		strbuf_reset(&s->buf);
> >   		if (file_diff->hunk_nr) {
> > -			render_hunk(s, hunk, 0, colored, &s->buf);
> > -			fputs(s->buf.buf, stdout);
> > +			if (rendered_hunk_index != hunk_index) {
> > +				render_hunk(s, hunk, 0, colored, &s->buf);
> > +				fputs(s->buf.buf, stdout);
> > +
> > +				rendered_hunk_index = hunk_index;
> 
> This line could be grouped with the rest of this block without the blank
> line if you wanted.
> 
> > +			}
> >   			strbuf_reset(&s->buf);
> > +
> 
> I'm not sure what this new blank line is for - previously it was clear that
> the call strbuf_reset() was grouped with the code that then reuses the
> buffer. The rest of the changes look fine

OK.

Junio has already queued this iteration.  I wonder if we could reduce
the noise in the list by squashing:

--- >8 ---
diff --git a/add-patch.c b/add-patch.c
index 5f11692911..778f168298 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1451,12 +1451,10 @@ static int patch_update_file(struct add_p_state *s,
 			if (rendered_hunk_index != hunk_index) {
 				render_hunk(s, hunk, 0, colored, &s->buf);
 				fputs(s->buf.buf, stdout);
-
 				rendered_hunk_index = hunk_index;
 			}
 
 			strbuf_reset(&s->buf);
-
 			if (undecided_previous >= 0) {
 				permitted |= ALLOW_GOTO_PREVIOUS_UNDECIDED_HUNK;
 				strbuf_addstr(&s->buf, ",k");

