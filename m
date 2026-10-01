Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3227E3D47A0
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 17:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790874877; cv=none; b=Og+tu02Q+q9eAqzrOpgP5flJYvwGPgK8WEaLNTAyi/NpJJSggbwMWi9WOJV9oGvRwb4iyBrGcDw+efnOh/SFu6BK9JPH8g8Y003m90TBRbsdJ/n+jP/tY/JYS4SGfoUZmzUZU9LDUKaivjucZZDhPiDAABL7HViGor/dmrSIPyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790874877; c=relaxed/simple;
	bh=UaXQIKJrSuLsvB6Y0c2XhTi/Qds+xn0UC83nH65/Wj4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qFblO549L5GlhElGaEYJzekW4uUiEsD5GuLXGK5qCG8cG9H7gxdNIKSTaFoYByZ5pOMICAB2enQ+7yAN9DF7p5zJnqXdqjC+YMkupWPNAjq133kGYEsQ4lgF0OS8+YDpyv4ln84a5z/XTTzhxFVYULd2/ujhFTYE0N/+g/ZmLj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SN8Kij5M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t8n3Y3lR; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SN8Kij5M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t8n3Y3lR"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id D7241EC0231
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 13:14:30 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 01 Oct 2026 13:14:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790874870; x=1790961270; bh=djJHKk3X+F
	1vhob/5AHK/o+tRQIUqvywt/kjMrwFCnI=; b=SN8Kij5MTcAZkzFQb6zCvm+IyN
	4WQChFH48PXjl+5WYKsBN9/zb/pjukzyRPvEWnRyl4etK1rb5XVxmwQjqlk9gEYz
	jWYm65GMBYXbql9A6+fs2SH5BSDiglTtRiPdYMFZZxsN6E9YbqIyqnjXDvoZqAdw
	dTF0SnGsFLoEVyKiU5uPm6MxGMR30iP6UwYC2KDrftXY3gJJtLAt855G0gAHFQyL
	9/MOWV+dDiOo2IxFFedgo5EVpRPjHC6Ei3nCWjbVtrsLchfF0Pu7Ka8GKIaCZZtJ
	uJO68A0bigQSP3pkFiP93dCj59okn4Tiwrp+OONtGtLnOF5JYXTaZBsjcdKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790874870; x=1790961270; bh=djJHKk3X+F1vhob/5AHK/o+tRQIUqvywt/k
	jMrwFCnI=; b=t8n3Y3lRzy/mz4869JLo6qVRbR2iM82WH9yqK4stes4LIO0tlE+
	ChJ2zlODC0ziW/DwKXyX0/vVYbdckqiKYHkjr1w77tvBu6yjlg2HArqSOtB+eSXg
	Hcp7cnb3948F+VCIEyHmlqS3BOuqh1WNKSgDgCO9Kv0dZk6ShnmA+cKQrFIe1wng
	ZF1PyT1IoPqvDGES60LQK2bYh0J9ojgMt3gQIUXGjxApeX3CQEmCuihFgLOWGBeX
	Cw9O1etxAeFy7WkyY0CBHN1NH0iDW7zgEXj42DG//U6QD8NlVP9GWGc9QtaczxzB
	fXPMCOMNC89ANyJpxV2cdPNwXp3IbY8nxYg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790874870; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:hIYdXEXje9P1QiKoOvPzh8Fl3B/1n08N2bpnieLOST89lPk
	yIhQ9+Rber576ZjoRQHfeKlcmH2rvDtLP91ScvnS+093cM4vO6/Zj/0xhctVI7gK
	5W8XbRU/iNRZ6IBUKgsCXexTFZLo1XVHisvY7+ppkdw6PyVz2LP5V4ItjWFnKqC6
	8lUzvS33eSYAsYLvZgKj5b6PMbBHETnSKUR6REX8A7K4lF2SoHno+5qYvDRTfNXo
	UqEkGPuyp0i0UFk08BvxMRvW1BpUmsHYnmA8V2M7RAMHyjHY0wEY73qTRzGZZEMB
	BEc4OY/T2+69ZJd6JtT9kt8fQOkPz+pHciPtCOQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:M7/d4r0gNX24095tVfqJThavfhKghaFOT6mXaI8Exvo=:UaXQIKJrSuLsvB6Y0c2XhTi/Qds+xn0UC83nH65/Wj4=;
X-ME-Sender: <xms:9pS-auc76o9vpEzUfzSeLCO4WJm17LLgWG6aaDfgNtc7UZi8o49xCA>
    <xme:9pS-avPLr6YckKMucscj_D-IA3Az-HRZUBIiwMVG60DHoIUGuW7Hr5J0rmVgsRwvh
    zG2s6L1rPw6YCiwIpT_ngQ3N1zn52S_oK6oSqvt6yU9Nk9xL5e-G-U>
X-ME-Received: <xmr:9pS-akg2BBYIfe-3EyFMFPXqKlHVCu1iuAt0k8tVFXJnpj5FKquh1qyNzU36_cr7nV85KCrt7bd7OhFNT5RhZkc1mPaCoVgcxsO3>
X-ME-Proxy-Cause: dmFkZTGMyMUHnvo/2jbuOUfCNEwZ/iFEaBhjzdwu7uwX6SWjrPO3wGCpFduF29o5m93w7g
    VmIO93eagqBHcZ4bmKWnDcbDjgbbggSZyIMwEDRXjAbdU8k0lG1CblIsctJdxk3UNCq9zg
    zcc4jeAqR7g4/Ol5AD7AdgGxChPDFcefGYQav55c464iGXdVEZPhNt9w9o73UshiKobXwF
    fOHtqQN8liV0tGe2dFZXUkGKH5wtyM5owfTtu0QGGtp46gwIUl6TizhlFJcgwEYtCl0Nei
    B5uNlZuialqwqa7KkerKl4oosCVw1TnN70KXaHcNq7KWYHwyrMxZY6k9GXApZZm+GvGlMB
    /8NMeQYSY41FtYWHXV8YF9cAof3WeMqAYwdvzG80yOjahvkhsb35U7vz/sFmcnLDhPASp0
    UsYZ54bHth7NTNF6kmLTQ1VwJovipVQoBASRnozppVsfKiiJkpwQopecMGCBVnDkBkO3Lt
    Y0qpY5aR+jCjQ8vJznn8NPAl81Oz/uEWx9HanY3NwRsUdcKAe3lMOePhZs5NzAM6l3UQhW
    15JDKKTjGTHJjU7q5SLaX8mesIMtsAByk/OsOycsCTcZxAQ1dPMJqyrfAsH3kGxMrYDK2i
    OI/P9Uzy30EXABSMNhg3H5a/38JkxTAm4CYbLpPCwLTRNIAwd7kiDZlsq6gA
X-ME-Proxy: <xmx:9pS-aq3aD3wOponmxgreO-Z3lPSTw6Ami1hxGoISKxRauCsDmoqcFg>
    <xmx:9pS-ami_9FsPPyoi57-jyOyLJi9rqH5DoYixLVuJOET5sRutlUoBcg>
    <xmx:9pS-aic9o_12_5-LUmxT0PeJ4VxxiY05n8Jb-SPEulQpL99HF4wTRw>
    <xmx:9pS-ahknUWHAkwv9M2Nd58kgQWETuIbQvWwrvyDZRiopqsJl1eICCQ>
    <xmx:9pS-aoAGZ9jw6PSC5YmUw5s5R7k1K4jxSTeUigsgczzbnxKXhOz6H__l>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Oct 2026 13:14:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/2] merge: remember conflict labels
In-Reply-To: <6e028692-447c-4a21-a9bb-739e42f1c9aa@gmail.com> (Phillip Wood's
	message of "Thu, 1 Oct 2026 09:54:52 +0100")
References: <cover.1790761727.git.phillip.wood@dunelm.org.uk>
	<fdaf3da993366878b51bd0b2a950888710cafb8a.1790761727.git.phillip.wood@dunelm.org.uk>
	<xmqq1paad71z.fsf@gitster.g>
	<6e028692-447c-4a21-a9bb-739e42f1c9aa@gmail.com>
Date: Thu, 01 Oct 2026 10:14:29 -0700
Message-ID: <xmqqy0ch5one.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> We
> would perhaps benefit from documenting the common files like 
> COMMIT_EDITMSG, MERGE_MSG, SQUASH_MSG, MERGE_HEAD, FETCH_HEAD and 
> MERGE_LABELS somewhere in gitrepository briefly explaining what they 
> contain and how they are used as a separate series.

Sounds good.

Thanks.
