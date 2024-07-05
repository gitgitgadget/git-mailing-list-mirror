Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49892208A7
	for <git@vger.kernel.org>; Fri,  5 Jul 2024 20:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720213007; cv=none; b=HvIwxzpyPuvQYMp+oePL+AfEOm/B1kobpxvLKxrSnte2XHWTTFBuzPU6aEi/zcS4OjKwbSOhc62D9ppgq4esXHFPNkQ9eT2z1VDA8iskTTeOjSkb1ISHkYIkn7XmT4T0e1B+vR7H8xEWwPaHK31+flmOLrA6TYyjHR8/FOjKauY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720213007; c=relaxed/simple;
	bh=XUzmYG1h58OSkWkREglr0DSltzINQWZZWzV1YHQWe2k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T6ChZOUKbmW+sR7IDfp97MqPyIeLY1qklnVOQUoAJvnCcaXs9RIyz1uysobEhMrLtqVAFhTaKZYt5qUT7FX+l/2KLlwt/V+zn28G3U+QiZEsjnJceC9H0fXg9qXd8FUea7Dg1LYjixnRUhT37LUWUI+2A2sD4dnOTgskdEnWTLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DrUAG8Z8; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DrUAG8Z8"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-64be6442539so1703697b3.3
        for <git@vger.kernel.org>; Fri, 05 Jul 2024 13:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720213005; x=1720817805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c+XamF1ST0S14iWXHeknyhydHMGxQ0bqLGch3Rr0ALU=;
        b=DrUAG8Z8NZb4Ruqb1A1zINCZDXRZu5NpKOhtHb1h8mA2/0hww5jss1yNuT4PhT0UC+
         TWvHbrUDDCGjd6nCZPlesZKWDeV5rqBH6jd/LTvGvvxhGTOpwiHFAOb+LXfpbMVLNJ+t
         1wS9Qjb/DRc5GnlXU5IldhxGBUbvSqn47wBrk8nSY7h78krB5iZfwG6+ovEB20iqkOhY
         J46MJcKNLGH/x37pxFuCstsAFrM4aq3E/CSLEUj0SREsXAUv60M3dJzrloNWHiFsPxeT
         lI+N7z+zb8z2SNhTtdW7SlLf4Pe6Ymc2X1WWIgckiAWjciCdmYNJL6+pAwBHxPZezP62
         xH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720213005; x=1720817805;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c+XamF1ST0S14iWXHeknyhydHMGxQ0bqLGch3Rr0ALU=;
        b=cTYm+w35N86ELVS+mSKHWhMbutuXisBwip0G8mENRaWZQ5xximrlMeuZAtMNMhaRQc
         secYwAmiI696j/F24x9/QJ3IGRF0i597NOcjl9bnsmIBQZsr8ZigPLL7DfOxCvWzQqZh
         ZNVLyGb1sNxvegu1GhuAYJC+70XGs8LGOs/992GfQBUa2XJ/mxiRuO+77nEK5K39idhM
         RkW7MRjGIefAv1f+l1ZkM+kHxW/KjnCDNNMI16E2ydVAgyIEbMbKgDn90kXeDdDIR4lk
         67TT5GJ+Rctp17YtoDISEdrQ/kVd1qrSDlQHhHA1BOGWhh8HZrw/YoJNhRruR67EGyIQ
         V46Q==
X-Forwarded-Encrypted: i=1; AJvYcCXqg3ILTEzdtuFdbGJGPauxVL+WLZWvpoYuvwSAsVhULe09QhhD9gNoQLqb39sQZj9d/m+JmCLczHOmw8rfJ5lFNabM
X-Gm-Message-State: AOJu0YxH8Z7/ItaNAZvuw4oRjasXVfllEhHuNPCNj7NFkoQ5C8tqHcSP
	m3UiMsLCiKiA3d4lR28GOpqkfUQ1Dsd2Yt5UWjIQjlAFD/N2zcF/
X-Google-Smtp-Source: AGHT+IE+iduLgMXf/Le+htQSp66vBE79+VEgqccFPlA9670nGAFxX7kJ9zryxZYS1bDOGhmF55KdOg==
X-Received: by 2002:a81:8390:0:b0:630:b000:f548 with SMTP id 00721157ae682-652d95c39famr44379267b3.3.1720213005026;
        Fri, 05 Jul 2024 13:56:45 -0700 (PDT)
Received: from epic96565.epic.com (pat-verona-h.epic.com. [199.204.56.213])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-654c79b9b06sm1637817b3.36.2024.07.05.13.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 13:56:44 -0700 (PDT)
From: Sean Allred <allred.sean@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: brianmlyles <brianmlyles@gmail.com>,  git@vger.kernel.org,  Johannes
 Sixt <j6t@kdbg.org>
Subject: Re: [BUG REPORT] git-gui invokes prepare-commit-msg hook incorrectly
In-Reply-To: <CAPig+cRQPrtGBTxM49nUeHvsVr0qEOnKZ5W_4by=A9mXEsR3DA@mail.gmail.com>
 (Eric
	Sunshine's message of "Fri, 5 Jul 2024 15:57:09 -0400")
References: <17df67804ef7a3c8.df629cdadcf4ea15.524a056283063601@EPIC94403>
	<CAPig+cRQPrtGBTxM49nUeHvsVr0qEOnKZ5W_4by=A9mXEsR3DA@mail.gmail.com>
Date: Fri, 05 Jul 2024 15:56:43 -0500
Message-ID: <m034onpng4.fsf@epic96565.epic.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Sunshine <sunshine@sunshineco.com> writes:
> On Fri, Jul 5, 2024 at 3:23=E2=80=AFPM brianmlyles <brianmlyles@gmail.com=
> wrote:
>> I noticed that commits from certain users were ending up in our
>> repository with comment-like lines in the commit message. [...]
>> [...]
>> This seems like a bug in git-gui. I see two fixes, but I'm not sure
>> which is more correct:
>> [...]
>> - Have git-gui create the commit in a way that causes the message to be
>>   washed
>>
>> The latter seems like it would be more consistent with other workflows
>> where the user is seeing the message in an editor, so my instinct is
>> that it would be the better fix.

There is a third option -- new plumbing in git (a la
git-interpret-trailers) to expose the logic of `cleanup_message`. This
comes with some nice flexibility, but introduces complexity around
transferring state (e.g. passed options to git-commit) that would
probably be best to avoid.

The second option above does seem simpler.

> A patch to make git-gui strip comment lines had been previously
> applied[1,2], however, it badly broke git-gui when running with old
> Tcl versions, such as on macOS[3,4]. The breakage was not
> insurmountable, and a patch[5,6] was submitted to resolve it.
> Unfortunately, the then-maintainer of git-gui lost interest in the
> project about that point, thus left the issue hanging. Thus, to this
> day, git-gui still doesn't strip comment lines.
>
> Resurrecting these patches would be one way forward, assuming the new
> git-gui maintainer[7] (who is Cc:'d) would be interested.
>
> [1]: v2: https://lore.kernel.org/git/20210218181937.83419-1-me@yadavpraty=
ush.com/
> [2]: v1: https://lore.kernel.org/git/20210202200301.44282-1-me@yadavpraty=
ush.com/
> [3]: https://lore.kernel.org/git/CAPig+cT-sfgMDi9-6AEKF85NtOiXeqddJjk-pYu=
hDtTVAE-UEw@mail.gmail.com/
> [4]: https://lore.kernel.org/git/CAPig+cSC8uNfoAjDKdBNheod9_0-pCD-K_2kwt+=
J8USnoyQ7Aw@mail.gmail.com/
> [5]: https://lore.kernel.org/git/20210228231110.24076-1-sunshine@sunshine=
co.com/
> [6]: https://lore.kernel.org/git/CAPig+cRQN4PjfxEOZ8ZBA_uttsRPS8DPDgToM_J=
FvichDDh_HQ@mail.gmail.com/
> [7]: https://lore.kernel.org/git/0241021e-0b17-4031-ad9f-8abe8e0c0097@kdb=
g.org/

I haven't looked super closely at the patches you've linked, Eric, but
it seems like those are specific to stripping comment characters. As
I've noted elsewhere[1], there's potentially more to strip than just
comments (like patch scissors). I suspect the only paths forward to
guarantee that message-washing happens would either be an option to
git-commit to explicitly enable it OR (probably preferred) have git-gui
invoke git-commit with an appropriate editor instead of using -F.

[1]: https://lore.kernel.org/git/m0h6d3pphu.fsf@epic96565.epic.com/T/#u

-Sean

--=20
Sean Allred
