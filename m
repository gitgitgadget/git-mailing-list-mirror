Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86322190052
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 21:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737061358; cv=none; b=ebmia6/gjbPyxjLAcL6ZKmfVXn85h67RU3FUekdbvWRDeSAHeo+zZ0e8hB6lqkO/8RwfYv7grYvz7iIYxls1w6pwpYRyEadlNztswvV1KTtoJQfxZEfBHCQWJrWgJU66m7OFbN0qbX3iyJyJyoZudltiZu801GFvxylWwMTGGA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737061358; c=relaxed/simple;
	bh=DahHT2yZ9aJy+H0TYEN3WD5hhnM1hsCPZ6WYGLRom4o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hdovfk8RU/QOzkLA924dGC4Cq4cEB0VxBNrh9yKbIvLGNckRb7rhu9FCiOukzA0b3oUGPsbDwFwBA0WE6U4dddPjWnd8vCjUDZlcZT9QzLhVBL7cBGg8cv/rL6tnPJb4ypA2Wi7hiGUg1mcs/GzwH2Mz9ajdktTxXmRyJr6z5lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aVffWUqV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZQ2I8F/N; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aVffWUqV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZQ2I8F/N"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6CDDA1140152;
	Thu, 16 Jan 2025 16:02:35 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 16 Jan 2025 16:02:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1737061355; x=1737147755; bh=SNU1WTYLkq
	PXgK3BFZCTzsbq5Hc50c89qnLXtAh0mvM=; b=aVffWUqVKgIx9HI51T1X2RRa5n
	H0FdsTOU5VP1fsz6yjzjpi8DS2yvKiiV4dBihhwANWGpAW42EsLC6sWlDTdieHry
	NKaWwfSF3UEarkUsp0T4jCbXKys1EktpmM2lkE/UkBoWJi4UPaKaK5GBOGVLht90
	8YULuwENQUgSly0pShoAhhd3PATsr1435wkAYrfmG2aZ10LeLeDc1YayEdeSsDvj
	s6RC4+ppAxM4gIhS3xdoRaRmVNGbS7xziW916DfuanEA3y90s3i3M1JOdlWS3GFZ
	JhCSzPIEccvvx/gZTLk3Yg6+V4aLZsKt25wMKT4U6+iXPdZVe6JPfvgjUgFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737061355; x=1737147755; bh=SNU1WTYLkqPXgK3BFZCTzsbq5Hc50c89qnL
	XtAh0mvM=; b=ZQ2I8F/NodWwvo5BZBEr3Try8t5BXbv5+C1Zv6cPERNgF23hZQ0
	rg1QGPxDWB9IF8FMwldviqvk44GO34xksb1DhsEwwcfY/8FQm5hlYe33IxZCStw4
	FR/DLcwxjrpjMHAvpU0DKEvFSD7JR1kKhWx37njiPiHeZS9OXXT+4wRitK6uS9NY
	oD24ydFmjnhwMhoMmzsTkMx9FHtZujTJIxEtXzS7ILakCRyA+vM8yZ6mnZOX3lCt
	Ye0QGRZaaw+6p4fxVzZlJ5uCGKG74SML7rx5QBkA9PjHlCUBp6tyxwZbL8BHcOWj
	7o6MPFas3Ohw7Tu4ODgS4S9N7Kjs189uhaw==
X-ME-Sender: <xms:6nOJZz3ExuLCS5cBqgrfHN-6Nmgx7kFfe6cGxxs1ufAHmMN2-Z8dAg>
    <xme:6nOJZyF4IjleVRnbH6f44D3XkbLPLXl-SicxBXslgRpQhOvywH83p0IjZoly5sQh6
    vHKci17-q6uFVshCg>
X-ME-Received: <xmr:6nOJZz4kZ5_7jJUHpYqjJ-_X7HwXHgK-hDium77rwVDjaXWWmPl6vhml_GgHx1x5fzxKVXRvDzeqlGoBn-2jK8ncFo3Np1WoFN81>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddgudegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeffieetueejveefheduvdejudffieejgeef
    hfdtvdekfeejjeehtdegfefgieejtdenucffohhmrghinhepghhithhhuhgsrdgtohhmne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhs
    thgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehsthgvrggumhhonhesghhoohhglhgvrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtrghlvh
    hinhifrghnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehnrghsrghmuhhffhhinhes
    ghhoohhglhgvrdgtohhmpdhrtghpthhtohepvghmrhgrshhssehgohhoghhlvgdrtghomh
    dprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgv
    thdprhgtphhtthhopehmhhesghhlrghnughiuhhmrdhorhhgpdhrtghpthhtohepphhsse
    hpkhhsrdhimhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgt
    ohhm
X-ME-Proxy: <xmx:6nOJZ42OhftKCyO_RI6O4uV8RtzLAh1LGxq_ZkN873S3_2_Z5Dd_sA>
    <xmx:6nOJZ2EkMAKkuYb4axz4-5zAgJObODan96H5C-Yo5K8Wqx9XZ7zk6Q>
    <xmx:6nOJZ58_gVdd3C41KwzTKqwiHF-RFnGpv8IX0_2Yrvq_ezyTkDwYYQ>
    <xmx:6nOJZzmCYlwgC7hSEgdIHwsej9AnWcsK0gc5PkOHMAK9dBW2-f1iCQ>
    <xmx:63OJZ9eCh0IL-x-ii8M71mLWl2rPKLFIL4AOkwO4Ltn5v2CYvknDNy9T>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 16:02:34 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org,  calvinwan@google.com,  nasamuffin@google.com,
  emrass@google.com,  sandals@crustytoothpaste.net,  mh@glandium.org,
  ps@pks.im,  sunshine@sunshineco.com,  phillip.wood123@gmail.com,
  allred.sean@gmail.com
Subject: Re: [PATCH v6 1/5] common-main: split init and exit code into new
 files
In-Reply-To: <xmqq34hjv5kw.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	15 Jan 2025 18:46:23 -0800")
References: <cover.1723054623.git.steadmon@google.com>
	<cover.1736971328.git.steadmon@google.com>
	<ff6cd62397ec2755d15e9d76f9af8a84b54a36c1.1736971328.git.steadmon@google.com>
	<xmqqr053wvip.fsf@gitster.g> <xmqq34hjv5kw.fsf@gitster.g>
Date: Thu, 16 Jan 2025 13:02:33 -0800
Message-ID: <xmqqtt9ypj4m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Unfortunately, build based on meson does not seem to like the
> init_git() thing.  Perhaps we need to add some missing files to
> relevant lists in meson.build file or something silly like that?
>
> https://github.com/git/git/actions/runs/12800227601/job/35687658673#step:8:961

I needed the following to get "meson compile" pass in my local
environment.  I suspect that Mesonized CI jobs exercise a bit more
than just "meson compile", so there is no guarantee that the
following is enough, but at least hopefully it would nudge you (and
those who may be interested in helping to build a working Rust
bindings) in the right direction.

I think it should be squashed into the step these files are added,
i.e. [PATCH 1/5].

Thanks.

 meson.build | 2 ++
 1 file changed, 2 insertions(+)

diff --git c/meson.build w/meson.build
index 0064eb64f5..e5ba28b47f 100644
--- c/meson.build
+++ w/meson.build
@@ -245,6 +245,8 @@ libgit_sources = [
   'commit-graph.c',
   'commit-reach.c',
   'commit.c',
+  'common-exit.c',
+  'common-init.c',
   'compat/nonblock.c',
   'compat/obstack.c',
   'compat/terminal.c',
