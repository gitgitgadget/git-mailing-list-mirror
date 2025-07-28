Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6AE86338
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 20:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753733984; cv=none; b=O332hE+j47YwsM7/YlC6lE+uoH+KP268WucESfKarx80xNqQbpOgHcYi0XUUTzlvcYuilzrFV9YYe8qYPDcaqs4bB1zeXjI4QIxbLcq/vZmQsBnvXU+A80C1pCyXqi/cUmOKPxt6x7TCb/kuCE6ArlHesDGYIIRbWlski1/SfHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753733984; c=relaxed/simple;
	bh=mBdD2kgdU9hSKCqqTmU+xdj+vYHz+SvcsaGWBzS6s2I=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h6B7uRdTGsnoG6q9wMWZOgvqoLvfTE2LrNq/mGTaMk9ldQ/wh8GeLlx62mzhXUJBqUyos9/RCfGtka592ra4q0J9Xtw4jcPL0hfelluWQOSxHZlghsO9yFqjTkW33nizrIXKU3LiA35p2+kNJZrJC4ja8dOXeL1vZvtuOaYHzyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUeXO1Un; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUeXO1Un"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-886c8de5d90so916310241.0
        for <git@vger.kernel.org>; Mon, 28 Jul 2025 13:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753733981; x=1754338781; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=mBdD2kgdU9hSKCqqTmU+xdj+vYHz+SvcsaGWBzS6s2I=;
        b=KUeXO1UnC2jEdfGgucedDBuPhEhTmZBZ/uFWIkoBe//Q9hFJZnJaawTpB1Kn1gVMuH
         rrlU7og0gD4t6sulonqR+1WMxubgiDD5pNGlyQpS8HZFXrV3qUCM2n3hfCPGfw+M6VA1
         EcTAkJh1U6yQ6n2tJO9b4WdxONI5tICjOvWO8eXYUUXhmaIG4jxzMcL2IXaDusx4cgVC
         3A2uC/Id9u8SJFSaDOdcPY7GHGAyoZ2/M+2Pmnf+nVw1rDClUd9ORDgiGEGIxOD3LOHS
         zx6ladcJQu+pJxk6QwnLo6GnRVnQ4iUTnrGU8N/x0JDa2/GfHiv8+BkYUnzFKsvTMrwv
         u9AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753733981; x=1754338781;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mBdD2kgdU9hSKCqqTmU+xdj+vYHz+SvcsaGWBzS6s2I=;
        b=vIs46TEYzXdXCet7quB1SUKgfm6xeXEGMimhtFsPicTCSilEf8dRh1BKvH6ZAVQU7u
         W6z7Ys/+Y+/8prtDoEvnEi5RZMfX+28VtUXlgEzYFsQT8ybbnUYHJfYlqqnHs33JWwz9
         CuVQyBPQ/JcOZHU/dTj2ruKBWO1SRN5BvqXauNPnzSHgCIv3TzTl3DXiMaQMXx+uVCZg
         pKAd2UmeWACTHASgqw2U5bycN6lUC16At5XxHmYjgJJ3aeOq62HnOfqWDTlMPKQxVvQo
         11y3OuKGVOIhMEzNHu+g+0nMZLrovSnG0rCfyCcJfyrqsbu35W+S7dZpl6vELfo6HgJv
         KaiA==
X-Gm-Message-State: AOJu0Yx3oJtKwS6L7E7tuAOqtGfS3bbApcjYTMbx9ZElTuW57+7Y59xv
	V5mGBNtM3EU8+29zGlK45yw42zrLUUo0vuDP5LBD4RviREmjd3s79q50fFTUz4a0X4yLeCX3OtC
	RjAmdvkSTjtgybbAacKXqNSnHT0KNsBgsmWPQ
X-Gm-Gg: ASbGncs/gyHt9oy9qlPkRWCSv5LzQpDabIIs3imTD5ptGLX4jrDvGVd1BPiRJXaBGGH
	iE1G2jd+F/tmblCEU5Q+gXADUZRqxZjp3yGdfAnQYXqgvK5sR4ch/nc82MWQoQEBnpMwua4uYAI
	SPflwZkAdX5zlGI3bE354wdpolft3XRtvpEXaI/dnf4rDv8/gWc2iKokKTyJpuWBIYeURugc9oz
	BOAkmk/AKEPT/g5blPabcCxQGpNCTZE3qQypQ0Wf6NGPt2QUYBo
X-Google-Smtp-Source: AGHT+IE/Sy6ZnQfHYn6wJ6QulNgcsMjWu+OK5wnj8VvIfZpOjsvWYO6gDBE07/DYKYhDtmaVSldC1qcNy5dYgZbJkeU=
X-Received: by 2002:a05:6102:6882:b0:4e9:8f71:bd6e with SMTP id
 ada2fe7eead31-4fa3f8f1c7bmr5985696137.0.1753733981629; Mon, 28 Jul 2025
 13:19:41 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Jul 2025 13:19:41 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Jul 2025 13:19:41 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqo6t9xlr8.fsf@gitster.g>
References: <20250724-kn-small-cleanups-v1-0-0c70f591de3e@gmail.com>
 <20250724-kn-small-cleanups-v1-2-0c70f591de3e@gmail.com> <xmqqy0sdh529.fsf@gitster.g>
 <CAOLa=ZRvyBK9vVz4+OhLUgAyktdVTb44VC=e8KQNB6BszJ0ixA@mail.gmail.com> <xmqqo6t9xlr8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 28 Jul 2025 13:19:41 -0700
X-Gm-Features: Ac12FXzkb7MPtNjJtBaqQykPjqswhFOccTcaxGvaQy_AoCCBBTgUyq1mU96-QhY
Message-ID: <CAOLa=ZRTL-V6nmRv4HM8LWu3q52V4Exf50KpF8AHt+hoV4n9Mg@mail.gmail.com>
Subject: Re: [PATCH 2/5] for-each-ref: fix documentation argument ordering
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000018a33063b030381"

--000000000000018a33063b030381
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Indeed, I blotched it up somehow. Will add it locally and wait a ~day
>> before sending in a new version.
>
> Hopefully no need, as I've tweaked a bit locally while queuing.

Thanks, but since Patrick also pointed out about the 'synopsis' block,
I'll send in a new version with the fix.

--000000000000018a33063b030381
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d187041b34541aa6_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1pSDIxc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM1FnQy85YmhaQzB4YWVxZk1zdkxnRDhPRzMxeEl2WApCRFNzZXo5dTVY
eEFwejdPYzNYRS9aTGp5Wk9xaHlwZ21yS2QrVzlqd0ZGZ21BUnhsY0w1akFRSjlHYWxlRFVlCm0v
aFp1SDIwSEJjbFo0c01IYk5WMXZCR1J1eWpzNkRNcXcrV1NzbVJGeW5DWmJsOUp4dFBRUjJNOHRM
MHlZdmEKbTFpT0VJZndCQXBrYWw4NndxVGVlcExLRHRhclhxWkdHaThvMW9qOHFqdHdRb1VtcWpw
N3BXWmlqRGdoeFdVTQpnUms1YnVVRzkyR3B0cjR0YS9ZZ1ZZNlVlNTIrM1JwSVc1NERKTytYaEJC
TnltRlJkNWgrNkg4eTF6U2tkcnhJCkZpUGpNKysxY3hWZnVDVGJKSkxsazA0S3J6TWJFOEZRUGgv
R2RqVjBvMFRZMy9DSlVkSCtFb1gxMkhOeG43TW0KakhValI0M2dScWhoMng5bHdmQ0J0cGJrZWZH
a0VEZHZBeFNYZjh1V0Q0NlVEdzc1THUzMXVFN3RGYWNUTFg1OQowNGJpcUFkTnVWTkVPU3hYdVZJ
MEg5bEQ2ODBCNTlLTEkyUkVCMkgrMHhrK00rU1h4VkNWeEZXV1h0RVdEODJoClpIMGNpZHBVNHg0
Q0gyeVRMbTZDdzNiMHZLZmNCbStUSm5jU2ZIYz0KPWFQb3YKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000018a33063b030381--
