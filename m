Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B992BAF7
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 09:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761816952; cv=none; b=MSoguC6Xz63ShT2cwGlqh76LnVGOy/R0W+5acmnAeLCf6TqW+ig/GWYo+6zz90W7sdVwuudeS3lPYnGKtHg/eOLM5Y4bBTtiteYD4Jb0dfSD8FE+9JpAEzjon/JrpieRTKrJDWWvW3svgj1dGko6LkOy6FpU0WCETLx9GLKc0fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761816952; c=relaxed/simple;
	bh=Qo4dGRktIvUlzjylca8L8gTkX6XND0I39zQpKRipRu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IVTpkOZtUykYR673fcaX2xc6tJmNRQ6kxu9hTWJd0iMDKw1XaecJo8OXDydI5pNpW/B1slzrTff1CefCiv6Z7ZTZGiNzsyBSDcu9dqmVjfi7YurijM3tIr6IjRNI5JQ/+KiFm1B36T9jAgwKudQO/2lq4ftY+2Qs6UOb3LwId/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=delpeuch.eu; spf=pass smtp.mailfrom=delpeuch.eu; dkim=pass (2048-bit key) header.d=delpeuch.eu header.i=antonin@delpeuch.eu header.b=Fz4ACQj7; arc=none smtp.client-ip=212.227.126.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=delpeuch.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delpeuch.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delpeuch.eu header.i=antonin@delpeuch.eu header.b="Fz4ACQj7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delpeuch.eu;
	s=s1-ionos; t=1761816947; x=1762421747; i=antonin@delpeuch.eu;
	bh=Qo4dGRktIvUlzjylca8L8gTkX6XND0I39zQpKRipRu0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Fz4ACQj78lODGPdnk1/v2UPSlfL/Bt53lQggoqsIdMcWUXtenYzYvWItxzjwOwWF
	 ODFWJ9LgsVAlCLkOz6X9vTvR4UNC4x+J3Q63SO/Dp2Xyn9L5z8RKm4Nr0gnUd1+x1
	 IVD1ST72AfSTEUX9rjb3dtnPCGWBazlShOAOLRqWftie9QPmOpWm1nFvjb8Qkdstt
	 56NPAF/bL7PJe3AEajqIQ14koGox3JHnc1N6v4obDHxYgKQs0i5jPE9OExo4YX8lP
	 w7aakGo24tQ/D097j1dquWnwWyIh7l99k+tISLjQVSclnJi4lnJH5KqNsRjOhyF4s
	 ZlNGRcUuf2+8IX/yag==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.178.21] ([79.246.85.239]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MfL5v-1vtWBO3UHT-00pXG8; Thu, 30 Oct 2025 10:22:41 +0100
Message-ID: <33d44dc6-36b3-4736-b3ed-96861a3c4003@delpeuch.eu>
Date: Thu, 30 Oct 2025 10:22:41 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] blame: make diff algorithm configurable
To: phillip.wood@dunelm.org.uk,
 Antonin Delpeuch via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>
References: <pull.2075.v2.git.git.1761658643278.gitgitgadget@gmail.com>
 <pull.2075.v3.git.git.1761686060477.gitgitgadget@gmail.com>
 <fde3dae1-bb11-45e8-9211-50ae003ca497@gmail.com>
Content-Language: en-US
From: Antonin Delpeuch <antonin@delpeuch.eu>
Autocrypt: addr=antonin@delpeuch.eu; keydata=
 xsFNBGgHXTUBEADS18aRO7bimgHS+h0jcyOKhkCbD5z7f2rknttOLYv8hD9ygPENyaD2aQTA
 pwcVsUTGQSuWUOivL3sPkmXyKO/rwIOvXJ0Y7plfD3zgiCS2LqFivvZ1FHHXWZeDm7z+pJ6X
 M+pqGY9uvwtlPNyLMaYmkvwJ7CWAL4SfpTJZBjmrRINZuEN5ZHRkpECp4exMC2ZCYv5hg601
 KzOAramvTcF3U+w5a5MTnBbJFvpLSVqLI8FWQIoJocsH2haOPxSjJnYcF4ifRyUNBX+j3so4
 YGqrmaiEimzdyK+FBRwym4SsQ8wP1KkG6NqlepCJU7Y02ZG6zbYzcm18HwUBgVMSqjyprrxU
 PZnzNpEf9pkOcRLnQ35V5PSMRIsPr9HbSEhSHmJ0QiGa1PWOSYePrYfRO0NvThPS+7TwnO9E
 ncGSolmXCnDGcKEHD7xWg0QLZzRLCfZEoJPDyWFxBGoMOOhO8HVhWRp4OoS8B40nHceheTy0
 neoJS4PvFf2e4kDolvNsj7+ih83MbGT7d58o2bhPrLjjVTC8MpQv+mD/ItijiUa+Y597HvXf
 ZY1CUmpxb6pwTBsT0Xroqa66h+qL0ynQ0cSqym5Hnc6P0VbkLzMPUWdRRKtKRpiF3fxj4Npn
 Wf/X1cBKciyhpV+zpCLnqPeMgNqE77y4bPoeXV16F2JzQBpm7wARAQABzSZBbnRvbmluIERl
 bHBldWNoIDxhbnRvbmluQGRlbHBldWNoLmV1PsLBjgQTAQoAOBYhBCVFcaS8o3zDa5u0mJIs
 G2aj09AiBQJoB101AhsDBQsJCAcDBRUKCQgLBRYCAwEAAh4BAheAAAoJEJIsG2aj09AiyvgP
 /2aJLnQdj+WY3eoW++QE+0IsBBcxSeBFsyuxJ7gVO2hMRWLdjg0aTMR2eRPRTEw0T69EK3ja
 b7t4ZPO6R7lmfizcVjsH1eimm5KzfsN4K0HbB5e14qXCib8FOXLLXc9e+3PCUXoCSdQrxrtN
 8WDXjfwPkM6D14ZVLDKrSs/7BD3oGuTXHI3OlU2/50l3B5dM3LJm1nTDjN0I2JK3gHocSryA
 40lh3jfly/iEAFR23WfZ/dX9mpoUW3S89R0MRySbX3Ev1fUesMXcr67bzbIUn+gpCSKbgQkU
 Ra2dL+O1A3R4O7qqU6AFrReSCI31RIFZOaQ8EW5lPMsbQZnqTecTNHw82COGARnX02hy9zN4
 iEHHfe1MffYMqYpsbMBVjlZH6fQDcnkf7dazemp6KiFDcpo2LDaLpt0XJxMGUJRqAXh4PNkO
 C+rYVIPeZAP+Yyu3gn3Y64ACMXJcfwCCvwXi5UyCe0v3Jfpd7lM+5J/wa2CY3iH1fmE3Tpql
 +qwg9a62iIjntelZjiLEs8MV5G6uy/dk7BrgWtJWMiWp+C/sK4R8T6khXQNRQ/bzf96RloS3
 M/NXv4y7SxxgVReVM3MzPqtkaN0Ev6Or3GIUcZHYIi5fW022ReLO5d9xCK4z/CIzmO1i2JnZ
 0dGU66DmBeirbJbsHjy2EF3yqI9zh+P/Tok3zsFNBGgHXTUBEAD3joToBh12sV/o1XGK2t/b
 UuhT3MI0Nlm9rm+rnjtJ2+ujiImW/naaANT8XfH55GIizPedhKKJX3JaTczYx8RNmCXR5/Zi
 uNsfR1GfIJ63kzKfycLm3ElWN64/s43njmRGSx2EAcT/q3GKFldfy07INqH7HnPx+8+IZxZg
 KQnpCqaRruP44BB0cVNMZtKD6w7ZK5oGOZM9nU5Yc1VtVgA1Lji3Iinq/ktYENhaxzacfWX/
 0yP+eFQzzTQm9fdejRkDdJtX+Ni8HYTbtRe1lr4wzkQTbL650HhIWIotwUU68XqIJr6nbVqg
 TZfdez9LpHURnQb01zDs96YQ2jPl8ux7RnDU2O71tJAUkj9w2VTCdHhbn5w+K9lS4ZSWRR99
 iUPrIcp1I5szPs6OwQxo0++eQcruX/XUtVXFbLYH1NiarJzSLyzSvyqf9xN1CK3jFpt3Js1+
 2e6MAYDmwzyCCjPq2ldfrHnWbAHuGiCqRBjtEcsJ773knoTP4vH9I3IrD+Nysdy0dgwQfjUY
 bDgSmL5BHzVjwSizdDf5Lp1oEjyFwHz8d8YDv6kgOhrmhx6ExVzoHxm6jpH9TdOLXw0wFpm+
 /6JqTj2uCnQnIT4lPPqmdy3jP0eFjPV3hKxAyghINxdKmt0ZIXsP3cP44av/BOC578HoT1uJ
 kED5lA89N653kwARAQABwsF2BBgBCgAgFiEEJUVxpLyjfMNrm7SYkiwbZqPT0CIFAmgHXTUC
 GwwACgkQkiwbZqPT0CIiVxAAukCIXSvk9E9rcMcnmAwq1GDu3ZufARlQka8vqQnPKZHIsenK
 hBJ3hetDgBgijspiuSQYyJwOkimA3b8UPJl5gJJ6W1bU8WkHdnylIcTTxVnyo/Mh/YWb3xvO
 rQ/6MZ2WGMMKwK3E6QW5nyhPvponu6clbut+21i4lrpV2319nF+0Q/pAxOrsLoAGAGyVj5XP
 XllS1tn8Jn5KqGdlvhNrF2k1hc8i5X/3K/XIVZt9BpkvqQl/dYcpHKF+pL4vnQomRmaggnR5
 sErTJ+sCgHFCgo9afNrYb+xvTYcI7iFJ4fk/tltPfKkW8Q1JAHaW7aW8UgSMGBpmAq6WLKPw
 Uh2eTaldJCflI5mjxU/HtYBy+3qcR0z0XWKUev5Qsr5+uhTsZuL33+jLAkaFX/4UPEEDQ7RW
 gCumBfb2ZbvJn4yLbQuioSx6TEeEHkMKIhiinVOT9U8RghMuXiV/Zh9XJhoNNTqaxfIeCRKh
 FzGJc/dq4EaIYWri+3w6DQ5Bes5PufGdMucQ2XtuHfPhroHt2nrWtDu58eplp7xt20HEdV1B
 wb7b+qQ98JZc/ePefFBZOmp4fuk+A7Nfb5EBk5NVBaJPHck5VcUMAeaJ4NA6UdC/uSOE5DHq
 eGAwlWKyg+U9FtN8jnsH+nKg4yNbAk75s11Bln14ovghyu5L4hAojIYoL6U=
In-Reply-To: <fde3dae1-bb11-45e8-9211-50ae003ca497@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4/qEAw8ogqhh7TyxRL+HbGLtE1tfIxXvSYABsslhUJCLCE57NCt
 wq4GNpu4LfC6tcst3jQjD7JM8P+LFsCPcuZc8ExgHVDOQ3W1zFJ6TbJPlvE42BRg7nps5W3
 d+jhm9l7TNe+bRblmocZTfmWBItIMVgFD7wefrWqMZdP8y1REly64Lmsn/ccv5KA1/4QWiN
 ZXjZiweVrdQNIz8SlKtaA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:t1cs/SkV1gg=;yw69jLtBorRlm7vUqMPbgiwWxrd
 fQg+5N2yZvDKN2U6WZoKGHTsFVJ+6iHCKA+UiDsnX4Pf/whvWF4ThbBOdlr3JwNtJe7Cw0Bn1
 2P0dQIr1I90tUZAwQkqNVmGZa/6BR6v3ZX4KZKc25sMBGhaS0anhm+USwERh73OQhkXB8IUka
 GM/hphX0YQIeUBPHsttM/7JWk78EKbiKKbDxQGUCfd8Z1d0QBW1NE830xGEicjbHSt/FaPlwX
 DsbFoNUcfwfjcJ8+L379dOVfZWtRPu3zTspvld0PEcFknp3l+hvDjLqZ6Wk/Wt62Our0RZ3z5
 4/YBW5ghXCR61HcjXSeyGeg24cFzfXjlaccH8nhO2ERn0B9ENTDX0ENlncDYtApbD/7/f/pqj
 XDavh+UkcvKvDimmt4E3NS+eRSE9ZAAUU4D1PktNMAbefQEW4CxC8QYt9CotkXTyTIU9wFnKu
 LYuS1Xc+Tpxzx4flMbBbkGIxp8Dcmn3gvSZOKFJgnrjxWvklEk0VXY3Xz5L6nonr+oaMVk/7y
 S6525JiaKBTtYW/AwfIsw4XiKC7prm650jiUMdGrt94Y9bLaAcERqK4mU0ykPxp6fdKptVtfK
 Y39D2P8U1ylzDDzEfr3ESvY/k0PEySi/d9DMVlrvdQ7K0FOfTq0MO7QEHb4mdcRf1JnvK+cmA
 61aigUeXTjDVwNlOPD3EBBAyYegR2Gx5P5UrawbhkdsMW9RKjzgiiPlaIY7wN4/U19qVuadvT
 gLPRuaa+cw0R6cAts4Hjd3+gqgb2M4i6KPpA6GIvQXT/kJxhBoSDO6M8gVP3mI+5MzYHcroaq
 Ulrlah6f0t67nnuS9F5NHzItfjIAhXCsah6LnpqhfCAZT+t5rXIrql4T6sE3Ezc3k5/3FwmTJ
 qW+wOY7Uz2wlmzGy/jfWWKGqryJeLhU2ifJDdpZ2Wbgo1grvYAXewiikIvgVadxTyG5nzayqt
 UDztQ1/iLIFHYxjN3ogJA0EGeLaqfJf46gKGXpZdNpY6UaDhy0Xl32hrddR9T4bhZl74phLrG
 z0em1LmixsbGSUZy/6nUPzKTW6lXJBiDkmljBnomiLdc5Bk6nqVSBh6YfIZnbCD5++uPSu9w3
 GaP2K8yTLwip1nb2BOfwm0raOHpomyTTNBNtj3apjX9XGsgJ22zwG8lkSnZM/o95pGHrDa8z3
 YKhL1vexWGUmR4IwdF2nZWDiORpxdmohqU//mxoz6RSXyUuzGeYwOC/gO5vnawEWleXYaPuhM
 yk/dSJ4G5IqHpUbi8RZ9PktBz8mYCLp9l7Ov/P/BH8+PA0meIPKkIlAv9FQmI/CsI6XIEKuqO
 c5e5bWcIYYqIdsfzsC+yJXsngkvMBCm+PSxrMTcP12PjAvAhcTBti1NYfzH7yajZXcnszS1/Z
 uC2qT3WovfJQi2RgsqNU0iDjWEgBqIada1wF/8tv9dAv1vkKV4kB0SgTC5+b9U6r7JRfGMXyI
 n3SZR1Hx/mlYQCCjHDYnuGUzHsH0XUR3oOu6GKwKGFLcuShIC0BgAYhxvf1W6D8Dv8d66M8Dj
 pCjnjjnlMd7HAXZqNiQhWDjErvReekG+l/ucqYS+UVqrHxIg8uK3SCjL9zZI9XswGN5i2qYUf
 URmaOxxtDj6MF5NTED9RHBUU/J+gmJ/qbo29rq2xh22z4inha+ZehJenKRl1uS3wOkmx1r+Bp
 8=

Hi Phillip,

On 29/10/2025 11:16, Phillip Wood wrote:
> Unfortunately XDF_DIFF_ALGORITHM_MASK does not include=20
> XDF_NEED_MINIMAL so if the user has a config file that looks like
>
> =C2=A0=C2=A0=C2=A0=C2=A0[diff]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 algorithm =3D minimal
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 algorithm =3D myers
>
> We'll parse it as "minimal" rather than "myers"
>
> As we need to reset the diff algorithm in a number of places I think=20
> it would be best to define a macro
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #define CLEAR_DIFF_ALGORITHM(=
flags) \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags &=3D ~(XDF_DIFF_ALGORIT=
HM_MASK | XDF_NEED_MINIMAL)

Ouch, good catch! This problem is affecting other places as well.

I'm wondering if we couldn't even add XDF_NEED_MINIMAL to=20
XDF_DIFF_ALGORITHM_MASK. I've reviewed all the places where=20
XDF_DIFF_ALGORITHM_MASK is used, and it seems that in all cases it would=
=20
either preserve the existing behaviour (potentially allowing us to=20
remove an accompanying "DIFF_XDL_CLR(opts, NEED_MINIMAL);" macro which=20
becomes redundant), or in some other cases it would fix a similar issue=20
(for instance, in merge-file.c).

Is your suggestion to introduce a new macro motivated by stability=20
concerns? I'm aware that xdiff is used in other code bases as a library,=
=20
so I guess changing XDF_DIFF_ALGORITHM_MASK can indeed be seen as a=20
breaking change.

Antonin

