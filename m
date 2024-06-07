Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E2433C0
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 17:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717781909; cv=none; b=s8XKbfETLX11r7/mIb9e5Fd63Su1ZIvu2qkWomZltBv3Z7v9zJpk/nB39HrIXNiOQS8U9rRb46mpMVUtAE4R+YZ29ZFN+NJUbTkZQ1p7DonV1Z181nOWbZJPUWwSUfsMFNXkxpMDbdPIn1/jWZe7r+uNYAXsdbwqFRxOgL/Ps0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717781909; c=relaxed/simple;
	bh=/3bN3MAwBDb8BavaWayZJprvGNpSQB4Qp499cC2cJXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mGyxbMsePy5r2VJS5g3FwfDiByIfGdeKqgTLB8aghAziNaR6oyTYyxaXEypZV/2iQfT2m71EWv/vcagE99FkHqkfhaKOt5dBX/g9NUVKYyUil4GVeLPqp+DHaBO8ky+lliROIPGUhY/ozsGR4VC+zA4hg9JymZwmKrtD/DwMSL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HK47yh3E; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HK47yh3E"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42163fed884so12674955e9.1
        for <git@vger.kernel.org>; Fri, 07 Jun 2024 10:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717781906; x=1718386706; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AGErjYpJnVm5BMiaf5qzkhLnyWr+XUGPsTNxL8aXHy0=;
        b=HK47yh3ET1HFvszeDhGEnsPKGhWqPw4jPXuJp8xhjXcE4Xs/lLOXSctVFnz5IXOIwH
         poUJ5xmJbV5zj+6IFb5B/mEO0G1u1W1yaq98N0G1u2azxRpj//UxG3LQWmjRaCuhNDiv
         9dAxfFEMjyXWx8+sv+NCBb1NB4gfjpH+4LcgDSjtx73ghaPeCaq6clqLCsp+c+Crjxm3
         dwgEoVC1SAVyVgShhYXzioZopzMHx/4pT5L4/ANrrxzNYzT+RRfWAVzILg3ih4eyWJce
         03WV4RCjLThnYFOzrVpqnyQtN2L+urQpZfed7bFIMCDWSyvftws9g3vc3KHaPI6IKfuM
         E5bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717781906; x=1718386706;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AGErjYpJnVm5BMiaf5qzkhLnyWr+XUGPsTNxL8aXHy0=;
        b=gNCo7aUtoCaIo0Q8+g/xer4ggsFXjZu5CX1/PAM5lOJlR3nMPy2n+FBrvkQIql/R30
         PXILFZ3xhh+gSs1Ho4Bel+AqEpoG3UPy9EegvikZlJWvuN2KVZHJgi9Fh1p/NSK6qFKE
         /EiUAzEf9Pt1RnrTGxi4NTjXKXtuBBDcdoIBqH1fhKtx7i5ZNNgq9JrDBR0BYVB28Z/h
         db2Z56Ys8DnRnDsc3/c4boi36qY5a+G6hJQjqkhGqehmsMrqFExDO6k46nf/naaJ8rdM
         0jfoPD7mDBlU8YJWAsNx3TiuIMFUywdGGaYdNhTLjEBLFlC2edr41o9f7Cy6M9HXdOt3
         K9xA==
X-Gm-Message-State: AOJu0YxI33eQ4JFMqDzjjleq1xvUrp2D3UNFPlR7Ilaojh7fgHANcWNM
	B9gB0S3S3e8k/tmEGCe2grTyQsSnQj/k+uBU9lGS/DwW3SOgvRz0
X-Google-Smtp-Source: AGHT+IHuSDGS2OWH93keKIHJGSwvwcUOuC48vHjG4hw60isBJKxQwwal8zye+jp8ywapJ1VxrXSBdw==
X-Received: by 2002:a05:600c:4ec9:b0:41a:821b:37f7 with SMTP id 5b1f17b1804b1-42164a328a6mr21881925e9.27.1717781906070;
        Fri, 07 Jun 2024 10:38:26 -0700 (PDT)
Received: from gmail.com (200.red-88-14-44.dynamicip.rima-tde.net. [88.14.44.200])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421791b1ea9sm6657425e9.21.2024.06.07.10.38.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 10:38:25 -0700 (PDT)
Message-ID: <de9d8f38-6e4c-43d4-acc4-a38e860787a7@gmail.com>
Date: Fri, 7 Jun 2024 19:38:25 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] t4014: cleanups in a few tests
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>
References: <6269eed5-f1ff-43f3-9249-d6a0f1852a6c@gmail.com>
 <14365d68-ed04-44fe-823b-a3959626684e@gmail.com>
 <cb6b6d54-959f-477d-83e5-027c81ae85de@gmail.com>
 <9f520828-f87e-49b1-aa4b-c00ec6bb0133@gmail.com>
 <20b95372-12cf-49bd-b1b7-dc069e7c86dd@gmail.com> <xmqqed98ekv1.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqed98ekv1.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, Jun 07, 2024 at 10:14:10AM -0700, Junio C Hamano wrote:
> Rubén Justo <rjusto@gmail.com> writes:
> 
> > Arrange things we are going to create to be removed at end, and then
> > start creating them.  That way, we will clean them up even if we fail
> > after creating some but before the end of the command.
> >
> > Signed-off-by: Rubén Justo <rjusto@gmail.com>
> > ---
> >  t/t4014-format-patch.sh | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> > index e37a1411ee..5fb5250df4 100755
> > --- a/t/t4014-format-patch.sh
> > +++ b/t/t4014-format-patch.sh
> > @@ -820,8 +820,8 @@ test_expect_success 'format-patch --notes --signoff' '
> >  '
> >  
> >  test_expect_success 'format-patch notes output control' '
> > +	test_when_finished "git notes remove HEAD" &&
> >  	git notes add -m "notes config message" HEAD &&
> > -	test_when_finished git notes remove HEAD &&
> 
> If "notes add" fails to create a note for HEAD, test_when_finished
> would notice that it cannot remove a note from HEAD, wouldn't it?

Yep.  Something like this, no?

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index de9e8455b3..1088c435e0 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -820,7 +820,7 @@ test_expect_success 'format-patch --notes --signoff' '
 '
 
 test_expect_success 'format-patch notes output control' '
-       test_when_finished "git notes remove HEAD" &&
+       test_when_finished "git notes remove HEAD || :" &&
        git notes add -m "notes config message" HEAD &&
 
        git format-patch -1 --stdout >out &&
@@ -849,7 +849,7 @@ test_expect_success 'format-patch notes output control' '
 
 test_expect_success 'format-patch with multiple notes refs' '
        test_when_finished "git notes --ref note1 remove HEAD;
-                           git notes --ref note2 remove HEAD" &&
+                           git notes --ref note2 remove HEAD || :" &&
        git notes --ref note1 add -m "this is note 1" HEAD &&
        git notes --ref note2 add -m "this is note 2" HEAD &&
 
@@ -893,7 +893,7 @@ test_expect_success 'format-patch with multiple notes refs in config' '
        test_when_finished "test_unconfig format.notes" &&
 
        test_when_finished "git notes --ref note1 remove HEAD;
-                           git notes --ref note2 remove HEAD" &&
+                           git notes --ref note2 remove HEAD || :" &&
        git notes --ref note1 add -m "this is note 1" HEAD &&
        git notes --ref note2 add -m "this is note 2" HEAD &&

> If you do
> 
>                 ! grep "notes config message" out &&
>                 git format-patch -1 --stdout --no-notes --notes >out &&
>         -	grep "notes config message" out
>         +	grep "notes config message" out &&
>         +	git notes remove HEAD
>          '
> 
> at the end of this passing test to remove the note from HEAD (so
> that when-finished handler has nothing to remove), and run "sh
> t4014-format-patch.sh -i -v", this test piece 4014.70 fails with
> 
> 	...
>             notes config message
>         Removing note for object HEAD
>         Object HEAD has no note
>         not ok 70 - format-patch notes output control
> 
> A failure in the when-finished handler is noticed (which we might
> argue is a misfeature)

Dropping it doesn't seem like something to be strongly opposed to :-)

> , and that is why it is a good idea to write
> 
> 	test_when_finished 'rm -f cruft-that-may-be-created' &&
> 	do what might create cruft-that-may-be-created
> 
> with "-f".
> 
> A standard trick can be found in the output of
> 
> 	$ git grep 'finished.*|| *:' t/
> 
> Thanks.

Thank you.
