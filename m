Received: from flow-b7-smtp.messagingengine.com (flow-b7-smtp.messagingengine.com [202.12.124.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B1C522F0E
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 17:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912545; cv=none; b=bMap+cRcelXnu7MkwivU2CtdJojX0A4GLaYY7u99DdbrRoVW12Al1CVebQ//69n9T/BIUYR1zlZIY81NyJfcI+p+58VgbNrKnCfiy/SZDqDKcecho228wmdWanXXk1IC3StK+vw/ydN5TuLGpAvwrMka6LuOaOKfRgPg6r2GKkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912545; c=relaxed/simple;
	bh=affloK+eksDobnlIleKBKjbOz8p/TbW0lDohApbVS/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TAulP3J7d8QwjBSsj9kviYCxLy1Z7EW1HDAalWhG4+j9krUYXYLVAixbyEJTD+vK8Rf07r/N7rSJCWn2hn34FFJcbJfxXKAncOm27mthK1UMG1wACNawXCODgonLfGAvHeSyIq+2kZdFR7AUPcPvLDUfwNQkhFGyiNdIEWxbPWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=u8utKkxo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VT06HGcs; arc=none smtp.client-ip=202.12.124.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="u8utKkxo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VT06HGcs"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.stl.internal (Postfix) with ESMTP id 6A4A01301043
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 13:29:02 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 13 Oct 2026 13:29:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1791912542; x=
	1791916142; bh=y0+HtTzQLjOLoRXOhGumLATOdtamjrstixNzqL2B5/8=; b=u
	8utKkxo96OA6ZZmMeXGQsCY9HWCUDGva/fdoCjy+M9Kf6jk4swZ3obETPR+fEuIz
	WSSKkH+vlvXb7Fz02s47EOdLrbfNYPG4HNzcHDYgd+H+j/zUAX4G240NcZCjJy+q
	CjIrO4CJ+TtNZaHiFPGB2hNiJ4EkCF7HQJk7/E9/X6Si0+X1OJkO1GjKX75JNxVf
	WaYql7wiILmf13aVihjf/uHf1OWzXKzzaj/VJWCGRc2q4rSOdMy4XiUfZYUE2XbR
	Fet5ItMm469OTSKdDpWBb2aLC0giYPnocrKxWOmmzwPRp3gOo3pIKYoPPbdEby2+
	1LExAieOPIim16qZahjsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1791912542; x=1791916142; bh=y
	0+HtTzQLjOLoRXOhGumLATOdtamjrstixNzqL2B5/8=; b=VT06HGcs6YO1//m1X
	jVtB0TTRXa/7A3kPnPd81mWVBotG4wwrdtrN7e27YZSKBMI9PvLwTPrmO1K0Ioas
	Jdcwv8M/OdF7QxXHXgO5MkxBI6ST2SqNxi5TvM+7Kbhk+nOMfmu+puzu4Nyey+i+
	ecnSgJwSDdd4p4PDs6cPqDo/D3Wa3w7Wj8lYgt2KA86inSxw/zlsixe+nnsvHRJ7
	ztqrrADgmiUhlFtFj24+Pad0zWyMB8h4Tgd19zF+Ed5OavFw9UYcFLgms98zWnFG
	xxADGWXVfbePtBPELDFd25iogrdZonwX0PXKJQg9oXPw5gtFgLeM2mwRbQLxm7MW
	1skjw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791912542; d=fastmail.com;
	mf=PG1hcmtjaHVjYXJyb2xsQGZhc3RtYWlsLmNvbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:BEcY1oPpQed9vGaRs2ZpwEKT8A9t6fYmVigIvcSpkC+jKPl
	BqpaTGZn4mTwoA/AQAuNTBXgkZg4jrCS4Sqem79QlHY6FCWIIWr064ESEIAHfnn8
	RMgnaPEp4ZM4QHqWN3StVCv81xuqKdqkcpso44CQk3yLF6PN61iA/FgM+ZnFNg9f
	UXY0kLNZhYbPya+sywWn7QvTeDC2ac5nks29hZP62iM+wv/VZjxqUzMWxRx8I6Qn
	1mCVnxARP5oI7ruckq79Jud0Ia38oH9OP6t+MtUnqJdZH3+HWZKRleTjUrXwjLLa
	5VJ6TKFbq1prCJQIRTISBjyUXjbDl51dPEQq9yA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Jl8+b8kNhxEYmTAxIrR14URAB5f5gELNcelCclHHoGQ=:affloK+eksDobnlIleKBKjbOz8p/TbW0lDohApbVS/U=;
X-ME-Sender: <xms:XWrOaiXAtCy4KINURh8kgcvbHVoXmlZZDXOE5UmqzeqCCdATtbK0Sg>
    <xme:XWrOalnO4QimJv03b16c5RPrLHRDw69Gl9LnF27YvhfsBA3xb_Yt4e_2bdVoi0c9A
    cYh5mhYp1Pbz6Ouq7lwclOEa4G3AqkE3cxj7p_ekxniu7iCkwcT8nlF>
X-ME-Received: <xmr:XWrOarbffn2yHnxoGLDxH9KXfM8rHY4vYLn_Tf0HOsH6XlBkEMrcGpYIisYAkVo2mV5GtqCIW0ceMd-7uY_aJhq19HyvuyQKwDSU5zgKcDZvRg>
X-ME-Proxy-Cause: dmFkZTEtnvW9IPgAf6BqDj28j799XQ1bqExy/kW8oe4hpny3EYHUdwstFVLMz46WtiwH3b
    Rivg0J575pq9cTgsyum3YTLBCVFdJjKgBNmAqcA74w5VI2bsW2Wd6Lpyk9DlNYQYEPESem
    RQDRUQzb52OEW+JpW2/40bMIW1FalY+S/f8XcrFywHOzvx1Cu+B1IErMDGP642przGTRl/
    nt7TrPy6TBf+Ulr8vwDy4UGTxk+IE4d4lbDuL9QTChe/Dt9Zbo8EYpI9WHvWBiHYJ53OxV
    RGC6UmXC4irMr9UDIiCVt2cgfEbBejvNk1rezoV58xcRAVDYhgqXsdiuYlv9j6jCBzCItp
    eVBUcY90zY6hXWDzijqwC0S4x8d95iRgo/SfqBDrXHnY1zIEBnIisOrziwzjs/7CqI9j7n
    0NECPzhA8tWNOFieAWodXPTyPJN8BApQTCSlnLQD1WheqfPIjK5dFAKXO9LxZBviEtIMUe
    vxgYmji8XpN7T8Vx18OMYunQ92fJoKrlZ6kMiuaohqTVlQ9dVTDPs+lpMs4gNEMe1311a1
    PdQFQncoqddSBIbWNX4CNNK33VmGxDtirEUUDJGSZa9QwMg0HisQ35Cda5iETr+hrIzQGF
    re1s7cpbUGf/MIma2XlvGcRD6WI3i2zGMUG46HFET67KoOat+T1qBtJ8vAkA
X-ME-Proxy: <xmx:XWrOaoPS6lSrEluVQZo3hWRweh4inxGXwPM_25xdt2CBKNFuuPjWbg>
    <xmx:XWrOaoaJInnuSaP-Omf098SK14GsD0GP8fRRzwL6mFv_b3Pr03i80g>
    <xmx:XWrOau0_YeWWgaw9yzsUXKNNA-scrQSJ_Jc1Wdyp6O8lBJrAFEvrBQ>
    <xmx:XWrOamc5PgbAmljkSsl5pBY_fI85L1el-9_wbq-JrPFhtKq7HrphWQ>
    <xmx:XWrOav8lboweHNl4fl_yO09YflVvIJHOD-Fbig88Y8Wu2M8d6Y9W0Z5J>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 13:29:01 -0400 (EDT)
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com,
	ps@pks.im,
	"Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Subject: [PATCH v5 0/1] repo: add revision filtering options to "repo structure"
Date: Tue, 13 Oct 2026 13:28:49 -0400
Message-ID: <20261013172849.1109478-2-markchucarroll@fastmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261010150539.930614-2-markchucarroll@fastmail.com>
References: <20261010150539.930614-2-markchucarroll@fastmail.com>
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

Differences from v4:
- Make some control flow cleanups.
- Improve tests.

Mark C. Chu-Carroll (1):
  repo: add filtering options to "repo structure"

 Documentation/git-repo.adoc |  31 +++++-
 builtin/repo.c              |  32 ++++--
 t/t1901-repo-structure.sh   | 208 +++++++++++++++++++++++++++++++++++-
 3 files changed, 253 insertions(+), 18 deletions(-)

-- 
2.53.0

