Received: from 20.mo561.mail-out.ovh.net (20.mo561.mail-out.ovh.net [178.33.47.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C69818DB1A
	for <git@vger.kernel.org>; Sat,  5 Jul 2025 23:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.33.47.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751757754; cv=none; b=ifErRqckWvZrJDdrFd2FESozc4VjTPd2OTssUh2PndU4sjp06p84Dhmbmr1inp/6exsZHzUfi0fIj4/Er17fAHAQL4IGvkV5jz1Nq51ECaVTGvmJegMGkO0Pom7DAGF57Cuwn+kV1aCRJwF+Mmw/DLi1OhPxeigcECT6Kog6cCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751757754; c=relaxed/simple;
	bh=QsBaVaR0b+aFjYP7ZrxsySbBOn3qOsQ0ujW8HqVE0kU=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=g4taITZuQ37lcgbk8G4fsOG+/Dgnq+jdBFSxh4TsFnTj/vmnU882CRraJo3gyDku85RzIZUa3bvzD/21r7bUhbKMIYuEo2sLLn6jeWofM0kfBPQrVXEd5D83x+3V0gPVrzl3i3qjEqcH/HNosfca3wCo9q2HaNWvQKj3ei7Bt2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redoste.xyz; spf=pass smtp.mailfrom=redoste.xyz; dkim=pass (2048-bit key) header.d=redoste.xyz header.i=@redoste.xyz header.b=Ylcejyoq; arc=none smtp.client-ip=178.33.47.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redoste.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redoste.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=redoste.xyz header.i=@redoste.xyz header.b="Ylcejyoq"
Received: from director5.ghost.mail-out.ovh.net (unknown [10.110.58.102])
	by mo561.mail-out.ovh.net (Postfix) with ESMTP id 4bZQzs15F9z5xfh
	for <git@vger.kernel.org>; Sat,  5 Jul 2025 23:04:09 +0000 (UTC)
Received: from ghost-submission-5b5ff79f4f-c46tb (unknown [10.108.54.3])
	by director5.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 8E545100205;
	Sat,  5 Jul 2025 23:04:08 +0000 (UTC)
Received: from redoste.xyz ([37.59.142.98])
	by ghost-submission-5b5ff79f4f-c46tb with ESMTPSA
	id 1iFCFGivaWgfEAAAbh9nmQ
	(envelope-from <redoste@redoste.xyz>); Sat, 05 Jul 2025 23:04:08 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-98R0027f9d0c43-98bc-47f4-9fba-1a9764a13049,
                    03B360DA9A158DBC4F736A687BEA6D6B8F7DE961) smtp.auth=redoste@redoste.xyz
X-OVh-ClientIp:62.34.249.37
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 06 Jul 2025 01:04:05 +0200
Message-Id: <DB4HWL9M36X4.2GND0UHYOS8Q0@redoste.xyz>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>, "Jeff King" <peff@peff.net>, "Junio C Hamano"
 <gitster@pobox.com>, "Fabian Stelzer" <fs@gigacodes.de>, "Elijah Newren"
 <newren@gmail.com>, "redoste" <redoste@redoste.xyz>
Subject: Re: [PATCH] ssh signing: don't detach the filename strbuf from
 key_file tempfile
From: "redoste" <redoste@redoste.xyz>
X-Mailer: aerc 0.20.1
References: <20250704230829.29696-1-redoste@redoste.xyz>
 <20250705192113.GB2496172@coredump.intra.peff.net>
 <aGmGCmkwC1HlSyog@fruit.crustytoothpaste.net>
 <DB4HMD2HLG24.1V8Y9JDW6BACQ@redoste.xyz>
In-Reply-To: <DB4HMD2HLG24.1V8Y9JDW6BACQ@redoste.xyz>
X-Ovh-Tracer-Id: 12639633829473064341
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -30
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvjeefudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlhcuvffnffculdejtddmnecujfgurhepggfgtgffkffvvefuhffofhgjsehtqhertdertdejnecuhfhrohhmpedfrhgvughoshhtvgdfuceorhgvughoshhtvgesrhgvughoshhtvgdrgiihiieqnecuggftrfgrthhtvghrnhepiedugffgudevjeetueehudelkeegudevgfevheekjeefhfevgefgvdduleehffeknecukfhppeduvdejrddtrddtrddupdeivddrfeegrddvgeelrdefjedpfeejrdehledrudegvddrleeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehrvgguohhsthgvsehrvgguohhsthgvrdighiiipdhnsggprhgtphhtthhopedupdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheeiudgmpdhmohguvgepshhmthhpohhuth
DKIM-Signature: a=rsa-sha256; bh=oSnv3LYTA5oXjyw3OvLoZwVwBV2+AUT7djhwPv1LaHM=;
 c=relaxed/relaxed; d=redoste.xyz; h=From; s=ovhmo3968190-selector1;
 t=1751756649; v=1;
 b=Ylcejyoqlktx4NOqKAhKq5nB8594jc6FjrddO5NWMBygQyGvk+vMiiadVgCmVHhMBTBWiZTT
 jFhjYYtNCUS8S8yJJvNPjHzsQv3oKvIxJiGMLCIleOVshH+wN+He4g0LZ2RwTEY/Gjy2pyOn5Rj
 BeKDRj3ulxS0IU08ZBJt0u/CdNDzwI6jlQ9yih6FpBBebPLFyRNNpkiUErId2yyB05EYb3ACr7O
 A5Sp5qtoG8K5l1jy+8wzCccE6KM+yMd/iuipYF3HGHEgBh7esQd4lIgRTgyen4IuGYQn+Zb9iGC
 dySxxVS7yOg63gpP5/vawbeOGrCYNUz00uGAF3DhgN9Qg==

On Sun Jul 6, 2025 at 00:50 CEST, redoste wrote:
> Maybe something like this?
Sorry, it's my first time contributing via a mailing list and I stupidly
copy-pasted the output of `git diff` without checking the whitespaces.
Here is the proper version of the diff that can be applied:

diff --git a/t/t7528-signed-commit-ssh.sh b/t/t7528-signed-commit-ssh.sh
index 065f780636..359dc8eba8 100755
--- a/t/t7528-signed-commit-ssh.sh
+++ b/t/t7528-signed-commit-ssh.sh
@@ -85,6 +85,7 @@ test_expect_success GPGSSH 'sign commits using literal pu=
blic keys with ssh-agen
 	eval $(ssh-agent) &&
 	test_when_finished "kill ${SSH_AGENT_PID}" &&
 	ssh-add "${GPGSSH_KEY_PRIMARY}" &&
+	export TMPDIR=3D$(pwd) &&
 	echo 1 >file && git add file &&
 	git commit -a -m rsa-inline -S"$(cat "${GPGSSH_KEY_PRIMARY}.pub")" &&
 	echo 2 >file &&
@@ -95,7 +96,8 @@ test_expect_success GPGSSH 'sign commits using literal pu=
blic keys with ssh-agen
 	git commit -a -m ecdsa-inline -S"key::$(cat "${GPGSSH_KEY_ECDSA}.pub")" &=
&
 	echo 4 >file &&
 	test_config user.signingkey "key::$(cat "${GPGSSH_KEY_ECDSA}.pub")" &&
-	git commit -a -m ecdsa-config -S
+	git commit -a -m ecdsa-config -S &&
+	! ls .git_signing_key_tmp*
 '
=20
 test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'create signed commits with k=
eys having defined lifetimes' '

--=20
redoste
