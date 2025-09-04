Received: from mail.aegee.org (mail.aegee.org [144.76.142.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3C81A9F82
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 09:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.142.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756978564; cv=none; b=hhSSGzqzVpBJynu5uYKCPKmZ8mv3x4151ElTvMZexvh6SGl3kJ9vU0cc9IhA+LrsG+hD9FLTlIJ5vkcVYwyoQsMg9JHv/WaFTIMZ69voqAh6kT0aKyVgSkgtXCV8wHX7MXmhgnmn5zvMVENl0wlJPQNefoSGEv9rroWuZoDHvoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756978564; c=relaxed/simple;
	bh=xK8ufI0N3qqFZqjWoTi0pdnGjlJ0Ndp2C4MIEYpNptU=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=lHUpVKtAYpIPrWGG0wpc4mQhdp5QWPVdcjt5FA4AbAFZMvWyJNMkTn07tlS1ymK2kzyxvVuC9Kc93N26m8IpWRZVNUJQzOyKw6Bajrk3e18g/NXTbfnoFrHPVIeDWdRHqydLhJYk6XMt/IAZRz4yWD55VO/dJhlVVF0sh+t5Lyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aegee.org; spf=pass smtp.mailfrom=aegee.org; dkim=pass (4096-bit key) header.d=aegee.org header.i=dkim+MSA-tls@aegee.org header.b=bW02bKXy; arc=none smtp.client-ip=144.76.142.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aegee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aegee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=aegee.org header.i=dkim+MSA-tls@aegee.org header.b="bW02bKXy"
Authentication-Results: mail.aegee.org/5849X9Vm2703251; auth=pass (PLAIN) smtp.auth=didopalauzov@aegee.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aegee.org; s=k4096;
	t=1756978389; i=dkim+MSA-tls@aegee.org;
	bh=xK8ufI0N3qqFZqjWoTi0pdnGjlJ0Ndp2C4MIEYpNptU=;
	h=Subject:From:To:Date;
	b=bW02bKXyHa+skAE79ad9q5irc62Xqkd6YnNFbv5oA/8WUUp8pN2h3tM4ORtWY49Wq
	 hthwzCWBB+/Sj+u/rcHvM6aVNqJ5558ap72lplPJZJ9XNdHTWq3D2/LFhAwcIr6KUD
	 zicYx0vIe5tLi+3ULSihdAmsbC2ikNB3ruzOvHYaoGnLAdEKBKT8hFZqQBo2r/nkzz
	 OM/3TO6nEOQZjRh/CD4q7rkkQQVSqKNme68avXhNGL9LwO4WtytgUuPkH7HZSG3X/c
	 73XHHMSKVth4sGNIgVcvavs0pGlyFHvjfn22QhO6xNaFQ1Uedq3d5HhHXy1kraftCV
	 wNfpBrP4ut4Gl66eBqdRkIBFdpsng9uToUKQNhpzSl9wFLf5X64O2ezxZ6GPnKGjtd
	 10hpxzbIne0ukYE3eGjqnEqR33qmkm4zPgCybgcrlsvaMUn0b8LfemkVvYMNMm0OZZ
	 i5tfeIes1Bget1h9PHtLZhxVoArH21yuhnee6rsgSQOQPkQRSZ6+E6jVUvPSbNkR6X
	 vHUU4qqdRp4Wp2Mjh20lFoQu3IXsLokqURbUd+P7ztjtbYpnNl6RCu+osju75+n+v5
	 LcMhoT4vwbth4TIOZFIS5YrK/1YMpLVS2N3dtpqFVYPuiqsHIbOSejE57CocwSIo8V
	 JM5ytBLOL7yRUrY3kJERlZp8=
Authentication-Results: mail.aegee.org/5849X9Vm2703251; dkim=none
Received: from [192.168.0.242] (95-43-114-153.ip.btc-net.bg [95.43.114.153])
	(authenticated bits=0)
	by mail.aegee.org (8.18.1/8.18.1) with ESMTPSA id 5849X9Vm2703251
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <git@vger.kernel.org>; Thu, 4 Sep 2025 09:33:09 GMT
Message-ID: <79ed51fbd94ec2793ab0388b33963b366e48c590.camel@aegee.org>
Subject: Doing blobless clone by default; switching between blobless,
 treeless and full clones by a command
From: =?UTF-8?Q?=D0=94=D0=B8=D0=BB=D1=8F=D0=BD_?=
 =?UTF-8?Q?=D0=9F=D0=B0=D0=BB=D0=B0=D1=83=D0=B7=D0=BE=D0=B2?=
	 <dilyan.palauzov@aegee.org>
To: git <git@vger.kernel.org>
Date: Thu, 04 Sep 2025 12:33:08 +0300
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.0 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello,

the most common workflow to see and change files of a repository is to do  =
git clone.  With --filter=3Dblob:none this process can be sped up.  Blobles=
s and blobfull clones have their trade offs.

I think these additions to git would be useful:

=E2=80=A2 add a config option to do by default blobless clone, when just  g=
it clone URL  is invoked.
=E2=80=A2 add a git command to download all locally missing history, includ=
ing for treeless clones and blobless clones
=E2=80=A2 add a git command to convert a repository to pure treeless or pur=
e blobless clone (that is delete some commits) - to save disk space.

The git command to download all locally missing history should show how muc=
h per cent it has completed and after Ctrl+C interrupts, when the command i=
s reissued, it should resume downloading the remaining data.

Rationale:

The reason people execute  git clone  is hardly to issue immediately afterw=
ards  git log  or  git annotate.  The reason for git clone is to (try chang=
ing something and then) build the software. (Provided that git manages sour=
ce code.)  Doing by default a reduced data download with  git clone  will s=
ped up the initialization, it will save bytes in transit and reduce server =
load.  In fact I think that by default (without extra configuration)  git c=
lone  should do a reduced download (blobless) and
git should download the other things, when asked to do so.  This default do=
wnload preference should be ideally managed by an option in global gitconfi=
g .  When looking at https://git-scm.com/docs/git-config for =E2=80=9Cfilte=
r=E2=80=9D I do not recognize anything relevant.

For the latter https://stackoverflow.com/questions/76770003/is-there-a-way-=
to-configure-git-to-clone-with-filter-blobnone-by-default suggests adding a=
 variable GITFLAGS=3D'--filter=3Dblob:none' .

There might be already commands to switch a repository to: full download, b=
lobless clone, treeless clone, but I do not know these.  In any case, if it=
 is possible to switch easily between full and blobless repository, in both=
 directions, for me it only makes sense if by default the downloads are blo=
bless.

Greetings
  =D0=94=D0=B8=D0=BB=D1=8F=D0=BD
