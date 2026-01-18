Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174FC33B6D0
	for <git@vger.kernel.org>; Sun, 18 Jan 2026 14:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768748128; cv=none; b=PiNjkowGBEgySecgXPv6yXhyXzRqf72Q9EUjOLOSxSsLjKgwYDXbeW/01DKUkbG0jXCOHTe+TN/1YwhvhiRsejAd5pRGqd5qzORwVqgQ4p3xAFkkFd/+LFvaredXClI9zk/vJeE/GSJAfPMbcj9t1svvenSZq/N8PWBHcUyGmiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768748128; c=relaxed/simple;
	bh=gqIHoRSWQmmCTkD7tC5dXWOiXJlHnbSy3tzKW1SRuPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ENE9aoz8MDASFFlRpFpYhfZsY/UBVIef7EtXywPZHRulAzQUn495Gsgg5ZjkR1olY0i6E0OsUHETAJHOyNVENn9oNWp6QnvQHwZWBfSH0agJZA45+c9GLLWLWkFXR8XrYWAAG4EwJG32dE2Hu8jOHqHbpl1cjGq/UgFTz0a5rCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=ReHqw3k7; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="ReHqw3k7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1768748123; x=1769352923; i=l.s.r@web.de;
	bh=sMuztoyyxkxNLqcnnn3Otoa2R16to1PYynN2FfKGfkQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ReHqw3k7ae2vj06r0C6+KXGVfvjCH2uaqGpq1MIDvsUTHxGBAQku9+k6reT0S+dW
	 qMUyzd0ukw+qks2BOj/1kimL8inRduGdcOqIFcRz+URpfl2TiVtbvVvBDyQ5F8Khe
	 uI9FdvlWm2z+zR3awxmG7627gqDABAhdNZA/WUkzQjpZWA4lc66f6Q7ZDzHBt/6wZ
	 Ssdt9hbGdYJxVK0A1nMSzk3MaAmqYkpZ1Z/gs5gQLOFsbNQ65zQNRtbYlkOZJ9swB
	 4OprbRJq6tSNTnlXdzJcQ7BzmdwxrwNuO/N6SLsbgkGoafNalmZCUoRqum91VsKrp
	 CywaLYpmouK+fHmSqA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.19.215]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MOUtm-1vRSOj2pZe-00HiAY; Sun, 18
 Jan 2026 15:55:23 +0100
Message-ID: <5c7e853d-f368-4d8a-a5f0-f4d485c1c3d6@web.de>
Date: Sun, 18 Jan 2026 15:55:23 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] ivec: introduce the C side of ivec
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
References: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
 <adf1395d201e916f23accc7644d21aff4f58368b.1767379944.git.gitgitgadget@gmail.com>
 <0a306227-5db8-4d12-865c-fa0efe5c6beb@web.de>
 <CAH=ZcbB=Yf=wn2O273adrvpUpE0bJGKwrAjOAjmB8AgJrjz5Bg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CAH=ZcbB=Yf=wn2O273adrvpUpE0bJGKwrAjOAjmB8AgJrjz5Bg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:o1WBMUtd4Ui9gsA+C79cItdg5CrNdlmqZvwir8Xm6R7EOQkKkRo
 8NM+ZdpNJ2y+s7TCMMM9YvAvnaGpDTxwxvyXTVKewt2WHQpBQa6oxsMx2q+IG8/fid+gxX8
 2kYh8dl2bx1uGPYHLg4L99NXAKkugt60HZj3aoPOfC55owmF/QP95aZCJeup7bxGqGWswcm
 pyAUiO6ukm9m4rb7oXYIw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MHUn5csJFpU=;XAFqk9VTZB947GLpgNPMRowI4Ak
 je6rex7DMvjiTfQ+qzGR8MOa4wTK2pkqRpyU9Pt07WDw3BN+IuUbYumUSjTJ/IEQXBHuTsg3n
 JUiRNR6JfhuBMhkGc1+OhM0UASf+6hY3Y122RCsG0FKbJG3buj22DEfL1NQO3Z1fMVZh5xij4
 xsBiJMD+O2cUcYwxGpCgyUbdyPji+BBOJRzvJnW5Z1Xw9hQb9COAGwaCtdYLaH5/jA2n/35Wm
 0tg9UsRpVmBfqMnqhJ35XKffvR9TYoAGHj1Zx9cymdlNoJB4R+dBC4L6wMQpfStwlQIMa2y8i
 HcQLp5zy+mXaDpJaLsBh9BiW1EOiGLD1KQ7mOWKTP43NQ2QAGjdJVg3MQn/bsVYsebZtAIeG1
 rNveYCr1P2tKn9kGZWvwqJ/FsNB6RgGzjZw8B/9AD3iCW4kPlJGKuDJahlBTYJr3fMmyZDzsF
 lN2XQQSxFyYmwzHLum0weKdPe41GclDYAeqAObg92XAlBWNrOOp/SIzbmpj4+fEonrMQ3jb3o
 WBTWn9gAXrioG57ZtOfJi8kJfhYHJ29XiDzaBcgfwnQvtQlIqYTfyrBcCtqaxiDxMpSbTpT7+
 S6bfPEC6Ht3f99+IptGogNliDOdsmMcPuUd/6T6ecCXxnXh8QUz8AnS575Zu67TSYf6oaphhk
 l44C89MNmB92tEpPuTi98jsvAGWZ/GAYzyzb28KJlFzvTVQpIvUqcgnDQyn0HYEGmmdMeuecq
 FNVKEV2J58gnnGX5+xUZugC0olSB9tei+gFiLfuCZDEpyRGWTqlBdDooI/xcZ3fkjo+edGGxg
 wbtAzQSaeJU8EwoMfbcidQA3sA1nQe9vXKMJm//DGPhI2LqGVezx5VqBKaSkrUlltCpwcPoDR
 5JdsRin6i2zy7ezNyZ9biWZBW9s9Fwgg8J75a/dHNqmJMgZ+gQzi5ViihPOy4K2gz3L5Rg91o
 2L84iDF2EzlJNwkn2Kp/uB6nkb0cqeW2micI1QM/XkDIJUjyPERMpLuxrXG8P/isHy9m4vuU4
 TasJW6obre6Nkz6cwrrLLuYG+rCj2Fd85skV55kilpGJaASkU0aSZsNLwIMrrYb66u6ZgHWtx
 cupEFBAY1ujyNBcLDxRZpH7s9uGPjyr86yQ2WsUW2/ndg+A/hEDkI6IsQ92F/Nm8ZSbTIH0p4
 vrIMVM31DL82UeKayIOPmGEJA4z/z7zvn2CNzDYnFCeN37k4d85v2oBFqnIjFPbukzJLCnE5Z
 NTrtfpZxpTw/W8BeOE1aEa3H5MXpGg70wrQLo7LmrcxmSQRxnosSLYof+8CWKRkbpHcvJBxAc
 eQyTZQAtYG8tVAgVXq1ddKu6tYsHHHlW0ImcsXeuWw/WpFKhV4pkbEISUnDARzTmVbRqda3kN
 hc03lFPO0c0pcBBDVQDQcu1L6o6IysDRDUEevXlXu8X9wTHU/oa6JE9KN+KsaoyVh/XlD8OK5
 e+c29WQtI3jjOHyYpi0r544PikkNyyfXwk/Nb4h2kSreNWeRMFsWXU1M5mIYc4CAPuzKtb25l
 zxjitHgbw7boWU8v3qJk/rRAo0d9dH0vbITTOgVwUMkZIJNzrxe8rpYFJ4uuIrgCDx67M/xSD
 Esr8fcd0EW4jRR/+IAshudS9uUwfVZVJduMNb2HCh2Henu7NeIxlzFSxr2lNlelLJzO01x9c1
 jR2QhMFvLTaYHRFIN9ar9lsABCcPgd6n5jJCt5I93mjEBZyb7qAe5RSRKPeHo0LFrjJGHNsQt
 cZllC8q0DBbhFMVZDmAqCLk4GIItWLuBDj+t4gvhAn+Gz0gqHKz1/ajoNusAce/hjr+hFkNpi
 QKGsqZ0JtZ5uLLXw+Flox4ukYyQBTLadOHq4m6dO2rlTeIt7mlm/fVaNfemsDn4ZL1Ro2jW4z
 4/QjgwZQo0b0F7xitReG5aR62my0BFkVFsy2MrszWNxvokc+NHSDpnBlLfm8NqLHoqGsMBppp
 0QkjXPssHDiQDxh9TJNxiPUYYRcv3+xUwX4eAIDF1XY9hMQVbJLyxGnmyq7WJBzC72jyPVUWl
 /qbpLYHdmLXwt7HWXaWYk/Y3tm1inGbNQ+GyWr0oo1gjaS0LM/7DkhFJBFUfxLKi0RC5NvmNF
 qT1eZKjCIxR7w3QEPQ0Ivqj1XfwxP7X/d5aGRbXSH790X3G0+PT/sWszPR7IDijdTiqQy69Fb
 2DQqESVg1FJmq9recs8GVYXU4VdPGwdkZc7+HjAMifnyWsrtmxnMXNvvNiC/KTdJbrB2dqYDP
 V07FzXqDMYMb9D//YNyULUN9+xrexjoP2OlKRWPRwBYrcIg3xhOwvfrhruq+2q1aWhKjgjr59
 miOcqvVtkWotI087s4IXEWQHKkgSxAaWattKs50LA9M4/YL9Ix4/pcsmLTcq27o9TgSbMZfVo
 mdBYUazb97mC94flg/csocYluwmA+tgKKBkeOdlNd511mRGQcRs1PZ1aE0La3iTbDgxn+14wm
 9aRrsimFtcCZWQAQRqbXYCoRP3FFwJ60fo+C3+vZnUE2F5Uv0kFBhcM/iZfjb3N0DxZdzkL3P
 L8W5xLJ1hd08qFnXeKA5X3IVdB68xeDbHOG/2c5gj0tu1JhIfRpCHKj6tQq1Qm5THOWriuDKk
 WSANSzT2T2uB1czFLWrxYXZiQmmMI97hJxyohlpODkGVm7RO7TjlZUaTCljZ6rU/WVjlRaBG7
 wIkWcAHlNnhxeWXqa62HYmPSt81YYePdAIr6ZRY3Qz1imupTlUYPeBZP9SrQFGJDcrL93V3f2
 yLwMYLOU8yBAQJSxlYtc9Z7j9vaRk+fkeI0d4zTBG/xX6VUy14eLDkkjkqsLej21avEr5D39N
 4PgoHM9H5RPG8c5Wl24QNRhavWoEE1xR6OdyQ3aOoL/xnJpNRB5QFigwrzm11hT/cToSTlB29
 BBI1mvYY26LPczcV/6KF4AHQFLveODCtH9I8Ljg9El3n4aE0R79MoRTCIFNyj4l3D1C4xbvVV
 WryG24O7AsHhXPYNIqd0krgMygHsNfvGdEba2k1O4LjITfZdrDBAUuni18/TYx4OSwDicLSIZ
 XsucYDrCfAvyxnFAf3/F3BFbE69zEjQBZaKgRFQOnmTbpCwlRsmLyJEtA5AXvQrPSmi8Zres+
 Y6TCTfusMTz1riz2Etsk/rhQV3CwbjrIYz9prRpptUCCHnw9Rm4ncuv5PG0KAPs01eWQRBl8t
 BPhqEH3bf70gBMdKCgyQogRIkU6KQiKclz0+YZj0pgNqVEOCTCE2a4OB0QaKgrwwc9+Xqt4sn
 sRSPV3FrNDLkf/s49HiVz+Qiw7jWN18B8/CPoFurlj8WJazxHYWpRav4CdATeUS5hQiEJcBpd
 QR+9OeHyWup+MBSZ+wH1c08t26dRmbVpySRjjltKRbG9Jmg6jFpunGBaLd3p/I1aXnQXgYbU+
 1pNq3lHwmZfVC/98Vk4LZwk+Do9u+oceeLYQ0fvnQc5ObOBL2J6v/jd0qRqyT2MyFVCp23Y/A
 PbWYQ255lIa9c5zFaKE45+IAND6iHkDi5T27Jmxs18/O8B87aOuRcVYxCtgqXSZ+UdMg3j7zR
 ByY9DCibG5s221fGSDRYyU88eMZ/Dpkb+lHXDgXHGSsbtxmk6MFSYhj+A0mF35RQY/loPlHNV
 HqgEXgOzGirEQDo3bn7TTWK3MmzwfXqvMzNPKJOfOb3dV5Ju+abUrjlPeDDmn6D458vw8XEOx
 S7oHyWbt541XKaquiL8D84m9qKvUOkcimGSNdbRzfymLqdiGx6rRasuiHltriiCwQ0dwstgb2
 3Yt1R3WeGT+H+ACeN0NPn65QvzhyLCCufbGxPe87mtPG01sM2TMEWISzvG3l3L0OtGFVWrX9E
 fgdca8Qg8E54ZN+i0wJHtATwAglZMada3sqsR6ZvmLiPYQxxKMepD1KqGwohQd5GMJkA56K+8
 gb0gDokSEYV3P2uia3b1QO3UnEcE+OwdDuXylBSqWcDqiYv0CERZ9xgU3jILC2jc70CVIq4zf
 KvwaayZhtAVtDsxBL6IXTVeTbzjzMzi6kGiFbpTUI/VpL+UxXnkj+8Vr6XvOnp+OKFTx/zKr5
 6na4hPRoRf9u0LfhJXO7mX1033c0YLJGduw2RHbkKxDd8o/O8rx6G+LunTPKYKsG76dxCPzu5
 4u77g/OhkFNv57IsibZVXHiHAJpYa3aBi8g4uzBYU8JgEaX5Adi1YHicu1/FfXZoQZWbToOMv
 TwHLSPNqsLhP2f9Ihmlp83No8+kWItkqI43smWIv+9BKSb7DJ1gBRnLC0D5e4XakK1jxJMcBy
 CDyRMtrN9v/YFsrBYVjX631mq90eQp4nQ6AzO2VtJgOb90w5XCm4TE+opfnYBSP2FCYek7oaR
 zm5PhBc1r9CUQbH3LgYshZxBiI8Sshi4Yj0m4u2QtbxFhXLUu4yMFAVuRtAF/OivvDC++G3Cw
 PcCJUtbSynSqpQWsj3y39cyaXO7JYn3AWZ4xZXL6ibOeqn0XHTzSUPDqxM9+pMckCSduv/733
 kAKnuUUFa9l8pRW2icfA3OKWRC950p4FELdu/cqs5baGXjhl5S2tO3VIooMoe+pZNVwgLofEV
 aKBrTWCUBJQtI8OZGj7Pewt9NIMWuac0GVeLL9CwNurmxrmC6ZSdShAORb+/cbKyIPvX6C7Fq
 11AbZ0SKT2ijAb16sI10ZwTjO62VZ7T4JqMz9z5XUFuyNEjmhljiorTABCZijbt8CattwqFad
 IhmHOsXPVD8Oes1Ji95OzPy73mSaJxToJ26jS9gkmN2nESJMQuPoCjNa37WD9Adn/K1coCMJT
 U1B1T8WB0bKvrHAuDZ+cmP29cvewdeBhakRfNE+H7Qx5J/as51x/+7ycXeJsnCdse5X9Cjg1M
 ezRqecwZ+O3OEeusHiGpqnAhsiLmcN53LZu92h6NCU8CtMS0OmzxIlM8j7kl8DD/ayf9isdqO
 eLEyB+9zYlVIEBgT4DbQ5lluIwjbdMKL584l17LLRvbr8SvgQYEDD4YtDlsM35NjeKzud13Vq
 sV8B6GJOCj3f59GbkKIuMeE++tAnIH0XfQxGZbQ60u2AWOONsBfiJqcCYk82et9YgrzQCXIeE
 yJcmpE2vz89OLjKkJm7wCTmIhsISvYrj7vGaXDUoOu4ZEtBtOfab9RCbdhYTyrd5Jiq7A==

On 1/17/26 4:58 PM, Ezekiel Newren wrote:
> On Fri, Jan 16, 2026 at 1:19=E2=80=AFPM Ren=C3=A9 Scharfe <l.s.r@web.de>=
 wrote:
>>
>>> +void ivec_reserve(void *self_, size_t additional)
>>> +{
>>> +     struct IVec_c_void *self =3D self_;
>>> +
>>> +     size_t growby =3D 128;
>>> +     if (self->capacity > growby)
>>> +             growby =3D self->capacity;
>>> +     if (additional > growby)
>>> +             growby =3D additional;
>>> +
>>> +     _set_capacity(self, self->capacity + growby);
>>> +}
>>
>> Constant growth steps like these cause linear growth and quadratic
>> complexity.  ALLOC_GROW does exponential growth with factor 1.5 to
>> get linear complexity.  Here's an old plea to do the same:
>> https://blog.mozilla.org/nnethercote/2014/11/04/please-grow-your-buffer=
s-exponentially/
>>
>> Ren=C3=A9
>=20
> It _is_ exponential. ivec_reserve(&vec, 1) means grow by _at least_ 1.
D'oh!  Right, it grows with factor 2, as growby is at least as big as
->capacity.  I can't read.

Ren=C3=A9

