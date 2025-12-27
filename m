Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CACD277CA5
	for <git@vger.kernel.org>; Sat, 27 Dec 2025 14:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766845828; cv=none; b=W+lHtOp9Gjz91WBn+LPn5gJQW/U2vm7ns0XyytT7X/JBEaXLess7OE8EqD3D1wbCo0B/hVEl7x8PhEj/kbTcilTf9IZQNWWHyStSoHHMTMXdy0tfvA1QuTsoN3bohN11NrQ0u0kQ8Bf2jQeIbH5RnIJx1+O5gFljXNreKUvR9ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766845828; c=relaxed/simple;
	bh=pJOJv7R57/TbbEGmwik14DrpsyqTfCjQBexm5f/NPcM=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=CxFJKpQWjRbp4oyB/yG+2gudconPmDC7Wnb9A9p2H0LEadeei4+hU1klnq0G1C/wPDdbV1rAGghxkWeT0hvZl3zhRbAWNzuHMLPOcAu3kQtjQrMnWE+I/NUBD/Nq8A75LxOmUtTebJmsPGl91o3elnqrdoPrXi9sefk5JNsZOTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 5BRERWRM873660
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Dec 2025 14:27:32 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "=?iso-8859-1?Q?'Michal_Such=E1nek'?=" <msuchanek@suse.de>,
        "'Hadmut Danisch'" <hadmut@danisch.de>
Cc: <git@vger.kernel.org>
References: <eb36360d-f539-4f77-b175-57330ef05eac@danisch.de> <aU_lqe2Z47STv68O@kitsune.suse.cz>
In-Reply-To: <aU_lqe2Z47STv68O@kitsune.suse.cz>
Subject: RE: Git destroys u+s and g+s directory modes
Date: Sat, 27 Dec 2025 09:27:26 -0500
Organization: Nexbridge Inc.
Message-ID: <008901dc773c$f05508c0$d0ff1a40$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQEn2qJ4gzm8cugOVbAMroE87E9uEgHX2IMNtpAFVkA=
X-Antivirus: Norton (VPS 251227-2, 12/27/2025), Outbound message
X-Antivirus-Status: Clean

On December 27, 2025 8:57 AM, Michal Such=E1nek wrote:
> On Sat, Dec 27, 2025 at 03:37:51AM +0100, Hadmut Danisch wrote:
> > Hi,
> >
> > (please respond to my e-mail as well, not just to the list, I'm not
> > subscribed),
> >
> >
> > I do have a problem with git 2.43.0 (ubuntu server 24.04.3) and
> > directory
> > modes:
> >
> >
> > I do need my git repo (owned by me) to be readable by a system user
> > (running a rootless podman container).
>=20
> When you want it to be readable you do not need any special permission
bits.
>=20
> You can set the directories and files to be readable by group, and =
ensure
the
> container user is part of the group.
>=20
> You are porbably looking for core.sharedRepository configuration =
option.
>=20
> If git is particularly unhappy accessing a readonly repository and the
container is
> short-lived you can add an overlay over the repository when creating =
the
> container.

There is an option with ubuntu: Access Control Lists (ACLs). These =
provide
override security for directories that might assist in your process =
without
having to worry about git security settings. It might be worth looking =
into
this option.

Randall


