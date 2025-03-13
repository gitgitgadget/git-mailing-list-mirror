Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2D02641FD
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 13:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741872647; cv=none; b=mWdr6hsZChNKSKuTS+iaqfamYQ30esDEm6ineYKiwiVLPVku5yuBG1SEJvf4fcb44OT58WlzJm/K8v5FyDKfNPzwixWFdjrEY8blpaGFk186/n03pXHLssRVX/ru0T5mcgllsSXGKvS30ayWLm5GXflxWD+MM1b5hcFh8jzSpD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741872647; c=relaxed/simple;
	bh=L7uzNK5mKVCNgJvvA8C8Mro4K3pqWhuSBlC5/h1HIUo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R5f0T8wSpjSJ2v+12/BKkURjTY0jsPKC4YwS8Ebg9IbEHLAKzgm6PPq/3/tiGDUPDEGqnBdm8R1+zqmGz4fkbt7hJCoeF+K8wEtqx1PyHVrV+As/vk0UEOgDkf7OU7ApQ7yMRX6DZIgfNauR+yR5LdAhO0ajBBIvjYWN35SduZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FD9VF/mc; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FD9VF/mc"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-86b68e51af4so408182241.1
        for <git@vger.kernel.org>; Thu, 13 Mar 2025 06:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741872644; x=1742477444; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DuP1n1kRW5dBw7ikRSm2QidOxsRh90TTzmrMvL2LbQo=;
        b=FD9VF/mcDG2UJEwSWEZ/fIm4wy6EG9uX63/waeQbm96WfDHqApTweALA+SIbTuEatV
         E47gJl4HgqRL9CxxgZ3FGi2gsgN6Qs+d5Pegr2dedgtFMuHUW46dBdwNZvrDjoHuBT8i
         EdKhDXG4LpMpBAOQZEwiOcv70lDLjrHCcOEoOJOg75MDZwJ7nP2bJBwlPknpSxcfrtIG
         eGNe+dJKKEJ0lSVSPR3Sc3L0gl3UxYmfwx6RDeZc49YmdinFmUO4d7shbrfEYOKczEpG
         qbeTPe91pl89EAEsDidIQXC21Lo9O8omzQlZp9lvAsCgvs5CFMqi3CtnklJU9mJAi95W
         ICpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741872644; x=1742477444;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DuP1n1kRW5dBw7ikRSm2QidOxsRh90TTzmrMvL2LbQo=;
        b=VS2Q2sgKf7s6C9oGprfRRY/Vnm770eHpaMN+w3QDP0/s7kVZCF6bwvAtHNrjuUurJF
         3jLI42z63YSS5WOH/z++R08Tpm7+se0MjIDG037kw4LlQrBCylFv2bimq1yRgseY0Wtv
         vpvZs7M8/foi9NJLgp4WiVhndJFamk9yYy8jnjQMbM5egvBgUa75Y8H+hgLE2c3Qqqy8
         qBdlnmOaftPy+tEQpw8XsLoxq79Om9jLiI4MiaRRfFejtrLqtooYXCTN1NOaiC4WE0+z
         AgIYZIS+lxZ0SyK6ItphcoslzLGgUL1rlvRL3bSWOPaLp9Jo4GHlCfN1Ru5frx6jc/Ja
         puCg==
X-Gm-Message-State: AOJu0Yw73WKL1WjDWRb4VNSIa7ADpUBLgD8dxxswumFTmRr5IjCDUKhy
	ydVhoxWVksnzIo+M03J7d+TS4KpTPiJr/p4KvXJ1WIt5jqp3vCHLGrRuu3vnb09t2lD4ySExEXG
	X6Gnfb7mnCPKZs59vxrF3Zbuhs9U=
X-Gm-Gg: ASbGncvC+hq51vmhmGxBmMbOQlrJwKXjhRQ5v/N9w3c/eGjVnNypj2n6sIiyQpCHN+7
	ePKSYTx0zaQf+QLE5K+wfZ3vB8PW9LOC+TaMDBJX+G2/M0vxOVmrECqNjrJA6ZhdRRa8fXujyKB
	xQpJHbKXgeXJXa5H7y7bTTLGMY
X-Google-Smtp-Source: AGHT+IFQQZ8vlLabfuze9FXrU2GEz3QUEtq9o2xypWcBUFmpMc+4W8q/mRNhLh+63ISAptwy2EvQQO+DrTRoESDCVpU=
X-Received: by 2002:a05:6102:2912:b0:4c1:9f48:617e with SMTP id
 ada2fe7eead31-4c34d3760bdmr11885964137.21.1741872643772; Thu, 13 Mar 2025
 06:30:43 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 13 Mar 2025 08:30:43 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqsenkaoy3.fsf@gitster.g>
References: <20250307-493-add-command-to-purge-reflog-entries-v1-0-84ab8529cf9e@gmail.com>
 <20250307-493-add-command-to-purge-reflog-entries-v1-1-84ab8529cf9e@gmail.com>
 <xmqqo6ycczdr.fsf@gitster.g> <CAOLa=ZRqMnus=MZV1ASce4pxnMkVRGqhZZ+vZNcGhWdUQE-JRg@mail.gmail.com>
 <xmqqsenkaoy3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 13 Mar 2025 08:30:43 -0500
X-Gm-Features: AQ5f1JorBwdLS-t2vQYjgqV0WBDHuaaHFcM-13KtPtfW6PsZkXee5Jk3s9RGW-g
Message-ID: <CAOLa=ZQq6ax6Ba4gLN8P_TTV-KOrfN5yyNJB98oFx4fd9SFkhQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] reflog: drop usage of global variables
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000002d44cf063039542a"

--0000000000002d44cf063039542a
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>>> but I also suspect that it is mostly due to the original program
>>> structure that uses OPT_SUBCOMMAND() that the subcommands fail to
>>> respond to "-h" unlike the top-level command, so this may not be a
>>> regression.  I do think however that this change is making it harder
>>> to fix.
>>>
>>
>> Hmm. But this is the existing behavior, no?
>
> Didn't I said I also suspect?
>

Yes, I misunderstood!

>> But point taken, I'll drop this patch in the next version! Thanks
>
> Yup.  Take your time, as it is already deep in prerelease feature
> freeze.  I'd prefer to see us leaving spare capacity in our minds to
> fix regressions introduced during this period once they are noticed,
> without getting distracted by shiny new toys.
>
> Thanks.

Fair enough. I only pushed this new topic, because I had mentioned to
you that I would pick it up and I didn't want to forget about it.

Either ways, I will take it slow here! :)

--0000000000002d44cf063039542a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 241d159cee43f56e_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mUzNnSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meEtjREFDSVpja1dwdHhnM1hweE92QlhmY09RUThDaQpNOXhEcG1LQnhk
SGdCdFQ5QzErUUUyRjRNSWk0bTMxalpiRktQRWtlOExuYjRIeTNWcnh2Y1BhaHZWcUdzS3hqClJV
am1LVnFUVHlUQWg1UGxDZ0ZmelJIUjc2QXRZQ0VJaEZETE5qd21PRE5yZkYrOHVsMUEySTVTR0Ex
WUZEUGQKbUFUSlFYNTZQSnVNcUQ3U2NSVWtoOUgrSUNoUWlSS2kvT1QzeTIzZ3RwdFc0SUZ3cGZS
a3p2V216bVhCNUJRYgpIaUFZenpLSFVvaHRldmNUWmZ4Y3VIM1U3L2s0ZGdEQUpLQ0x3bkFmdXQ3
RkU2eW1yVjU1MnlRVmdJNFBsMDdsCmZxZXR0NjVyNjVmend6dFBuakVpb0M3d3dHOENSV3NTMVZk
UkE2K2hLYVh0cUlSQk9raENMMmRSb0doYlgwdG4Kc0x4bUI2SXI1NUtiN2puUmNncFJoOHFUYmRs
blF4bnhLZVBQbHF0YzVPczdVUWRIVStaUXhTOXY4UWR4NVpwbwp5V1VPdVVrMmo0TVYrcTNTRlpw
SlljdWdLSThFVFk0NjlFQldZZklJYjUxSzljZjZPN1k3ckhyYnBna0xEK2Z1Cm1oMW5vS0tvTmwr
Vm9tNUdpN1JQbUtIU29vMGpDd3E3Rm1ZR0NVOD0KPTJSeCsKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000002d44cf063039542a--
