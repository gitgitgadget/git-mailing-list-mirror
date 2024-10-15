Received: from aib29agh124.zrh1.oracleemaildelivery.com (aib29agh124.zrh1.oracleemaildelivery.com [192.29.178.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A29F1AF0A3
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 16:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729009908; cv=none; b=OqH6OeOgvAIjY1Mj85RU8v9jwvZjip4AwgipQQ9wk64cIBNexqP5oUk0q9sFfD39PccpGX3EvYeGDJES04jmoLTYAGyoeJfMhh7dKdwtsFSeoKJxvscsXek/s4SuW/wS9jddcj94k2rdGI/q11sSct5X9mFgU7UOVa4/tiSaXeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729009908; c=relaxed/simple;
	bh=TqEUJrzCN7gp1Tezm4HN+MwQqZYfikYAWJ5W89K6VWQ=;
	h=MIME-version:Content-type:Date:Message-id:Subject:Cc:To:From:
	 References:In-reply-to; b=sDyoyfQ7kZ7OX6gHRXejXcuAIChREZ0hqS5vXY/8u5ZF0/Zjz5UqsR6XoKbfraL4VOwMYQYPPTQ97CkQuJxyZdEarpFRs4JXRyEUY2tHCD8LPW9mXJ3MoTcGB5GGgk9F7gkOzFVKBrnOYFToMF9RViG6ydFVO9meB4t3Y186PJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=ZFZw8FEr; arc=none smtp.client-ip=192.29.178.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="ZFZw8FEr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=vuPbolYzQoMWb655GW1ALLIGNK7wC8T0FeW5q+6lE8I=;
 b=ZFZw8FErXumh8xraIDwcC0xn5YJdl875m18xKtXhv0MsV05ROO3ZtG6d97ApmvjnKiNKscGadjUB
   VDaOwj7co7AjQsP+e8H8GOHfe1op9JxEJeIUQpR69DvADKxyBFe3fI/B5xTfuurE5e7HJYB/zJv1
   O+YA8h/qs/qPMfW74VGQC32L7Utn2iM57+sq85jiO7SGDTeHrklsDrFLSrlVpzRGXgFjPABLUHWB
   xvCIaWR1X/k3905XJ0mm/2Q+myWuHPl5OFPfSi582pcKAVu4dXMrhZ+mbovDSpkqUKQzLLbf6Wh/
   W41sNP6T2+x+SnngBXyHlphPB/6zX16Wv9hzBA==
Received: by omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SLE00A8IOKXAH60@omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Tue, 15 Oct 2024 16:31:45 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Tue, 15 Oct 2024 18:31:02 +0200
Message-id: <D4WIUDMT92X8.31YFOS47V1B4E@ferdinandy.com>
Subject: Re: [PATCH v8 3/6] remote set-head: better output for --auto
Cc: <phillip.wood@dunelm.org.uk>, "Taylor Blau" <me@ttaylorr.com>,
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
 "Junio C Hamano" <gitster@pobox.com>
To: "karthik nayak" <karthik.188@gmail.com>, <git@vger.kernel.org>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
References: <20241012230428.3259229-1-bence@ferdinandy.com>
 <20241014225431.1394565-1-bence@ferdinandy.com>
 <20241014225431.1394565-4-bence@ferdinandy.com>
 <CAOLa=ZT_m=H8pW9qkoOf+b0bLnzvT-3taQYFu+J6WT3DRi=6sQ@mail.gmail.com>
In-reply-to:
 <CAOLa=ZT_m=H8pW9qkoOf+b0bLnzvT-3taQYFu+J6WT3DRi=6sQ@mail.gmail.com>
Reporting-Meta:
 AAFCPtQWsvrvBUFHjZYINY6vpOcMsYrCgOcwz+OOugXhI2ID3H3c4Vtnzt5NeJR/
 kU9z0bg6ORCrC1GUIBOTIc89+AoyL5MyAbSGRSBLOS5erryOJtWDj4BTNY4L76Ys
 MioshZCXhPF9MmAh2WpyxChs0TjK+b49r+5zpDrIVSP+le4gGH7qpoJCG3U7Dgu3
 H3htv+ER/yAO0RmzGdqfbKe/o3D3sJNAXzTnjs/2c8gx7NjMqqk4SgW/AwQgal2+
 PrkGY3Rut2YWlZAMQKGU5Ffb9g1cUOx/4sM1BwgbXg/Zhsm7ulFp6JsWu8JC6rU0
 G5rZucP3GNXBCftXOrXrr9k78TxwfyxeNhbgEDIfxa/j40bTcW8F4alUXx6Kpsyt
 besEqR9C4Q+6uEUGuTSaxIRkEKIDjtJT3WH2W3njvnRQ1siz+fUtK+/ScgR8qle4
 CD3auuvmeMpbJmWoKV7llT+SEw1RsD0boTEAtRAFdNYQroTrRiRap9hR


On Tue Oct 15, 2024 at 09:47, karthik nayak <karthik.188@gmail.com> wrote:
> Bence Ferdinandy <bence@ferdinandy.com> writes:
>
> [snip]
>
>> +static void report_set_head_auto(const char *remote, const char *head_n=
ame,
>> +			struct strbuf *buf_prev) {
>> +	struct strbuf buf_prefix =3D STRBUF_INIT;
>> +	const char *prev_head =3D NULL;
>> +
>> +	strbuf_addf(&buf_prefix, "refs/remotes/%s/", remote);
>> +	skip_prefix(buf_prev->buf, buf_prefix.buf, &prev_head);
>> +
>> +	if (prev_head && !strcmp(prev_head, head_name))
>> +		printf("'%s/HEAD' is unchanged and points to '%s'\n",
>> +			remote, head_name);
>> +	else if (prev_head)
>> +		printf("'%s/HEAD' has changed from '%s' and now points to '%s'\n",
>> +			remote, prev_head, head_name);
>> +	else if (!buf_prev->len)
>> +		printf("'%s/HEAD' is now created and points to '%s'\n",
>> +			remote, head_name);
>> +	else
>> +		printf("'%s/HEAD' used to point to '%s' "
>> +			"(which is not a remote branch), but now points to '%s'\n",
>> +			remote, buf_prev->buf, head_name);
>> +	strbuf_release(&buf_prefix);
>> +}
>> +
>
> Shouldn't the messages above be marked for translation too? using `_()`?

I guess it is unlikely to fall under the "should be machine readable" categ=
ory.
I'll fix that up as well.

>
>>  static int set_head(int argc, const char **argv, const char *prefix)
>>  {
>>  	int i, opt_a =3D 0, opt_d =3D 0, result =3D 0;
>> -	struct strbuf buf =3D STRBUF_INIT, buf2 =3D STRBUF_INIT;
>> +	struct strbuf buf =3D STRBUF_INIT, buf2 =3D STRBUF_INIT,
>> +		buf_prev =3D STRBUF_INIT;
>
> Nit: these names could definitely be better.

Indeed ... The second patch is a refactor of remote set-head, I could inclu=
de
a variable rename refactor there as well, and use the same names I used in =
the
last patch when adding the similar calls to fetch's set_head.

