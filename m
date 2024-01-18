Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D663218B
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 22:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705616767; cv=none; b=bxC7AMRWKWOoYPkmpEfbuqRur0m7iZFPL8xA1IhhUSOX0lYEBLH6yQDZra2U4nhUdsEVmFIr4TuiRwoiD4Q2Bg5IRg5tHp34ytTRUr79roQ3E6IPr5+8N0O/r7US4WL2seo6FxSIqBbzskZ81NohevMAKJXYvVNMtdui6iSWl78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705616767; c=relaxed/simple;
	bh=tnqxieT1s5J1rcvPEQW4ppOxPrRGvA7XU69sbBdv8tI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DlJbyu/J6g4zdKHXfevyWHkPrtai2/29sLhiQ2bqYs6i+yIRz/uAltx9K9GOC6MuW6QKzqd9Pw46MGUnmfTp4+BFKFj2HKJqBU1PeRjugDitm6GT3CbzVy65fSEWPRggRVV+RMgkrOohSkEtjjGrH9/W9V5KXQDUURbYcB1Ugbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HrDDPSNY; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HrDDPSNY"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5cf555b2a53so1059496a12.1
        for <git@vger.kernel.org>; Thu, 18 Jan 2024 14:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705616765; x=1706221565; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i06dUwAALBOlLUxkn/C0zDywKFyyNpAZ+0akzpnE310=;
        b=HrDDPSNYi2QbYq7SkISz1EFOLdpI1HDZNWQ0MJyQ6lvIlbyRbshjwrjpaZ1RyjPh59
         hhF1+vHIbw0vWucECvtpurs1to4UjxQje2EMloYqIrma+Zz/ubJzaLFp8CHPwo9Vclx+
         FKP9+GNRisM75QGOeXPXJr9C768D5XidNYGGUSwSwPtReReTd0PAomsDEDfSf23OSIpp
         UfWMNk1S4UAXK3i5021WHhW630zZDOApMtr9g/aQd37mPNylQvxcJsfyIv4OW6C1OnPC
         z6qb+5zfL6KoVnssETtW3Z5Y6D6Bpvxp7AOPftcyTRFWNzWdj46dhiBhg/j+RsnPmK8O
         clcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705616765; x=1706221565;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i06dUwAALBOlLUxkn/C0zDywKFyyNpAZ+0akzpnE310=;
        b=vAsw1NIJ63O4Wj2og63HeEqkL2xNtwdX0w+oY+8EFmXEf2NKiFuXWP5nDGUs/Pr259
         3H+zkeePHiqzB+eYm4SJwLFH+HrddCbIgEmfbAZ7CPrLTwMoRWl5eDg8EzezGmRD+LgM
         iogARc1ySKbIZHGy7cngyQXhV5PJ4Vjd3TnvVroLJC15j1Hmpbp053DsNbu2FDOy7Tz1
         mNlxu6fb0IKqyeb5QFt5bJbKL9BmlJQizVSHCrC61MLDA9MMkt5n+UgGVFdJQofQkV2H
         Ut9Ow9CgjsAjkWT38Z7rXiMYtib77h1xsnUluenspOOLTJ9092lE0zzcWwr/7GE2vEVu
         2B5g==
X-Gm-Message-State: AOJu0YzJT3hY/+EQ9guKJtdQham+81WnpgcTUFPONZbck1qcNqPUltn0
	TuSzrimbafk8288Az81wndBnh4ZE9kXe1ITof5/NsPGH9VVdH5QmEXlvk4J1rfY2jgTkdFiZUy2
	VDg==
X-Google-Smtp-Source: AGHT+IFcSROZuz70yR924OrwdM+BwFYfzbORSHIXjbd8zKkeWCMjFLrrUI++QZsd2k31d50kIyqKOPu3qtQ=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a17:90a:d481:b0:290:415d:9215 with SMTP id
 s1-20020a17090ad48100b00290415d9215mr428pju.0.1705616765219; Thu, 18 Jan 2024
 14:26:05 -0800 (PST)
Date: Thu, 18 Jan 2024 14:26:03 -0800
In-Reply-To: <CANYiYbFOa-E8Pivhgn_nmy982fn7VPtb803bewnC_UV7qY3xcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1696432593.git.zhiyou.jx@alibaba-inc.com>
 <cover.1702562879.git.zhiyou.jx@alibaba-inc.com> <d343585cb5e696f521c2ee1dd6c0f0c2d86de113.1702562879.git.zhiyou.jx@alibaba-inc.com>
 <owlyy1cvhua5.fsf@fine.c.googlers.com> <CANYiYbFOa-E8Pivhgn_nmy982fn7VPtb803bewnC_UV7qY3xcw@mail.gmail.com>
Message-ID: <owly1qaei8hw.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v4 1/4] transport-helper: no connection restriction in connect_helper
From: Linus Arver <linusa@google.com>
To: Jiang Xin <worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>, 
	Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"

Jiang Xin <worldhello.net@gmail.com> writes:

>> > Remove the restriction in the "connect_helper()" function and give the
>> > function "process_connect_service()" the opportunity to establish a
>> > connection using ".connect" or ".stateless_connect" for protocol v2. So
>> > we can connect with a stateless-rpc and do something useful. E.g., in a
>> > later commit, implements remote archive for a repository over HTTP
>> > protocol.
>> >
>> > Helped-by: Junio C Hamano <gitster@pobox.com>
>> > Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>> > ---
>> >  transport-helper.c | 2 --
>> >  1 file changed, 2 deletions(-)
>> >
>> > diff --git a/transport-helper.c b/transport-helper.c
>> > index 49811ef176..2e127d24a5 100644
>> > --- a/transport-helper.c
>> > +++ b/transport-helper.c
>> > @@ -662,8 +662,6 @@ static int connect_helper(struct transport *transport, const char *name,
>> >
>> >       /* Get_helper so connect is inited. */
>> >       get_helper(transport);
>> > -     if (!data->connect)
>> > -             die(_("operation not supported by protocol"));
>>
>> Should we still terminate early here if both data->connect and
>> data->stateless_connect are not truthy? It would save a few CPU cycles,
>> but even better, remain true to the the original intent of the code.
>> Maybe there was a really good reason to terminate early here that we're
>> not aware of?
>>
>
> It's not necessary to check data->connect here, because it will
> terminate if fail to connect by calling the function
> "process_connect_service()".

In the process_connect_service() we have

    if (data->connect) {
       ...
    } else if (data->stateless_connect && ...) {
       ...
    }

    strbuf_release(&cmdbuf);
    return ret;

and so if both data->connect and data->stateless_connect are false, that
function could silently do nothing. IOW that function expects the
connection type to be guaranteed to be set, so it makes sense to check
for the correctness of this in the connect_helper().

>> But also, what about the case where both are enabled? Should we print an
>> error message? (Maybe this concern is outside the scope of this series?)
>
> In the function "process_connect_service()", we can see that "connect"
> has a higher priority than "stateless-connect".

What I mean is, does it make sense for connect_helper() to recognize
invalid or possibly buggy states? IOW, is having both data->connect and
data->stateless_connect enabled a bug? If we only ever set one or the
other (we treat them as mutually exclusive) elsewhere in the codebase,
and if we are doing the sort of "correctness" check in the
connect_helper(), then it makes sense to detect that both are set and
print an error or warning (as a programmer bug).
