Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374E9AD27
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 09:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740993449; cv=none; b=gBoTGZCqkmWCdnjYPnyLDyzTVOcJmM4uQh+1xOEGZ2x/cvQJ3iHZ+D9rTZ0uZsZ2RLJjxejIAVVvAEwtgDyj2NY5QMHMxCWNdw3XmSoWhk2cIDit4RZTDhIMPaOeJD8XhL0GW0tiL5sT5w2dUQg4VCxc4Nk7xWTXDmJicNf4Jvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740993449; c=relaxed/simple;
	bh=AkoSBtXwnodUjYA4APOqUgOCpulE1y6ySERMAo1jE8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ULHRuKl+V35SI1boxZb8lDprNwaUsTfpMi/7aJ4skeVreMGc9/SeBDQoFY6p2aK0njjzd+StuStYV8S2GExQSEhpdwOmaUXjTpE0B0DAj5DRuv9Ah/A3cfa0Y1nSSO8tyBGyu3wPbxRWHN+kydGwdr2yMiFQLKc/tLaCqY8Fw5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVCEpksd; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVCEpksd"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6ef9b8b4f13so34995157b3.2
        for <git@vger.kernel.org>; Mon, 03 Mar 2025 01:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740993447; x=1741598247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWtJ8iwdC32PDY9K2E7pKq8PXAW6gG1d7NX1t+KQipo=;
        b=NVCEpksd010GLlahNY3i2TGTgGUwxYGW4GIyeFh2aEK3WBzXqxgdl7nlHUR2Jv75Ml
         yNj8PrskuKNPyQj261mOwvrH13YWTH3KXyabbGZVAZS9qXTr95ywz86eAagiAaN787jC
         5SFUgJbKwlxkwqAX4R40ippMWdLFVVbG2974knPb0GSmNwiCCvjdKwroMZ/0z1ECANFQ
         LYQ1m6q9vqrgEaCg0AiZq7inKbevMIxBNgleBeVNqqjkp2sE1c7bSU8LfmlT3U9xY3IP
         g4jhBe8NzLGgnY5kelmozbKuAZo+sg8xxRYsXG614j+ApNBsrlU4GVds9s3C/XkNIs3B
         GNmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740993447; x=1741598247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bWtJ8iwdC32PDY9K2E7pKq8PXAW6gG1d7NX1t+KQipo=;
        b=jqJpHR0wGArlpjOpnjmeZatRnillB0m6rb4Z9/+sboK522tVdnLhaKRN+JJlV8adg7
         1FPkBGzSuuS/AuQibQYwzIno3bWZSz127WCPhQTx2mEUYG2hUCfn/qTEDvo1U3YFJWog
         j3ZYo/pLXkCppfa5Mt5vyA0VCdTwEJTMIf3j/mrTRJBVQClULOt99O6tpRIb02vH9KoP
         1DzgBtQQg3gYBH1e11YV0VL4WBM6Xn+YUyOSoMoHAv9YJExp9n7SJZXGKU92CvRB+pYR
         7qzfJuMMtWXchAA/KO1nEKKRuK/j+n7W2jAvHYDtCdcDoTlp63joDdMN8+Sn8wIln8NN
         4MSw==
X-Forwarded-Encrypted: i=1; AJvYcCV9A47+aUIa8Mi9cYQLxkhj+lsFSFA6wWsr5c8QOhxdbAYf0ppCpdQsZxo3FWTlmYXhqKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKwndYg/c3bJER5xg3zMzWEQSfkEkJvCF5jyCVaXKnMsmZ0mqe
	UYepX1e9dPLCmEpTX7c8/T49T3J8tPW7+dZZL0XjnfNqH1QHHNV2AL2GbCvZe8YlC8Cf0yThdIt
	T7VwmEzo63B4Y6qMEewT1g93S6Sk=
X-Gm-Gg: ASbGncvwktDXgFw9xVXvVgC3tXRjdBItI75irs1mnCAcXRdxk2tI2x6cQOR7DmtpGT5
	+QldMFKT7ErPnNUCtUaFzB3ZNPRmc9gpQlTeaR1KEnjGsbfrCa/Tvio5XnuPqWr2cwpO2FSMpHB
	ahzDvSwcBSUkH5GLd2T6JjYjKlv0w=
X-Google-Smtp-Source: AGHT+IEW/p3RLS0EwRGWlsafWzU+CngllulwUpcZSwX8eh1VPdpCIh4pbLIcwWyG7IKA3O+cOnxzeuplh9bl89InP7M=
X-Received: by 2002:a05:690c:6208:b0:6f6:c95c:85b5 with SMTP id
 00721157ae682-6fd4a139e73mr147006987b3.25.1740993447060; Mon, 03 Mar 2025
 01:17:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFXmTzjQuZn_b-nQHkYo7KHs9__gc1ctoLx0KioTcPEkqak+9w@mail.gmail.com>
 <xmqq5xkz708v.fsf@gitster.g> <CANYiYbGJevT_MAKW9n8qvk0Q6AWUY12mD7Hzcg6=+o_tkDuOCw@mail.gmail.com>
 <CAFXmTzgJ0_p92kaqFcby8En6EqEBnccN-H-uH_HMBNQtUtit+g@mail.gmail.com> <CAFXmTzi_acK2dCen27tgRCYWhD8oHKDq1FE-xsvnOG+F1jytwA@mail.gmail.com>
In-Reply-To: <CAFXmTzi_acK2dCen27tgRCYWhD8oHKDq1FE-xsvnOG+F1jytwA@mail.gmail.com>
From: Jiang Xin <worldhello.net@gmail.com>
Date: Mon, 3 Mar 2025 17:17:15 +0800
X-Gm-Features: AQ5f1Jr2xHfJ6w-gjOyGVzIcv8sKl-7wmbGVtdSG9CDS7bDQjuj9W6_tkjV6R_Y
Message-ID: <CANYiYbG3EOLZg-OsfJNnHjZEEmuHLvOpbYyn-8w3=bQWM=a2-A@mail.gmail.com>
Subject: Re: [PATCH] doc: fix typo in it.po
To: Ruggero <giurrero@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jiang Xin <zhiyou.jx@alibaba-inc.com>, git@vger.kernel.org, 
	Alessandro Menti <alessandro.menti@alessandromenti.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 4:42=E2=80=AFPM Ruggero <giurrero@gmail.com> wrote:
>
> Here with the correct commit message:
> https://github.com/git-l10n/git-po/pull/828
> There are many failures
>
> On Mon, Mar 3, 2025 at 9:21=E2=80=AFAM Ruggero <giurrero@gmail.com> wrote=
:
> >
> > Hello Jiang,
> >
> > I created a pull request (contrary to what is written in the github
> > template): https://github.com/git-l10n/git-po/pull/827
> > I haven't run "Refine your commits" with msgcat since it creates tons
> > of changes in po/it.po. Let me know if that is what you want.

Hi Ruggero,

We have some conventions for pull requests to the git l10n repository,
and we use GitHub Actions to check pull requests according to these
conversions automatically. E.g.:

1. The subject of your commit should start with 'l10n: '. You should
amend your commit message; the title of the pull request does not
matter, but the commit message is very important.

2. Your patch is based on a old version of git.pot template file, and
among the 5013 translated messages, there are about 1000 messages are
obsolete. Fortunately, the message you modified still exist in the new
version of the POT template file, and after you update the commit
message title, I will merge your commit.

3. There are obvious errors in old version of Italian translations,
see the report of mismatched patterns in feedback of GitHub Actions:

    extensions.partialclone vs estensioni.partialclone
    git rev-list vs git-rev-list
    refs/heads vs riferimenti/head
    git rebase--interactive vs git rebase --interactive
    --verify-signatures vs --verify-signature

   But before changing the above errors, make sure you work on the new
version of the POT template. You do not want to fix errors on obsolete
messages.

4. If you decide to contribute a larger patch based on the new POT
template, please contribute a PO file without file locations, as
frequently changing location information can significantly increase
the size of the Git repository.

-- Jiang Xin
