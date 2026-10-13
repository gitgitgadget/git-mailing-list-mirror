Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B814A3D20
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 20:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791923092; cv=none; b=oAA2pEqd+r/zrjk+Fe+57E1l8+EZI9iuft59Q5HkqMtdQp2qmr5TUNk6BkuB8JEKdbK0aDCcws+FymNdSeJxynfW+Qil9Rh6L5tpP0xhmax58Cozw8iAieFK2ao5dao2c/Rzx0JYz/RQVAKQ97U4NiceM/Y+ItJNCEo0+PTtUOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791923092; c=relaxed/simple;
	bh=1i8cNoI5fkTJFaWhVpQLsioiqldO8Ka6wo60QtzUlgI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r8Qny46+BsaBy/Tb1TaZm3EULPvSd0BHhrGofz6q1iup9jgwAwo6yBoIUBP/Ca7FeE9Wh0EX7XUvH91DbgAHi/o2lUSqCeriBJBkBwRT7AdqZ1HYkJpwf/JTDxJU33GQLtG/Ad81kH0CPhRWBymX2n5Lqu/og+PNObJkEspT2sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rmistry.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EL+4QHg/; arc=none smtp.client-ip=209.85.217.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rmistry.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EL+4QHg/"
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-7bdb408a368so460393137.2
        for <git@vger.kernel.org>; Tue, 13 Oct 2026 13:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791923090; x=1792527890; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xMWLx9zIAVnRwPGeFUcCQV46D6HT2vjkB4FVVeJCxGw=;
        b=EL+4QHg/puDgXkjONcQQhEdyafFL6ibmnkyE+rxLEnFWykyXjpv+85CpielqESf3oJ
         MuLc/aS8iFWs38qjw2sBd3T/qdsVT4pKEkRlwvrtaJIwIMjsQZXCZYQ7EfSRCJXZ7dKQ
         ZopTrAIzqMo5ts9RSvXUK0QMMRYL8pRHAq16kobu4CqLx0SaisRUipUqgNQBWKWv/ZmY
         3iDneNF8ANQmob/XCfio1DAYrwgMH3RCtoL8UfL+tsL4VxNe3/t3IVCTw4MfGi22KZhR
         XuOYItoXttCKIWVjXiaBUNea+B9OYGR80OKgafEKg8E3KL27Udklg7RDuC3aE56ycVVb
         c83Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791923090; x=1792527890;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xMWLx9zIAVnRwPGeFUcCQV46D6HT2vjkB4FVVeJCxGw=;
        b=JpjWTDEyDoHKOVNm5cgnWvXAHr+57D6X2WbCKti2SiZqvR5ffunpNBYBGRCASlu+ri
         iJW4tg0ZtM7zwLXILg97iAmR7y0D9mfFqt03QdP81qLeOcUA3wlqRmCHuof8fJ7HN8c5
         Txag7HYtrUH+H6wj+o+TdjJSmG/Eh0q4T4eXsUOfy3I6O8RXVfnzuRZXWvhZ0mtdy7ED
         fgRZgUcwbS3Z4Uvk1H8gxBZ8SdBGgee454FIvQlGjIBMh4HdR9kb6qr5D4wxOywyUL+T
         PD6kgjmI4YmFHx4dphG0Ljo04jBGxVMb7Gor5Jyl6/9mdUCJpCJBOTnqDehILMN2ePpR
         +eMA==
X-Forwarded-Encrypted: i=1; AKwUvBwhxznK/hutE5NrRBAGYVcspEhM5dyCaA+LfsJzas2n0g6ozmZezMXD85oZW3t8wFRmue8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKR8ZTl6A3QdzIORM/zE3CIbzceLKGKDzSzogOUVpolCm8UD3C7
	ItsBr4weiGD72iH6/bO0K5RCxpMpfC5kh1a0TPQu2FMkueHw3KymQEdtvp5rM3QOWU+7Z9yn+tW
	kL8r6yTFfLQ==
X-Received: from vsue15.prod.google.com ([2002:a05:6102:390f:b0:7c3:acdb:332e])
 (user=rmistry job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6102:4499:b0:7a7:12c0:f061
 with SMTP id ada2fe7eead31-7cb372821b1mr3477043137.12.1791923089796; Tue, 13
 Oct 2026 13:24:49 -0700 (PDT)
Date: Tue, 13 Oct 2026 20:24:48 +0000
In-Reply-To: <xmqq4iepzex9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.2224.git.1789169384240.gitgitgadget@gmail.com>
 <pull.2224.v5.git.1791902175.gitgitgadget@gmail.com> <xmqq4iepzex9.fsf@gitster.g>
X-Mailer: git-send-email 2.56.0.rc0.2.g605eb049a1.dirty
Message-ID: <20261013202448.2116038-1-rmistry@google.com>
Subject: Re: [PATCH v5 0/2] blame: ignore revs in .git-blame-ignore-revs by default
From: Ravi Mistry <rmistry@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Ravi Mistry <rmistry@google.com>, Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org, 
	Ravi Mistry via GitGitGadget <gitgitgadget@gmail.com>, Abhijeetsingh Meena <abhijeet040403@gmail.com>, 
	Kristoffer Haugsbakk <code@khaugsbakk.name>, Phillip Wood <phillip.wood@dunelm.org.uk>, 
	Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> >      ++	config option.  An empty file name, `""`, or `--no-ignore-revs-file` will
>
> That's "a configuration variable".

Fixed in Documentation/blame-options.adoc and in the commit log
message.

> Hmph, build_ignorelist() ignores the string and only pays attention
> to the fact that the string_list_item having a non-null .util member,
> so this diff, and the fact that a specific string is on the list, is
> a bit misleading in two ways (i.e., the string itself does not
> matter, and the value of .util member does not metter, either).
...
> It probably deserves a comment to help future readers, e.g.
>
> 		/*
> 		 * An entry with non-NULL .util member adds the
> 		 *  .git-blame-ignore-revs at the project root;
>                  * see build_ignorelist()
> 		 */
>                 string_list_append(&ignore_revs_file_list,
>                                    ".git-blame-ignore-revs")->util = &sb;
>
> or something?  It is especially misleading to pass &sb here because
> it is not used as a scoreboard at all anywhere.

In v6, build_ignorelist() passes i->string to
parse_default_ignore_revs() so the string is actually used (both for
the working-tree path and for "HEAD:<path>" in bare repositories), and
cmd_blame() sets ->util = (void *)1 with an explanatory comment (rather
than passing the scoreboard).

Thanks!
