Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98B810F0
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 01:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784166457; cv=none; b=r52oFe/L5+gr0KK+td5K6kZrokZfKzsdrf5Y1v/Rn/urk7UMvNqZPofo3VsQd/I24azgQW5jO/DbRYbGMYSoeBFOkr9ZNTBcvuTFsWhMqb45p2s6au55SXVKtZYVa0MDK6+gBXRNHXuJTBsQ2qz9/idoqsLtTUFdDg0xLT/eO3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784166457; c=relaxed/simple;
	bh=TXk8xK56qoKxYf7RHi+jRzO068k3Dq6OLp7OBlzjt+M=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=hNlYtkWxwoxlJilNKJ+nZAvo4dfXcMY2uLuy/NddHgLTQFFcX8qxiIhKI5YauiT3FFq4TMM/MFygukPpUgmE2Zd+g4k1JnqOCJdEOPAR/yTbg13ATTqdL5RkCRhS0agmo6NmW3u/X5tc2r7M0hzri6KdoTtPwq9KDpqBIUdedHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqhGemtC; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqhGemtC"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-475881b9a4bso2481750f8f.3
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 18:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784166454; x=1784771254; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oRy/stI3DhpvCTsgC4NlHMe4ybbAgwpm3NUlrSX7Tbo=;
        b=nqhGemtCApFKykEGNZ3qwQF4o7X1jNE+VXXHn1iJkOiNUhCLuaScxg5pLM/T1Rhxm0
         mZF6Wl9WMxSgYjtFndVswENOVGb2a9x+vATiY/R/0Lq7CxlsuhB84BYAxJMSTEHlbsxp
         NAVCZ0beBmEJPZBJp8uyle7/XPj+Tu421f/P7UxOBX/n2xx+YHpdE95CR/xXXh3xEehX
         SJVmYhIO48HCkAIWB2Rro8aIRplNo1gws32fkKjvDf35MpHy/2aokcERdZJNtsOQ9koQ
         LnQpfeYhnIouoH57tT3Bps5H4WbhqnvHuDDBgJ5MXuV6iBneufEHTgPVz3W9omnLedJW
         Z3vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784166454; x=1784771254;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oRy/stI3DhpvCTsgC4NlHMe4ybbAgwpm3NUlrSX7Tbo=;
        b=UjA+6xbdioO8kJJKtBk9YYgWxswhZD0eAUEprXK67sDK7yRiNpF40OcYX98P8uLjDC
         +ZnTVPmFjc+LT1XttEXgMLhDV4htRg2Hti7ctTF8JfnPJkSrNQutV7kxVJB+7VylWSgj
         9FI3MBX5fWmvnM7yFOiGkSXT+IVa6Fj4b0Y/jSlaB/7HhqWRZe6ItNZ+6yLD8z7NlQle
         n1gTspjmwBXbvKcM7AJ8cm9gMw75ZBqvCcAS0EgsO1cbCvP9lXOhz9tt86pOHngEQ24L
         YAfaRFxuTOq2iTjB+Zdo0QGRWwiCz7qoisz1w2lPvwg0unAPGefiejqQ9a/a8lHSvL/t
         7WsQ==
X-Gm-Message-State: AOJu0Yw95o2+AXrSQfiw6i3MRMFK6c2EABUtqt85rlQ2i0r/wxE5a1bo
	9SP67RaP2oWbyPPZDYBD6IfuAOl8hnQkAw57ySa0RXybfUL/mIS9sXF0
X-Gm-Gg: AfdE7clo2TZ3QcB5g0/CS59WkDzMQqR3IlJx2thl9eaBZhVONnTU3cw6Q9ysVNQC78B
	i9BwOQKSe9G9HGdPhc5gkpNV2n66gq4nsRs75XIAZsgcfy1FtBoqFsiEY4pPBh0gv0eRAqAYEIN
	RqrYWgL3BFbfKa8zhQgntGIBhNDuNFqba7ixQWNnBCGO8CAeU0gVXwtfirjmHwMLWb1v/J4qamb
	Yfmv7JDTwaUjxrprOhOpNCYBGgu8dbk0F1C6KGD36x/hF2F9kJ4vYtACTGUKec2Em3LqLzJojiQ
	8ND+wmWqKbZ5R1zG1zYrMIuABiaCEx3nUHdmCjrmzSnQP6MaLdPOl7N9Mad6N22iL3fz7uWhd/1
	rWs2PizTAsEk3BYwz3qgqwgpXrrVObZLtxm48wNX/p+v4ig61t57MWGOSGaFINf8T//aNXl8v3m
	j7GijptYpAL7t3QlrUCQ1cJw9MJVJta1KSzl4diabWSLj/HN5ANSgp98w0MDOB+/D3kQVxfuNy5
	vmSRf2ashJyML2wA/e+SIgv/kdmeeKqVEAPERXMTOIs2ugY/Mhh/ljL1PKL084Ubd618AkJQ7N5
	ALUVZXiQLzP7c1F0ne7fZ33/cmzzFP0xe2q/OlpeAcRhkngBTviP0mY8MIs=
X-Received: by 2002:a05:6000:2002:b0:475:f100:35f9 with SMTP id ffacd0b85a97d-47f2dd4361dmr23953371f8f.54.1784166453848;
        Wed, 15 Jul 2026 18:47:33 -0700 (PDT)
Received: from localhost (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464d6fa7sm20595273f8f.37.2026.07.15.18.47.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2026 18:47:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Jul 2026 03:47:32 +0200
Message-Id: <DJZM80YDCMQG.SXP22P43W1J3@gmail.com>
Cc: <git@vger.kernel.org>, <chandrapratap3519@gmail.com>,
 <chriscool@tuxfamily.org>, <eric.peijian@gmail.com>, <jltobler@gmail.com>,
 <karthik.188@gmail.com>, <peff@peff.net>, <toon@iotcl.com>
Subject: Re: [PATCH GSoC v18 13/13] cat-file: make remote-object-info
 allow-list dynamic
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Pablo Sabater"
 <pabloosabaterr@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260714-ps-eric-work-rebase-v17-0-afabfc83260e@gmail.com>
 <20260715-ps-eric-work-rebase-v18-0-34d7adb051bb@gmail.com>
 <20260715-ps-eric-work-rebase-v18-13-34d7adb051bb@gmail.com>
 <xmqqcxwonnkx.fsf@gitster.g> <DJZDEE0G6ZRS.2RT8JTQQ6CUXB@gmail.com>
 <xmqqwluwj8of.fsf@gitster.g> <DJZH1PLDC08G.1XTK39BO8YOVS@gmail.com>
 <xmqqmrvrk9ge.fsf@gitster.g>
In-Reply-To: <xmqqmrvrk9ge.fsf@gitster.g>

On Thu Jul 16, 2026 at 3:30 AM CEST, Junio C Hamano wrote:
> "Pablo Sabater" <pabloosabaterr@gmail.com> writes:
>
>> We can force "size" when only %(objectname) is requested so the
>> server validates the OID, and discard the size on the client side.
>>
>> Because this is a cheap fix, I'll add a NEEDSWORK for the existence
>> check to be done regardless of the attributes requested.
>
> Hmph, why NEEDSWORK?  Not doing so would mean that the result
> lacks correctness.  Why should the first version of this series
> deliberately produce an incorrect result?

I was trying to keep the scope of this series to client-side only.

But you are right, I'll add a prep commit in this series that fixes the
behavior. no NEEDSWORK.

Thanks,
Pablo
