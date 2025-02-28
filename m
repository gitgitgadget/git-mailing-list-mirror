Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FDA23F39A
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 22:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740782580; cv=none; b=WHnp/rig3pa6Oa3FeJKYda3yHeOKDk3loNUHx/d58y+KI7S+mT/pzaQLumC/stmwmBQdv9kfBBMRIp1tIaUNzOCJsvRQ1lltKBtaCS1NnlQI7sNxmW9D/e6xJ3svJw14Ygf1xsJ3yTJVFXkv7IcgnRxTBIi7d/zoI6Dbe/qJ7Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740782580; c=relaxed/simple;
	bh=LjAkiD9L7JNV841zD2Ehqk7RrGltXHwDVA43CFVuWlU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ahWIhYCJv7YEnI5jqJyaTP4TGF0zWSR06o47p7v6825K2XecQFDovVO9B3JtzzRPeMh8MY/BWvl2Dn1DyCKeHBAuJ0KmA1CJNPjdL3gUC1zatnA4ov+4l+Xa7aq7kGU82ZJ2jQ4J8DH+ZeQS8C6EeWOddsIrP3zXEbeRuWjyyJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=29v7DyM1; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="29v7DyM1"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-471fa3b19bcso87751cf.0
        for <git@vger.kernel.org>; Fri, 28 Feb 2025 14:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740782576; x=1741387376; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LjAkiD9L7JNV841zD2Ehqk7RrGltXHwDVA43CFVuWlU=;
        b=29v7DyM1toxLeflENuCDmL8VuNwvUR1OEPlcjDO1HEkVAUKFBwig12XcC6ZoqioUnt
         E86yB1FBxKZsrcO3finQ1O5ootrSO5V8ET2MF4z/bK8Vx2wep2nNvWIcl0Wtyiq7O0dy
         ZyJO9obT3nFZXyJ0jUa4dl8+q7NfSt/DF6P6ZGCqLfPwY4w+XB7MQ5F7F6yGVQCK9Hcf
         HKFKx+UxMqep+/hgQBxpfGGugp5QSS7zoXowktNgpwE95KJAl5YQadhqx2gmkbEBteZ4
         mOXEiWgFvZ4fNhXoNFGYe2lnRCDSJhIMujICSMN1ZXJ86XA/0dE97zKDzWEqs9G96PuD
         mdog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740782576; x=1741387376;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LjAkiD9L7JNV841zD2Ehqk7RrGltXHwDVA43CFVuWlU=;
        b=sZP1FRHNBmurP0n7ZzGnfbsqRuEjY17iho4QgTtz7dmViNodjRTnc/WXKawZ5ekUSd
         66S3ggqyohdTqJBCPAfrGue9AzbjTnWdyy+c5+0Eoo8FGygi5ASuDtfJ985GkYdLsez/
         TvVxfb1xEsOcuyyQHk1k5LWuHOPAMJRHf4vq79i5m9ypV5JtSG/Nvl5sxg4oo8cAnSQR
         ugz+P3P3xzUro3D+kAqwUR7b44O8/09UKwqeH2k7j9/H1QXlSTShmPR+JHgqbYE9/mqC
         +N7RAEDmRnwApuKRuvnoH+XCqw9BEu2jaFOkmq/B/Y6rDjQci0s4KPp/+cMi/0LIzgcG
         0nbA==
X-Gm-Message-State: AOJu0YyJgnHexwuRtVpFgZnCFJYPihedMrBUUEr0nQRBH6XVFeWtDPc7
	J2EIFrkI8UVtmJGbhFPq09nYG76ERKznwlcx1Ey9UCHZO0QLnmqNU4vF2iLX47+cwZQmWTt1MM7
	bumdzpgI8XNuMOsJVl6cyjmlk82X3b3wvw3kXv2ohNo4ctOiVewyt
X-Gm-Gg: ASbGncu9WooRKE1JQlRE+l+6pXh8/D7/CuYbfoKLu3rVOsZjGpOCoeQNY/0iHfKsgDO
	HK+lQ/dXenC2guiUigNJvp4y0To4VF0wvvC3DtAlkK6UkB9dfok7hqKQ3jFqI+gxP+KG8PAKnUU
	BqAmM2vB9SWu/fS4DmQIQTEcoF9ggfuAlKUf0MnBCc+bBz1VxqCHTZt21l
X-Google-Smtp-Source: AGHT+IGxn5OQY4lHFgFH9Bf3t7mjE2UrUPFAz5UrJJVKuQLmyiCmRPjmG1EKl516siZ6ORigvDhbiM5gAzRXZKM5IVc=
X-Received: by 2002:a05:622a:1b89:b0:467:84a1:df08 with SMTP id
 d75a77b69052e-474cd62546emr172451cf.23.1740782575603; Fri, 28 Feb 2025
 14:42:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Emily Shaffer <nasamuffin@google.com>
Date: Fri, 28 Feb 2025 14:42:43 -0800
X-Gm-Features: AQ5f1JqQqlYhhaWa916NX-sIL0DG4poOJTfEFuScrNX2F6XBQCcMnhZsvhigwhM
Message-ID: <CAJoAoZnk88ZFZFdEtUxMnUa1OZiXYOgcw8DSbB+A0LzyCPFugg@mail.gmail.com>
Subject: git-mentoring Google group replacement?
To: Git List <git@vger.kernel.org>
Cc: git-mentoring <git-mentoring@googlegroups.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"

Hi all,

For a few years we've had this git-mentoring@googlegroups.com list,
with the intention to give new or aspiring contributors a lower-stress
place to ask for guidance when they're just getting started in the
project.

The list has very very low activity. I think we get a newbie asking
for help once or twice a year, and they do get responses right away as
far as I can see; but we much more often get spam, spam, and more
spam. We also tend to get spurious content violation reporting - from
bots I guess, or maybe trolls - and these lead to legitimate
conversations being deleted from the archive. This happened a couple
weeks ago and we lost all conversations but 2. There doesn't appear to
be any way in Google Groups to appeal these decisions - the
notification email that was sent to the list owners simply suggests
that we...get a lawyer?[1] We had a similar takedown last year or so,
and I tried to escalate using Google's internal ticketing for
employees, and didn't get very far there either.

Because it's not possible for us to push back on these takedowns, I
think it's time for us to seek an alternative and shut down the Google
Groups list.

Dscho proposed shutting down the Google Groups and having people ask
in the Discord chat instead. I think it's reasonable; we've had a few
newbies asking for contribution advice there and they get answers just
as quickly, and we get a bit more moderation control. Discord is still
not scrapable by web crawlers (which is one thing that was appealing
to us about a closed Google Group). It does require account creation
to post, but of course we still have git@vger, which does not; this
mentoring-specific channel/list is supposed to just be an alternative
for the especially shy.

Thoughts? Alternate suggestions? I'd also be happy to host a list with
some other service, but I don't have any personal experience on which
services are good to use or not.

 - Emily

1: Here's a sample of the takedown message from Feb 16, 2025; because
the content was down, the link helpfully does not point to any actual
content. I have no idea which mail was actually taken down, because
there's not a good way to translate from Groups URL to Message-Id as
far as I can tell.

Hello emilyshaffer@google.com,

We're letting you know that we've permanently removed the content at
https://groups.google.com/d/msg/git-mentoring/mPiraiIITXI/cdsNx2elAgAJ

Why did this happen?

An external report flagged the content for illegal content or policy
violations. As a result, our legal content and policy standards team
removed the content for the following reason: unwanted content.

Learn more

You can learn more about our content policies and enforcement at our
help center.

What you can do next

You may have the option to pursue your claims in court. If you have
legal questions or wish to examine legal options that may be available
to you, you may want to consult with your own legal counsel.
