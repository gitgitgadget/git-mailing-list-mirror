Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342EA34C9B5
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 17:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761673258; cv=none; b=SysbCdKCyd7/Mkfrx9RqtgXt8GEajR32NGs0cT5NqXOODQw3tRJrJAvNj4pk9Rf++lsfphcVCwA+Mu8qMgLZRyxkmdM+g3sEo0cK8dh5/TWE6ikPKSlUpulpQwy13sv3qf3/kv1/dJ/xVUM0tkTfn3lv+Z2+dVXo8wcVRRdN9uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761673258; c=relaxed/simple;
	bh=S3SL9i9CNE1HoineUpvSQoA2i0RXtuQiDhjDLuxUlb4=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=AHhdxExoPKbpvzEw6ALjOi7B5yAjNUVBcUVVZilw5g9jXGoSVoqR2OyO9tnL8DGY+FZCp7Wcimpkp8rSmOywXWXqADBW6P9FY7yIDDVtq/HG45Je1k5+dwOL01wzwcu+6eIp4Y+JLtVXLcajyFEVxBXG7ql8nTW59MABTQkFsyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 59SHeluq1573698
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 17:40:48 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: <git@vger.kernel.org>
References: <xmqqo6psjq2n.fsf@gitster.g>
In-Reply-To: <xmqqo6psjq2n.fsf@gitster.g>
Subject: [BUGS] Git v2.51.2 on NonStop
Date: Tue, 28 Oct 2025 13:40:42 -0400
Organization: Nexbridge Inc.
Message-ID: <000d01dc4831$ff049500$fd0dbf00$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdxIMDgk2f6mfGB6ReC97lOrbknZOw==
Content-Language: en-ca
X-Antivirus: Norton (VPS 251028-2, 10/28/2025), Outbound message
X-Antivirus-Status: Clean

I have found new defects on 2.51.2 that were not present in 2.51.1 when =
building with OpenSSL 3.5 (probably unrelated).

Many failures in t7900 resulting from the use of test_subcommand ! as =
seen below. This is run in bash 5.0.18:

+ test_subcommand git gc --quiet --no-detach --skip-foreground-tasks
+ 0< run-no-auto.txt
{"event":"child_start","sid":"20251028T172435.690328Z-H36b1c598-P7b00002d=
","thread":"main","time":"2025-10-28T17:24:35.879833Z","file":"/home/jenk=
insbuild/.jenkins/workspace/Git_Pipeline/run-command.c","line":740,"child=
_id":2,"child_class":"?","use_shell":false,"argv":["git","gc","--quiet","=
--no-detach","--skip-foreground-tasks"]}
+ test_subcommand ! git gc --auto --quiet --no-detach =
--skip-foreground-tasks
+ 0< run-auto.txt
test_subcommand[5]: test: argument expected

Regards,
Randall

