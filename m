Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F91314A636
	for <git@vger.kernel.org>; Thu,  9 May 2024 09:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715248740; cv=none; b=KCwqPBs40i43KzuLodvHFkIOB4ZUMPMk9LyACWpoBqcrBXLtELoYl6NYN3eZvt2qlDuKVwE9qDlbFfVXj1Azah5fFiyhxhUNLWjcqFNXp8AxoHFlIMXjLhkX/M1Gey/6VPkh9s5NyipZdzJ6qz7C45QbqnXgRrV4eVWt85Hgu3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715248740; c=relaxed/simple;
	bh=dV7rSLLAewWFU9IC3Wx+gW3HeQkrQo7bY+3Hnwd10I4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=mXVs0rZ4dQdP2CvYJSDqFMp1zl81g0plo1UfnJFmjiFPEb5MLJ9K9rq3VVezYlXz24m1wJL/iQ/eGu8cj6eQl7m2zJOY3GZ05Ni94x+PjDJhg/HrQwn/HbbA0YRqMwo5f+2Z2w2BpRZvlKgMuU1kiCB4FZydP25k98pPbRuGy1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFC2OhFO; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFC2OhFO"
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-61804067da0so6590547b3.0
        for <git@vger.kernel.org>; Thu, 09 May 2024 02:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715248738; x=1715853538; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fms4SxDNpWP9olieK2SPD4D+Wn3v6CH2YB0AL/jfLwo=;
        b=IFC2OhFOaH7y+KZxzxabbppEmHJyjeejKlGVCBrIZHElj5f4qQhg/2SBgpkNV7Nsg7
         Etlm6a8AhwQnGUC1J5EP0VrMQoTiDtdg+eR0GniL7Z5/xVw6SIp2RA97dzuPk3sRnSAi
         pa6rnV1QmHwOfaawaYibGQiXkzkJnF/LD1KzWHxyJ1v17ixKTaje/o7FEnkiNCHT9BRz
         7buNTElJNo/fQ8zuVVDw/nNF4D+XinyS3ANUWV0Fdmq3Wk9ZZ+xmqPWfxymIsb59/85A
         EfKLl0VffBI7JShPUcJSO8QyKUwpiE/ChQa/SZY1ZROXco9qhlfD/YYjIJRQoXbaPFJu
         423w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715248738; x=1715853538;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fms4SxDNpWP9olieK2SPD4D+Wn3v6CH2YB0AL/jfLwo=;
        b=TLcwBAae4jCU1C3K/HOlHWHotcFK6ov3EeDCOU7mG8OP2FYJlbzCn0CR8V1Js9tRPQ
         1O+LkAzfubWJsu6gz24ylX1I5i6q9a0rNOBbIUsGWyjrOoe3CPBW7kbdPmqZD9PzUHJp
         cAqCcpTs/7A05ov6h5ybk2vV6ud9K+zvBpker5PuYOps/2j2TQ/LShZyFTRAf3nwC7tB
         PE/rgmD4SBThOIZnh3+h8MGgWfa+w5BN6KGlFU6mnPPbh0xTBkICQ9CSat34GcFOgCPg
         mfpCnRhw0sr13e9AdTM3Q7E1CGnX3KuSk8wQ5atpsZC2AGUddUso1hDvwtwkAX6CDb8J
         8s2g==
X-Gm-Message-State: AOJu0YxdlicFh09/p8PH1GP7I9It/m3hR5FcFA8J5dshHGOqjBRAk3ys
	J/SYOsYZwByH8ZDgt7F4EXmcpmgsmrNskdHoEjEqp2FPauq9mupGIcpJ4E3SraT//yD8tnK1+0K
	AyNOkrakw501FBtXXeJTG4KV8pmJ6dwHtJGcfMHlI
X-Google-Smtp-Source: AGHT+IHnOv7gQBwpzERfY1yS1HQCgC6k9B/2YcCPj29yvP4wCxm71Hds9wNSKRZTg4AunT34SaCtCUz21RFPK/QzsRA=
X-Received: by 2002:a05:690c:4a0b:b0:617:c578:332c with SMTP id
 00721157ae682-62085b4834cmr59284307b3.4.1715248738528; Thu, 09 May 2024
 02:58:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?5a6L54+C6I+y?= <skf710559582@gmail.com>
Date: Thu, 9 May 2024 17:58:46 +0800
Message-ID: <CAOd6J=s7XTsL_Le5_7zSePmR2gx0Fkxek+Ko+5wAJaEbXNqXEQ@mail.gmail.com>
Subject: A problem when I use git merge
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello=EF=BC=8CDear Mr. or Ms.=EF=BC=8C

Sorry to bother you by email.  I need your help!

when I use git merge to merge codes, I find codes lost.
The situation is like this=EF=BC=9A A branch called master, another branch
called dev, last branch called feature.
On April 20th=EF=BC=8Cperson A pushed a commit m1 to feature.
On April 26th, branch dev is create from branch master,
On April 30th, another person B pushed a commit m2 to master,
On May 5th, person A used cherry-pick to merge m1 from feature to dev,
On May 7th=EF=BC=8CI merge master to dev=EF=BC=8C but I find conflict codes=
(between m1
and m2) is auto merged without info=EF=BC=88like unmerged paths), m2'codes
covered m1's.
And I want know why m2 is covered without prompt=EF=BC=9F


I had do some try to make a reproduction, but failed. T T

Looking forward to your reply=EF=BC=81


Thanks for your reply!

Best Regards.
