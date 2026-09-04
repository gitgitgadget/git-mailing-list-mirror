Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C238D4F0544
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 15:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788535315; cv=none; b=uUy6dLcojIwFDvIxbueCvFXrl1kJEmT2I/otDfzIBuzyKP5cOlAaw0NC0vPIWpTSt1XnL/NYScXrEphZpveW9Nh9tLDEYamQSghTwVVibnLYGkhLqgyZrln3zGY044gQZHavYYCULCIrki+eADrsLJxHx/YmzbiLWcf7Oiein6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788535315; c=relaxed/simple;
	bh=ca3Kvcb3snmEQLfGh4pR2czBL5IP+inJLePb3dMOFBo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iL60TKHpm5b7bZXZa/1uqpnrW8woCOYQerLyXHjdjqnYNejx5gsZDT2NKJF+aNYu6wZulE8HQFZ8ckXR3NjujUo+Vv9b3GkVMXVCnIIA7Jh7MdvEeDi8QGfMxlCqSyQBAgNWpNupuG0qmCO3KNwxx6ApNvMk0qb3lc4azv5M5dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VLmTfgDW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sICobund; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VLmTfgDW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sICobund"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E87EC140011E;
	Fri,  4 Sep 2026 11:21:52 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 04 Sep 2026 11:21:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788535312; x=1788621712; bh=jkSveXhyE9
	KUx71TG+qy9AUiQ6wTUSIBXv+m1n9+yEI=; b=VLmTfgDWRDjSwWqUBYKhML1Y33
	juPWOx68EXwiWF0qYOtNeAhwEwTT6jpv4LC4leykBXcbLlJ6DXNE29PxBQWNRr/i
	unnCKXxVYlq11xac8o4jj5ovI98hpezadzN9WwcAPnp4kiV+onnzEGlVIaSIFNCa
	74GHfvoDVFyDrYRDO2WuKdRvvmo94xq9LrU8MhZKqh4bykOuiKEiRqF60cUUM+lT
	RCksqL5lunX2z4T6JbrFZLSduecCXV38+9bwVS+LjBGH4BOM+rx+PBuD6V2XAgcU
	4MQEg5xl/ITdYkJcCXDnsjjA0PQgC8rQsE3qV5m0ATJpTChYk/HxlRsxe+Sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788535312; x=1788621712; bh=jkSveXhyE9KUx71TG+qy9AUiQ6wTUSIBXv+
	m1n9+yEI=; b=sICobundlAeLxinrcbYMokiQnnAc0G6WdJHy88/S2iarbcV/xNL
	YCg9jw9RujALQ0VFveuq6fph2NNpPucqKQy/gkVn/D1Ls3mpWYo3qKZwa3D6YtzR
	YVezD/MMVeGCgzOn+UZ74Jp9JVDh+2gsIBVYdK3kkAZFmdziJbbJiWjl0ftgA3oV
	+4WnUeFt/uxg3yx9VnARbW2CKUFda+SNfV7Xm3athBYSJ1LhN5JxteQz6m2TGrJi
	9hUMbgCbxxaySl81kzchVacxIdKovZJfEbIlAhpmKUTMdVjNW/5r9OQ7c6S8TcR8
	8IC0xXy2dLM8VtrDZLEBliXSYAPNHMUJ/hA==
X-ME-Sender: <xms:EOKaapPvihM_dkDnoT0Rsa2PsTimOl9iLflZGOrmylj9XO3AY5vFkw>
    <xme:EOKaatc9iwDdkXwM66BcT1XuWVJ28IpWAl2s7q9uDshX7jnb8eMpRQr5fYtYgajZT
    o3PMDYVTDH3Hp_bflxES3x60WQb9-yxNeeJc4GOMSE04i_74LYMH7A>
X-ME-Received: <xmr:EOKaaoU7Iv7916Iz6fSF0z812XKHMlXCMXK8zumEZi6K53Fc7q1Xva4tr8iGvQHUBYfF-wh6q-YgMFVw6zNfvkt7hkzuXeuY_w>
X-ME-Proxy-Cause: dmFkZTF+L2LPezd83q5rY5tbhE+DOSYbyhofdVjXNl0PyYHnJytdM/gm7TzDuFmDUNBJ1S
    /zDya0Ie9vxRtSPI97dx9eRNlSD0MLxhOqDZvzXlci+y1iGdVsEvFMurAOg7pJvbhjgbJA
    sIL/k+0rLkp0AUUfcsepNUrxXYmw7q+R+Bif6RYkgaS1COjhEN/Y6Ogmb8ZE9jREbp7ELm
    nWh+ChPLpn5aGuHEDAoLhU0EhAjhPfSPKluaqfEgFZhndI9JW3lAIGLUBIl7owx76YeLjk
    EPtbrWxEkSrJCvDpJeujJpvdeyVqMJmuGl8zqylEnUyMti8LGA7gh3S/kgRSvt5xtgTzsX
    3EnOCRnTHGm1uy3MHvxx8ScWOSBrxd/XyY1YutQaeUj7+4A1aT40yCPCX0QhB5hmnvID9x
    SRMo7mEFdxp9+vrCtkJ6jwy40VKHJ2OgcmOyHpE7GKXkKaObKlJVQtY7jSQngcDZbsjPWC
    D2Q13so0sqB9167PBWcZhhurX6y96m+OcYYcpmfSVaN16W3X5fIvx0t+pMRHE3O70By6dV
    JfkirzdayUqObpzKAjdn3QbjeuaX1X2kyYiA7vgMcz2mQ+2g4lwglmqFhjqmuEJiERztVE
    7noy8jEFWGfmnZ79fsKCHmttIPkgwUWSqyfC/noA0cY5T6A3I1BHbhODvFyQ
X-ME-Proxy: <xmx:EOKaalgvpS7OS7-JJkkPqvaNUnspPoDMdorMl-z8HG8YzrQlGXG-Mw>
    <xmx:EOKaan-AN5A9nSPuduskMSA-wpCC-TiIiyo3DNEvNyTnD2A00ViPyQ>
    <xmx:EOKaanYRmdOoANAKMEgZq2w_HZWMugkP2EU1kdOXRJp0zh2WswmzoA>
    <xmx:EOKaau3NZ1PkyjHI_eBept49S_Xxl3wl5sDiuwuwCInAF4ppXp0opA>
    <xmx:EOKaavxLfiwmfV87dMmFbs1hpKBLGlhCO4GXsuhRWWZqZC9yCnKLyvB8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 11:21:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: phillip.wood@dunelm.org.uk,  Harald Nordgren via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v4 1/2] stash: reserve exit status 1 for conflicts
In-Reply-To: <CAHwyqnU2c3T_i0gvkqiPPM7UYr8t5bzynr66iG4Z6YUKqZk1Cg@mail.gmail.com>
	(Harald Nordgren's message of "Fri, 4 Sep 2026 10:16:17 +0200")
References: <pull.2364.git.git.1784993669.gitgitgadget@gmail.com>
	<pull.2364.v4.git.git.1788373743.gitgitgadget@gmail.com>
	<ff4322180294c784bcd5f4e92b35e4b334324ddc.1788373743.git.gitgitgadget@gmail.com>
	<xmqqwlt3h1oc.fsf@gitster.g>
	<002b1324-0f7f-45ec-9f67-624a41801ff7@gmail.com>
	<CAHwyqnVp6BVGx3+UCqBC_gOCuyq1c62uNi1f7Wyfpxd1KdyM9A@mail.gmail.com>
	<xmqqqzjab2ho.fsf@gitster.g>
	<CAHwyqnW8sdnDcncpZpaMD8fmWaj+WJQxhA4G-Y+L5PTW=h3k6Q@mail.gmail.com>
	<xmqqwlt29l01.fsf@gitster.g>
	<CAHwyqnU2c3T_i0gvkqiPPM7UYr8t5bzynr66iG4Z6YUKqZk1Cg@mail.gmail.com>
Date: Fri, 04 Sep 2026 08:21:50 -0700
Message-ID: <xmqq7bl16nzl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

>> A local "make style" while you develop runs
>>
>>         git clang-format --style file --diff --extensions c,h
>>
>> which tells the command to check only the parts of the system that
>> you touched.
>>
>> I do not think it is used in CI.
>
> It seems to run as part of CI and doesn't catch it then:
> '.github/workflows/check-style.yml'

I never make any pull request to this project, so I didn't even
notice its existence.

My question was more about what is in .clang-format file we already
have and if it would have caught this.  I was actually hoping that
"RemoveBracesLLVM: true" we have at the end, which is explained like
so

    # Remove optional braces of control statements (if, else, for, and while)
    # according to the LLVM coding style. This avoids braces on simple
    # single-statement bodies of statements but keeps braces if one side of
    # if/else if/.../else cascade has multi-statement body.

would help us, but it only can do a small subset of what we want,
i.e., excess braces around both or either if/else body are removed
(see [*] below), and it cannot add braces around all the bodies of
if/else if.../else cascade only when one of them require them, it
seems.


[*] effect of RemoveBracesLLVM.

git clang-format --style file --diff --extensions c,h
diff --git a/git.c b/git.c
index dfd62d4010..c8df287d70 100644
--- a/git.c
+++ b/git.c
@@ -61,11 +61,10 @@ static void exclude_helpers_from_list(struct string_list *list)
 	size_t i = 0;
 
 	while (i < list->nr) {
-		if (strstr(list->items[i].string, "--")) {
+		if (strstr(list->items[i].string, "--"))
 			unsorted_string_list_delete_item(list, i, 0);
-		} else {
+		else
 			i++;
-		}
 	}
 }
 
make: *** [Makefile:3503: style] Error 1
