Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82B0287258
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 09:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761125877; cv=none; b=EQBHoXZzhsOFizSVSGqELCsP+YxoTqr1XFQvzxMSUz9+hKmZnJ/vsdEqslSt2U/fPtoXLpUpZTzLX6tgcHxtpVh1K83OXp4Fj2Th27Z1jeyOmFSUSoqVN3KqDOZDV2oA59jDTvXUATx452E7xXOOexohVdJnsGxP8gJo2jNkSCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761125877; c=relaxed/simple;
	bh=FE75UB1GeUlADpOQRjqxP6PPvxCs4jKyclbY5DsI058=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=soC5Czb6QgWkg9GrwJfBa+VLT8Y+4J65l61RxsYSdTop0ToikMrAUiW+2obfP+MS/fJvYppyj1XmZKm8IcHfYz7jcXBeJWJZkSH4Q8vSYPnqj/w3eaBaJFiSiWydjx6AGqac6KVc+cSdjNizRxNxZZXQt06PskwP5hqLAXSKjbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=delpeuch.eu; spf=pass smtp.mailfrom=delpeuch.eu; dkim=pass (2048-bit key) header.d=delpeuch.eu header.i=antonin@delpeuch.eu header.b=Hca7WK+a; arc=none smtp.client-ip=212.227.126.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=delpeuch.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delpeuch.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delpeuch.eu header.i=antonin@delpeuch.eu header.b="Hca7WK+a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delpeuch.eu;
	s=s1-ionos; t=1761125867; x=1761730667; i=antonin@delpeuch.eu;
	bh=rU2kObhqJ+4HGirz+VR7G5mlSgwjtAMQ0TROdD0y5Nc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Hca7WK+a8GuAaOl3al2pv/d5uySd6ecUv39OjolOyeL1UZdOtRBLRuq1QG4y1znW
	 X73OEnCpn5BEHb1nkBtQ4t7VvfcQnE9CAbHM3pYUkGC2yLyEhoI7MtpcjG37+1AsY
	 Kmnwv//dFCUKg7vEzm5F6qd0maHWoenbwFVgRQLO8HLCExvbbRbsof2FpANF17621
	 YsGsE/K1wxBf66PpJnavMKP7BK9G4Bb4jpz8oyJQnPUfWX5GISpWil7GMTxEeDGXN
	 p6BL/ttEVdnGHWC5oXWWmOQUeOSg81dZDBHO+21gwhrgNwoEgwiJkgVtW9Sxb0KqD
	 87LSi8kzRQmTcjlF8w==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.178.21] ([79.246.85.239]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N5max-1u63WK1ZlL-00ybNX; Wed, 22 Oct 2025 11:37:47 +0200
Message-ID: <d59a2f97-1a69-44f6-924e-7419e36329a0@delpeuch.eu>
Date: Wed, 22 Oct 2025 11:37:46 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blame: make diff algorithm configurable
To: Junio C Hamano <gitster@pobox.com>,
 Antonin Delpeuch via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
References: <pull.2075.git.git.1760972162827.gitgitgadget@gmail.com>
 <xmqqldl51rtm.fsf@gitster.g>
Content-Language: en-US
From: Antonin Delpeuch <antonin@delpeuch.eu>
Autocrypt: addr=antonin@delpeuch.eu; keydata=
 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
In-Reply-To: <xmqqldl51rtm.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mB40GzqlNq5COCCVdeNLxeEfWZ04ACq8psEHOO+wmrHnv8FCwkW
 bB5lLw/rB7P+YtJG740/tN8dnD2xWvhcejeBfT3Lsj/7QV9VYqjyXWFKiM1O613k0fEhSrC
 rWVjkZ8yXXVBHrcequYZC4fP3fOCc06hL924Kk5xJf766qt5M7Zbi5lPp0Rh+YR/LXXEOW+
 8ILS767E4Xp/bEDZ+UJJQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:10BsxGIxDIw=;f689TWdKlJ/02piWWhdzPTvWF4i
 3wJUJ/lGmTSh18vgKlt4smYQ+yvMIIpMx3dHY6eQRl7Uf62DMRqUJPVZ0MtUQncohEPvi9L9T
 1HPm0mEFogv7hod17xeYvykf0TH+wMISg3ulUwa6/mjlTZq9DSaXHAd80BLV3RPBQ7Tsxaaug
 moDJn+uO+JQKWRUMI8c8RuUXMpaOyB+Xnuiz5CDExCBS570cWLXHXHJOLfB6RV7gjYPypysES
 Zutzc30fcj2cIA3HpN3ddQ8xqNCWGh4r/pddkJdy9RJySv6a1wrZ1M7g3W887XzzoloGnLbSj
 AmB9yA5wgMmG6R//mmD4YmdpSl7Y14i13I1vtZMCJ1ylYX9P4Y3e/RB/+idBKTJA1y9rl1JRW
 rHV8LOET6wHQ62lphyfSo0WUhCe6Eoaou2C9QiGesHXFhPR33/bPXbiVl+ITqS0h+D27TCtlO
 p5UiThJvmblUvIZG6bTJMREY4e4uGzOPZBG3/AV1EMnLwRmW701ESXAVzv8iF2j5lvmGKfBLm
 LLd2SzbXTy6O/8Qtlt2ms9PjCsrsTnyNDKug4CtLlZ4giUBpCW2sVKKJV/DDXUCNiEHzBAyZ4
 n1iKoQLVekAu8yUyIGV/Ti5b8aws3iMaulyoIko3stWUWC/WH5ni2Obc5oEbwKLk9rySaqpKE
 NzyGiXRkP8ruyJjYlW6Hi9v3ehEXb7SAUPNVWtx0kqHFtgrhFX9RCDVTfw+toUSiWSoKdKe2t
 jR3ySnZGdiDt//nC1FogyupFLNVfU3VDqATNKA4T+uDtnwfokfLKyT4uwfIJ2Tc7WaDjrJPGB
 f/lSRsnpUkTTvlHERDnQHXrJSibzghG+lDWeR9+13oI2xDRGsgxzST4Q4+i0OTmvNZxXFgyOH
 eauz18D185blzGDgzcyaa/ksWlpWHHQwbcOazjY125lqzkFSuVkyeCbU40pKjcFxjK4VfM3F4
 E+VF0J8DGIH8ZAb8uScC4qhOeJn0iQ0wlyFk8h/e2/kYR50uCDLXlOyx57vAYcaxXL32ms1/Z
 oSOGbknqkqF4wjrelH/8uLQvrjAgJwRmArfi7ZQI1tkSB3OJgXrVAeZKu7GTXdt4PPG7a5czF
 brr4Mm+JZfeNoPyipWdxfcWUoR1idpIDuKfaIAxEHkHAPYMkZh65+zUHFquPTOdU024FvWl5i
 z2z14CMxccV+s4yC7N+pzS3tVuHXSK2TGcwiuhdw0jy4gaXFEawHG+5sd537Ya4WIDfFkZpjQ
 9IxkMtm0fxfFnH8LICdHUfXEKgqaE2ZzkwYfaHqLnR+CfWjsGRGojPmvvNQL7rSMbE5oAnlyL
 ZEImyExj2LGTI6jV8+aVbYDRHniyGVxkxV/Ddtp63N1BgQqHbKk4s5bc1I5P3TvCl7dZpbteu
 gFqTo5RSBwjZegfL7GzO6P3jbtoOZ/iTMu0D9QMMIMxAKRPAXj2nOJtxa7ILfy/0loB/2/9QK
 Snhaa0zV0J1+cnNeAmyvm1sTzK1O421dnBypt3FRNkrOMBikIroTta0Lkm7GC+f3ZI0y4BNXd
 cJ2RyIjaOpI0FJ5s9L9FrZpCiiiZKVnma8fPhZyQWOLiipq75dLn4CuLNxRwa813Y23fxtBn9
 NuHwFM+5NdTEHPPQTD2OLZJKuEpiz0YhsOxjmvKybw3oRezbTBqoxLTQS+Cn2vsiMUjM97UaH
 ZCAttYO/1ybrfI7yAOo39tK/yPYZ8ZLC0wlYRYjqLQ+YEtwWG6Q4UqrtgzYdfQGaxZVLfzex5
 LnDD5A0h5Cbbz

On 20/10/2025 18:05, Junio C Hamano wrote:

>>      If the general idea of this patch is judged worthwhile, I would be=
 happy
>>      to add tests to demonstrate the impact of the diff algorithm on bl=
ame
>>      output.
> Do not ever say this here.
>
> I've seen from time to time people ask "I am thinking of doing this;
> will a patch be accepted?  If so, I'll work on it." before showing
> any work, and my response always has been:
>
>   (1) We don't know how useful and interesting your contribution would
>       be for our audience, until we see it; and
>
>   (2) If you truly believe in your work (find it useful, find writing
>       it fun, etc.), that would be incentive enough for you to work
>       on it, whether or not the result will land in my tree.  You
>       should instead aim for something so brilliant that we would
>       come to you begging for your permission to include it in our
>       project.

I am surprised by your reaction here, both by its substance and form.

My understanding is that gathering feedback on a proposal before=20
carrying out the implementation work in its entirety is widely accepted=20
as a good practice for contributions to open source projects. For=20
instance, the following guide encourages to do so (in GitHub terms, by=20
proposing an improvement as an issue first, and by opening a draft pull=20
request if necessary):

https://opensource.guide/how-to-contribute/

While this is phrased in the context of GitHub, I think the general=20
principle behind it is healthy. In projects I maintain, I feel bad for=20
contributors who submit contributions that clearly required a=20
significant effort, but that I can't accept for certain reasons. I wish=20
they had got in touch ahead of investing all this work, because I care=20
about their time.

In fact, I already did so for an earlier contribution to this very=20
project, and on that occasion you did not seem to take offense at the=20
fact that my proposal was done without an accompanying patch:

https://lore.kernel.org/git/8bb5e41e-4db9-4527-8492-3aca6a0f40bf@delpeuch.=
eu/

Has your position changed since? Or did I benefit from more of your=20
kindness back then as a new contributor?

Your argument about my work being worthy on its own even if it's not=20
integrated to your tree is an interesting one, but let me expand on my=20
motivation for this patch. This change is not something I personally=20
need, nor something that is particularly fun to write. I am working on=20
this with the hope that it will eventually make it possible to switch=20
the default to the histogram algorithm, for the benefit of many git=20
users. I see no point for this patch if it is not integrated in your=20
tree. It is a gift to you and to the git community: if the gift is to be=
=20
declined, I'd rather not spend time crafting it.

Concerning the form, I feel obliged to let you know that from my=20
cultural standpoint, your reply reads rather aggressive. Specifically,=20
the sentence "Do not ever say this here." reads menacing to me, and the=20
use of all caps later on in your reply reads aggressive to me. I'm doing=
=20
my best to assume that it is not be the attitude you wanted to convey=20
and hope that you can receive this feedback gratefully.

>> +	*opt &=3D ~XDF_NEED_MINIMAL;
>> +	*opt &=3D ~XDF_DIFF_ALGORITHM_MASK;
>> +	*opt |=3D value;
>> +
>> +	return 0;
>> +}
>> +
>>   static int is_a_rev(const char *name)
>>   {
>>   	struct object_id oid;
>> @@ -908,13 +941,16 @@ int cmd_blame(int argc,
>>   		OPT_BIT('f', "show-name", &output_option, N_("show original filenam=
e (Default: auto)"), OUTPUT_SHOW_NAME),
>>   		OPT_BIT('n', "show-number", &output_option, N_("show original linen=
umber (Default: off)"), OUTPUT_SHOW_NUMBER),
>>   		OPT_BIT('p', "porcelain", &output_option, N_("show in a format desi=
gned for machine consumption"), OUTPUT_PORCELAIN),
>> -		OPT_BIT(0, "line-porcelain", &output_option, N_("show porcelain form=
at with per-line commit information"), OUTPUT_PORCELAIN|OUTPUT_LINE_PORCEL=
AIN),
>> +		OPT_BIT(0, "line-porcelain", &output_option, N_("show porcelain form=
at with per-line commit information"), OUTPUT_PORCELAIN | OUTPUT_LINE_PORC=
ELAIN),
> WHY?

In an attempt to conform to the coding style of this project, I ran=20
`make style`, which generated this change. Given that it is on a line I=20
hadn't touched, I pondered on whether to include it in my patch or not.=20
In the past, I had submitted a patch which fixed a formatting issue in=20
the documentation in passing, together with content changes further=20
down, and you had been supportive of this:

https://lore.kernel.org/git/xmqq1qaeqtw7.fsf@gitster.g/

So I decided to include it this time as well. I am happy to remove it if=
=20
you prefer not to have it.

I thank you for the rest of your comments and will take them into=20
account for a new version of this patch, pending the discussion above.

Best wishes,

Antonin

