Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473A033469C
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 22:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783982227; cv=none; b=TaJUfQZ/MLp9GLzHoiPuI3SsoDifz9kEyKePkj3tEgYMuL6ae4P/QNlCHflbEwo5QeYO311vYUBfnocWc3xAqXXzc7fWjkMOhMJBhl5vUP3iuKg1TSgEXwVgWo4p/jFBZ/cp2gqUw5Z7IXv4UsJToMVzwWvrjEHKtN89QiC3Y90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783982227; c=relaxed/simple;
	bh=sUhX/RFLC610lRzJ1yRQMc0iaAu3CIbOsYVQeiRxy9E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IidA+HCa9PzdXrF5X3XNO+zE1dRUnEVGixOO6xlX7w9YOUAft0c7c3PURHqACWri97SRapB/Xm8sKN0xbKYgzom/CXgHuSEtSZLIBUZy97Agx5evv8Mr/Q28WM6wzqDgQpDfE3CSkgDKi1mq2QhFJBsbSsEH+TrsszLm22e3Pxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=E3t7upa8; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="E3t7upa8"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51bfe11a356so6374901cf.0
        for <git@vger.kernel.org>; Mon, 13 Jul 2026 15:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1783982225; x=1784587025; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GS4js1h6usHZuwAh5k3jfpeeQOETNf7Jxq0DoUfHieA=;
        b=E3t7upa8KnBkW8r0euRgqXYJmFVmQM1kntKSD1FTFuJGU76F/+JPP/9mcVDsYAyWJv
         f7JyNa6Pt9Oh7q1V2V+hpHfQxEZvEU2czFGj0n+di6c1hVARw9CiTx454cusuOAau45D
         51Jc0VZvPHQ+WoFw19EHCIHmjtsZHLW85yBhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783982225; x=1784587025;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GS4js1h6usHZuwAh5k3jfpeeQOETNf7Jxq0DoUfHieA=;
        b=MOfgmkZqGrGy2ndSgRw6XdEgEC+HiOxeTuuMPxk85cHJoVGV4QNDIT8Ta4Lo/Ircmn
         Rdf5omgm+KHqggK0M4uDXhvvwJ3RDSHe/OP1a2wFaFcJzXLASmnr1VU/pzGPKNgWeLvi
         J55Q/ko4B6Aq8tbVg/62RhiVTlXX/dBA2SBTDQ3QPfbWS5UdggSp6G97ATWCa6gA5Lac
         vvVWVZee4XDssQweCXca4Jv9Ep2NwFxg0OvKyq358gbfE5UPr68UTLOSyxGzsIOI7Ql1
         hBXGQKLJrhQRev9QqZ99acJ1heWbrJmm143HnFd4zzY3f9Z46T4IqXkosMB7KV/gyEEA
         Y5mQ==
X-Gm-Message-State: AOJu0Yz+M1maZsureFRhH+57CSA4gG99G6N88XdSfRxUOKZZ4RWmTAl3
	e3TSZc9BxybE7BgDvTGpTyZ0C0md+UDD1w9fh9gPJ6ThpjgowrpcE6/j8H5Bjl/NGHo1oxfDFtp
	J3WyZY5w=
X-Gm-Gg: AfdE7ck/EiViPvzbHCviZbbGWDpTIZOfhy8jdKjhKzr5g2yKoAYJ2J5/1Pn+ofEsPxg
	SLOfTHyf53zX+LXkXcVd0ikgFvbjuWwBZUa2DIBhmelOk99ltbdXW1YJ99roJXsQmbne/622i1b
	fo/12AJD/Oe4WqOY1c6T4RP/7OvhopHOqoeN3aqMKlGPbfm28A5KKAmp1oiZjjI9oraoijSEPPR
	ugbDMFm6OZBCZGezCleyGSiqWM7eP/zFTT4IQcOx9Ir2TBhRgAIDZfO8x7+un227Y7eou3999yR
	KaFpLWGJu7EHduuYOkpr68ff6lHKpiMkOGAtis66v5BmjmL2WrN6Kjx3TWcx8V2trGKfHzX2HUL
	oq/fVjW9yNuvxJa9x5UHNvGKnD2qaEhk3yKELhdKAZYk90mExZ/8SZZDK0R8oXWk+kAWhuz9Fwz
	UqsYrQy9KxVg5CHHo0PAOJDMwoacOl2RTmmPRxwp5hz9jWrb2mIUsUOhvMMoaMVI+h2cQtIjKUm
	OTn6XEnuHkZ7GVaLA==
X-Received: by 2002:ac8:5dd0:0:b0:51a:8c9c:7de0 with SMTP id d75a77b69052e-51cbf2f40e5mr84626681cf.10.1783982225117;
        Mon, 13 Jul 2026 15:37:05 -0700 (PDT)
Received: from com-76773 ([209.249.37.148])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caacad30asm93526161cf.9.2026.07.13.15.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 15:37:04 -0700 (PDT)
Date: Mon, 13 Jul 2026 15:37:01 -0700
From: Ted Nyman <tnyman@openai.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
	Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: [PATCH 0/2] packfile URIs: support concurrent downloads
Message-ID: <alVojchfRvHG8p9D@com-76773>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Packfile URI downloads currently stage a pack at
objects/pack/pack-<hash>.pack.temp. Two Git processes fetching the same
pack into one object database can append to that file concurrently,
which can corrupt the temporary pack or cause a resume request at EOF.

The first patch gives each direct packfile URI download a private
temporary file. Ordinary dumb HTTP pack requests retain their existing
resumable staging behavior. A later packfile URI retry starts a new
download.

The second patch handles the related .keep race. When another process
has already created the keep file, index-pack reports "pack<TAB><hash>"
instead of "keep<TAB><hash>". Accept both successful forms and remove
only keep files created by the current process.

Each patch adds a regression test for its respective race.

Ted Nyman (2):
  http: use unique tempfiles for packfile URI downloads
  fetch-pack: accept "pack" output for packfile URIs

 Documentation/git-http-fetch.adoc |  5 +-
 fetch-pack.c                      | 36 ++++++++-------
 http.c                            | 77 +++++++++++++++++++++----------
 http.h                            |  1 +
 t/t5550-http-fetch-dumb.sh        | 72 ++++++++++++++++++++++++++++-
 t/t5702-protocol-v2.sh            | 31 +++++++++++++
 6 files changed, 177 insertions(+), 45 deletions(-)


base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
-- 
2.55.0
