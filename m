Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7591C54A9
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 20:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757708193; cv=none; b=oU5KExEsduITZhchI7Z+FjsDmaBgAvr55agD66dzVtlWJc2OrmQPFBgywcIdZZNQTgb1mqlb9HmXcK5wn5HVs+nRG5RG3DjkLlnnh8RzgwLd67wzuYy9HnCuq6NdNUKA6GYWH5+1oDSj1Rw991qd3wVv+QPFR/E1/UpJKY1VmCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757708193; c=relaxed/simple;
	bh=0EKqv9+nChvfTi3/HgaYJCRH/x98dwXU+6nfxZTYx2w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cUGnpr/6PioYe1/3dSRjbDSJGmpSrSsVJmn4d5gHdid2kWP55A1PWqMXyjAg3U80ChYKt1/cozZp8IhqoTpL5YHRbWxvzhcr8i8jIT4iqke7LvI2pRwrOfeiMojF84XYWnACBE1NrZJ67WeylSlyFje72g++mkx/mRFST7Qci60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 58CKGSVd4025522
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 20:16:29 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: <git@vger.kernel.org>
Subject: [QUESTION] mergetool environment variables
Date: Fri, 12 Sep 2025 16:16:24 -0400
Organization: Nexbridge Inc.
Message-ID: <074901dc2422$2039a910$60acfb30$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AdwkIOHol8t32RWZRE6dW97MDy0iSg==
X-Antivirus: Norton (VPS 250912-4, 9/12/2025), Outbound message
X-Antivirus-Status: Clean

I am trying to integrate a custom mergetool with a shell wrapper.
What I get from the online help is the following description referring
to the command and environment variables.

mergetool.<tool>.cmd 
Specify the command to invoke the specified merge tool.
The specified command is evaluated in shell with the
following variables available: BASE is the name of a
temporary file containing the common base of the files
to be merged, if available; LOCAL is the name of a
temporary file containing the contents of the file on
the current branch; REMOTE is the name of a temporary
file containing the contents of the file from the branch
being merged; MERGED contains the name of the file
to which the merge tool should write the results of a
successful merge.

When I try to use this from a shell, simply with:
#!/bin/sh
env
exit 1

the described environment variables: BASE, LOCAL,
REMOTE, and MERGED, are not present.

The history is trivial, but has a 1 line conflict after a
git merge. The file is called a, with two lines at the
parent commit and the middle line changed in both
branches being merged. There are correct temp files
in the directory while the shell script is being run. The
merged file looks as follows:

Hello
<<<<<<< HEAD
Ours
=======
Theirs
>>>>>>> Incoming
World

This applies to git 2.45.1 in cygwin and 2.51.0 on NonStop.
There are no upstreams. Is this the problem?

Any thoughts on this?

Thanks,
Randall

--
Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)
NonStop(211288444200000000)
-- In real life, I talk too much.


