Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAE0346796
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 16:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762447981; cv=none; b=UFBGUEeVOdBl/HosNnNeQqYhGRHOYtR0HkGHIusi+u2a8JVA4awxlC4zAY6hm5jvSTtIkyFzDEJsHNn4Qcgx0KL61pobKKKhW33Q4rJEeaCQzmBXwrULxD/DmFiLQ+Ki5Dk8Cu3oFEQJCfVfqhAeGh+n/CdpZMvFMIEam3nw0Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762447981; c=relaxed/simple;
	bh=jtjPlMxHWzgLIuGbxbyni1AFDO4kyRY1KMEiCIB+9D0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YAXkFRdevYzq+EZyE9a48gt0o+ORKu3xBNVrb1BHci3KO97RQsUW1f2n2EKGj+rLozxEmeY2TD/0XmwExTeMpXXhhri64EaDdGOQjRt8Qi1PZLgqZT2Pvx8MnLrUgIjV3ALxg1hlB2vtf9IKxSRSR4JfRDQGRL2x1S2AxNUABzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TURgr/Bb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SiNa/aDi; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TURgr/Bb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SiNa/aDi"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9F93814001D1;
	Thu,  6 Nov 2025 11:52:56 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 06 Nov 2025 11:52:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1762447976;
	 x=1762534376; bh=IS24sW+//4hKBcVgD6TTr2FYPb6GSaB7jLhn6KgbdKI=; b=
	TURgr/BbW5jHN1IM8O5vSASSgZWh+FJN6BBq89lVQX9gk5veiC5TQZgNBoJvnL4O
	LRzkjo4Mw7/JiXvGYnJNnm0AvO1VMK1dfxwK/+ty17dXOQR/xRNVdTl2jMuhFW5I
	1PU8ydyHO3SNEZbMecbtlAtRsZjcPihLt8SV0/p5WYs1kCNQKfLR4vTcrBiWWXsm
	w+uFHUyAQVODL6KOSXigJ1qDCgMrujeh7UZCPufDrCGJtJOxrTn6xg5VDgcty1r5
	SV/wAhBa7mL3eOiG8ZToUzFxvIkmNKzeeEwwz21jVSSzeW2ASG/VRJ9OFKsD5Jt7
	PaadWj5/cQpvnLiQ6RHVRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762447976; x=
	1762534376; bh=IS24sW+//4hKBcVgD6TTr2FYPb6GSaB7jLhn6KgbdKI=; b=S
	iNa/aDiznpUGoGfEUOWx/Sap8Rhb8ET3vbg/T+nCnAoh4F5jeXMRCYJJlgdpV6DW
	9S5a1gz5/GXZPcQ06tK+nKAdgHUvhi4MfkJzD+l+EUjNbeJ7yGWhB8XfT492YfnY
	MjBEwTzLTMZg+Q7DCmOqKIfYav/zpaa6FpO4j0Ksu/83OkGMOvJF3vf66/bf9YNw
	/QOVpY2PX5orHmOgXvaxDWG+4mFhlhwIYfLWKNN9GcnITloLRfiENM/vx9Yb5GiS
	hTz84XRhsEhvsczOqupkR5qmOuTvDRMOeChxhw6KitN98L2RWR+0gb7JuZG31vZY
	jlH+RVtBa0ogulfaQgodw==
X-ME-Sender: <xms:Z9IMaYqwKD_Ccua-dRlkNrsIhjLvdVLSa15ObA_NW-gwDy-z4ZfSLg>
    <xme:Z9IMacc0R7eqQGrBM62lhgKD-Cl30KeioH5wPf1Oy521AnQKxzla7MQOKAme29may
    1EMmD61HacintVWTr7ZhM4yTCK4tmkGhPTtLFSyK3n-HSMlOzRHHg>
X-ME-Received: <xmr:Z9IMaXp4celGuTiAkK0Wr9mpbPhMRGm1Hc8U84MDMxY4lbYadpf4LNyvy_qpBY2QBeoA-aFHP_1RxZLdwfgRby9Uw9nVlRn4hlE8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeejfeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnse
    hgmhigrdguvgdprhgtphhtthhopehthhhomhgrshdruhhhlhgvsehmrghilhgsohigrdht
    uhdqughrvghsuggvnhdruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:aNIMadE1nIJdDUj0DDJ1HL4Co6GUKArz9gfNvOZybtVswbQRdKjAZg>
    <xmx:aNIMaXvDc1ewRGs8mGMnSQigMf7kZVo1VmwzTs7eUd83KKKKtD9CsA>
    <xmx:aNIMafWjezh-OLk47wsIlObHDxSj-YIZgqEkBUXSeAULOLLDznJBkw>
    <xmx:aNIMaTGA4WCqW4KhojZEk1dEZ9Oc6-vRe92kcxPo3pfvVt2T3Y90gg>
    <xmx:aNIMaUInkAbTcYXb_Da9rhTuFlR-JCqP_2SFI9-sku8d0m63gLYCl3NC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Nov 2025 11:52:55 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Thomas Uhle <thomas.uhle@mailbox.tu-dresden.de>,  git@vger.kernel.org
Subject: Re: [PATCH] wincred: align Makefile with other Makefiles in contrib
In-Reply-To: <927c2094-3654-edec-072e-1f6ca7d91f96@gmx.de> (Johannes
	Schindelin's message of "Thu, 6 Nov 2025 16:37:45 +0100 (CET)")
References: <3869ec21-e20d-cf9b-5913-6389c372a5f0@mailbox.tu-dresden.de>
	<927c2094-3654-edec-072e-1f6ca7d91f96@gmx.de>
Date: Thu, 06 Nov 2025 08:52:54 -0800
Message-ID: <xmqqv7jnhzmh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hallo Thomas, wie geht's? Grüße an den Biergarten am Blauen Wunder!
>
> On Wed, 5 Nov 2025, Thomas Uhle wrote:
>
>> * Replace $(LOADLIBES) because it is deprecated since long and it is
>>   used nowhere else in the git project.
>> * Use $(gitexecdir) instead of $(libexecdir) because config.mak defines
>>   $(libexecdir) as $(prefix)/libexec, not as $(prefix)/libexec/git-core.
>> * Similar to other Makefiles, let install target rule create
>>   $(gitexecdir) to make sure the directory exists before copying the
>>   executable and also let it respect $(DESTDIR).
>> * Shuffle the lines for the default settings to align them with the
>>   other Makefiles in contrib/credential.
>> * Define .PHONY for all special targets (all, install, clean).
>
> These changes all make sense to me. Feel free to add
>
> 	Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Thank you,
> Johannes

Thanks, both.  Will queue with your Ack.

>
>> 
>> Signed-off-by: Thomas Uhle <thomas.uhle@mailbox.tu-dresden.de>
>> ---
>>  contrib/credential/wincred/Makefile | 18 ++++++++++--------
>>  1 file changed, 10 insertions(+), 8 deletions(-)
>> 
>> diff --git a/contrib/credential/wincred/Makefile b/contrib/credential/wincred/Makefile
>> index 5b795fc..d92e721 100644
>> --- a/contrib/credential/wincred/Makefile
>> +++ b/contrib/credential/wincred/Makefile
>> @@ -4,20 +4,22 @@
>>  -include ../../../config.mak.autogen
>>  -include ../../../config.mak
>> 
>> -CC ?= gcc
>> -RM ?= rm -f
>> -CFLAGS ?= -O2 -Wall
>> -
>>  prefix ?= /usr/local
>> -libexecdir ?= $(prefix)/libexec/git-core
>> +gitexecdir ?= $(prefix)/libexec/git-core
>> 
>> +CC ?= gcc
>> +CFLAGS ?= -O2 -Wall
>>  INSTALL ?= install
>> +RM ?= rm -f
>> 
>> -git-credential-wincred.exe : git-credential-wincred.c
>> -	$(LINK.c) $^ $(LOADLIBES) $(LDLIBS) -o $@
>> +git-credential-wincred.exe: git-credential-wincred.c
>> +	$(LINK.c) -o $@ $^ $(LDFLAGS) $(LDLIBS)
>> 
>>  install: git-credential-wincred.exe
>> -	$(INSTALL) -m 755 $^ $(libexecdir)
>> +	$(INSTALL) -d -m 755 $(DESTDIR)$(gitexecdir)
>> +	$(INSTALL) -m 755 $< $(DESTDIR)$(gitexecdir)
>> 
>>  clean:
>>  	$(RM) git-credential-wincred.exe
>> +
>> +.PHONY: all install clean
>> 
>> base-commit: 4cf919bd7b946477798af5414a371b23fd68bf93
>> -- 
>> 2.47.3
>> 
>> 
