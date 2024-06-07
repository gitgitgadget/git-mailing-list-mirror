Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2101C1552EB
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 20:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717793578; cv=none; b=M0ukZtCHRz2UjWfcGhq5Qoqq/yLmhTxhDNzo5Q5S6F+7HywY4WVkJ6kI2fK/PMGz0QJbLersonViVE173GvTObQycQtCbTZTJFU/3mbyUwpiTEYM3MBo3LA6Cno9PHvxG4p45YXBDEEQXIwI1YxNYVAQvwGJKQMdz24eKIvc5og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717793578; c=relaxed/simple;
	bh=QpdGtkN3M34BRFWYOyydhXLAQO+Ir90O4Kf+alBg9OE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=a7nxAqZAS0TJ6rErE54V2U/76Ndh3p6olsKhvnXR3DrVSxkQC3zVPUlp7N9/BKobu5aWs8DDfraskjWaAuQ92xUNWRluMuq//eO8jg9qLAuhY7qxepUf2+eyxruST8TS4XV0uTbfxwBiXlzcRxuXxvVEmLC3Q0Qtt0Gq2xZLSW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bv6bpN/g; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bv6bpN/g"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4217a96de38so2031005e9.1
        for <git@vger.kernel.org>; Fri, 07 Jun 2024 13:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717793575; x=1718398375; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NFZv8kR9UNHd/SoNRivqxF8RFWCjX0h6LkdA0m5f4JE=;
        b=Bv6bpN/ghovDJUApXGvb957OTgE5Leu6lAbYToARBso+3ccz/Z7forDskrtk8iw+Nr
         OLV9n3qjRoPf1JZO8v+6iobgBeqMRMPdSZpbY4hGg0ouWxtAZTpHIFpthdBa0PqEE91G
         GY/Vf27uveVUwru8CjL4WX/36KaK++KolpmlH9au1OU4VWUBz5UFBAt4JLX2Xkt+/Jn8
         4GJk7NZ6Zj5Jd3DW51AE/zZuq2hqoctBnwjp2oLx6HcFh+7Hj8gxdbdtLTyHeHqvM4Hm
         N8D8M8Rjkg6ffSNfBzNbKm0LXE4pwvV2ZD3qxNv2kKqWdx1SE6ip2BfDgjcYYBm8yeL6
         zQ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717793575; x=1718398375;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NFZv8kR9UNHd/SoNRivqxF8RFWCjX0h6LkdA0m5f4JE=;
        b=Ls2sAoRtjBCtGGJ+g/kK/9WTMe6Qe6PEB1fA69YdFLYbyfJK/3T/m1EK6C2Qat/Ccl
         vydmVIEfKmiqoJvqUPBMvLlnCP0UIQ4eQxzc7lKobLD8yghnjRb9w1bHvNViOZ5ylvuz
         z7ZAc5eY0FMqpqxJjEH+MNhUQHXhIzJJ0fX5qgt3faNxjdURo+evOrepS0Va2TlBluoK
         APX22gVVeRwTv6oo4nRrra8kwLNkKWMPtLXmHO0x2oMeIDlEsMtIF0oA65Mg9ZmZR/D4
         7XjGprOV+L74uTpk606j02+tuiHMD3tl6mNXW74n6cQP1EqOkQqxx8fNxs/P9NnveJDR
         L7VA==
X-Gm-Message-State: AOJu0YwyrAetHgP1hBZrjpuGVfUlQBsn1D1zPkDrzbWQNdVzK3plk7g3
	x6AeMWmpzJWdotIuc5r8OEXnAl3bFqY2QU+uNYeweWA5Nxy4DyUEkzFDtA==
X-Google-Smtp-Source: AGHT+IG0jqcIWV03XbfgnBX6Hxq8G70lPw0sqX6MBg8nlaLdKM3aUDBXlxzDQrfLDcv0pYgLxxHilQ==
X-Received: by 2002:a05:600c:35d3:b0:421:2049:5d66 with SMTP id 5b1f17b1804b1-42164a06c82mr28812825e9.21.1717793575233;
        Fri, 07 Jun 2024 13:52:55 -0700 (PDT)
Received: from gmail.com (218.red-88-14-51.dynamicip.rima-tde.net. [88.14.51.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c19e57dsm63257925e9.9.2024.06.07.13.52.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 13:52:54 -0700 (PDT)
Message-ID: <91014071-13f2-46d3-aae7-75c8ea036786@gmail.com>
Date: Fri, 7 Jun 2024 22:52:53 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v5 0/2] format-patch: assume --cover-letter for diff in
 multi-patch series
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>
References: <6269eed5-f1ff-43f3-9249-d6a0f1852a6c@gmail.com>
 <14365d68-ed04-44fe-823b-a3959626684e@gmail.com>
 <cb6b6d54-959f-477d-83e5-027c81ae85de@gmail.com>
 <9f520828-f87e-49b1-aa4b-c00ec6bb0133@gmail.com>
Content-Language: en-US
In-Reply-To: <9f520828-f87e-49b1-aa4b-c00ec6bb0133@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This iteration fixes some tests introduced in the previous iteration.


Rubén Justo (2):
  t4014: cleanups in a few tests
  format-patch: assume --cover-letter for diff in multi-patch series

 builtin/log.c           |  2 ++
 t/t3206-range-diff.sh   | 14 ++++++++++++++
 t/t4014-format-patch.sh | 25 ++++++++++++++++++++-----
 3 files changed, 36 insertions(+), 5 deletions(-)

And here is the result of a `--range-diff` from the previous iteration,
that implicitly produced the current cover-letter :-)

Range-diff against v4:
1:  678bae2e42 ! 1:  1dbfce39d9 t4014: cleanups in a few tests
    @@ t/t4014-format-patch.sh: test_expect_success 'format-patch --notes --signoff' '
      '
      
      test_expect_success 'format-patch notes output control' '
    -+	test_when_finished "git notes remove HEAD" &&
    ++	test_when_finished "git notes remove HEAD || :" &&
      	git notes add -m "notes config message" HEAD &&
     -	test_when_finished git notes remove HEAD &&
      
    @@ t/t4014-format-patch.sh: test_expect_success 'format-patch notes output control'
      
      test_expect_success 'format-patch with multiple notes refs' '
     +	test_when_finished "git notes --ref note1 remove HEAD;
    -+			    git notes --ref note2 remove HEAD" &&
    ++			    git notes --ref note2 remove HEAD || :" &&
      	git notes --ref note1 add -m "this is note 1" HEAD &&
     -	test_when_finished git notes --ref note1 remove HEAD &&
      	git notes --ref note2 add -m "this is note 2" HEAD &&
    @@ t/t4014-format-patch.sh: test_expect_success 'format-patch with multiple notes r
      	test_when_finished "test_unconfig format.notes" &&
      
     +	test_when_finished "git notes --ref note1 remove HEAD;
    -+			    git notes --ref note2 remove HEAD" &&
    ++			    git notes --ref note2 remove HEAD || :" &&
      	git notes --ref note1 add -m "this is note 1" HEAD &&
     -	test_when_finished git notes --ref note1 remove HEAD &&
      	git notes --ref note2 add -m "this is note 2" HEAD &&
2:  7d3afe14a7 = 2:  fa22af3ed5 format-patch: assume --cover-letter for diff in multi-patch series
-- 
2.45.2.23.gd1e9f8561b
