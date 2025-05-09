Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A7127B4FD
	for <git@vger.kernel.org>; Fri,  9 May 2025 09:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746783509; cv=none; b=FuFnC5uq3gh4Wn7fv0pFP/2kkDYbg6sa5DxDg66UvwL6flY9/EfRwChFZ1CSWJS9vu+BnHOy1vPhvsBLAUDir+gyGCGsbn5agb0lf6mQ/B4xnDWf11f/9GyM/Tz+3yh88YPCIJrxVONUlHxjvgU9y8TA8CFVKX20L6D30GVkvFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746783509; c=relaxed/simple;
	bh=EKhtwpddGFpLtMhRlf/ILSB2bn641hQSr3WTf26c9GU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TnFwz0KqVfoSZ57PC0G7SSYn+wH3CtQ3HxNn4j0dvLzDnFFDY073TkZ25xPKr6VzB+fkfqKz5NoncRVSOeGa/1HnBuAh8/YwxuIKXFH2U1PcvnPzOm4s9MOBT8D6i5lJFy/fkfpF1Pdk4g2ZLFjqnW1Mb4oYGXV/A08eWuraPeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=OWiSYdQY; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="OWiSYdQY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1746783503; x=1747388303;
	i=oswald.buddenhagen@gmx.de;
	bh=EKhtwpddGFpLtMhRlf/ILSB2bn641hQSr3WTf26c9GU=;
	h=X-UI-Sender-Class:Date:From:To:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=OWiSYdQYC5xhh7QyGnhHQfuQkBrfC3SLUMT7u0kXMJgB4K09z1F3VkGONjk7n7i7
	 5mRZAIeIDeS4JQ8sXUGU8GPWbtWBpzsSPxuZ79amzLdAqdEs7+jflhpV5GWeyfOIh
	 /vX80steBWg3mtTxUXP1xgk2CEhNXVbRYFLJla6F9ZDCo5IrtZ7jta199CNy9vNBT
	 UpixEw6C8KrQT6wRNAHDS6pNeutCWmICwxxIHZZF24bqmUdFY3wU71VRUtcieNOFq
	 uRyuLOVt+pVj2I8Jku4I9zBJGq0FWtqtKZX5SHXJ7XJfhJsZ7mLoT06K9oiG37jgR
	 anUUEvTxQYeXTxtOUA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ugly.fritz.box ([89.247.162.107]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MUosN-1udPeo0QKX-00TOSj for
 <git@vger.kernel.org>; Fri, 09 May 2025 11:38:23 +0200
Received: by ugly.fritz.box (MasqMail 1.0.0, from userid 1000)
	id 1uDKBS-rHD-00
	for <git@vger.kernel.org>; Fri, 09 May 2025 11:38:22 +0200
Date: Fri, 9 May 2025 11:38:22 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: git@vger.kernel.org
Subject: various issues with filtering commits from log
Message-ID: <aB3NDl518qJmQrJQ@ugly>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-Provags-ID: V03:K1:7ymM/WcI3Hwpb3xqyIGPREHkKhoawuU5FP34+rtMp0BsWOHPW8O
 mOonr32xNVxQFKWLw7CKlU0rs+7YoARO/n+vPjgcwvmOUvPXtaAr8P50NL2Vbi4YjeM+WSV
 rmME8FGs3+9SHV3c+Ehjk1zeH3sMUfGwPxKRC/Uu7hEi0mScZnzCXg0vTW+rPUaaGvUz3Q8
 Z5fc/HBzrG9V4QScO4NCA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5scGTWaBJ7E=;ftgVneaj+rb/gPd1dYflkOoxh51
 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
Content-Transfer-Encoding: quoted-printable

moin!

i have to deal with a repo which has relatively little traffic, except=20
that a bot is constantly spamming it, making it basically unfeasible to=20
get a quick overview of what happened.

so i thought, "there certainly is an --exclude-author option, and=20
ideally, i can persist it in the config as the default".
well, no. what i got is "--perl-regexp --author=3D'^(?!The Bot)'". that's=
=20
.. not user friendly.

once i got there, i noticed that --graph tears apart the history. the=20
manual talks about parent rewriting, but clearly this is not applied to=20
_this_ kind of history simplification.

so next i tried to approximate the desired result by logging only the=20
most interesting subdirectory, which the bot luckily doesn't touch. this=
=20
actually looks kinda reasonable, with the catch that a lot of tags &=20
branches are missing from the decorations. this of course makes sense,=20
as the relevant commits are not listed. however, it would be rather=20
desirable to have parent rewriting be applied here as well, so "fake"=20
decorations would be shown (with an indication where this was done).

these issues affect "log --all" particularly strongly, as it's not=20
really clear what belongs where.

somewhat unsurprisingly, these issues also affect gitk.
