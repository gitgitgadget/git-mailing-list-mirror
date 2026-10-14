Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9D2363C46
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 21:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792014427; cv=none; b=DerMtwpoeMdptMfSc/z+gOFTuPNxywG8+vQA38Q3b6LhPSsZRbH13RMNNcE6GQh/JsXDUuU2lf8IKOaSEdo1XfKEm+xq6I5aPP7XvEFg1984du+u1M1YoGGuCVXm2dAaMN/hq2MqxhEziNr9/Or60kbYAjyomyqQkwQ3sUB+hN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792014427; c=relaxed/simple;
	bh=4/NJ6Bp6jJMPMUZUvm340EgUGtrHvL1kSv4ToXO0CIo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E0i+jJf90W0OHFPRzrwXvb2b/tem2UHqlflVuVf4qtcBt8zowPso2bt9j9TSJsppijluKtYssGRwLLamIMv0QW1E/t0YKhkWpLtkwTjBEdhJgkZ+97A3XO+y14wKf5Ono66H+HRywJ9703SheJcJskQK3u6qeH3jl2FwUb8z+eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hqOZiXQV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Fx0WEe8G; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hqOZiXQV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fx0WEe8G"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F21211400130
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 17:47:04 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Wed, 14 Oct 2026 17:47:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792014424; x=1792100824; bh=4/NJ6Bp6jJ
	MPMUZUvm340EgUGtrHvL1kSv4ToXO0CIo=; b=hqOZiXQVPZR3SEocsw8gqk0d9u
	l0CiLW8T5xQSkM57mXjakN3eYaL3WpI/zXC+cQMyCQnvsgh+6f0bNHOPg9EVdU26
	eo78HFCeF0yLYRFdpWh1lzcF8NuoUpYMvp6Vfsp5RTy24SvANJ5l5HP2qOGFNnCF
	QoYXeQTqgdyI5VTXNhxUHgVymh69/Nz+OtTSjxOJcQko87zEyVUDXBCgxI1ecZzO
	R5SdaAYeIw+NCBblxWDc3x/c8nBblTCmj0HdcBRu0AKyafmBNbECt8wfTf4lucgU
	rPEDloSpit/ORYUv7ZCKVz4626aWs9yZwajXyNqjjotJEe+iiQZ/ca8BSdAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792014424; x=1792100824; bh=4/NJ6Bp6jJMPMUZUvm340EgUGtrHvL1kSv4
	ToXO0CIo=; b=Fx0WEe8G+4jRlwjDWunr/bCB9R6pxd6fF5RlOFDU2q8Mx06HtIO
	5iaGuCTwK+rkzZcxiFDQ+hXfyaHvcLSUkPgrDrWCIS1LsjpFGlA+d9sRXQEI5N79
	ChIDk9AZS/g2cnh9+31eLr/JVGm7gdz4ip9No4U/paT9S5I92cmlBZPGB/UDXvhj
	4DLg80SFMPKg692Dkia2wKHZqAMISZ7N4SJnlJvnNNv3gYttl7ZAUeJZ7xsRb4FU
	sonI6nb5i2XZcYvdg0F+dEcOdlo/sDTrIJrUaxDhaD9zgMCaLqdaQ1cqdBiypITI
	1xVoBFAl/wF1LIpE4NaClJKu69R7BvcZmOg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792014424; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:kp/FHqwpWuABaa+MRk++iqLzBoSv59/hwT5ryy3BNiVlpu7
	Pyk3gxXSGQpvI/heiG/4MvXWfwe/bsw2jcNqu0loLtFykt3DxlfkMok9CYgCO5In
	JDnDeIrAA/QKRvPzJHRIbv1JjCk1+uni0lvhhxakO6FgM4GrrEKsngNsq5klotjv
	iu/aZ4/Pc3K3112590mACAS0lSNg69JuNWx1wjpWUSgTkPfHnDa7MqIrdsSL4U3h
	IQlFQq7jRC8aYp1lIJ4RbNWLXuk4BjthRtwIL/JT1TAc+AmETOe16lyRn+Zhz3Vs
	DBuRgeqNIb/8f1hRN1FdbLRrvNpgeMJeZ8qoq6A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:tKFyluLHR8u62IZppe8+/yxVtm58i+8/OPXkXx06beM=:4/NJ6Bp6jJMPMUZUvm340EgUGtrHvL1kSv4ToXO0CIo=;
X-ME-Sender: <xms:WPjPavAjTD_URJZ8hrUe8UVtj7CxkzuJHPB5SnBg63uD3zqP7Hgbkw>
    <xme:WPjPaknoXSs6G6GSLpmErb1qFCg1_ftc7A9cwl7uzmNbOg-RPK1YXgDE5RVumDgjs
    coPq_PPTv8vUEcZHVl8HQ63sDgqoRu3Xl3SCtzsYrp1rUNmO4D9Vg>
X-ME-Received: <xmr:WPjPagw7htp3nRjRMhgfQdsLLwOFroExl80Yvj0MUtJ3lVilorJ1YBqLi-8oIp9_u4HyaAPDonOCu2SXRM8ixrlgSxv61rYm0lBy>
X-ME-Proxy-Cause: dmFkZTGNJC2Rib1LUakoyaBVDVDJve+CFYm4jKzcv+AtBTjdxb2H8ia+7TgpjLTGBMMZ5m
    z3ogAtNU52xRD0HIGnlg06uoine1EHNLgg2gqsOTjzL2vlfg551DvRoaqDcxce1g9hF2MF
    pMOqal6swI4SQTr6T8iGl8QU33vXDt4kctWcoRpetWtQtP4JL/gOWbr+LalR+6/gsB2594
    IARlZDuzOe8bxLmCAynQLuYUQGR6awg/WNC8s71lQU67F+IUQSF2ouyN/6mmafTQeQZSLa
    x1zDQONSK9HjI2b5vxoQF6W9njPsmae9NSUpmFyKjaP4+DzfPMJTik3frcNClbJge9n7WT
    HPAv4jvQc7PG851r0eZ3LDyib3uCUImh65nMZdzmg9SVXvWRNmhqvAkY16NeA8KEvBlWTc
    AaDGgZJOOLPAwk1P0BzcBNrN+23eTivHF82z/Js+Nz8iFyyCX3YeWePAdlWOjnnW1ORE+E
    jZa1omRzqf8wP22HBAo2q5qv9t6rcQTp/aKEFBth9HDe92XkqjoUVnZ+quMKcnhPDW42c9
    4LA0jAj/cwX+W+njUnDjlN9axdJigBTLBg6rhufXu7DOimGi515f076Ph6rjVyw2cMFrP8
    VqA27xb/1Z4kWHhaOKtfc6Lux/dyNry3YNMHh4NL5Hu1U0bQsRbfKjF4nZvQ
X-ME-Proxy: <xmx:WPjPauQJLfDwmgBEf7wTGiXW0qMq4sIExmfUJj-Fj7Sl5VQyJh14Xg>
    <xmx:WPjPao-cfrgNq48tTs7D3803OYvipyx3dUBJqIE9hgxXKNyxGiJVOg>
    <xmx:WPjPassgHYWP961XE8cgsA9xa6Qdb5FpA9eC6SFQ_6MlBgEWUnrVlA>
    <xmx:WPjPagOpxKB_Zl2Am1iCljrnrMY_CieQNllXF6TXrd8TcZ4Mpse4zg>
    <xmx:WPjPakDRpbLbP6rG0FB85tWZIQrUTstjUxAxS0von1OsE-QpoLChh61I>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 17:47:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: Shashank S via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
  Christian Couder <christian.couder@gmail.com>,  Siddharth Asthana
 <siddharthasthana31@gmail.com>,  Shashank S <shashu8660@gmail.com>
Subject: Re: [PATCH] t0081: modernize the code testing whether a file exists
In-Reply-To: <CAPSxiM9-F-1XKvWeEnBk=_FyKyev5pfnid4fiN-OjLYLnCTWVw@mail.gmail.com>
	(Usman Akinyemi's message of "Wed, 14 Oct 2026 10:49:19 +0100")
References: <pull.2254.git.1791962806807.gitgitgadget@gmail.com>
	<CAPSxiM9-F-1XKvWeEnBk=_FyKyev5pfnid4fiN-OjLYLnCTWVw@mail.gmail.com>
Date: Wed, 14 Oct 2026 14:47:03 -0700
Message-ID: <xmqqzewgosyw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

>> From: Shashank <shashu8660@gmail.com>
>>
>> Replace the old-style shell `test -f` command with Git's modern
>> `test_path_is_file`.
>>
>> This instance was found using:
>> `git grep "test -[efd]" t/'
> This is not necessary, remove it.

Since many candidates are working on similar microprojects (which is
fine) and making the same mistakes (which is expected), perhaps mentors
should tell them to read the review exchanges on other candidates'
patches and learn from them, instead of or in addition to giving the
same advice repeatedly.
