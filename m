Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A546C1AA795
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 12:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729686866; cv=none; b=RAqcHFshPU3wD49yCiQZFU6oUU8cX1sdjTXkcC9DrNZLNAt3GPg88A4ThHlyL7ENFTdLeRr6OLK+oFqdfu1LWCNDE/Mq9b/febbwk9aXwzr5x0/qfPw8xUO2sn/uF84Ch72k83za/lyNi08f3odQpVPWIstai3CYDf+zns6HMas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729686866; c=relaxed/simple;
	bh=jokUkA9hpy3u7AVb0SPOCGuO/rH5ZFvjBdemZCgygcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HI9z6r5AwROG6JhgQePSln4gsktedJ1jMpr9s0iTN0u5yNVUgL5duwGYuW4vNRIs201UGzOmzwAaGhVYTsjmQYY6WXJ0nlQPyc977+T8HAx6R1fEkd+/Fsw7OcRTF4AzvyNm8lcB2HKJ8lS4zoJD4QHm2E5RG0ajDke7d9tM028=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=M9HGn/pH; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="M9HGn/pH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1729686854; x=1730291654;
	i=oswald.buddenhagen@gmx.de;
	bh=V1hssme3xZvaSSxCh4UqkqlQWfkGuCCNqbAEbcgPmgY=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=M9HGn/pHjgrlNQkfEoBLstTVPdgI+EA1q3M65ZXf5Yma4hixdHQeR5hQG3+l2aOh
	 wmB922JGuKfxrH8vcKCLYAiGYOf6wlnTHbhpkUX5d3IBraI5j5YMUQH9KodKUeIWT
	 bhzy4Jg+5SerYNI9RbKpbzwt/rzLEawUwu9UdhOPVc9d1GIK2OGeH3dM0hpseDIUo
	 ETmv3ybxaWRRW6wvMRJ07sLWoHDaSk0PGptzkpqMfXnVE6uO4LrvOboPIAthV4ros
	 EBvsz22R1xEu2eRgb/U+GrI/cbS3PUqDXQLQ2FbnVkU/tcmgyG40BwfB/yBJwLsPV
	 3R+0Nvx/WZwV7jtIdw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ugly.fritz.box ([89.247.162.120]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MaJ7v-1tQs3U3nBV-00QS8Z; Wed, 23
 Oct 2024 14:34:13 +0200
Received: by ugly.fritz.box (MasqMail 0.3.5-13-g85b6fce-plus, from userid 1000)
	id 1t3aZ3-Llz-00; Wed, 23 Oct 2024 14:34:13 +0200
Date: Wed, 23 Oct 2024 14:34:13 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 12/12] gitweb: make use of s///r
Message-ID: <ZxjtRXf8IUrvn1tK@ugly>
References: <20241010235621.738239-1-sandals@crustytoothpaste.net>
 <20241023004600.1645313-1-sandals@crustytoothpaste.net>
 <20241023004600.1645313-13-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241023004600.1645313-13-sandals@crustytoothpaste.net>
X-Provags-ID: V03:K1:iDP4B+6gTVP72mB/6lXGzbUR8ISwrLVLXOjf8ZkLui82SU6fe/P
 V2gEUvo8F6Nv2eP08/V8FM2UVEAOz9CIDeRttzRGOruixNIFRVkmTOlXbEWXC7zwHpSFHDm
 qc+ui1vJVMsLP8BM62SaLJOLDku7El8PdviHFpAvEcOEykdQAiTVPo6oJRFIejn+1c0YP7D
 hrsbeSl86CFeGbRxpcKiQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/gZmDQ34E6k=;mkSv/jF0fmUXNT0j18Ojc9OctA2
 DpyhuvqadY3kgoyMtFYgHJ0EpZKEQdGKcdkj4U33p7exXEtN1MXUk1rXChyWGj5AqazU2nxI6
 77pghNoHSVQJOjieu6TISmnPvnp/TTptwdox7A4vfR2BDnM0JvZBZ3gtueVRrG4hNNrqs1cuC
 PuSL7iqL+HdPJkME7GPB43mbv8Mu2DDUKbNGfjsE954bJgBGNUuiQ4w2sjRc3zVZOqCO2VAJO
 0eI09+woJ9s2BN0FWm5Wj8AsB7T7NB/7JWYgo51IfJAZLxw7y+gLExhg71AhsMAu7WFWLGzbs
 N1sidpUqYbuAw9ydITjgf00vhauBav0nmo510fzdmASx0N9YmGDgKPIhYRELcij5lvYS3dqJR
 LijrIJjfxmW3II16lY4E1xog8qzKCdAWsXMQE+pdHr7kz5lKwu/1WBWiVKPJFdPvd8pcvmATD
 Op+WGoiYtlXBw1XAhpKIpGiWk1kNAzl9p163Zu4Ws/XCk9t7JLIOPkEqkvCGEPS8kq54kcvSq
 2wLC82H+znHJNmeTGr2bbqrOgvzZv2W2NDBMWTY5gXYua7n4dD55wYCSwuThj7+RqXlJFR9s9
 nsXdza0TWbSA+pwW3RVaifnsWvqv96N9se5024893tlYMIjJbZezcDHwb8Q+KsnaO4soW9P2a
 Gaipalm2RKNgOueeu6ARmipdw84iBdCdAB5jGSZlXVjPhpweSNjsCGwj8ZA5E11HPADK1Ghwd
 n+7eLn0Bzf+5FxnXKUEMJREVF9E11dg45TL9Q2irk5PqKC/ex7kx36lJUJZG+Bvm1Fjl/yExZ
 YZ+Kb69lpa9fTv3i/yloG9tQ==
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 12:46:00AM +0000, brian m. carlson wrote:
>In Perl 5.14, released in May 2011, the r modifier was added to the s///
>operator to allow it to return the modified string instead of modifying
>the string in place.

>This allows to write nicer, more succinct code in
>several cases, so let's do that here.
>
"several" is a bit of an overstatement.

>+++ b/gitweb/gitweb.perl
>@@ -1188,7 +1188,7 @@ sub evaluate_and_validate_params {
>-				(my $error =3D $@) =3D~ s/ at \S+ line \d+.*\n?//;
>+				my $error =3D $@ =3D~ s/ at \S+ line \d+.*\n?//r;
>
i'm a fan of "excess" parentheses where the syntax relies heavily on
the binding and priority of operators:

   my $error =3D ($@ =3D~ s/ at \S+ line \d+.*\n?//r);

which is arguably semantically clearer than the old idiom, but not shorter=
.

>@@ -2700,7 +2700,7 @@ sub git_cmd {
>-		map { my $a =3D $_; $a =3D~ s/(['!])/'\\$1'/g; "'$a'" } @_ );
>+		map { my $a =3D $_ =3D~ s/(['!])/'\\$1'/gr; "'$a'" } @_ );
>
i think

   map { "'".(s/(['!])/'\\$1'/gr)."'" } @_ );

should work, and is an actually significant improvement.
