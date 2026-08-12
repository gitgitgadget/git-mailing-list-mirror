Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F5A2F6188
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 01:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786499164; cv=none; b=fPJYIjwCqpfZJB+pIOp/Hx7ZIsqdoT2L8ugv1ITtwxaDYtdDmQ5tRTMd6ALpYrlYzh9yl15k9tm9mhMWIhkC97BwsnIgm0eYIisrHcroCu2bt1Les9sa+M6ZDlPCDY6mW40baaSYSwl+WEwCjQIN5SFiq+QPyK6S/SkZHS5fT4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786499164; c=relaxed/simple;
	bh=Ue9Q1A+Tqa5GhWJUvlITpmlo8Eo+kd1DghJi+WfMz3U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LvcXqrfqgd7KGnV2d6ofCYmlZT1xi4E1LlI+FYKrlQQ6szHb7255qlKDbUcOVOBnv5pyOD0A31Icnin3Avy2lPwf/9ueXXUL63Ezy/pOPDrngUbXu0wcNJCOiIDYOeLN6g5TYwSCAdfVtIfec9eeAWLe5zOCZDrdpFFALBfDILI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=e+RhtS80; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YABHwQjY; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="e+RhtS80";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YABHwQjY"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E0EA87A0142;
	Tue, 11 Aug 2026 21:46:01 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 11 Aug 2026 21:46:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1786499161;
	 x=1786585561; bh=26XxVlDxs55XbXjJapCpcbu8RFVprkFRl9qLLWgsNsc=; b=
	e+RhtS80hprsnUpMmCSJ2+lpxeTqRDkJyMUbyegG/fIxvXAmIfxm7SLD7WHAlNyJ
	biaTjbQYo7BR4WHSsaEMO9cZnBRffyjBDMPs4ZMQa0yLV35iCbfLl/xphZbz8QqO
	NNYoUQalpy6YNfNIQR0hzFWnyiqbZG4cwKVNCqAuuIMH2IFPSG3/WeIOmMLrsU7J
	QqeCGVpq+wVnTmXUCfGQW/FhbEQpZoZiRH5lKTQn23ODAbaOAt+x/15512TK+Rui
	6sdFYR5VVzgUQnax11Q6Yqvbk5Fv/08RvXJ5/YMZvz4NXE5fx1gYHpjX9aJOrtcc
	bvyTpbXTQVYCuKFnOBhP0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786499161; x=
	1786585561; bh=26XxVlDxs55XbXjJapCpcbu8RFVprkFRl9qLLWgsNsc=; b=Y
	ABHwQjYKfB1ifmuZuS1HhhJjKNqdMR5fXEo7tfi6Fi4i7Y/YfFx/8zITSG//2CtL
	kpyPcqIFeFjAwzhr9fvesFTNw6yYxWQBSHKhze+6q7EF5P3acGMlKe1KtBfFCPwD
	Q8h+wFBKDVb5c6nH2GxPg6fMMRAYxbH5VmRF8rp9rB3RxH7up+qaohXhIUhSk0pZ
	/gdfarwDxkP9JAN0xhzatBcMNJWQxCyb5/Zf8nBe8riHBZU4/LaMSnDyF1/1FZgG
	pJGwS2UDiZW5vZYbXUxRLPQA7CUGlQqKc/Sv2/EhteKEjLG3Q9w273cstMIYHrXm
	cQHQU/hhTmi6NrHY4l+lQ==
X-ME-Sender: <xms:WdB7aklZhKNuZi_fcLtrc0eYN39qoIqNcmDOFSS06cL59ZiWtADWJg>
    <xme:WdB7amZ6kVeC3tbym_j9AKIytTHvMBHUl9vTlGsC6-8bP5x9bZ1IlF-3jYGApe8Vb
    4T7p4siNfGfbHxSkbj4hr5OcEreQWh8v_EX1bAtGuPKzDHV9TgP2w>
X-ME-Received: <xmr:WdB7amSWDs4qtmivA0cM__qqpVzmikjejASpilL7fy0DoOcpOfe1lkdp_Ya2ctrOnADCd3jSeIKzuO0NJioi95OSTTxoNJQqIQ>
X-ME-Proxy-Cause: dmFkZTEf6wPXOQ7TRKpF4mRG7WXS5peblZHjoxKBXnWFJgoD5HV2I7750O/BRgEhKBvob2
    X8XBsltlGdrhCg+eJtKLsDes3w3boNiOLyV0HJwSEo9xQolBSAzvkZgSGEXp/oBbsl1Gm6
    nRAbxZnBFr/UL/nTSJrrSObDlbUjJ1O+JzTZ4KpDJrxcIOXiXkhxyZZ1iZpPle3S8ojreP
    yugBU6PhPZmBWrUHZIVVTGqoQ7lDrqKxTVC0lfZKaLhRc2RwkLNazjPtgkyFBwMBURe/WC
    2ldZA7TEE2w1ulZSkrYiEJPNeVeNNmMdzvxvgioWe0OiZVWxjzHSBsovza1Y2UBAq7WGje
    /c1lH5oultxzgCHB3tQMra2TY/CSye2ZrX6BrzcO4n/Zb+xY0dkzlK618igk8SQm5mVAe3
    L755lFNyK/6fqarrgcgqFqWD50DtVrEH/9ssRgBKM6DLPL8i26cNli0w9hv3MnX29I0KfK
    w82S2veFNqVi+4vUqO/BnIj8XKDRkcY0BsBNhLhaVarz1EIp9yhSHYFY6tyUOhsvRHPjLB
    aWq29RnuKFCsopNW3n4q59bM7kuzB08/4UCB2mkX5BVZSuKQvyU6XjMt+mYZSFaBnrbAHb
    QH7Gwa3vM6eQ3bSlqDGtZ2LAG+FuvD0/7bnxRmYXaDD+vXNWnlF2fLqEfg3g
X-ME-Proxy: <xmx:WdB7aguWEEGyOCbTncmqlssl_FaGp1Vpgdet1eeCzuKqkWskLtma7Q>
    <xmx:WdB7aoH0gfgX7MWIN4BCwTmbz7PSwyxV1LOf2nyF4a9xL1fEWo4ERQ>
    <xmx:WdB7ahy3juebeE7Xero7R5ZNdhHIPmH9TEhjGqbexxbVJ3vfSKjN-g>
    <xmx:WdB7ai0bHq9s_HlKRvdAU8F8e8qS0rt3nXfUzXqbrgw9lsW5dNsnRw>
    <xmx:WdB7akiqauRAZIH9OCR1tCUuLpyOMw6E3kDOGpZiqbY30cOW72vCCmyu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 21:46:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: git@vger.kernel.org,  Philippe Blain <levraiphilippeblain@gmail.com>,
  Leo Kerin Britton <britton.kerin@gmail.com>,  Elijah Newren
 <newren@gmail.com>,  =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
  Patrick Steinhardt
 <ps@pks.im>,  =?utf-8?Q?G=C3=A1bor?= SZEDER <szeder.dev@gmail.com>
Subject: Re: [PATCH 0/2] completion of 'git [-C <dir>] checkout'
In-Reply-To: <B79E6047-CC44-42D0-A9CA-BF7B8D2C8B93@gmail.com> (Ben Knoble's
	message of "Tue, 11 Aug 2026 12:33:53 -0400")
References: <xmqqcxvp481b.fsf@gitster.g>
	<B79E6047-CC44-42D0-A9CA-BF7B8D2C8B93@gmail.com>
Date: Tue, 11 Aug 2026 18:45:58 -0700
Message-ID: <xmqqpkzoyuuh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Ben Knoble <ben.knoble@gmail.com> writes:

>> Le 11 août 2026 à 00:04, Junio C Hamano <gitster@pobox.com> a écrit :
>> 
>> I did not, however, find any readily usable machinery in the
>> 'git-completion.bash' script that allows completing a path within an
>> arbitrary tree.  If such machinery were available, 'git checkout
>> other-branch foo<TAB>' could capture the output of 'git ls-tree -r
>> other-branch' and offer paths that begin with the given prefix.
>> 
>> Regardless, implementing this is beyond my 'git-completion-fu' right
>> now.  As I mentioned, I barely managed the 'diff' completion as a
>> monkey-see-monkey-do patch series, and I would welcome others
>> building on top of this once the dust settles.
>
> I do not know where it lives (and it may be Zsh-specific) [partly
> because I haven’t looked while on mobile], but I think there is
> support for completing « path » in « git show <tree>:», so there
> might be something to build on there.

I know where treeish:path<TAB> support is.  The thing is, it is not
a reusable machinery for "git checkout treeish path<TAB>".

Thanks.
