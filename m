Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E697A3A1A23
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 20:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790280830; cv=pass; b=oE2rDxmiFhGaeW4g8go1C1VSPPgAl5i+72wvBf3ETrm9+/ovo0JMuFyejRcV0tMD10FgWVSyqGVRv7DuczbHT6JLgFWm0f1BdLy97gD+YvQOTqkr1WMlikKirQfh9W5f44lt6iUUDJIR9/qwM6buDkTceSAPtdrQix5wpTWUgms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790280830; c=relaxed/simple;
	bh=JV2W/FK7QLtZ+OGAqYb/daCN8hI6bojjlNL7OPY/3x0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YVhodDONTI+Oi3CPMavZlytgddjCuZ3Y/PWLkJsqYEIi9D8PQfNhSo/dIXEC5UK48rtYJxRmNNAcnnjsdbKjLV+kCMX4lNCKy+LvkkEiAl00cJpwuLztzTJZ4Zz2NjTd6w9/6SnTKLN+LLevFDEU08Nrvc6zA4fNxbviOEkcZXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MksUCq1g; arc=pass smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MksUCq1g"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a5d0ad9b89so1105311fa.2
        for <git@vger.kernel.org>; Thu, 24 Sep 2026 13:13:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790280825; cv=none;
        d=google.com; s=arc-20260327;
        b=prD6M/aO4VtKmemPzNmrDaktMp3CDz7Vg9UUpKlROhvOil/BMhor1cKyGWVCaQs/5P
         oZ85zn1M20iA5lYjdxvSHkBG7BeFiay19YPv/TxUWz6Qkg3jSfko//1hqCSgqq0ThY8T
         Cun4xYAGHrwn6zVF74LaTkEFDfmwKvqULl6eY28q3hiR2ArQzTDBLnuL+FkQ6KT1w7+H
         nioHL/liOzJMksyJb2nsHnJHtSUgyqsWPJEWupqJU46/K8XjXq3EfKDeI1LzQJmasdRa
         bNfnN/bm0b2b6N+vqHrCWl/ogfd2u79RsZLmIQ7WkeEhBguxrwfk48OA2HcsdBtsqMC7
         0qtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DVLRW1JrCLsO/vfYIzKLYZuJnkZp3XfY5/a5UqFqd7Y=;
        fh=OvDRtyxaDoeF1PwUN+tKrYf80B55k9QvyGaoDh5oDJ8=;
        b=cIYMQa5uwEcudFN1rS0DwlgXljLsSPOq8j+XLvuz8zDV0Noebrwo+9t9a2D8q9S/Mu
         MPecjkCBzGQ+zE2wq8SM5WsUjAJO0VwoZxFTr7MIww3Sfm4YJwzHTUNMfQnd5KhR2oTp
         s/sMK6YvGTSzImGyIa4kip76sLyBc+cBMeJwyQwoiEwKfwLqIm+cOthK37gyyUrN91fy
         fmawnFgn0/ept1D6ivCmUjF2+0UREqrAt98wj/J/VwjpF1Qd9MXMRfNZTmNX3ZcJa9ib
         cSGLdwsHBTZPTrUAz3c6LYNqCEAF98FC0DbPrtjW6xHO/IiyUny+1jKyArtTLNOr0pnz
         suVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790280825; x=1790885625; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DVLRW1JrCLsO/vfYIzKLYZuJnkZp3XfY5/a5UqFqd7Y=;
        b=MksUCq1gay1KHJta715/kmAlIU4fIulmdcYtACJ6Oacv0e+srNJpUrudmAk1tm1jga
         4xXQeGgAuXjSqDPDIlbdFVgyOvRFMJ/dfZi24vylbsVffd7ozeAdKbH8sNsDrh4eO4bm
         OjLvth2RMY1ucCQlcnPQP9NGJRa40jakNAq2073foHe9tLKlHZYCIuq6/GIGVNOa8Fan
         hW/h9uaB6/cJWzy808mb/ve1hfIULOf6wxBP0538NrpCtnA+ImR6aEyXwVyJh9aLWCaJ
         lVE8joXKLUrpx+x+ob9XjFgXvmyBHhSZmzkbaFB1O0sB3ALSSi+d8fsaTruXsxx50ijM
         SDwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790280825; x=1790885625;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DVLRW1JrCLsO/vfYIzKLYZuJnkZp3XfY5/a5UqFqd7Y=;
        b=vej3PF57L/4JVEs2LFRDQVsRjILY0Q9RahjEBWb5E2b850qP6quwyiZLA8BxQPLsOe
         hHF+BPOUrPVMx/p7krbigWF5Tr6A1b0Ja7krFyG9k4Wu1F627ohURW3JAfKgOHZ1GeYp
         deee4yzbs1g3FwU769kOtkYgAHTGBXg3X2OKVNfbh87k1Si35kxEIwfjINhDNauZ8NWX
         eIzgngGj1yBgio129kBkrMyy+MyH1wq3qrsIWU2PECtvFOCYEIR4uQ2Uil7tp62h+UhC
         wHssCeHv7qm2Qgq3ZtoqZqIgD/n8aRxACrLFtjuNxaQqCB1Ux6gWl9uKQBdXbMiFwl/o
         PnUw==
X-Forwarded-Encrypted: i=1; AKwUvBysybzI0EU07a1BZtdFkyVevA5LBj/8S35BZIGC/6R5qul3++EemexQ0FKZabJst0JrpS0=@vger.kernel.org
X-Gm-Message-State: AFuF++lyx/VM1aS9vl1uEySE5wXttWOhpoGKCloGqfBcRWz2v6+A8i32
	ZEA0FI4Lf3UwGMfibIe6mf1DQT+N6AovpvPNWUWYybgg9yR4KnOIUZmO+9yzbWJZGgMISx7JpUv
	hb/vPg0NO1WKnhgWxzYPeR/OUmuZZnmA=
X-Gm-Gg: AYBFou2PTQB6BmaUYRZ3okFrp1oY0JMyPr93QBAuReVYccBHd03eBJ0G8M2HW0W/OLH
	NGc4N8IhmUQDJtyJnah9ypGvx0O357H8+OLdSCaIzDH74Eeir/DPe0t+3N66JkQskyrakXMUzLU
	GKswc7j97UvtHylzZl/UzgFwK9KF3TDZrvUxn/RhXf1tva+t6VCXECKesJufndurQVnFlikKjXB
	Ibp5rT/KYUZZOu41us02FRLTxkzE4E4RsZ6USKYvLLmzWq7LtiqJowt8oRpWRSuf4yNlE9gMvBU
	TGxHJfMyKBjvywLz2E/EpOk9qYMLwwULWQ+Dcvhi3jOnR9nmGfjAC3FHxRyr30TDK8EadTQDtJR
	TfvVXcscho/HyjTzpYEAhfErZuJjnESyTrPK63w4tEvHgrYYYeXfCBb9wRoYXf58uNdSQUg==
X-Received: by 2002:a05:651c:43cf:20b0:3a5:a139:526e with SMTP id
 38308e7fff4ca-3a63c4120f2mr7125051fa.20.1790280825056; Thu, 24 Sep 2026
 13:13:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1790113781.git.maciej.ciemborowicz@gmail.com>
 <cover.1790196627.git.maciej.ciemborowicz@gmail.com> <9b76cc2c40a2b1fe727677a9400e3b26ec1ab437.1790196627.git.maciej.ciemborowicz@gmail.com>
 <arUEhkuC448hUTCw@pks.im> <xmqq4ife4mzc.fsf@gitster.g>
In-Reply-To: <xmqq4ife4mzc.fsf@gitster.g>
From: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
Date: Thu, 24 Sep 2026 22:13:33 +0200
X-Gm-Features: AclHuK_28Yzysv3KU64zpba2X7rBy5yWBZZ8p8J4kSgMVqlAy8hNjatzlyBpPnU
Message-ID: <CACQ=SRGA5j9ChJ0uM4=5iCwEDgWQEdhhrD8OF9=RJ7XBxqb0dQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] refs: allow callers to supply old OIDs for batch deletion
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	Phil Hord <phil.hord@gmail.com>, Elijah Newren <newren@gmail.com>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	"D . Ben Knoble" <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 6:45=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:

> "callers cannot preserve", meaning "after deletion the values cannot
> be read anymore"?  Of course, but then callers can read them
> beforehand and use the stored value when calling hooks later.

I meant that refs_delete_refs() has no parameter for
the values its callers have already resolved, so those values are not
carried into the transaction and are therefore not available to the hook.

Patrick's later suggestion to resolve missing old values in the common hook
layer seems to avoid this API question altogether.

Thanks,
- Maciej Ciemborowicz
