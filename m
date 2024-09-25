Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27BC1EEE9
	for <git@vger.kernel.org>; Wed, 25 Sep 2024 17:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727284974; cv=none; b=ujZN7qfibMxvNZ+Z2ZnvKutLb1UAVXxuzGTQzrliTrl+gAE4ZsyeMLv16/G9uN+xVrhYhaU2EtpkL9JgOauNDOC1ttqqYS8X2oE84d2EKB7CS81S9HXSnjs0j0oJM7xfYxtWvuw4JtG0+qz1YjFZRbQehAXzz8/wgmlFogzgwYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727284974; c=relaxed/simple;
	bh=C5PzZOpr83HXhumfPRzxmLK+drulaB33rOpCukIEUn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=By+uEL2mbyZg8fXX9M3e2S/c6e2XI4XjOpvHTckRKeO+EE/n3Oyoh+QFcI0pbJ2IXqXQ2CWP7J6upElWaOybZOOU6O0ZELDydwYyFlI2tXbkthzy04mmZw/OWVsdW7WF/dgkqvQvEJvnWNhFOAIwT58u2Rj17Z2cBDxRtLQJ8Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=FOO8xw45; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="FOO8xw45"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6c3f1939d12so1103557b3.2
        for <git@vger.kernel.org>; Wed, 25 Sep 2024 10:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1727284971; x=1727889771; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=75H+Max4OwsDKLI+R30ZUJe2Nlo2ECqjANir+07Se+w=;
        b=FOO8xw45bVSK0p8VgEg+ZsjgBcZ6pmx9rn8QD790DdZOrfviPvlcxtRJlld4p06UKl
         dfUe15Dw8j3tOBWwYl3fpfbLLbRgEaPRgLpy45bhncl+J2jakpHDVYDAjTD7DHY2j6zr
         Vu41ExVROB2Y3OlbRZuFCSVbcm/n7hdv+Wg7aE3IgV4SBiNyPmq7UfQ4XbACu31jFJJ8
         Sp6mOAwfStjzxnoBlBatmy3GA/kvGO4E7j5dICwQpIhLgBKc81ENS0Fbi0mg6xprxwXC
         N5RML2dqdVXzRS3RYCR4Ud8evbh5Mbp7DOwZAdYV3OTR4nrYRDv2Lthzki+NGz8dsxe+
         fDMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727284971; x=1727889771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75H+Max4OwsDKLI+R30ZUJe2Nlo2ECqjANir+07Se+w=;
        b=BYiifROiqdk64fqh3qOcc4kncYFE11x/sHmSmxwJfLIzaNWWevmaOo8GkP98Y+H5ls
         gZy++1bue60Xgq8KNUiAW2h3W3WfujYq/qtSUIhx3aUkxcnEe1gd2ti5NNSlWpCsDp25
         dQrCdZsF+oZvqMTgRzvor5AAR9I/47RfPWOP6O3EIoHnnPVTugTK/aWu5IhYBAOK+ZrE
         D9fldvZmoMpPhydZja/dRGXgCPzlLfTSd0gpaYNoSUmYfYUrh6Zc13sECLimbsbDe6TI
         JUcyYYgMyAJo2QWRcd9xNM3Fgi4+BWuwjLHXom+9zFkrcV8z6sBjLlBKX0bkfDCjNMxE
         wxNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXboWOJ3guSWJHR+szYt+tMLRA97NxIQCfwoTW9ktxsxsaGGTITb/+SUhEx1fMuu6eSIe4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUMD5Hb/fAgksB5qXt+mqXqT5+4TonPFFh+ddOFre72/K+DrzC
	10oxiCBPwP/8UQVRzyeCOrkLDIsg+rG1aweUqMd0jAMgxih1ZLwgWR4O089ElzgYWErKeDdoDcJ
	x4zk=
X-Google-Smtp-Source: AGHT+IGeL/oSr7AP/Dg31triOquSmkbaZCVmFZokt6wuI2IhDjECjd0TEeyg8Si40daxswUeBSmpHQ==
X-Received: by 2002:a05:690c:6608:b0:6b3:9cc1:97e4 with SMTP id 00721157ae682-6e21d9e79e1mr32089517b3.30.1727284971486;
        Wed, 25 Sep 2024 10:22:51 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e22fa977b4sm121577b3.42.2024.09.25.10.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 10:22:51 -0700 (PDT)
Date: Wed, 25 Sep 2024 13:22:50 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 0/8] hash.h: support choosing a separate SHA-1 for
 non-cryptographic uses
Message-ID: <ZvRG6iniVZi+IGFm@nand.local>
References: <cover.1725206584.git.me@ttaylorr.com>
 <cover.1727199118.git.me@ttaylorr.com>
 <CABPp-BEqWhSVSEArOu_45Bt8W0d8PWThSbWrYAEWKrcMsDGsHw@mail.gmail.com>
 <xmqqjzezodzb.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqjzezodzb.fsf@gitster.g>

On Wed, Sep 25, 2024 at 10:11:20AM -0700, Junio C Hamano wrote:
> Elijah Newren <newren@gmail.com> writes:
>
> >>     -    these callers are safe to use the fast (and potentially non-collision
> >>     +    these callers are safe to use the unsafe (and potentially non-collision
> >>          detecting) SHA-1 implementation.
> >
> > Is the "and potentially non-collision detecting" parenthetical comment
> > still needed now that it's referred to as unsafe?  Even if we keep
> > most of it, maybe we should drop the "and"?
>
> I appreciate a careful reading like this.  The use of "unsafe"
> becomes easier to understandable if we lost "potentially", e.g.
>
> 	are safe to use the unsafe SHA-1 implementation that does
> 	not attempt to detect collisions.

Me too. I ended up with a slightly different wording that matches
Elijah's more than your own, but I appreciate the careful review from
both of you.

> > This patch was also fast->unsafe translations; I identified two above
> > that I think should get some tweaks.
>
> Thanks for carefully reading.

Ditto.

Thanks,
Taylor
