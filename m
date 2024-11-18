Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AC2DDC1
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 14:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731940171; cv=none; b=gZtJ1BDD5WBzbADrbRxYG40wpNNwoCp0JBeF2RTYUgJsvsJnwNOcGE+2BBn1k5yV4qr/dRC5wF/P8bOV11y7KLn/oz7cnCOUT2oCjvg4qO4MDh3sV4qJ0GerbCwUFhR/7+I++ZqF0x8IPY6C/8GkPfjX8jFwjrfdUucc5mf51Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731940171; c=relaxed/simple;
	bh=wJxKxxMRzdrB9ibWDmaiTQo1I1uXrq6rSXB57oI0o3Q=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ObPPKKGF0HWBayiHjqZb1pQ+QILkwir6x/c24phIN1vIueDNEEODoaALFE1Kg/6pvElfUoTYgF+pXzzAEqyvWZS74cPUimb8hzC51vfFICVEZZ9kJcu3Vez6rlaDATYurYQ7adp2Tr5sQQBkUDzRoDdtRbi/kFfMMFAFzPld+L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UEoDG3eu; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEoDG3eu"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7181caa08a3so2031583a34.0
        for <git@vger.kernel.org>; Mon, 18 Nov 2024 06:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731940169; x=1732544969; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZbtIwamQABgd9iFIHNn9RMhcnqLJUnm5gkIYEfA3v2s=;
        b=UEoDG3euZlcy7JJyfMM4R1Mz0mUKmFWXFtvYuz8b94FBW2NxvZjmqQ9too09lcfQx+
         ldF1J7LLV/Z7mkDdqt8pnzcnlNNTxxasyPpFhJrgOCFyD0rhyO9ltgyHrQ5S+SpOcoRZ
         wmflCtKpBQR7ww4+gf7E0EN01CdR+ZciPd7sd04MeMwe7/+Vk4VdkdkcEUfRUtuWpq/0
         jG1e8p3QZmmeyBs0jkOnmGTAw+5wW8rqtidTpRsEPHrvuadTFFqe1nKnT9QrIHR5cOtg
         FCQ3253rqC2hRwIAkdd2pedBBi/ITS48Z3tSrYwEHFjVvN7nck5JaquIgu0iRnweNMJW
         Bspw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731940169; x=1732544969;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZbtIwamQABgd9iFIHNn9RMhcnqLJUnm5gkIYEfA3v2s=;
        b=tdtmPzO7VI0CXvoP4QqEkbATBxc2stmrYcuU6IxyHWMshk5M/fXJ3CjycjQOaNVRux
         yeqY2GtrH+/twzOt1Zdw7bqIOY/MS2W7WsZ90dwR0pvTWdxkjdnOX8SNQumgRgZyDz+F
         e8NaRVvwMjzQlOdMhfFRj3IwPOsRkDDi33UQpS+HthVEO3EWBHcxz2dfTY0QhXBehfcT
         1h9rI/dsBZXERJuGZ7LWB7YXKTLZWlqZgMUchunzGnD6YLKZoNLK9OuDGEi80bzTq1XM
         kn2u02OoyzwtJsSdpxzhkgsEKvPJkPYQqHW+4VkYnEE2KdzMgPVqdrlVxckqJL+TVr91
         EuHg==
X-Forwarded-Encrypted: i=1; AJvYcCVdxBgTbu7TUEbOmryq7TkxvouA1snAApyxCExuCm6Bf1cXApuvj//RFXzpobaCUSuA8s0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzANIpcnxrDwiq9Uq10F6dS3NuX734a+e484XV33cvJOwSusAz0
	FqUGRkMVw/VkYaUd3EzOToy81wOAK+oDalNektW9vxSa9ICHXA3IR81O7Fzqh5vD6qhVclfxc7Q
	MYOFHXEgl1iAd1KgTS4Zg4/79d+Pai94W
X-Google-Smtp-Source: AGHT+IEHz14Dj7e6VT12Cp2Rm9uvKMAR3zI09lrVjla1dwIJvDwP2/1gofa6aVKo/v5jRRJqM4RDmBmGCMo7g9v/xIE=
X-Received: by 2002:a05:6830:2107:b0:710:f83e:111b with SMTP id
 46e09a7af769-71a779317f5mr10166807a34.8.1731940169246; Mon, 18 Nov 2024
 06:29:29 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 18 Nov 2024 06:29:28 -0800
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <CAOLa=ZQXXR3RR_2zBfCmR06t101W1X5VqN3P_LYYz+AMJKu+=Q@mail.gmail.com>
References: <cover.1729677003.git.ps@pks.im> <cover.1731047193.git.ps@pks.im>
 <b15daefbc83383b3ea2b6ab7d2f091d3d756952b.1731047193.git.ps@pks.im> <CAOLa=ZQXXR3RR_2zBfCmR06t101W1X5VqN3P_LYYz+AMJKu+=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 18 Nov 2024 06:29:28 -0800
Message-ID: <CAOLa=ZQ9Etqz2t=OnsvVzVSyhSSB1jp6BYQ=FML8-_u8PGGVkw@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] reftable/system: provide thin wrapper for tempfile subsystem
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, Eric Sunshine <sunshine@sunshineco.com>, 
	Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000905870062730be95"

--000000000000905870062730be95
Content-Type: text/plain; charset="UTF-8"

karthik nayak <karthik.188@gmail.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
> [snip]
>
>> +
>> +int tmpfile_close(struct reftable_tmpfile *t)
>> +{
>> +	struct tempfile *tempfile = t->priv;
>> +	int ret = close_tempfile_gently(tempfile);
>> +	t->fd = -1;
>
> Nit: below we do `*t = REFTABLE_TMPFILE_INIT` should we keep things
> consistent and do the same here?
>

My bad, we want this to still hold onto `t->priv` which is cleared when
we call tmpfile_delete(). So all good here.

--000000000000905870062730be95
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e3e48edf38783e42_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jN1QwY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNEprREFDZUEyUWc4c3crR0R3cjd5OEtzSCtlQ1pPVwpDMDJRYlBnbXpM
SGRiT25GMHJrNE9yQWRmQmU4dmhkZmdub2RlL0dBbHhWWVVIYXhFTUVCSzNkUU0wOW4rdDVsCkxx
SjJNN0t4TjBFWGk5cDM4WjZPRG9tbjluWk9aS2o0MlEvaXRHdEc5TDN3dm8zTmZRYURyR292eFFK
T3BjczUKcS9kaWxoQk5yOTc2cmI4MnkrcUJ2djRpREtldURVRUJ1UFBpZjZFVGdhaU1nbEpGd2V5
SHE4cDUvOXJNcFJCUApLVVdRR1BzVWRuN0h5TlRvaWpQS240MTk4emIySVJKTlN3R0k3U3FaMGJm
UFhsa0xIK2hmdHp3WTVqMzJvRUwyCnV3ZjdFV2w4dld5Y1JyUWN0UnZEU1o5QU55Tko2UkFOazFS
RHdiSXB6TGN4TS93aG0wckE4WThXenhpTDR6QTUKZklHYkc1enZRU0VPVVVRU1BITmdGRHk5Mnl6
eUhKWFZzWkoyYXErYWZhS3BDZUowSG1NUGh3TEtrb3BTVHVHcgpTVnVGTG5KTkp5T0tZdEVmd0pt
ZVprZzJqb3psUmNVWHJVSTJETEpSVGRHL1kweGpQVzhocEU4bDZTdmVVZit5Cmt1aGJrb0dkMEZ3
ZGVCWktjNVByc2N5ZVBFMWdqbUVRbk15MjNDZz0KPURWR1oKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000905870062730be95--
