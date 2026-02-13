Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F81C34D4F3
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 13:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770990168; cv=none; b=FrGl8rk9lIrcxNHzzPfNY3Ju5+4lj1a6GJZpFzgteuKCD97s4mhDVHeudJpRxmUnX5aZgx0BSQadNrHnkuysxp7kmWipC9/0FUIjdmnahnnDpZxzGFBLjGB4O1hVnZKHjAf3t/9q4/t4ENhW242BNvfohX9Pe3SLYsINGVr5JnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770990168; c=relaxed/simple;
	bh=Oc/ih6vJttcAXsOKVwV3jo57cdmrXej+Id/ffr5u0HI=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=srBZhHIn57uz4o5wm2vqkcOrtbrhNZwcgVUkOf3jIwhZAAr9k+I7K8zK2x9Dr9XcH/ZIO4isiEvjhXcMKyiqdOpn/t20oiuiZ6yTTupYflyoCwRVqekXrgXxWRxrF/kWG8gAPJQ7cpBSh3FzHJyiemZQzY03Elzf9v8ep6b/2zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nkXcYnfH; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkXcYnfH"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-797a52d8c34so3880207b3.2
        for <git@vger.kernel.org>; Fri, 13 Feb 2026 05:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770990166; x=1771594966; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MLAB9ar9FTsOoxJKAi0y+1h2rZ6FunvHhYJGv3UYmJw=;
        b=nkXcYnfHpWUv2Sf4AgXEMgUJxF6Ju5Qr50rcif07nlunB0/ZIzXc0g9oV6iL8RvwOV
         9+iHznLLBzNdVIOT+NkPZke3SXbTG6IcqHPo/Ni2VQgurkyC+hJEdUwWHkcgn8Gu34vN
         Xq8avfo0wMMXoiUn4ge5qoEDzlGkypLH9krw91LfuZCyJOEJTqFcn63P/OwMpTJdr5bo
         6jX5P0k9PIpihE2bw3bxcgCG9yeCfshJR8LAKyTRA+Ndf+cZksX+Z6UBnUC4ZsPt8mKG
         rC+OTV3eNYhLFP4Tgt/YWqHA8MlYRFH4RZlys/dXpyg1wRriRexpACS4q5bdFbuL7gpA
         XqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770990166; x=1771594966;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MLAB9ar9FTsOoxJKAi0y+1h2rZ6FunvHhYJGv3UYmJw=;
        b=OYGn6C5FLh6mAuXsrlRyIA766mzi/C/G/b5swWqd5ZuMTpU4QFfV+PBBzaFgMEz5ET
         uhwh2/op28fzfwdviDIaSObwQl+2+wDP66gEIMCYubDvlUNSK09W4KehwelrDJPpihXm
         8jB27qHdTbu0JARDv/sP/P0H/t39PrEKRylrAnKGJcbZbUiAL2ODeq2KZNvf/tZq3t8M
         2gIC778YVd/k43JiOMksLTZ5Tz0ZofiOJV5cILVQpmrd1HOwuZd68oHtj9FCvVrOAFcR
         mV602qO4QF8Bzj+SPl09hMoStW70TMrjhv6Mfm2j245a/M8ty+jvV59CRQ9ZwNB9q+Am
         dz0w==
X-Gm-Message-State: AOJu0YwGKHkogoAWEIspkHZBtVMJiyb0E6xpVxz6VH7Nw0YnPAHuJ5yn
	WeT6slnUTiUgMygTmIRkbhd5ZthAp8xGzBcHhSOg28zneaCQnyG2I+a4Zgk0zw==
X-Gm-Gg: AZuq6aJFsbcguNOpaVBwvkZZVi0PsGqIk9ZH5njJd527sLoOvGJN7yly1Sw5IhtowNc
	uKVtBRqDnvXz0PB7tu1Q+CCwZgQJAMsr+ydQ6Fol9dEmTXkoHpKIkFjCzeUQWQHfRpjPjOSHcOb
	Apshn3UvUNdvvwTbksY0tggJeDAjFbSfBSeGWliVh1AWqYbl96cikWJbEwT6z541eFn4vfSiyhd
	8l0qH8AQ95vv4+6emw0cgAdSPw658W7GQAjnL+r42DEswSSCbnkhBC0LXjFsjKR2rI4ds6WLs1j
	hMfXKX0MsMGlABAoP0rH9CAasfdegXSJrgwM/QjsP7g2VelPMk7KwwI0J1+jCt3Q+/eD6MDL0Cz
	MWR4MrKC4SOCHwBH6mb3mSZSUJk5NCkz92SGxdBndLRojHK+kljkQYLQ5UAVFeTAlQqFFaG/yX8
	NZhhANWOk2jUYi+Afbxv0Q5akzbMHQZ5E407lZa1lycO0j1Paan/w8RehUo2cXVMWVLBlgvzvvl
	xmcynxWkYJGjWApIJjZ/tOpbRAZidhDhmLiVNFb
X-Received: by 2002:a05:690c:60c2:b0:795:905:c042 with SMTP id 00721157ae682-797a0cb9445mr15281997b3.40.1770990166095;
        Fri, 13 Feb 2026 05:42:46 -0800 (PST)
Received: from smtpclient.apple ([2605:a601:90eb:5600:8dfe:dc4e:738a:cfbd])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c2533ccsm67387497b3.36.2026.02.13.05.42.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Feb 2026 05:42:45 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 2/4] builtin/history: check for merges before asking for user input
Date: Fri, 13 Feb 2026 08:42:35 -0500
Message-Id: <3C51B8C4-E594-44ED-97F0-0EB7C36A3BCB@gmail.com>
References: <aY670nh0ElOZU46j@pks.im>
Cc: git@vger.kernel.org
In-Reply-To: <aY670nh0ElOZU46j@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: iPhone Mail (21F90)


> Le 13 f=C3=A9vr. 2026 =C3=A0 00:51, Patrick Steinhardt <ps@pks.im> a =C3=A9=
crit :
>=20
> =EF=BB=BFOn Thu, Feb 12, 2026 at 05:20:08PM -0500, D. Ben Knoble wrote:
>>> On Thu, Feb 12, 2026 at 7:45=E2=80=AFAM Patrick Steinhardt <ps@pks.im> w=
rote:
>>> diff --git a/t/t3451-history-reword.sh b/t/t3451-history-reword.sh
>>> index 6775ed62f9..12a9a7d051 100755
>>> --- a/t/t3451-history-reword.sh
>>> +++ b/t/t3451-history-reword.sh
>>> @@ -203,7 +203,7 @@ test_expect_success 'can reword a merge commit' '
>>>=20
>>>                # It is not possible to replay merge commits embedded in t=
he
>>>                # history (yet).
>>> -               test_must_fail git history reword HEAD~ 2>err &&
>>> +               test_must_fail git -c core.editor=3Dfalse history reword=
 HEAD~ 2>err &&
>>>                test_grep "replaying merge commits is not supported yet" e=
rr &&
>>>=20
>>>                # But it is possible to reword a merge commit directly.
>>=20
>> Hm, I don't quite see how "false" tests that we don't invoke the
>> editor at all, though I'm not sure if that behavior should be encoded
>> in the test or not. (Looks like Junio noticed the same in 1/4; I'm
>> getting better at reading my mail before sending, sometimes=E2=80=A6 :)
>>=20
>> Otherwise looks good!
>=20
> As replied in the other thread, this would abort with "Aborting commit
> as launching the editor failed." if Git tried to execute the editor.
>=20
> I'm not quite sure whether I get the other remark about "should be
> encoded in the test or not". Do you mean to say we should use a separate
> test?
>=20
> Patrick

No, just musing on whether =E2=80=9Cdid not launch editor=E2=80=9D is an imp=
ortant behavior to avoid regressing. I think yes, and I have no real objecti=
on to it :)=
