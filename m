Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E72C39A802
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 17:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785258260; cv=none; b=tKUi3Rc7b6at0plEmWoLGxFnj4nEAQ/ooHJJyk2jvanZRe2ZehDzJZJDqBGVV7m4AyYXvYmVAOfJ2v08f4eZwMq0bc5t6RfYNKjB6t4XNnzZ59rwkfzBaCQV2wkyRqZ9dXhG/nuWw2lqBKQiyskrl2bLW9Hjf/wVe9keyUVn66c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785258260; c=relaxed/simple;
	bh=Sj0rLtE9F1q9ny6d2Im17W/jd/Rsog8w2TTKXQ9lq6A=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=EWUIdD34jLfWvy2UkJxl9cMuF4vMx0zhbUBPyNOCgjgZqKdVRppW8C3fs6tMAc8C/zamcaIkTfgyTq7F3dAfBojnk2UsXfQ1cACU2O5pifeP54rKYmmoCUpLUtfUwBdyfX4qj/9EYXuGM828E9NK2NV6UsjWJ/he00z0Lp1TW9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mkz1d+U9; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mkz1d+U9"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so45297a91.2
        for <git@vger.kernel.org>; Tue, 28 Jul 2026 10:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785258259; x=1785863059; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date:content-type
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sj0rLtE9F1q9ny6d2Im17W/jd/Rsog8w2TTKXQ9lq6A=;
        b=Mkz1d+U9VgBVqPs5Hfm1Y4RiXtlwNbNpmGKRE/HwfUhPZIGcWL8Jt4lK2D9An4sNuJ
         XyIu5Tw04X+u4zcPR26X37p7X94Nz9t2xI37LcVE4z5x12y/8WNqxETnAIPHoDApn/V2
         a9w9JzNu+K9vY9JbNlv1XhK9teTcuMbboCSxcJkAGMBsRRs/zOHZo9/RufiVAdDcVAH7
         e7lAHErCSQ4cP78en1zygXTRH29HzuDbmnuzxdAIf5TA9JVPd6cXVDl1nkvwfkEP7ymh
         elCAL9cvVPp6e5Hq+HMyY7Z99wSln1xolFGRXuz1RmknzlK15ITPscer7JB+S3GjoI3u
         zEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785258259; x=1785863059;
        h=in-reply-to:references:to:from:subject:message-id:date:content-type
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Sj0rLtE9F1q9ny6d2Im17W/jd/Rsog8w2TTKXQ9lq6A=;
        b=T52BxpF4vSe/CWyeIhIOCpcD8+yfWJ8gkRQuwOEy5ZSCN6/XNZCMWU5KBqBCKntNKy
         cLVi18bgr1iBX/nKmZRekD7Ef2RLpQcALO1laMoj/8CnFlg8Mf1H7CqebNCknWzWu/Xx
         Y5rLexddJ/c+nxUk4VoO4r+gWnEcxrxCVWDz4fHDvaVTsSl9GWSSdXuDFTwG6uZiKkSV
         yvdwZIthFTjtjYR6B1O/1XaW2oMnOqSAMsXC8A+4re2kKus6z6mDCIiB1wrfuRtLg8oO
         ySwt5jLAMVqRKnbuZ6ql43Y5FyOMqMo7DxS3yxBhYIRPGQSmcnj3t5xT8L3T+DMuBn8a
         FyRw==
X-Forwarded-Encrypted: i=1; AHgh+RooIP+tG+XHUhWMfgsO+vEd0kp6URu5OBuG42fSkXI0Mi1atC/BqRn0YBlqvLeIy9IfG1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YynewKnXXW3TMCWS4zUPE0Ugr6rNvlR73I8PVWPrk6bqTcMtkhX
	Dsu0TKq/EUR5HN2yD0nPXj84G87CgFe0+v4rWb2COdrhx2TNtiWvIPyq
X-Gm-Gg: AR+sD12Z1gQ6Tw3s3qeKaaZZMa2MUzWVqKPkkRjwuWvhepKLMILMUnC6WFUF4HfqKC6
	Iec7C4ai9IqzvPGrNFyJp9G8O7/HzpBd/rpk+sVA2sqrW6KbPqvawme2cIihFYw5MDmajxn7YaR
	ID045oPhv25NLADbm238cXrC8zw3IZWc+L/oDSrzp4AZ1rKoQKqH7XGv+ZaaHDRXBJjd2lLtrXF
	4wPfWCP1G3KW4PG1Mk5OvFGOxcsGiHyitIMWBSDXgvzgBmrQ2EbsryZoAA6P90ONBUrNPnTyy5D
	hXJq224C8oRC1Ta/FVC51KD2XtI/D7gb4d88ZkOJ7ZqcObVLf2co6i7KrQhUQogN1ZRezwVc0jv
	PpfOlv1Y+lfuzPbuSqPzHnbE9QzABfnFMx6ZGBZd5QcXTWHsXy8XaQELrozciv5wQGcTz8KO0Zs
	oVdK00qVnb
X-Received: by 2002:a17:90b:3a8d:b0:387:e0db:bc30 with SMTP id 98e67ed59e1d1-38f6a457c3bmr3323076a91.38.1785258258940;
        Tue, 28 Jul 2026 10:04:18 -0700 (PDT)
Received: from localhost ([220.158.183.16])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504b1246dsm592042eec.2.2026.07.28.10.04.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2026 10:04:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Jul 2026 22:34:12 +0530
Message-Id: <DKAD8F8VLOMQ.3KKRGKVG6UT02@gmail.com>
Subject: Re: [PATCH v4] utf8: replace utf8_strwidth todo with descriptive
 comment
From: "Hardik Kumar" <hardikxk@gmail.com>
To: <phillip.wood@dunelm.org.uk>, "Hardik Kumar" <hardikxk@gmail.com>,
 <git@vger.kernel.org>, "Junio C Hamano" <gitster@pobox.com>,
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, "Patrick Steinhardt"
 <ps@pks.im>, "Pablo Sabater" <pabloosabaterr@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260726123427.173877-1-hardikxk@gmail.com>
 <20260727211520.84289-1-hardikxk@gmail.com>
 <c8fb2eba-c1c8-4f59-b467-e6d4766623d8@gmail.com>
In-Reply-To: <c8fb2eba-c1c8-4f59-b467-e6d4766623d8@gmail.com>

On Tue Jul 28, 2026 at 9:11 PM IST, Phillip Wood wrote:

> The last sentence does not really capture the reasons given in the=20
> message of the commit that added this comment. If you haven't done so=20
> already you should read it - see 937b71cc8b (utf8: fix overflow when=20
> returning string width, 2022-12-01). The fundamental reason to call=20
> cast_size_t_to_int(), rather than relying on an implicit conversion to=20
> the return type, is not about changing signatures, it is about avoiding=
=20
> an overflow that caused git to crash.

I did check that commit before. My attempt at explaining the reason
wasn't quite right. I have improved it in the next patch.

Thanks for the review.
Hardik
