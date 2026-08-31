Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC893B1EE7
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 19:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788202886; cv=none; b=Qm6VkTGrPWmV7nYC2Q8I9OMAOvm4uSVW2TEAH44jMoK1bi1845aACHv0NLp8RSDIIfcILt+hSUny1m+4rwPm7yw2qk2CL2QFgQZF44Q6igDzSPb/Ultf/wZw+7OrrwXFpTF6HNdMO03f2ZLZ9OrQ6TAZmzkn41Badk9CO/mYFVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788202886; c=relaxed/simple;
	bh=9gsHk9D+1E6cT54zSA3sUa6zKuqvXfyr4xO806PI8g4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=vED9ZWDI0Qu24yynsrc1gLuq6DrT5pWdqNR46ysRZmkc7M5DYrUPBsLe8/8Y2mdwTv0G8bFw9qeHxUspXgfk09H0xRMbpfSTzOMQKqv1t9ndRo0x8E59+1pXZIRFQSnJGoB7WV5qUMpGalVmA0jjNSr1e7rbbEmwVHe89cCbuWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HFdL+nek; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JOuV61hW; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HFdL+nek";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JOuV61hW"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 8F0D91D00119;
	Mon, 31 Aug 2026 15:01:24 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 31 Aug 2026 15:01:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1788202884; x=1788289284; bh=VZU1fKgLYx
	jTUKOWaGpHbRDfGbUERky2Dcxh40dRf8M=; b=HFdL+nekSWQ16e5c9mSuGAKMmV
	D4OOTk1MlEZIJLVDNAqKXuqO1n1whINGOavsm7Ospwh8+16beDHEeOQ7LbUXOvbh
	SBWHddZ9TGqMNJ7JTgme6cZ3lGQLep8Vli9Gy2CNwozrIU4Mpma8XqhheazLZx+9
	1WwwVrm2bJjwbccCe2w4iZgfaESye1A/YcX+bxjKvIWR9lBLc38+d4Ulgh8vpYf7
	iahQqx8Gya2Gve2VwLwc4K8kV6T2CVjFozWyI0WpQfKYPfoQ5i8vl0qAEF32adJm
	naOrPVKjxa9CdQSrXKw30v3qpvrNpS+I93ENa1WI2CJliiotckQvkP5f3Mig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788202884; x=1788289284; bh=VZU1fKgLYxjTUKOWaGpHbRDfGbUERky2Dcx
	h40dRf8M=; b=JOuV61hWyyPniZTEg6Vk5nFNjufa2hiq7++668b6ovN/Kekq54h
	mAxQ/w/4gZJi1fWHaBcbRC5tyf6ba1si/URC0zGMAnX48l0Xs01mWAtElydJSSvK
	G7ltKibNu5+LxYGxaQNFkcw2q0cTa0Vq1TH9yafiZx9qzxOlmKQHz7X7+/rrQORr
	k5WWYlUu+iCzREimzl+rhaJ6fnfRUsATcXAbxYkcY9MTWNcVb49zq+Bv9Dy4l9tI
	QsiYZOlyA/E13tRDMmi5HkZ2QM6gp4scQnQqx/WbzxgBXXyV5Xb9ja4E414toT5h
	q64yIAEXjH70sQpwfKx2F3hy1VqYbG/IZDg==
X-ME-Sender: <xms:hM-Varg4kETjy9RpRmlFn-lmwjQbI1pQVMhqFAXo5A3jQh3dJDItuA>
    <xme:hM-Vavdtz08KEyJG9CGOqG-Pn2fdL00lzKZbBgF2IAuCCNnw-BGw934QJPl6FqFnu
    0zAObFAZBlsafWFgK3vqNoMA6l-tmR8LqSf83TYE_RcB4fRiYWsZtc>
X-ME-Received: <xmr:hM-VaofETx5eDBGCOp60KKQPUU1XYWkLCvt7Pc9KpMxkOfGLOa99OsDfXV1KU_i320wn5-KRLKZ7-SLtroo3-icihlq9hz_JJw>
X-ME-Proxy-Cause: dmFkZTG4XIieL51fRN0BvLzkqaWdcZM5lO+ql5sIqTvj62hyduZGV3Bvqwpa/XpA3tlDnK
    F7mPvby1HPvq17Y0y5qz8C8miSqXNqxPPnReAJNf9lbU5HtbNSV5B8F8xd7tDZGQOBlSSW
    pCyVWYnMUtsMX38tVtNv9s5XWf5vbm3ViFM+Pho7vQ/L45Hu/3/By5Ffskf/Z9Eapyx7wJ
    RTh+Noj/HNAZLReQP1JX7GCQHXhiFoEw8wvukk0cRzYMAJ4X+V45Rjz/PwrtYtMH4hb8L5
    gtEWknYf9vh7QRTg1I+utljovfzQujh/jjJeoaWm5j6zGVjnEbm9a5XbZt2errkAOI1QBD
    sAbH74jDHB2Z5sEw6kPWwQJKsz8VUrGFtrsNvmqWWBvQTQgIEgi7Zlko3ZLrNdpdpAKGfB
    1CcaWdyWIjDXeM26EQI0qXxqEcvuG+/CRr+aYLKXZLs3oYwT4Bghbl1Z9+Q/c2qcDNLo73
    5x321KS+w9FoXqcUpyPtCJkeD3L6LMh9GCl3+lRLs0a+r01GyzaC5Mt9P6ZADLDWGTZT3j
    96XqpUII/1vPD0cXu1P9ESuS9LKTzYVZ+LhhdVtD6TM15N/WBc/GHlMHhon/JMmtjobrN9
    txnPM6hazsRioG9v+kd8z9MbT7oMlXeggLSDGkGB/J7XDdRcw/hJAQbkpsqQ
X-ME-Proxy: <xmx:hM-Vah97xrmde7GzlvPcI_0Lq3VUGFZ2-5FsNDBXrPu0ziETF2koHQ>
    <xmx:hM-VasnBFTnSJgk_l8DBeUgBoBL9vWJSGFDeMlD9LDFoWcqaRxRptQ>
    <xmx:hM-Var-ZO9iFs0bwIKXYFGNNH6iGklFbH3aRjxAJa3qTZKfpmbTPwQ>
    <xmx:hM-VaikaaWkoZnMINWKdTu2y4G-Sjt-Yd775wZyXwyZ87qcLJgCJgg>
    <xmx:hM-VaveS_n8s777hy_zzN4Vm30xEL9U7jU-NoO1i2OFexnBQxnVQ6xF1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 15:01:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Hardik Kumar <hardikxk@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] versioncmp: fix typo in versioncmp.c,
 t/t0022-crlf-rename.sh
In-Reply-To: <20260901-typo-fix-v2-1-6aeafbae6389@gmail.com> (Hardik Kumar's
	message of "Tue, 01 Sep 2026 00:15:01 +0530")
References: <20260901-typo-fix-v2-1-6aeafbae6389@gmail.com>
Date: Mon, 31 Aug 2026 12:01:22 -0700
Message-ID: <xmqq7bl6w1vh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hardik Kumar <hardikxk@gmail.com> writes:

> The patch fixes two typos in two places.
> versoncmp.c:            "fractionnal" -> "fractional"

Verson???

> t/t0022-crlf-rename.sh: "similiarity" -> "similarity"
>
> No functional changes, only update a comment and a test_description.
>
> Signed-off-by: Hardik Kumar <hardikxk@gmail.com>
> ---
> Changes in v2:
> - refactor commit message
> - Link to v1: https://lore.kernel.org/r/20260828-typo-fix-v1-1-24e80a87ed53@gmail.com
> ---
>  t/t0022-crlf-rename.sh | 2 +-
>  versioncmp.c           | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t0022-crlf-rename.sh b/t/t0022-crlf-rename.sh
> index 9bd863a970..328c6e5903 100755
> --- a/t/t0022-crlf-rename.sh
> +++ b/t/t0022-crlf-rename.sh
> @@ -1,6 +1,6 @@
>  #!/bin/sh
>  
> -test_description='ignore CR in CRLF sequence while computing similiarity'
> +test_description='ignore CR in CRLF sequence while computing similarity'
>  
>  . ./test-lib.sh
>  
> diff --git a/versioncmp.c b/versioncmp.c
> index 3a81b17bc1..f1e451755a 100644
> --- a/versioncmp.c
> +++ b/versioncmp.c
> @@ -15,7 +15,7 @@
>  
>  /*
>   * states: S_N: normal, S_I: comparing integral part, S_F: comparing
> - * fractionnal parts, S_Z: idem but with leading Zeroes only
> + * fractional parts, S_Z: idem but with leading Zeroes only
>   */
>  #define  S_N    0x0
>  #define  S_I    0x3
>
> ---
> base-commit: f78ce2f7b6df702f93d40b85d6bda92a3f65da79
> change-id: 20260828-typo-fix-721b77177721
