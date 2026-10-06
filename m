Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262F83DD84C
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 18:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791309949; cv=none; b=Q/cL+JEf4JvsZVrcQqs04ZC4uqHLIFB93cpxe9qn84B2z9SiW6yk6b/Lw/KP4WA3rgnC0TlRGK1YU9NiN4iaVVI1J0ckRzTI0Aha5a/EaU5w5i394VkjPUcCJh6YQy341ig/vPl/+wJNjrm3k2y0/DjMrUwsQ2LpckJGHMCDHFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791309949; c=relaxed/simple;
	bh=eeC4Y4+iVUrhE4ppsfPY7ZW20DpA2Km4JFCPvALom6M=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DKaow6fX9AiV4xF6aAer60XAOX9TOFnSF/MxoGNuijDtohDJY68GU7y4XsiY33gyEMW+AdOarb+/B42H4WwbHejO18h0qpKe9rAgo//NIidIwqIKZVszuGk9i3De1CiLnbDd6hn/o6m1oexDOww69faD9iVWT2ddhozxVJmZ7Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=Y1GKSbQn; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="Y1GKSbQn"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-9178d514951so25439926d6.0
        for <git@vger.kernel.org>; Tue, 06 Oct 2026 11:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1791309947; x=1791914747; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:to
         :from:date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TNEvUmSFK1rXxeNkDQDHCuJ+wGV9Alz5CZC4qGduWks=;
        b=Y1GKSbQnXv72i3RTDTa6mXpewzktkb7CAdxHtPjm0BkU+p8sLLLXsD4R77E3pYTXLM
         tAW8infjWx2y13A8cEOGbzEuWhQjXrC29wGGRZ1KzoA26RvmEjfNBT29Sq3yhe2DwdNN
         EeoNSTddvZwAIYV4jay/prb6xKEMSug1pCsXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791309947; x=1791914747;
        h=content-disposition:content-type:mime-version:message-id:subject:to
         :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TNEvUmSFK1rXxeNkDQDHCuJ+wGV9Alz5CZC4qGduWks=;
        b=1U3O5df2hmcw+wk7aNKGcOo9qODey7AJ/gOC1l07gkVqGtCppewU5QEiIBXx3IZEPU
         grSJpKI3YG+Nu0yzSoE1W7UsLILLfDY5hdLATPpLCfDQmoZieHkI7ho+dGVDiTv3myvx
         GAsCXs45mxEVihmFkzuPXdqnPoJWw5mYyNFaK013nYN1mfPtbLQrNPEUKMPkNNeEaIdg
         mIzYDl6l3Zvagok4GOrMOiwPK1Ph/Mq30zoNn2qQGCwtpTtoFx1uTZluZZxMnTWxUBk0
         jMn8zbJqkqdFlQQbWEs3elSiL1+dD+RvAoOQ3iM3OsH34Kmx4MNmhKEAAh6hb0cSxbgy
         tdMg==
X-Gm-Message-State: AFuF++kdfN5P2wua6BlyEfcHxR5R+r6NWdl7MD8SOAqBK/d74CSJYIV4
	REbi3w3YTSleeOmrHgBKhV1sD6gLrcQ0Tu/UnNll8b23arRlXepsOiz1abz4fZwoK1aQ+bz2NGs
	ez6omy8Q=
X-Gm-Gg: AYBFou31kZhOg8qqr/wGYRsCaTLFDrZO8rI9eU7PMtyKjKksvdnZpgv8ZpzvLQYipgD
	xG207UZyiDjbjH5nnsw1OvdYLNgdPDPkcpqzwPM6ebaMYMM8KqDRYqkuOz/0sYQUeB4sfg79Ti3
	u01geVhVQPSvZOozehiDRWpT6s/evUNZGB+v51mmWij7ypMSenOKljlkVGiutZds0wHbf1Q7vsk
	Fx/22DxDc01kPSR8LNrFsC5yaE4g5hMhSE9mgeVziultZQyXpQjHICTiEwn3MpbtsVIVZzeVWU5
	nDh6MkmbAJ8I54SzFfmM1Wjw51XC4Md3ExU+RBz380TKysAyxmwwR0VADpHyymfMNBHhRKX2LyE
	d40LKYBNb3aDxi2qDVZ/1h6ejlIny0nm4E4xvSwaRDoqwczBv1uCfOWB0c4vw65JkWTQv8eXYMR
	JfZvBEFj5A/qDvbGY5Lgqh6JE/AJgd48BFQ3JC4cXql0BlYWU86HmPi//XEjTAymwigfUwg9OiU
	gRALG/wZTZ0w014zZj6vCgmenVkRxMdotZ1/dMrXO/mK607FFrjPh+klE/wTjkSUvsix58ROZQU
	+GZdYc13llE=
X-Received: by 2002:a05:620a:601c:b0:93c:ca09:aa34 with SMTP id af79cd13be357-93e51086d13mr2151232385a.46.1791309944615;
        Tue, 06 Oct 2026 11:05:44 -0700 (PDT)
Received: from com-79390 (vpn-eastus-01.tradc-corp.com. [172.190.114.39])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93e98f6ce05sm19301785a.4.2026.10.06.11.05.42
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 11:05:43 -0700 (PDT)
Date: Tue, 6 Oct 2026 11:05:36 -0700
From: Taylor Blau <ttaylorr@openai.com>
To: git@vger.kernel.org
Subject: Notes from the Git Contributor's Summit, 2026
Message-ID: <summit-2026.94e33e9ddf234334.00@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Thanks to everybody who participated in this year's Contributor's
Summit, and to the folks who took notes during the discussions.

I'm sharing the notes here so that people who could not attend can catch
up, and so we can continue the discussions on the list. The shared notes
are also in Google Docs:

  https://docs.google.com/document/d/15gDNTjCh9-aQ1ES2MDot5_Qnxj6vRMGwxbH7eixxT84/edit

The topics covered in the replies below are:

 - Security mailing list and security process
 - Git 3.0
 - Documentation
 - Outreachy sponsorship
 - What can we do next with pluggable ODB?
 - AI contribution policy
 - Protocol v2 for pushes

I've lightly edited the notes for readability and kept the speaker
attributions. These are discussion notes, rather than a verbatim
transcript; please reply with corrections or anything the notes missed.
Release dates and reports of work in progress reflect the discussion at
the summit.

Each topic has its own reply to this message so that follow-up
discussion can stay with the relevant notes.

If you have feedback about the summit itself, please share it here or
with me off-list.

Thanks,
Taylor
