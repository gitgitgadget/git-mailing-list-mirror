Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560B0285CA4
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 16:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783960244; cv=none; b=UQyjwmR7Z+2uUW1v8Ut79iA7w7PvOOPTPShYcgp+WomELaYYPpgzUiRjX13Tkkh8IgdYSJwUAwSIFv+U9e9tTwUXLTQwjyxNEgsqvJv6QgI5GRbTX0ycRRpX5TEjoqxN0W5g5Okgw9XTjpFq65o6doTo3EWuGpPDZaq37WzNxTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783960244; c=relaxed/simple;
	bh=SYpWDO3jwFCroYE77JuyXPN8TvkUeD74fugmEjkM0QE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=q9d2xV9eWCTYJgXHuc1ztE2aPCOIVeyhMz0cz9nLv6kDET4O1KNeTZIhIK5Fpj0A0+n2tY60htxnn+youmh5EmAj1dAnhHh3cET+C7Sjw8Mm7OFQ576KrakIh/gtSuXgyg/pt60pKf4euGFkUTA/8zMPUuLeEg51bqLKgTNxdoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nw5QzIF1; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nw5QzIF1"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-848882fdb18so2587006b3a.0
        for <git@vger.kernel.org>; Mon, 13 Jul 2026 09:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783960243; x=1784565043; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MRRX9ujLspnHq9rxWqOfQgqut2zVTTagO8zZqq12Jr0=;
        b=nw5QzIF1DdozINVJywCMYkUsVVgyNUkbJL4D4DvepnwWBNELbebKkpzcpWNXXhgpkq
         xryLmHPJ6ACg3qe+KfWKnwRy4XYcu/cyBWoLL4u/Sr9PDTUYwZwmXwn68EZxqUx9fJgR
         m+aaeDGOuO41kBUIO4IlE+QKsEcsG5oGBYU+SETj9x3n/cC5ti9gECO2tM8Xf6/P+qkw
         ykOHOE9hoKZuHmHsWDvkpe6iwwYzsRZdfA/iDkA2vg3n9yWbAvtyKFZ87yTeqHJuoMer
         fcwSGqxiH2R1I0tN0ymAkFvkMDSu2O2WoBPtSdBLPDDWt5cs4+PjaGF1OFAiFkdHX5Lt
         3Fwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783960243; x=1784565043;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MRRX9ujLspnHq9rxWqOfQgqut2zVTTagO8zZqq12Jr0=;
        b=h+naAuASPLSVADJS2wShgyaI/5zmAblCHwOIdvd1JE2gVqF2clly0stPjwdKkm2MnF
         bzy44gEJIjIpDN6A57zXj7/P/86Eb83wDSbvG0SQXNs9l4oz4kTktYooSyhcvii7FliJ
         lKjuIrao6NbEP9EmkS/KuXhhA+oHU2LyIxP48H00f1nnMRAMQeU481juj6J9NdG5oPkc
         72IX+T6qfCr0eBWzRaUwVKUJzd4OSVLQN0FScARPh4gB9mm6fsY9iggtd9FKStq66yct
         3si5AqUi+5XuZH3E6D0n1GgS+rwDAJrq1+qJ7krQECMJIWOMIaB/IJ+8baKLn2SanfZi
         VPLA==
X-Gm-Message-State: AOJu0Yxcs3Eb5SosJQfxgxQpr8cdZDJshN2MNj0zBLkXRfTs5WeXIgAT
	07Lrz5+HtD/ExBRWcSNe/kr2rxbjcpGJ1Ait/M8zp5tACMaje2oNjpRq
X-Gm-Gg: AfdE7ckKwa57B2rXNBhCjjFQ3PFNbSiRikEnoNxODaBjahT9ivznPa7VwSIuh/N7FT2
	dv8keU5s05l73iT2/EWH6C8WNYSkQssnId+bb89glasaE5UIgUTFVLQJwzmUA1PcjKMYzij/Yjw
	wErpKubPq8iXvSq5Xdl0EE3fZcjSObbZ7aCGct1SQSjGrktpaG1LQHeuf3R46TT+yv77CImTJK5
	UPx1ghbfJWl60hRm7Yduep7DlUr/oecbyhtdPkkQ867+rgLUs3TXBm0kd6Mblh7hqp9nT0SSZL/
	3wh5ndNmGvL1GD9mUR8kKBEfraCjzbjMzvBl+Mkks2wr2Mc+ww5e/MVHspRW0GQJ/U4/jpc5N/l
	pFazMU+3r7uSWRxMkgXRJuPvfFaH53+ROFLD939aiv0ly3mnqS73xOQCa/5Z16147exOl9qiZcR
	7PXRZB7eVJQQkoszwmQdiBEkU+
X-Received: by 2002:a05:6a21:6f12:b0:3bb:21ad:40d8 with SMTP id adf61e73a8af0-3c1108c79c7mr10693096637.39.1783960242669;
        Mon, 13 Jul 2026 09:30:42 -0700 (PDT)
Received: from localhost ([98.35.8.117])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d8da9sm122707354c88.14.2026.07.13.09.30.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 09:30:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Jul 2026 09:30:40 -0700
Message-Id: <DJXL4KSUEAD4.1EE4ERHJZ00TR@gmail.com>
Cc: <git@vger.kernel.org>, "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 "Elijah Newren" <newren@gmail.com>, "Patrick Steinhardt" <ps@pks.im>
Subject: Re: [PATCH v3] sequencer: honor --empty when a fixup!/squash!
 empties its target
From: "Farid Zakaria" <farid.m.zakaria@gmail.com>
To: "Phillip Wood" <phillip.wood123@gmail.com>, "Junio C Hamano"
 <gitster@pobox.com>, "Farid Zakaria" <farid.m.zakaria@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260711-fz-autosquash-empty-v3-1-d227b63eb511@gmail.com>
 <xmqqh5m494yh.fsf@gitster.g>
 <7a1e5111-185e-4390-afa1-c19908c9bd86@gmail.com>
In-Reply-To: <7a1e5111-185e-4390-afa1-c19908c9bd86@gmail.com>

On Mon Jul 13, 2026 at 6:18 AM PDT, Phillip Wood wrote:
> On 12/07/2026 06:01, Junio C Hamano wrote:
>> Farid Zakaria <farid.m.zakaria@gmail.com> writes:
>>=20
>>> When "git rebase --autosquash" melds a "fixup!" or "squash!" commit int=
o
>>> its target, the result can be a commit that no longer changes anything
>>> relative to its parent, for example when the melded change reverts the
>>> target.  Rather than dropping or keeping this empty commit, the rebase
>>> stops with
>>>
>>> 	You asked to amend the most recent commit, but doing so would
>>> 	make it empty. ...
>>>
>>> and the "--empty" option has no effect on it.  This makes backing a
>>> change out of a series awkward: reverting a commit as a "fixup!" and
>>> running "git rebase --autosquash --empty=3Ddrop" ought to remove both t=
he
>>> commit and its revert, but it halts instead.
>>> ...
>>> Changes in v3:
>>>   * Switch the new tests' assertions from grep to test_grep for better
>>>     diagnostics (per review).
>>>   * Link to v2: https://lore.kernel.org/r/20260710-fz-autosquash-empty-=
v2-1-fa1e277e05f8@gmail.com
>>=20
>> I see you are already working well with Phillip, which is great.
>>=20
>> This topic, when merged to 'seen', seems to have quite a lot of
>> overlaps with his pw/rebase-drop-notes-with-commit topic.
>
> Oh, I should have thought of that
>
>> We are
>> expecting the topic to be rerolled, and I was under the impression
>> that the remaining issues in that topic were all minor (Phillip,
>> correct me if I am wrong) and hopefully we will see it in 'next'
>> not in so distant future.
>
> I've just sent a new version and cc'd Farid, I'll try and take look at=20
> this patch tomorrow
>

Thanks for cc'd. I'm not familiar with the workflow (I read the docs)
but is there an email reply when it's accepted into 'next' that I will
just look-out for ? I'm not subscribed to the mailing list in general
otherwise.

>> So it might make sense for you to coordinate with Phillip, and wait
>> for his topic to be merged to 'next'.  After that happens, you would
>> prepare a merge commit of the other branch into f85a7e6620 (Start
>> Git 2.56 cycle, 2026-07-06) or some other stable point, and rebuild
>> this patch on top of it.  That way, it will be much less likely that
>> I'd make stupid and unnecessary mismerges when attempting to
>> integrate this topic into my tree.
>
> That makes sense, assuming no-one has any more comments on=20
> 'pw/rebase-drop-notes-with-commit' it should in be 'next' fairly soon.
>
> Thanks
>
> Phillip

Phillip,

Let me know if you have any more comments. I suspect not much will
changes logic-wise once I rebase it onto 'next'.

For clarity, is the f85a7e6620 commit the 'next' branch ? I would have
thought to just rebase ontop of 'next' and I'm a bit confused with this
commit hash.

If there is anything else I should be aware of, I would appreciate a CC
if you can remember :)

Thank you!
