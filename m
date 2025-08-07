Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE7710E9
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 01:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754530778; cv=none; b=AP29/OD9aCQiS/3wx3cD7lh6zlDi14BfY/hk5vjNe/JtWa01q2DPxs3oaKwcd32B3RVusljje0TIpf5DsOGWpt2SmyTugrPqirUmTz3thPPWT1y4XTlPNjBjap7WPkjoghPItVKpsdtS1QmQBSvAdHhGh0xDuNVG2wMuUVjwlZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754530778; c=relaxed/simple;
	bh=VRN/ySie06fo5LLjBIGK4w4isuysihAGiyS0QfjCjws=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ArfPDy0PEcIHazgolXgkzPlbGZ1+4Fn932yOKWZg8lh+p6vOQkhEVgm07NcOd1xOFDQi+e+oDT4cs9y/JEoCMys9yoyv4lf9aRMHgJZWVOW8VYq5Sjsdhrpw/OS+Tu20lf78KGPD2PBinZ/MZiJeTynU6WObc3wnKaRLSfoXyOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nvrqbp0V; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nvrqbp0V"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-76bc61152d8so558562b3a.2
        for <git@vger.kernel.org>; Wed, 06 Aug 2025 18:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754530776; x=1755135576; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o7uKbURoxwktN+qm/RDs/i3nRCNcNLB+NQ10DlR9Nj0=;
        b=Nvrqbp0VcU0DBtaRxals5SpJ2E16SCy4QisWWMgIwKH9t1wwJF6t/LiahXjx4mhwcl
         /wRDEFcFno6CS1rYz7TZH5ktVEKlno2qlt2xMZQyv2BLf5A/1lRcRlFkEPWjZJjRGCjF
         B06E+Ns4qp5iJJqmRUcsi/0UfEsS1F3CcHzz3j5AFSNoxs687hzRgcBo4piSI1IDKILY
         u6nkh9pVoqO/qhTxZE2zNvTXUxnvCts/ztefR5t0Lt2DbG4gzme1PMZyGhdVWdxV14Y0
         hJVdK4PnxerhnhmALwXtaxzbo8ck9PruXLmbOc88Wqo6rlShybTCDxQx07jPoHa0AahZ
         MFpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754530776; x=1755135576;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o7uKbURoxwktN+qm/RDs/i3nRCNcNLB+NQ10DlR9Nj0=;
        b=QR9rf0TXeDWxFaaojTFBf15STm6UpELDno3CHc04fSm32vs0/q7CUvWmPBaO8a6TK5
         pWZ9uXXuDMY6eblrHGgFwO5cBqgAODEkdtmj88jUcTisFwYpaQBT7v6ibJJRH2/ZXIf7
         j4xPi3TVnVlfgQbXBvbnHCULppteuCG80RdH1HfyfRNYCEpxDPIMzwiY+Y6pDjOiNcVK
         K/2IXRCQrc/9J0yhG9LGod2wGxEAf3Jzt4EtRdlBS0SKVjbeRiPvDMuYAVBzInqXF7qf
         rSK8+zEcNSj7YWUc1DcrByxIryGpyKos2PipRnEwWRBAC5DSKYjzt+SrfPRJUWiu2r0x
         aEXw==
X-Gm-Message-State: AOJu0YyrtUATNIE3C0qKICxMDTv/j3KbNWDlGtgPCul0iAojMcfytHMu
	iWYV/pVclVUNPk4Gic42wEwY+wfMJjP8BY0g+iFNGzNNMDOXHBUaggErvejHYmiIOAG0Yw==
X-Gm-Gg: ASbGncsdAslWO3yd42GvvlZnmnVgigIUi9mlNOn7H215eFq9LHVXRTK4On8P8lW8oaj
	Lh84//s1BdoZ25Kpnh8En1IEpPmYQnR7nRDm5mIV3sbISHJh+esmLVAe44LnA+rYq3Mt2LNOXMz
	IutrDSka1F0dg3J7MW39oIm+zY50CXRX9szpSZQbwiu9Sn0FjXmvcodhJgNXGetzU7w3qoChG1g
	Pw9ujCLr56C5R36wLI3coY81RJJuPC8K87XPUJqgg83FR2NZCN0B8D++G4LEkyRq4USHnnAqp1v
	cXbXwJEW6B92dL/YJRtgEtDW9t5NjVj/x8RuR7Xxv8tCaOAzgU6/V384s98tW8a8OvTJQelUr4l
	du9AgSMgczdd+qLb9B7XIntLYaMrTcXHoSqDdztjNH7JLWFaqhx0ACvHlObRxQBQFiDaO
X-Google-Smtp-Source: AGHT+IEetTLfhV8soJXJFpk5E5jyJ4YiOF90XWJdcz6r8jq4F1HGGhtoOJJ4R/bLXuue66QuNmpUsw==
X-Received: by 2002:a05:6a00:2e94:b0:74c:3547:7f0c with SMTP id d2e1a72fcca58-76c2a2813bbmr7348311b3a.3.1754530776248;
        Wed, 06 Aug 2025 18:39:36 -0700 (PDT)
Received: from smtpclient.apple (awork062197.netvigator.com. [203.198.28.197])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbcbf0sm16644986b3a.69.2025.08.06.18.39.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Aug 2025 18:39:36 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v3] diff: ensure consistent diff behavior with ignore
 options
From: Lidong Yan <yldhome2d2@gmail.com>
In-Reply-To: <xmqqpld8tbib.fsf@gitster.g>
Date: Thu, 7 Aug 2025 09:39:20 +0800
Cc: git@vger.kernel.org,
 hi@arnes.space,
 michal@isc.org,
 peff@peff.net
Content-Transfer-Encoding: quoted-printable
Message-Id: <5B2238C4-CE27-4F14-B50C-4FCB70F76D23@gmail.com>
References: <20250803145155.57894-1-yldhome2d2@gmail.com>
 <20250806123306.25532-1-yldhome2d2@gmail.com> <xmqqpld8tbib.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.700.81)

Junio C Hamano <gitster@pobox.com> writes:
>=20
> Lidong Yan <yldhome2d2@gmail.com> writes:
>=20
>> +static int quick_consume(void *priv, char *line, unsigned long len)
>> +{
>> + struct emit_callback *ecbdata =3D priv;
>> + struct diff_options *o =3D ecbdata->opt;
>> +
>> + o->found_changes =3D 1;
>> + return 1;
>> +}
>=20
> "make DEVELOPER=3DYesPlease" would not be very happy, without
>=20
> -static int quick_consume(void *priv, char *line, unsigned long len)
> +static int quick_consume(void *priv, char *line UNUSED, unsigned long =
len UNUSED)

(I accidentally sent an unfinished email to Junio. Sorry about that.)
Another a good thing to test before commit. Thanks for the reminder.

>> static void diff_flush_stat(struct diff_filepair *p, struct =
diff_options *o,
>>    struct diffstat_t *diffstat)
>> {
>> @@ -6778,7 +6810,19 @@ void diff_flush(struct diff_options *options)
>>     DIFF_FORMAT_CHECKDIFF)) {
>> for (i =3D 0; i < q->nr; i++) {
>> struct diff_filepair *p =3D q->queue[i];
>> - if (check_pair_status(p))
>> + int need_flush =3D 1;
>> +
>> + if (!check_pair_status(p))
>> + continue;
>> +
>> + if (options->flags.diff_from_contents) {
>> + if (diff_flush_patch_quiet(p, options))
>> + need_flush =3D 1;
>> + else
>> + need_flush =3D 0;
>> + }
>> +
>> + if (need_flush)
>> flush_one_pair(p, options);
>> }
>=20
> I am having a hard time understanding the logic in this loop.  Is it
> equivalent to the following loop, and ...
>=20
> for (i =3D 0; i < q->nr; i++) {
> struct diff_filepair *p =3D q->queue[i];
>=20
> if (!check_pair_status(p))
> continue;
> if (options->flags.diff_from_contents &&
>    !diff_flush_patch_quietly(p, options))
> continue; /* no changes */
>=20
> flush_one_pair(p, options);
> }
>=20
> ... if so, isn't the above rewrite easier to follow?

Yes, I was being stupid again. That=E2=80=99s obviously better.

Thanks, will send v4 soon.
Lidong=
