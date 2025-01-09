Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBCE219E8F
	for <git@vger.kernel.org>; Thu,  9 Jan 2025 14:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736432745; cv=none; b=a+5B9UIt5rSO8X0oZAIyjKcEqKpTUl8lTEVC6v+X0rdgnn2qchaG36hvN7mCNMNnPC9hfPo7bzjUoAnqwMaaf0Q41EJnxv6bJLHGjUc5OuTVFEgA3wTvWKkvAYlVM6xu+TXHRfCQmi/8kODujyZb8eyu49dyXkc+aVYknG3nJTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736432745; c=relaxed/simple;
	bh=5kVs0E3oqWOs3iPDCcKdpTXww4NT8sVdY/9dQH1sNNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TWVLaUVim+1qPw1eIfXrYUGTNsybb4HthaDjeYaeRtMnMf60LkjqJjkJlxetf6s9NVczBOgJGw3gBJlvraSyCwpSdYp/7XdPYmKlgsJ/KvEOqGS8AIlL/spLq/wQlArbqpF1nlNruS1sp1ttmL2zR/+yc5USqV0dC6xZhR4U+tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fL6ndryI; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fL6ndryI"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4afe70b41a8so376430137.3
        for <git@vger.kernel.org>; Thu, 09 Jan 2025 06:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736432743; x=1737037543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hn6H4pKsXZe57Ilr5kmfIKSdUg/U8Dxsii++vVY5LX8=;
        b=fL6ndryICV4TbjgW6oOF1h9bARv5Gxx1D6XtaF6e8xCgj3PnqTBhX+O4BaW0LmYF2u
         JFGxNMPI8JLeSefWpsU+LXnckhzyMV0vYcE/U/HuF7CvFE90etmTJFl6XCK2AkYsE7+R
         /9DGrA46WIoagxWNzg2lv11AqgUEWq5u1luXwSZyEAlNR0wU+61FEr7VeSSujN/hmHhh
         YagkFwQL/MWRbKL++c+XMB2LXfvSKi8iSdYCWwS+S6lCETNClTVDLfNF83Z79M6l4uLz
         V7/+v3VFsnWTY1xQjZnouIf6Y2wSQ5fs7jj+haEHsbtJiLtSl9TZtpvcq9okMOl4FRiU
         E1Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736432743; x=1737037543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hn6H4pKsXZe57Ilr5kmfIKSdUg/U8Dxsii++vVY5LX8=;
        b=ZBUITmCK6VKeQuC/5dMn1KLM6OdTPwhLE9Hrp9qQUFPuLAcysGvjpXmIMOH8bzpgOK
         amC/uYoojE/3gMeJ8EesaKFWA5lpVzwLcvmWaQnXghUChR+6ZJ2iumKOSZlGdmG82mQz
         4jeahp5ZBelRJzaluOEFpGo8CgniWuVQ3p0npK9cg7kQvjfeVVxK3Ax/e33rDpWecWCr
         PGyF5O2jEwYOVkzWjtjwEFmkugBhpAPX5dAXTlAuI4Q9YWtJKgVyem1PO7j66nkrtVba
         CX1GxnM1smYj5nCPcchwjII+5jAC6OAgP6hPmcGBCtCfixSkGd2vbv6AqdUPz3QHh1Bo
         xLcA==
X-Gm-Message-State: AOJu0YyGXwH2c3N9ADsIT6tNikNv2Njg82vKU//TTVjRWNuDAnQHnO8r
	G6ajH6Vrp1G0ZYup6p7sQ9uAG32EgFtq5Rllrm3RjTCa0axP2nylXte2qomesNPpAoLH+97Bca0
	L0Uct+2KbPeSFm/21KCqypnAiAd0=
X-Gm-Gg: ASbGncvaDjPZUsppF168RF3Tf9bJsMhMHVk7UEMdl0JbGltA6kiHDbOouM7Fq4VwqUj
	QZbsvJfwMmN3IffPxBLBXTTHq6A6khNOi/JN23A==
X-Google-Smtp-Source: AGHT+IHWm/+7XdZfjWx3GIEdcJ8rwdovg+oQMrnSdzH5Vmyj2x08ccpvt9x5z8ltgwBasqSZFmLskllGHPWgayZwZNM=
X-Received: by 2002:a05:6102:3591:b0:4af:98c6:bc97 with SMTP id
 ada2fe7eead31-4b3d0e60973mr6059230137.19.1736432743234; Thu, 09 Jan 2025
 06:25:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106103713.1452035-1-usmanakinyemi202@gmail.com>
 <20250106103713.1452035-4-usmanakinyemi202@gmail.com> <xmqqfrlvzzcd.fsf@gitster.g>
 <CAPSxiM_0h7OyQO-Of8YhcOt4KbtuoKXe111ZCvsLf5y+OgCHaw@mail.gmail.com> <xmqq1pxdnuxo.fsf@gitster.g>
In-Reply-To: <xmqq1pxdnuxo.fsf@gitster.g>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Thu, 9 Jan 2025 19:55:32 +0530
X-Gm-Features: AbW1kvaAoutLK9KeNbpMvIc3L88ykofgW6gb6H_JTOMaXAMMHCqKtPRQCnzaxOE
Message-ID: <CAPSxiM93qVjoDGBRaGAv1-o3oiKkEE0mtH9ERTN9dVxvZpCczw@mail.gmail.com>
Subject: Re: [PATCH 3/4] connect: advertise OS version
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, ps@pks.im, 
	johncai86@gmail.com, Johannes.Schindelin@gmx.de, me@ttaylorr.com, 
	phillip.wood@dunelm.org.uk, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 9:45=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Usman Akinyemi <usmanakinyemi202@gmail.com> writes:
>
> >> Is there a need for a registry of canonical os-version strings?  One
> >> reason why you would want this user-settable (as opposed to being
> >> derived from "uname -s") is that a system that is presumably the
> >> same in end-user perception can call itself in different names (your
> >> Windows/MINGW64 example) and having the users set it to a string
> >> chosen from a small repertoire, the other end would be able to
> >> identify them more easily.  I do not think it is a necessarily a
> >> good idea to limit what value the users can set to this
> >> configuration variable, but at least with a published guideline on
> >> calling various types of systems (and an explanation on the reason
> >> why we publish such a guideline), users would make an informed
> >> decision when picking what string to send.
> >
> > We plan to implement another config option `osVersion.format`, which
> > allow users to fully customize the string sent to the other side using
> > placeholders,
>
> Sorry, you lost me.
>
> I was wondering if we want to (informally at first) make it _less_
> flexible, so that we can prevent people from being "creative" when
> the value of being creative is negative.  Adding even more ways to
> customize the string to subject the receiving/inspecting end to more
> unnecessary variations to call the same thing in different names is
> the last thing we want to see in that context, isn't it?
>
> If you have "any random string goes" configuration mechanism, it is
> pretty much game over.  You do not need to add an elaborate .format
> mechanism to let users throw random garbage at the other side of the
> connection.
Thanks for the explanation.
Instead of having .format that will allow user to have multiple
variation or different placeholder,
we can allow it to take only specific values for examples:
- "full" which would mean the same thing as  the result of `uname -srvm`,
- "default" or "short" which would mean the same thing as  the result
of `uname -s`,
- "medium"  which would mean the same thing as  the result of `uname -sr`.

What is your thought about this ?

Thank you.
>
> >> > +# Trim and replace each character with ascii code below 32 or above
> >> > +# 127 (included) using a dot '.' character.
> >> > +# Octal intervals \001-\040 and \177-\377
> >> > +# corresponds to decimal intervals 1-32 and 127-255
> >> > +test_redact_non_printables () {
> >> > +    tr -d "\n" | tr "[\001-\040][\177-\377]" "."
> >> > +}
> >>
> >> Just being curious.  Do we need to worry about carriage-returns not
> >> just line-feeds, and if not why?
> > The function `tr "[\001-\040][\177-\377]" "."` already replace the
> > carriage-returns with "."
>
> That is exactly my point.  LF are stripped; I do not see a sensible
> reason why shouldn't CR be removed the same way.
Yeah, I will add that in the next iteration.

Thank you.
Usman.
>
> Thanks.
