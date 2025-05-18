Received: from outbound.pv.icloud.com (p-west1-cluster2-host1-snip4-5.eps.apple.com [57.103.64.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4B915B102
	for <git@vger.kernel.org>; Sun, 18 May 2025 22:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.64.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747608991; cv=none; b=lYT1hf8xSy5oH0YKanq5xVkscU55lec/X2PV4PtbXUqxY2pwuuuaYbhkMunjdnoGNn4GumLx0MZLf/psjFVF8eZzadWsJr7hctbuc2BJVqi9gbGhxJwMl5ZA/sqRR+vzJ7qnqtlGmC1lDh4qM6RvwOfYXDkhkaU6UGAPZTLMhyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747608991; c=relaxed/simple;
	bh=b2I46yt0tAAt3YLFsqPQvPX1j0nQZ5sqsz9nsYoL8SE=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:Cc:To; b=naytPyvRAcarWQ35K2rRe8UEP1mzLZHMOvYW9us75IP4GAk+sP8A2OZ8oapRnHs1J4Wa/xL2IMgTs2v6dFafd9e3AiA64d2Ltsq10QMdTdfuT5RSaTY9f+jBllhyWjO2XSRYPZsuxSJ/P05qAm0a5ueu+Hk0V7j+GsaK6FyUob0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=yj0Gok4O; arc=none smtp.client-ip=57.103.64.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="yj0Gok4O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=E5kErvsTc3BQd9hOaWnfoZ9I6Eqp9vog1tr10nf41CY=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To:x-icloud-hme;
	b=yj0Gok4OAm0HSpTGB4ootIfjF+8sW8XRF6+fBKIRWtX2Y5fiDFlsuoHgePxd+HMyh
	 9uZBXPBUCsmzBzHgGt3DfeOWHCmsqSkSf+6XUQlOdphwtiOc9mJbIh2gVx5295yTui
	 birjZRDVvhwBJGvqeCkY/JD9iXyzqCgnl+wht2s6/D9moV6DB2Ew+vXtVw3PlAag5G
	 eQrcMQj0UXQKAvT+/ir0RlgtkggRsCoh1SQ2f82q1V9jdqJEbHtAuowlgy37EJr507
	 fkch9wzx2xy5VfeHIpra3yxQonUigudbaH/BCR5AN7coLkWEdpRU5rVJey7dsQ2+7c
	 m6/GZTB6XvtYQ==
Received: from outbound.pv.icloud.com (localhost [127.0.0.1])
	by outbound.pv.icloud.com (Postfix) with ESMTPS id 7C657180108E;
	Sun, 18 May 2025 22:56:28 +0000 (UTC)
Received: from smtpclient.apple (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id 502BD1800094;
	Sun, 18 May 2025 22:56:27 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Evaldas Svidras <svidrasevaldas5188@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Sun, 18 May 2025 23:56:25 +0100
Subject: Re: [BUG] commit fails with 'bus error' when working directory is on an NFS share
Message-Id: <E691546A-1676-4435-8473-27C7CD638BE3@icloud.com>
Cc: git@vger.kernel.org, peff@peff.net
To: dpantel@gmail.com
X-Mailer: iPhone Mail (22E252)
X-Proofpoint-GUID: 64YZe1cUcedJp_y69Kpj9qObhh1lbCnX
X-Proofpoint-ORIG-GUID: 64YZe1cUcedJp_y69Kpj9qObhh1lbCnX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-18_11,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 clxscore=1011 suspectscore=0 phishscore=0 malwarescore=0 mlxlogscore=723
 adultscore=0 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2503310001 definitions=main-2505180228


Efka 

