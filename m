Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B885D377AB6
	for <git@vger.kernel.org>; Sat, 10 Oct 2026 15:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791644769; cv=none; b=XhqcUeEk7wWNX0hB8xrZUrjXV1Pz61TeJN1N9E0JDBxxLKQCp6QifA+L6F1Fz2bpnUuPNLwKbQpQ/62jE5e/ADcQuOtptP1muKUL02S9rPTTBzXJnkx9HWDyhobq7zKuUbkTBmYZbjqi5YA44+5mKPgQiVeGo+Ur34znKjgjHjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791644769; c=relaxed/simple;
	bh=xRtbtFWzi/XZwEdO6YadSaHQ9od8qEa/fFDFdA4sXhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QK5XEzbx6bSjV/AwicapLAerZ9Vegqq6gOYLlqfScty/Hbm4Xar+PYGNZ+JePi4LItRsMVgCFOjV37EGGpB3o+ArvoibOBc7kMSIFX9TbhjV6cYN/TcVrLlODVMVKA1D/Jab3GQM11/SrrzJtwbdQVPrwEKCpvtrAllpCCSLlOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=ObbsOJMH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LovuGKl/; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ObbsOJMH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LovuGKl/"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id 98CF11300060
	for <git@vger.kernel.org>; Sat, 10 Oct 2026 11:06:06 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Sat, 10 Oct 2026 11:06:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1791644766; x=
	1791648366; bh=kbrR/X+bJoRff/5Ijn55mrNrk/HtMySpYzzjJnCb5RE=; b=O
	bbsOJMHJh+uZBlGrU9LfGLJ3zuy0rSRzQnBzEuMOzNZtAT80J7pEFlCo4QTj8+hq
	mYdAmKpo63X9GBeNBjz0avawIPUWJ0yKOS9lrh2L50cEQqLVjx2rECTkaUXufZOH
	pNPDnJl+JfY54OkEDhu5vYHupH+59c/W2eJuIC0fWefpywhORRgA8ei+lNi+unsm
	2puOm4lidSpNfxkK7oy2K4xs3/oe/2yt1sIAyRJbNQx/wktP4yeOuvLJ9ECJ4Svp
	hz5PKB0BHyTJfCD/eeYNOT6tEf8F3uhkEgVj2RrqUTwR0wAbFQ17PWqFpJD4RHb5
	VvNFMNB1nhCYVAofv9IBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1791644766; x=1791648366; bh=k
	brR/X+bJoRff/5Ijn55mrNrk/HtMySpYzzjJnCb5RE=; b=LovuGKl/mi0VApTOe
	GmL1y+PmCQ7zUqUq9J1zo7olN8Zr2bz0HtdRpLVLiZegZMUAggKOk4xPDXyeAAwC
	om59jeEgkQpLgTT0bqLHvxEHmd184ehvHjZJ8/KHk4hsSF67mwNBmeiYG91//MRS
	O084vOhvYyC8ecosE+DQUopftZhPrhTM9vewtsI46yQgYp3CAdDOzXBi+Og+eqVK
	i8edyQliHBcEPlpEM7RSezfu17lKp6lGpZl+IiZ6lbOkD8qoFzhgB8jQM3O5Fo3m
	Wn6d0n/oE2eF+2s2i8yXe+gLY/ysQJv4cBw3GL54cHVB/xgKq1Pi7JAhFyCMEriu
	QybEA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791644766; d=fastmail.com;
	mf=PG1hcmtjaHVjYXJyb2xsQGZhc3RtYWlsLmNvbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ht5/Zujall8NhQ813YqWuJKKXVl1EW8w4ec2CAQO84Zn/yH
	WI26j1FZb8FpHN4yABsSvSG/alyPhWTvX67L8VLLfYddEwbfPmkxQPAlsQA4RVbK
	VAH9qah8zewUIawVdWsieUMx2n2B51ie7IzQZt/G4A1fB0aZ9keDiFTi4aoBfX16
	xY42NyQpKrohAfBVUTyFcZdxZnVfKLQvRivvcE3xYmuG8BB/HcSMFwZm6Laf+Tfj
	u/0og/rC6UiNn4K3qVRtFCfZRdxZ+D4ioOfA8li19KmYAfUI2cpvKFP10jsQmMCH
	WhuMrk6Ft1/QtZacQnIEsODzQXicUagwADL9ydQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:1O+UHL/SKHCgJReKfgY9SbF5MDMaErCaXYsOXVaZYBk=:xRtbtFWzi/XZwEdO6YadSaHQ9od8qEa/fFDFdA4sXhc=;
X-ME-Sender: <xms:XVTKaj4-GfI9DwdJIwm8xA0ICcGXqsP72GnJgG3ToV_Y5GGcZIhO7g>
    <xme:XVTKav70AUswn5WShma71MckqUTV2VqzDCyw4FQ6fKS8kFQQqnV75uIxmhH7cG2Et
    GlcXdP73iZHmqrxtVItLDBsbgEFSR3PSU0h7vVaqe1ykUyWGpsuXcii>
X-ME-Received: <xmr:XVTKaveRAz4abUZkM2hQL2EYS8ZTvvnDPTShZoZ0ZCmpF5lIAX47b_e7pMoz7bWoGKL-CyYlHZPebBTghkmaksxjY3f4tw3095WH6Yzb7_0IxZjOmPmjMsYyi2wGRVd4SYaEeeFHHIaZrYIt2FNl>
X-ME-Proxy-Cause: dmFkZTGog1gbgdpxQY12HihMpuTujU1P00XF8G3/8NrOnsZS0NECYKzKdAoHjuLNh5xulE
    va57AlMBNr64lsR3YCUwc8UYPElrUBu9FUybAw6kUWe7WAboI1XQZ5T84ktOgCCMnerb08
    G0GUagxSP1zUiVYrwDvCgDoMkT3NwBc0k4OdTkBLByesshmvfcOboAfHcjP/GcbZ3V6pfF
    z9Tm1NDdrxz4C5YO5RGoniAyljvh15RSvZcTK0nu8DpaIMX0V2ze+asCDmKtRbnuXn6H2o
    kv7+mUdbcxQ232s3O6P1+R1GuMnNosxwv1AVPn07zSAWA3PBnA6ptqv+eFzzF8u96rweta
    N/2mHdCFZaTZ40R85r6KIV/eKMTc/lY1JWy92SqcXnFwrAmYJ0fV6oJYLb2/94YWY+A6je
    hor0RnG8DxFt0p48lFDooSE4T+pWnAhJbOFZBIRCpY0EC5TOrhGauxYyasZwkiobOxQg0p
    9JXPqK+2IhZryNp9cQaKXA7c4QuduWH/n035RQlAWBRogXi/JSi2uLItCZht+J7qX0lHJp
    xu7F7H8X2GWN/bYWfwE71WrqBLrMxX46WdGVMurpNdvIaJbmz0BsE7v/OujCI4RQ5Ro0Qd
    5pUnlqm9LFoOvH0m+XV/9l/NzreyQLozwrJZAukU41euA6ETm3Gbcq/W5Slw
X-ME-Proxy: <xmx:XVTKajAefTdaZ_Iinnsi4rJTj2z_KQ_Fo-L02y3kR1RTpZ_6vIE34A>
    <xmx:XVTKai8w5ipCMsh314Qk4jK-u50jHmWPaHsbcRJwxFNHSpilbmPdNg>
    <xmx:XVTKauILN4-9yVJeArMmli0Z2rqeEZ2HPITB4YQU9GywIcQPfITOwg>
    <xmx:XVTKarguYOeZh7xJWAkGDhSAVWEZ2Fcxt_3iZwEJFffx9fBvO7tYnQ>
    <xmx:XlTKauQs_jGFM2PArc0672KpO3x_iyYYe4tFsHIfR_hnZlltnEykLMm_>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 10 Oct 2026 11:06:05 -0400 (EDT)
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com,
	ps@pks.im,
	"Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Subject: [PATCH v4 0/1] repo: add revision filtering options to "repo structure"
Date: Sat, 10 Oct 2026 11:05:39 -0400
Message-ID: <20261010150539.930614-2-markchucarroll@fastmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924164503.119506-2-markchucarroll@fastmail.com>
References: <20260924164503.119506-2-markchucarroll@fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"git repo structure" provides a collection of useful information                                                        
about the information stored in a repo. In particular, it's                                                             
valuable for diagnosing performance issues caused by large objects                                                      
stored in a repo.                                                                                                       
                                                                                                                        
The current implementation of "git repo stucture" provides summary                                                      
information about everything in the repository - all of the                                                             
branches, remotes, tags, stashes, and notes. But sometimes                                                              
to properly diagnose a problem, it's useful to be able to get                                                           
information about the specific part of the repo that's exhibiting                                                       
a problem.                                                                                                              
                                                                                                                        
Add the option to specify a set of revs. If revs are included,                                                          
then the set of objects processed will be limited based on the                                                          
rev specification; otherwise, all objects will be processed.

Differences from v3:
- Remove inadvertent edits.
- Ensure that this is the right version of the patch, because I'm an idiot.


Mark C. Chu-Carroll (1):
  repo: add revision filtering options to "repo structure"

 Documentation/git-repo.adoc |  32 +++++-
 builtin/repo.c              |  32 ++++--
 t/t1901-repo-structure.sh   | 211 +++++++++++++++++++++++++++---------
 3 files changed, 210 insertions(+), 65 deletions(-)

-- 
2.53.0

