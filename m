Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AAA39CD00
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 23:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788564052; cv=none; b=GeX+Zma2VxyYDPzNYChH6F6aT+WhnV83Vs9gwXZelkubyU08vS7gVojkB8bqTmcjyDp5N6aKvmkqt+9hbo3x1WpvODdYeh5tBmMdlF/nRaUKiiU/CJZ/8Uv1tH3nLv4SAmJi/S3E3QkFcgqL5NLwIOYsC/qsCgNZf/melTBBe90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788564052; c=relaxed/simple;
	bh=LAE5WokTk1xw6xa6QnzQXWXLiXIpjch2wkcqtrNFW9k=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=iT1SJeB8omCNYb6zk7nNhr6CYE+Lqc2pCvW7KG36A25A0tUoepKXIkDHMMsA07TlTW84nOOaYiqSwtYgHoBiYY8W/b3wySA4oxRH5i5ijCjUOtBBpWFcy31Q1Mmk8dPw20R06LiouXvfwqvBu+/WOwWFcPKvjDJt+EFZ762oYxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sFnf++aC; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sFnf++aC"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-9390c3ade1dso77814785a.0
        for <git@vger.kernel.org>; Fri, 04 Sep 2026 16:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788564049; x=1789168849; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LAE5WokTk1xw6xa6QnzQXWXLiXIpjch2wkcqtrNFW9k=;
        b=sFnf++aC9L9DuUlBFIEIPDD76XiCW9XeBqjU/+i2Aw29X+fpflM89k4FDWgKUoKVK3
         UdeUUXeXOH0aR/8FC4nfr5ru+6iKSGhSTeD6cgIwtMZOsLvKI1iYkuoZ8xQnuTr+EeDR
         vPx0Vq/oNBecJSzK4bulBk5q4AImsQR+7fcUfKJZJArMjbRHsSArVAXOx7wwnjbMkg+S
         cxFHmMuX4/Ge9bycwwR0PmABI31bX9ktuCupEjfk/f0jN7HczLV5NC1fKtN2f3ku9jO3
         YPrSKghrSOdlxy4F3Ac0WniX1spGW2UD1xGn7kdR8b2z9+JAchWLbvQkLfbn/vuUXhW6
         5ezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788564049; x=1789168849;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LAE5WokTk1xw6xa6QnzQXWXLiXIpjch2wkcqtrNFW9k=;
        b=Szlx45LioGeieoXmQVWbbtvQmCaMwpmEXTeT+CNV9MI1GVdE6M0/7x2kbjeBHMAxWp
         hiLqp9eOR2PneBGCNbSvKXPAErNNrKr7OYbsp6MGEmSzarqnvl+mXjXYnUgsfAzivsmV
         9oZkl7VkyfxhOUpk/tP0YpMe5w9a7mMeipbW792sUNRMgXDWW8uyyFfmK/pZ4G3iNhRI
         /R2IEAjshvHay9+l59F/0+s9PSpki0364e4mZEd+AI4UhZdf0q8VVY9jJYbI8JMag4xm
         AKc99AnYFORIR4jTHCZDDtvVnc5y7yQ1W73Cr7mo66JKFyIinYAYTKc2i2fEHdgvFq6h
         TtDg==
X-Forwarded-Encrypted: i=1; AKwUvBxY7axQGQXFoq7jPjKdqw/PjPVq9IWpWSwjXqL3qki5k3Au1Mzh3h9Z7eUv/2bbLlcq+7k=@vger.kernel.org
X-Gm-Message-State: AFuF++nX5hUk3VsC40AqTMNRWcLWOp2p56yduExQaj8y7mXJ/ybI/kvd
	hV8MPknTyTh9G6j9Yy8u4l93JcJr50feXgkXF2nPXu9Pzx/1118ZdjKTwUfUkQ==
X-Gm-Gg: AYBFou1op0E2dzFG3QIixPQdYlhVeUlMTDLWcFprIxNVOMe8fxvARA4adAsOAxu728M
	P3DGowYr+0Q1d5umuU1yQmtcV2yPfzfDM02d6jxhEbqRTqeNLKyZHFlXmtBNaDrxuFefansEnGG
	DOnUZC0PuPp9x6kuBqdpW84rKKGFfdEwPKlHiNUEppkk8OW88s+6Npc/TAHNb4GMUYElmeMMHR3
	SQIgbYQwfsy6jBMaMoHiRlQH/SZL1IYJfjkAC4aXMbAxnHJZ59rD4ogA9BL5UJDA2pcqru2p7y4
	M3PTG2iMVQAvOM72CRYZ9nHs1DJITPVOQUAhDGp6eO5MyCm1217/WMI99sNXWmyw4gw5GamK/Yv
	bochlysvreHJcJa+OU6nchXzYPHrsM3U0sYaKJjcWOHj8j2VYLYhB4QiYoxxpQXOl23Q+xg89FE
	dx/WPXHTQFCoM+RyZTImTJgk3Nk/1gt3l0nVU9GLBg+AzwUaE7dApYz7ewbsKWCi2lxQVXTleOT
	CDpxFBs1ZlMGBZQRBHe37QyPiFTI/0VqE+VZ2GXNSec5OxypT601ZSvWGfsn1rPc2x3ef2jnKvc
	56yzv+0hKz9Fnu5VLTw9vDbHZ7ROLkUJGZ/UwHYeY7hhilBAyg==
X-Received: by 2002:a05:620a:6908:b0:937:58a2:45c6 with SMTP id af79cd13be357-939804ed8demr894912585a.31.1788564049297;
        Fri, 04 Sep 2026 16:20:49 -0700 (PDT)
Received: from smtpclient.apple ([2600:1004:b26c:dbd1:d5c0:ab95:5cc8:530b])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9397fbd6ea8sm329911685a.44.2026.09.04.16.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 16:20:48 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: User report on git 2.55.0
Date: Fri, 4 Sep 2026 19:20:36 -0400
Message-Id: <A918E4C6-AF5B-47A8-B2FF-69E87F6118D1@gmail.com>
References: <14ec96fa-897c-4bf6-a2e9-cd0c6e9b4474@app.fastmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
 Git List <git@vger.kernel.org>
In-Reply-To: <14ec96fa-897c-4bf6-a2e9-cd0c6e9b4474@app.fastmail.com>
To: Ramkumar Ramachandra <r@artagnon.com>
X-Mailer: iPhone Mail (23D8133)


> Le 4 sept. 2026 =C3=A0 19:13, Ramkumar Ramachandra <r@artagnon.com> a =C3=A9=
crit :
>=20
> =EF=BB=BFRamkumar Ramachandra wrote:
>> brian m. carlson wrote:
>>> Do you maybe have some sort of security software running on your Mac?
>>=20
>> I think it's clean, but it's still a possibility that the workplace
>> installed something recently: I don't see any other strange symptoms
>> with any other software though, and everything seems to working
>> reliably? Perhaps the most common task: I run llvm tests over 30 times
>> a day on different changes, and it never reports any spurious failures?
>> I will nevertheless ask the IT team at my workplace if something that I
>> can't see was installed. I don't use my personal laptop for llvm work,
>> so doing that comparison is not possible.
>=20
> I found the malware: it's Crowdstrike Falcon x(

Hear hear. I haven=E2=80=99t observed issues with Git (based on next, I beli=
eve) I compile and install to $HOME at work, but I think we also use CrowdSt=
rike Falcon. I=E2=80=99ll keep my eye out, but the scale of repos I deal wit=
h on that =E2=80=98puter doesn=E2=80=99t come close.=20=
