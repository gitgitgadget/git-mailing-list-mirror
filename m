Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDBE1D3634
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 19:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725652563; cv=none; b=d9dk8NvkwKUkv2susGdcJD9MLYwATg+7FdsUA/lq4+MTDjaFXzV9jIFHPTa4IF/D8+ZxTrOTt75eBginINIetu0hku4/vHnzrtcjkQLzK9lVqXQByPLvwd9ZNJ8GKhGiuSeOMcHYDg1nbdqx/CiS4NmsE2A5V3odMg7HvdhLShA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725652563; c=relaxed/simple;
	bh=ss2gqZsylG3hH5KMJT3uofedJ6KI4zjDw3ZPDQ1/Sxk=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=dbtuXPGM5e3UzI565k6jPA5KAstZ6fvHNWoobF7HqTT6KIVsqKzNbjKOZrRwsqjJ5gUa26nBa5De3PzAbuWowHI/e1mluHzSfbn3vYl0efbjTWeyQW6BdwCjpLGqtC5SWeN8c6WMTJDri8a4AfY6L0TeLUS0JcIu5Z3hvt6qpfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alchemists.io; spf=pass smtp.mailfrom=alchemists.io; dkim=pass (2048-bit key) header.d=alchemists.io header.i=@alchemists.io header.b=26YoRnSG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z7Q2vyrP; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alchemists.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alchemists.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alchemists.io header.i=@alchemists.io header.b="26YoRnSG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z7Q2vyrP"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DE3D41140194
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 15:55:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 06 Sep 2024 15:55:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alchemists.io;
	 h=cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1725652558; x=1725738958; bh=0t
	iN61hnIDWR+W9oC8FfvApQnmOv9iI1pG/kQd1aGio=; b=26YoRnSGM5RVXPxhIj
	Gihinq5SqNk6XRoT7H7MWnMNaoSfNsn15ApCnybSTQupzwB0yCj+GkBcPbkpn87y
	PC8HJUIvK3ZvKuIaZB0ryfe+gTcfBrLUd0zQy9gMTuMcwEkvUCFc/T9bkrdAsCUB
	x606Sl4iIyNbAEl091TRgij5Chm3gqlbI4t588jF+uCqnm+9XLeQa35qtEMBa1Ab
	8yFw3OUpT62CuPCV7JBlA/E0xpTUOoarMtkG+SshezWh7YPCKIf6Kg7h2+y+iDqE
	jYk1IBQyVWvqO52m+nFj/PUNbjloEeLlV911ds9VIrRNsRaQhh2/dMWN3veuFuW3
	31SA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725652558; x=1725738958; bh=0tiN61hnIDWR+W9oC8FfvApQnmOv
	9iI1pG/kQd1aGio=; b=Z7Q2vyrPfhYsBg8Q0PTfKOlM7fjGpHkCIusSYM6uX1dn
	zvvY46I8CtoKCVj5Up1dGWFcJxY2IItBWlOUnZQ2DdZUvFLls17DHHUiuzHLfXdB
	RSNWGvi+Wz7NSkT/QxScqSWP1ycvLrQqHoO6YZzsCEWVvU35+UwbQBczIQtWAY3H
	aMWa+FGBqDG6fjEit1p8Ev60AZACmmE5zDa5Q8PP4rKAMewtGED2ynNeu7JAH3ki
	HMDA4kS+SplsJfp5CMTLRY9pG+YJLbKG9d9S0QleA7DXKKQ2qqFyz+kc77nuNCkh
	k9tfvMeAydzQrNSLM6HPW+s9PTbXNcNEK4ZEqpdJGg==
X-ME-Sender: <xms:Tl7bZtwIVTEUCy3uE6DkSJg3R2Vu_YmR0EFTwl9-VJ0XEM-mDql5Kg>
    <xme:Tl7bZtSJ8KFjsnwp1AXXAtUupfZ_W7rEjoNo-tGoun3dz9LqCwhGiWq2tfKoGKy-o
    HR_oV2t1awkqBF5>
X-ME-Received: <xmr:Tl7bZnV_D-5elWZnBfDkeurQTIekmbhXqFXYWBmHZ4K8FAIAmb5hwgY__JZonV2ZYvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeiuddgudeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfgtgf
    gguffkfffvofesthhqmhdthhdtjeenucfhrhhomhepuehrohhokhgvucfmuhhhlhhmrghn
    nhcuoegsrhhoohhkvgesrghltghhvghmihhsthhsrdhioheqnecuggftrfgrthhtvghrnh
    epgeeiteehgffhheehjeevkeduieehvdejgfffueekgfejhfehffeigeegiefgtdeinecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghrohhokh
    gvsegrlhgthhgvmhhishhtshdrihhopdhnsggprhgtphhtthhopedupdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Tl7bZvjO24N-v0NizK8UcTz1koEnpIkq6d-qUjtIZnQBN8UEiIad6g>
    <xmx:Tl7bZvCzbblzeGW4VkEpKXJqrVKwgkMpHQopt5Gy1WGy0KVBSc5oeA>
    <xmx:Tl7bZoLZhQVEKO7irXkoD05ZoRdCAnjHvY6YqwMr76azb-bKGBfZrA>
    <xmx:Tl7bZuD53U1HvB1kGRACsb-wGJa2BiUkG08d8sa395mUyLG_m-Pkvg>
    <xmx:Tl7bZk7BEJKYWlHaqa_i0kk6fgiYKnyLx9Nwti2N96CzM3E87HwGRgSN>
Feedback-ID: i78e840cc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 6 Sep 2024 15:55:58 -0400 (EDT)
From: Brooke Kuhlmann <brooke@alchemists.io>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Fix issue with formatting multiple trailer keys
Message-Id: <EF5AE27D-B7CE-4337-B928-6073837218CA@alchemists.io>
Date: Fri, 6 Sep 2024 13:55:46 -0600
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.3776.700.51)

Hello. =F0=9F=91=8B

I'm seeing strange issues with log/listing trailer information for =
commits and tags and I think I'm experiencing a bug where when I attempt =
to list commits and tags with specific trailer keys, I get new lines =
showing up in my output.

Here's my steps to recreate using a simple Bash script:

```=20
mkdir demo
cd demo
git init

touch one.txt
git add .
git commit --message "Added one" --trailer Milestone=3Dpatch --trailer =
Issue=3D111
git tag 0.0.0 --message "Version 0.0.0" --no-sign --trailer Files:1 =
--trailer Duration:1

touch two.txt
git add .
git commit --message "Added two" --trailer Milestone=3Dpatch --trailer =
Issue=3D222
git tag 0.0.1 --message "Version 0.0.1" --no-sign --trailer Files:1 =
--trailer Duration:1
```

Notice that I'm using trailers for my commits *and* tags. Here's what my =
git log looks like:

```=20
git log --pretty=3Dformat:"%h %an% %s %d %cr. %(trailers:key=3DMilestone) =
%(trailers:key=3DIssue)"
```

The above produces this output:

08a07b717bef Brooke KuhlmannAdded two  (HEAD -> main, tag: 0.0.1) 5 =
minutes ago. Milestone: patch
 Issue: 222

01c4c182c85e Brooke KuhlmannAdded one  (tag: 0.0.0) 5 minutes ago. =
Milestone: patch
 Issue: 111

...and if I list my tags using this command:

```=20
git tag --list \
        --format=3D"%(refname:short) %(taggerdate:short) %(taggername) =
%(subject) %(trailers:key=3DFiles) %(trailers:key=3DDuration)"
```

...I get this output:

0.0.0 2024-09-06 Brooke Kuhlmann Version 0.0.0 Files: 1
Duration: 1
 Files: 1
Duration: 1

0.0.1 2024-09-06 Brooke Kuhlmann Version 0.0.1 Files: 1
Duration: 1
 Files: 1
Duration: 1

Notice, when logging trailer information for commits and tags, I get =
unexpected new line characters showing up in the output. I expect to see =
all information printed on the same line without any new lines showing =
up.

Also, I want to point out that when listing tag trailers, I get the =
"Duration" key showing up twice. I'm not sure if that's related or not =
but seems like very weird behavior.=
