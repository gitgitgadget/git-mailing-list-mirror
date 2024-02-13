Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1786EA93C
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 17:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707846080; cv=none; b=rGs1+taTX2U2j4HWfEaZCXrwlEiKRFCGYJL1o6+jZohPCV2oQYmsMhUHrXMuvLN2BYM9z4A/HdYKk1NPcPAzDlCS76FFrPzmAMQHOigDsFeGKqfvBGW6ql9FLJGyLfFefz1fOs5yTYKcI9u3Xtn0q1gJO1rzdokMXgWqk+I+eWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707846080; c=relaxed/simple;
	bh=kIf6um9kEVDphrGSRmM+3nVQFbErcvngpTKXWNfj/kY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sFZMM30fx11gzw9+zuawTla02LFE/AVb7/TMFpQ1xzfAVRLr2Pw/wODwGpX+KhcVUn7sbO8pI7SVF37I+OyyX2aXjDmFqqZbeYIqI+WW/Rp3Xd2Oe3nQTlvihjBuhRlBO08ebdl5GR6ZPNiPjOtWPVONVjMr3FQ73U/0BVIfswo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gOnmb8as; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gOnmb8as"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6dbdcfd39so9265258276.2
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 09:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707846078; x=1708450878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xQaGICI2R2EESrZ854Q8PzxpMFht1BCpGn7/WLZQ/Nw=;
        b=gOnmb8asnhj1tKRgkY2k1IJWnMy2yB/mMupWqgC43LJUCLeOfCBtQUM1acg01JLC9S
         rTqCdl/Hy/RKv2jn+3zTfgl88GUZAl8HBnlw/b9uShZ4F8gR0aDl0l9sEoGdHpfteQ4p
         6U/BtGeTG1ctwJJPLL+rzubPuYye+1pzbRpirZQsidnOl91eNws3S3LT2NiPbQpUD2OW
         VZldvEp5V+51o/Of97nCfd9umezihKRT98VyOIoat14KLAT35fPxYPtoJCXJ+vFKUqnP
         +vHjV6UdPPYh0SvSM7IpLksyvmo/mAUGV6vrjNlC9cMBZE5rUZE61ntYiy/mKBB6K4GR
         ysnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707846078; x=1708450878;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xQaGICI2R2EESrZ854Q8PzxpMFht1BCpGn7/WLZQ/Nw=;
        b=fCDVgMJD2YgdcRgiftwY+ViQC6zJ119kLK2FJNpLF936XmrFbZZ6h8+zEUqKzjhPil
         SClOM6COMnDfIvtvYW375alMtxu4wpxqJSlHOPDeayRONaDiaWlHGwILrJRzxvVJ92dx
         aCUXArDnDpU0pkSNcTaFrSHgXY/JAMM5LmPJC/oIX4pjCDykV51dhqcQDvSiUiYQcube
         8xPAR904gNBDPtgdytz4rlovKEM9ea4SCr5N8l+Ys2fqG0bfXVSVmPYahlA0RJko4v0n
         NFk+rkvHEj23yeAWHIenuci6ntr6t5WLMHKI0A6zF1NUU9GVsnCy09MtFuXX5sGYyQJx
         h9Bw==
X-Gm-Message-State: AOJu0YzfqJL38HZ5MgfsY/MmeIelZgMKBsHsiLcz/tBmLvxSeCIqHpUV
	qnC3mkN5bBWi3l4zhDELIBexOwOnAolt7zSPuJlU5VuY0UsSYL1gFkaGfy1HaJemcKUAa4hBQ0+
	sdA==
X-Google-Smtp-Source: AGHT+IGCdsdg5lEHW2DOjH5Xe0qTrtpgF+JhMU3vqtxI+XiBeoiGecQd+XPUY15xwXvgs5DNXXDKC04GVuY=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6902:10c2:b0:dc6:d2c8:6e50 with SMTP id
 w2-20020a05690210c200b00dc6d2c86e50mr1674118ybu.7.1707846078188; Tue, 13 Feb
 2024 09:41:18 -0800 (PST)
Date: Tue, 13 Feb 2024 09:41:16 -0800
In-Reply-To: <CAP8UFD1twELGKvvesxgCrZrypKZpgSt04ira3mvurG1UbpDfxQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
 <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com> <f5f0d06613f2701af9bd3a1a9274aae232e03d8f.1707196348.git.gitgitgadget@gmail.com>
 <CAP8UFD1twELGKvvesxgCrZrypKZpgSt04ira3mvurG1UbpDfxQ@mail.gmail.com>
Message-ID: <owlyil2sb6tf.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v4 19/28] trailer: make trailer_info struct private
From: Linus Arver <linusa@google.com>
To: Christian Couder <christian.couder@gmail.com>, 
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>, 
	Junio C Hamano <gitster@pobox.com>, Emily Shaffer <nasamuffin@google.com>, 
	Josh Steadmon <steadmon@google.com>, "Randall S. Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Christian Couder <christian.couder@gmail.com> writes:

> On Tue, Feb 6, 2024 at 6:12=E2=80=AFAM Linus Arver via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>
>> diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
>> index 11f4ce9e4a2..6bf8cec005a 100644
>> --- a/builtin/interpret-trailers.c
>> +++ b/builtin/interpret-trailers.c
>> @@ -141,7 +141,7 @@ static void interpret_trailers(const struct process_=
trailer_options *opts,
>>         LIST_HEAD(head);
>>         struct strbuf sb =3D STRBUF_INIT;
>>         struct strbuf trailer_block =3D STRBUF_INIT;
>> -       struct trailer_info info;
>> +       struct trailer_info *info;
>>         FILE *outfile =3D stdout;
>>
>>         trailer_config_init();
>> @@ -151,13 +151,13 @@ static void interpret_trailers(const struct proces=
s_trailer_options *opts,
>>         if (opts->in_place)
>>                 outfile =3D create_in_place_tempfile(file);
>>
>> -       parse_trailers(opts, &info, sb.buf, &head);
>> +       info =3D parse_trailers(opts, sb.buf, &head);
>
> I think this patch might be doing too much at once and could have been
> split into 3 or more patches to make reviews easier.

Ack, will do.

> For example the first patch could introduce trailer_info_new() and
> make interpret_trailers() use it. Then the second patch could modify
> parse_trailers() so that it returns a 'struct trailer_info *'. Then
> the third patch could make the trailer_info struct private.

Thanks, I will try to use this breakdown in the next reroll.
