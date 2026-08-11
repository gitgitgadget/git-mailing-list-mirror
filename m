Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CBA361972
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 16:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786465939; cv=none; b=G50SNQQYCkM+zVnqhsT6SGXQzK2UBTHO49OmjR2P5ucqBLAwkzl9pEyHM7+fq9gHxB0+sB4ILRPw4L/sJhszPmIjvdyCX5HrUvkRGz7B+yTBwFXSNn2zKyYHAD8N+jajVSb4hLtdH8pWIOPb3sqM5fPEIzwQrVR7LoszNt4u3sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786465939; c=relaxed/simple;
	bh=CwgDthQi/WPCAKyRrgt4/OoCPq8tHJfu1PP3CXLiXVE=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=QNlI8M/mFi2UEWNtKOIVsrOF/2txCU0ccLIZp1AJF40H1yt0/Fq+ViWDJUfYYHvhu5nOz5twGB/46zcqMOch8IjIFMJ8PnevPL0NzVSOBx4padIU4hXqHFvZ04Wayae2lh0eHxQmBw8ZwZRPIfHgMdk2whVGBq8sW4Tnycv3ksk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TtBhFimK; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TtBhFimK"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-81ea0b7d137so25443237b3.2
        for <git@vger.kernel.org>; Tue, 11 Aug 2026 09:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786465937; x=1787070737; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FUr+nMrLJcfzcZsVfWjSwb/cxhN7c7MgM3O82EHjMxQ=;
        b=TtBhFimKnw17dXs08r7HzeSC2dpk0UUiMO0sLc6G7LQp5ys+GqzqWVdp3nL8WlRfqe
         Oz5M38z1+vMIEm/E0lq36E0lq44T2Vb9M1vmA9au6odIX7U8QMbJS7B5X85NH6MS/K8z
         JsYP2ru2pPaJ1Ra4w73f8gPjtVRayLSc11gmj14eJkL47nXOULXIySHjeNhvLvPjFffS
         qCGNhs08hfiUz+j1h+l5+KO5YIdJqWT38G9rK2fTtMGV3kaOjsuBD/qhY/8nx4pMnAvl
         pRwMH1K0Uls9+xhJcb9y7I+bNiI51bXbqnNrk/wehTJ1P8LKL1OXrusOwlPGWH4YX2Yy
         0bRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786465937; x=1787070737;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FUr+nMrLJcfzcZsVfWjSwb/cxhN7c7MgM3O82EHjMxQ=;
        b=f35kaDUH5UndpjmkR4WZz8jfVyLUcQlGkebdP/uAGaDxOGo6PbcaiEBSkR7/wUsVTV
         VZtvw/wU9tS2/gD6bvGSO5vKfBhPEP37sDryIOmXu1zQFXToo8UnHhIaa3mVUHc/lEgx
         QjEWMBTyFTAKz3URhiBwG0xyaBjD8F44cLfmD6naLsxU6Ifpn3mT+FlCWgtd1i3I8+V6
         zf2GhCeiwjV/ZRykNjNFQInkZLCxew54/Nhq4uTqs2NAUMuiPdaFGZchq9eMUr3CqhDS
         KWg8nw5KNuguDL2si9Cz8wiJQDE+e4KArgVyXJsDjZNoA4R3J4NV1dXTCCe0wkpfyhM3
         JqKQ==
X-Gm-Message-State: AOJu0Yx1bfkavjKaouuDIkkW7bX88Vq2meKr+6+xakqLNnCdOJIo8hAT
	Bfp6/k1uZxbTl6H9iYT8xrq6AKd7ufvZUDD5r3V/uEGotnXLfbpqx9QE
X-Gm-Gg: AR+sD123/Nopgj3TwQEPAVyjQ+FSUeNGDHT78TQfHjogT2TQ/IL64Oxpmc1M7Ma7iSz
	SNt8zcqvEASXtFwB4FTQf2oDfXPcW6ZjrWAxoCxj3b0yUrBf/DcSHxtW/QqftqNK2SA0ZZGWLOX
	Tg7oODcn0CMD8oAgivzKfwgHyOZkhFOSx7vZAIPT3Oh5TGmN0hXZmhsd+1QHo2urQ1kWM2oT7mm
	f4hqCzQU1b8fs+T8FcOmuxSQ2z3X4+YoT4qQcLnhDQGnNW8Ex3Zl181w0KTpIylZwXqfOCoAtZW
	Yq5E3Wqn1q86y5aw4IhzMNLdysJn04cQmV35FtqXaVIoNb4ptjwoBbKq+QjQljpgowSmlGx1di0
	d04BpxioDNV3RuMMtbwo0xrtnEKR84uxIw6Pvwl0zZf5h7b4+97/tjp5rnW+hESZVgiXvtEA+YF
	ogF45/XIEVYk1WIk1uq9Xy+DNV7/1WpMK8MXEtd3Ydz3t4f90JiaShVEb0NvO5iOQsM1Xq7u6Hg
	zog7tDrgi78XnwHc6y8U6+wx3giRcjHYg6BB4lYGbJ45zO7N7y9h84RyvVPwjfIHgYF+bh1nuxb
	0ldw5wwOemLKlaUN8xObLcQXQrWmMGaUyF0hYw==
X-Received: by 2002:a05:690c:892:b0:81e:abe2:9a3b with SMTP id 00721157ae682-82f28ccf52amr33751217b3.10.1786465936812;
        Tue, 11 Aug 2026 09:32:16 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:9092:700:556d:681f:9688:f449])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-82ebd0cea6fsm12576627b3.3.2026.08.11.09.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 09:32:16 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 2/2] completion: complete tracked paths for "git checkout"
Date: Tue, 11 Aug 2026 12:32:05 -0400
Message-Id: <834FE315-FB34-47B7-9ACF-FC8194FBE8D5@gmail.com>
References: <xmqqmrut4a1l.fsf@gitster.g>
Cc: git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>,
 Leo Kerin Britton <britton.kerin@gmail.com>,
 Elijah Newren <newren@gmail.com>,
 =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
 Patrick Steinhardt <ps@pks.im>,
 =?utf-8?Q?G=C3=A1bor_SZEDER?= <szeder.dev@gmail.com>
In-Reply-To: <xmqqmrut4a1l.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (23D8133)


>=20
> Le 10 ao=C3=BBt 2026 =C3=A0 23:21, Junio C Hamano <gitster@pobox.com> a =C3=
=A9crit :
>=20
> =EF=BB=BFWhen completing arguments for "git checkout", _git_checkout()
> delegates to __git_complete_refs(), which only completes revision
> references.  This is good, as mixing revisions and paths in a single
> list from which the user can choose is confusing.  However, if no
> reference matches, or if "--" is given, _git_checkout() leaves
> COMPREPLY empty.  Bash then falls back to the default filename
> completion in $PWD.
>=20
> This fails when "git -C <path>" is used, as $PWD is not the target
> repository.
>=20
> Update _git_checkout() to use __git_complete_index_file() when "--"
> is present, or when revision reference completion yields no matching
> candidates, so that tracked paths are offered as candidates.
>=20
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> contrib/completion/git-completion.bash |  4 ++++
> t/t9902-completion.sh                  | 27 ++++++++++++++++++++++++++
> 2 files changed, 31 insertions(+)
>=20
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/g=
it-completion.bash
> index 38dec1cabe..bd4b6e9247 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1780,6 +1780,10 @@ _git_checkout ()
>            ;;
>        esac
>    fi
> +
> +    if [ ${#COMPREPLY[@]} -eq 0 ]; then
> +        __git_complete_index_file
> +    fi
> }

Assuming the prior step was purely mechanical, which I did not validate, thi=
s looks reasonable to me.=20
