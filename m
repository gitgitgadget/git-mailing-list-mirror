Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1FE1487FA
	for <git@vger.kernel.org>; Thu, 13 Feb 2025 21:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739482742; cv=none; b=s42DRM4qiwyZbJnfx22Mss2swNqDUicH65GHAjPN7TpexwSX0tZDCu3DQZn35j2DJYEhBJioV2HadLnKlUcFz0ECh/U+gJD/j76wz9dCdmGi8o7CyPxa4T1T/zdp05fekHClZB1V47CNsR7C1MzybD6hnz77td5sr6x5X/rrmTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739482742; c=relaxed/simple;
	bh=XMYcKd0H+AlBMu5BSFHEu3fnzETpPZLfndEOFqx5POo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=EeWZXsQoDpcHh9ISbYrNwVtpCl7C9i3CzIKiY7RN2tGEjBTQJJvaGzXt9i8YgH66qX+bT6xfD1qn/QCjzYHl9qZyRqueGbz5mZAnjMAeZp9MBjH6yPiq66HnMpt4HikiVj7O3u+0J88brbOFXeMRw97qPvgvP+Qwmucd2z/Pwn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=lLVP6M0S; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="lLVP6M0S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1739482732; x=1740087532; i=l.s.r@web.de;
	bh=wHoZHaPNXsXZU8uLqRwPVvaai8lkPoQMN9NqKT0soPw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=lLVP6M0SpTgPbfn0w84wSLLsDaZ9o3BG9vTu43Hh0pL0OYUWJ4xR0znjM3Z1z0Ue
	 k1xEwhbQPTrmSgZ5iGrc8z/JlXcNilk5Xup8Yk+Gf0LfHhgTFfbM4nS/9iLJuCibK
	 XCS7X4uX14iX+Ugqo8o2/JtM05PS4YqG16eHbWa3wg0XYfooRBg01jEMQINTsqzYw
	 V+Ie3Iqtzz1iiT+fXl32YdaNO5CH/nIU+RpDpKVri3KwUqR0xelUimle+36H5c361
	 Ibpyzj8MsuQnsi+X4PqDsmXOuI2tKSvbkVesDaz75dULWLEx4fV0GADhsgyhiluD+
	 +CZ52huDeBWB6QtfrA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.154.101]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N2BMA-1tEToI0Ygw-00r7fE; Thu, 13
 Feb 2025 22:38:52 +0100
Message-ID: <69909785-7f7a-4164-bdcb-bed61d006cc8@web.de>
Date: Thu, 13 Feb 2025 22:38:51 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH] commit: avoid parent list buildup in
 clear_commit_marks_many()
To: Patrick Steinhardt <ps@pks.im>
Cc: Git List <git@vger.kernel.org>
References: <16a7b572-0a3d-4707-9034-0dac69ea99ac@web.de>
 <Z6xIPowXnL-awm6g@pks.im>
Content-Language: en-US
In-Reply-To: <Z6xIPowXnL-awm6g@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0LTijPePbSbPGDxCorPhu9uiWUD3ZRxlXuoE0dsMxIdl6FnC749
 H8KIrHClS+M1cR/rfoz7rFiDdSR1NaPLjqQljmo9qjm3I6y0I7YuwfmIYYq+7HxwQHcTuAh
 qU6JGVH2OfLrfRNXnwRJ1Ti0BY8FePVxdfelLbnvVpAJQsUJaFdLYWiV0GfeItiMrcbXaqF
 t+ZmnumKXOsuRRHT0jR4w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:F6yryazsKVI=;i+2GZm4FEx+7FItCvTK//zIWDde
 BsDIpSyHoo2wt3Cu+nb4zIHf+dAiNNjMijASj+XH//ZTmrOtzaFZ0CGY4GGi4dcWUiypFYWVK
 B63f3SxB61S76A658aTfnBYvxvBIPlifnOnt6mAcZ83n6HM1zI8cxu6U0BlVVvl7Cubu81ugJ
 brsBZnmLDJ4e/19bK+QV6WoeYmpwcDWtefvuzshqq8wqc8Hevzg5DrnkxMx0ICDJc9ah9vUo0
 SqO0rUvvCYNa5wd00r7aYiqaRnuYiYPPWjflfGPdMEh9l8MjY8S0lFsdDeogudgCfSpuuJc4E
 W/COfxJnzgcYisYSt8BbNL0OEag5CEOXJ5xXW+BPX2DhGK+mWJqUoaQk/7Bn4aTIQd1tY0qVt
 CWnsZCw/X5A40tZKiWEqUXe5aaEUIA5VjSX/xqbbaLdHgfxUNh54zpKMxWVmgqTsAFky5Bswb
 EbEdvamg8qGY+abju75Qk4+ICzHC5hJI6XXsYcBE3QY2KUs92lcg2MdlMBW3WS0RCNOZls9yp
 F3MSr8F1PdEDstROdCx7kiYllTEhCDvzVOL7rV1rlyzf8Nx+hbNIuPULMPccrg9UwTwzUR7WZ
 UPqAY+YJDHDvZIuyOifvYl1i6KiBRRUtQAdsEaJeqkd8Lt5GmDglwqmDGyWU9Vx8IC6XiY7P4
 5UvxWwdhMyBRMJ0F/br78xHICGQ8KpGT7YOiOaCqQFEjba8DnlVJvei0GOB1oTSIITCjK4RKp
 WbcfqTOd37/obgDfk96cROBZd15vFO2rldSTrO+IjSjL47R+aqukpQEYI8ea6npgsPPm1Yhaw
 iiFk7YuECYIdOLIdDz/5pv7Fs1I2NcB+8zr7XG0OJNj9gqO0sSX86nAniuJg4ozzFkLObUsdd
 h5GTD4z2aUmOgl76KLWNrwDjORBgBCOLS4IiFieYdX/OKm7n/Zer+nAxKg1JPGEx0Wk4wklb6
 Kker9AxVb52eFJp7w0zUnWNhywyYc4t3CS7XVBsKfjvLyaVgdChy5Cy9wFKvS9OW4T2Rx6SRK
 OTOqxHCEAUotgePzZ9bhlrsw1BDBjwpfSaJswq+OsUcMlUhdQhqNe0Ea3X5lx8Nkm4/NLn6wb
 e7FnrmgDKR9epSOnWZVtJkmRvOiuwn394lgjMR2r5zbNMO06PAGsdpER8AB0VgOS//ZaqcytJ
 ZRrSlbHJjsAwmEeYvP3jVW2purlYntPhtYA+unZzuAiHBeUuFyaKWegwSPPYi8B48Eo6Da6IO
 WOXuUXDsiM3SID73CYY8hEPQ934JlZ0cVDwV+ALxz5T/t6107R1oIzQS/BSadIIc+l2xECsDC
 0HYwHJpvQamv+SUpMpq9+QiQFfckuXUnqtrEQlkqI4nIJFTbLpTYzHpfs3gcpylZNdJ62j29f
 D/1merjZJhp71X+52Z4gzKEbDik8wUwbK2DDmOj1MAKM3SRetez9P6T3KP

Am 12.02.25 um 08:05 schrieb Patrick Steinhardt:
> On Sun, Feb 09, 2025 at 11:41:15AM +0100, Ren=C3=A9 Scharfe wrote:
>> clear_commit_marks_1() clears the marks of the first parent and its
>> first parent and so on, and saves the higher numbered parents in a list
>> for later.  There is no benefit in keeping that list growing with each
>> handled commit.  Clear it after each run to reduce peak memory usage.
>
> Okay. So the issue here is that `clear_commit_marks_1()` only processes
> the first-parent chain of commits, and any other commits will be added
> to the `struct commit_list` backlog. Consequently, merge-heavy histories
> are very likely to build up quite a backlog of non-first-parent commits.
>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>> ---
>>  commit.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/commit.c b/commit.c
>> index 540660359d..6efdb03997 100644
>> --- a/commit.c
>> +++ b/commit.c
>> @@ -780,14 +780,14 @@ static void clear_commit_marks_1(struct commit_li=
st **plist,
>>
>>  void clear_commit_marks_many(size_t nr, struct commit **commit, unsign=
ed int mark)
>>  {
>> -	struct commit_list *list =3D NULL;
>> -
>>  	for (size_t i =3D 0; i < nr; i++) {
>> +		struct commit_list *list =3D NULL;
>> +
>>  		clear_commit_marks_1(&list, *commit, mark);
>> +		while (list)
>> +			clear_commit_marks_1(&list, pop_commit(&list), mark);
>>  		commit++;
>>  	}
>> -	while (list)
>> -		clear_commit_marks_1(&list, pop_commit(&list), mark);
>>  }
>
> And this is fixed by immediately processing all commits that we
> currently have in the list. As `clear_commit_marks_1()` only processes
> immediate children of the handed-in commit we know that it will have
> processed the first parent, and `list` will contain remaining commits,
> if any.

clear_commit_marks_1() processes the whole ancestral chain of first
parents down to the root or first clean ancestor.

> We also end up adding grandchildren to the list, so this change
> essentially converts the algorithm from depth-first to breadth-first.

It's still depth-first, but all second and higher numbered parents added
to the list are cleaned before starting to clean the next commit from
the input list.  So we go from "clean straight down for each input
commit first and clean their side branches later" to "clean all
ancestors for each input commit".

> I bet we can construct cases where this will perform _worse_ than the
> current algorithm, e.g. when you have branch thickets where every commit
> is a merge: But I assume that for the most common cases this might be an
> improvement indeed.

I won't bet, but I'd like to see such a case.  Can't imagine one.

> The question to me is: does this actually matter in the real world? It
> would be nice to maybe get some numbers that demonstrate the improvement
> in a repository.

Well, the maximum list length for clear_commit_marks_many() calls with
nr > 1 in the test suite goes from 12 in t6600 to 4 with the patch.  Not
that exciting.  The question to me is: Why pile up parents in the list
when we can clean them earlier with no downside?  Or is there any?

Ren=C3=A9
