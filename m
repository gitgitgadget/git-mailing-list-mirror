Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D1322EE0
	for <git@vger.kernel.org>; Wed, 17 Jan 2024 17:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705513306; cv=none; b=CPWPovF7j3tJxb8yUa7U24C21O3OD96RV9UDT/hXE7aq98cmlidt8Ny/oDLQq+oGRcTcrBBFL614Pn5Z+l8ZaPPCq32FFUlQlYwCBX+78CL89QXhHFnpUENDbTJbIiI6gtpjlNiwXx/N9nWgRTiAUpS9qZGFCLT3gqFnmtDCpWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705513306; c=relaxed/simple;
	bh=tEncVwMr9Zz8O6DT28lZiy5rcCuTyi88OzYWS7BxVJo=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Sender:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=sEZKbNEv5QgVCwj98h/SpEJmnW46GRJNlyN0G23EJfH15GpZC9gUkuJMNf495BYnVQemqOF12kCzpNtkJAzuJus3nXG69ESpdRNW/I9oh1RVlrDSM05Vr0zbR0ZIt40xcGoApG/PCEOfcz9Wrqt/vsSDsMHO677V3t+jwwXz3YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJwAOaKd; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJwAOaKd"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50e80d40a41so14514523e87.1
        for <git@vger.kernel.org>; Wed, 17 Jan 2024 09:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705513303; x=1706118103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sejckkgyn2JIRnQ4PUjMn4awOGM+O123D6XhpQJEcjs=;
        b=HJwAOaKdunKS5v5XSPQLiYd5FijUuAHLkqJ/NSJroEpZCcrJUkAi0kX23pA+uq0Hxe
         2F9xgVzyhb67xUk0jY6b65wNbM/N3V2L6hiJuyPoXr/bXPICk8uoL7lbZcTa9x325Qdb
         qNUr6mf+GpWnPBPgFwnp+Hv3Lt57MznsoKAwHm1QeYCjIP3lnrtbeBTVeQr7txbrV/KW
         X55ldiyBmmSFjgS/qMgRP/2UzM9G44Ftge7TI/uRZ6VjDV0er+TNxp4M1fIBjurpJtRV
         UrGVI6TwhOiXEwkxiXZhNzEdTWi88SLgqOiEan+E5e6O6Yumpgip45hDYFh1Gp8y6Cmt
         WCaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705513303; x=1706118103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sejckkgyn2JIRnQ4PUjMn4awOGM+O123D6XhpQJEcjs=;
        b=Fl6QNuZU5gAyQU3oOiyY4KPN0fdu8Wrij5cT5Nzkb25XYsjIvZ2LgX9Ah7wfgDMZBR
         ihG99jnOKdlsQHUDE9ZMc1wdbofSKYUYFgI1tAw8fwEgVWillAOn8MVb31dJmi4er7ne
         F3tFdyQzF32h6uRaYNqo5gGTk5inPRjLDr/Si0pQHYV40/NyHo9VqimZDDtwIJVkrv8i
         y7FfC7h0uMKp+M2qlQu8XGm4HQQEL5Szp7qC4PLtI/mZSXMLB1K3IBzmfyQ5c4ak0G0Z
         3hsV5zC+Lk5AhwAzv5NoGLIEZ+fVEe+v3ZvFkrjYVoyGTQP5kma89lhYiRKn6554ZnJB
         Dw8w==
X-Gm-Message-State: AOJu0YyVH/lMTFnTJYefwtC3Kdvx2eqse/ZZX+GryvImcjyT2ug2SbjR
	i/uN2V1KtGdUoCv6xUAdHxM=
X-Google-Smtp-Source: AGHT+IG8cfPlq+QihRclU9HdmCYchDWLlccVtfWoNCwEk+emiTAKbB0gQYf6N682bLuCdQA0eY53BA==
X-Received: by 2002:a19:6502:0:b0:50e:9d91:cfb6 with SMTP id z2-20020a196502000000b0050e9d91cfb6mr4470205lfb.123.1705513303063;
        Wed, 17 Jan 2024 09:41:43 -0800 (PST)
Received: from Michaels-MBP.fritz.box (2001-4dd4-dfc5-0-e407-3f73-62bc-9c57.ipv6dyn.netcologne.de. [2001:4dd4:dfc5:0:e407:3f73:62bc:9c57])
        by smtp.gmail.com with ESMTPSA id t10-20020a170906178a00b00a28ba0c3821sm7989104eje.101.2024.01.17.09.41.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 17 Jan 2024 09:41:42 -0800 (PST)
Sender: Michael L <mial.lohmann@gmail.com>
From: Michael Lohmann <mi.al.lohmann@gmail.com>
To: christian.couder@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	j6t@kdbg.org,
	mi.al.lohmann@gmail.com,
	newren@gmail.com,
	phillip.wood123@gmail.com
Subject: Full disclosure
Date: Wed, 17 Jan 2024 18:41:24 +0100
Message-Id: <20240117174125.22915-1-mi.al.lohmann@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <CAP8UFD3g_N+JJ_cdas2ZdsBPxuQFBXW8yY+1nC6AKvQppOYaDw@mail.gmail.com>
References: <CAP8UFD3g_N+JJ_cdas2ZdsBPxuQFBXW8yY+1nC6AKvQppOYaDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Christian!

Yes: I agree that the current state of the last submitted patch in that
discussion is far from optimal.
After Jeff Kings explanation I had a much better understanding for the
situation and the reasoning (and his suggestion was definitely better than
mine).

I had already prepared a new version which tackled (I think) pretty much all of
the criticisms. But then the above mentioned message came in and when I read
this:

> [...] they are trying to be different for the sake of being different, which
> is not a good sign.  I'd want our contributors to be original where being
> original matters more.

I am reading:

1) I am "trying to be different for the sake of being different"
2) Contributors like this are not wanted

So yes, I do understand this as a general statement on me as a contributor
without any proposal for me at least to explain the situation from my side.

I teach my colleges not to name variables with how they are initialized, but
with what information they actually convey and I found the "_NONE" one at least
misleading in its name.

So in the initial discussion I was a bit stubborn, because Philip wrote "I
don't have a strong opinion" and from my perspective the only argument was
"over there we also do it that way" (which _can_ 100% be a valid reason), but
Junio C Hamano did not even acknowledge my criticisms of the other the variable
name. I am totally fine with a decision like this if done consciously, but if I
don't even get an acknowledgement, let alone an explanation, my demands I place
on my code quality are that I write the best code I can. And with all the info
I had (prior to Jeffs message) I did still favour my first suggestion.

In my eyes it would be helpful to at least tell me what your (in my eyes not
obvious) preferences are on naming things, because otherwise I will rather
stick to my standards than blindly follow a single instance of other code where
I don't even know if that was a concious decision or it just happened by
accident.

So no, I don't agree with the assessment of point 1), but I still read the
message like that. I will accept it and instead use my skills in different
projects where they are indeed valued.

Cheers
Michael
