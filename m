Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D186192B94
	for <git@vger.kernel.org>; Sat, 28 Dec 2024 19:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.18.0.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735415314; cv=none; b=Ij215ZV0BzEt4PAS5yomjmeB+EZJUfHZTv6ehIXXgUw2EaCYIEm0udxX4lomhRZ+KX0SSas20q5VZl4/FeFpycIwMBdo9lVZwjd1efU1iThL9Z2A7UWMQpsPwLuVyNtDQGAQ1gon5wXC08ao+FTnamjtm4xRFuGiCeVDYQPPeas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735415314; c=relaxed/simple;
	bh=X2F80NWxKpC55wbJ+5ptqn806PKKWH4pUeCqk+SwxMw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g4qCQauBJGZSWsspaZXTygklRKuKJy5Qev4UOxQlQhCfxecGFnjVEw5nP6gkvzR5krNeWxeQ5MIe9wzaKqGwR7/bu9V7yX5aavguqxvu33B7N9iLkg/RHtMUbyoYXoBfJWoeEpHbJ5fX2V6qkW3o06T2zX6InJEQe97HenwuwWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=nefkom.net; arc=none smtp.client-ip=212.18.0.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nefkom.net
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4YLCPS20G3z1sBpv;
	Sat, 28 Dec 2024 20:39:56 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 4YLCPS1BMPz1qqlS;
	Sat, 28 Dec 2024 20:39:56 +0100 (CET)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id C_IpNTrTkJlO; Sat, 28 Dec 2024 20:39:55 +0100 (CET)
X-Auth-Info: 5a5DpZxxkgtrsJndGcdU40jZvVyrhgD0dWZLD8/FOJ1PYtVgokEpUd/VPCj72SaN
Received: from igel.home (aftr-82-135-83-134.dynamic.mnet-online.de [82.135.83.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Sat, 28 Dec 2024 20:39:55 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id 390512C1A00; Sat, 28 Dec 2024 20:39:55 +0100 (CET)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Jeff King <peff@peff.net>
Cc: crstml@libero.it,  git@vger.kernel.org
Subject: Re: connecting the local main branch to the remote origin/main
 without pushing
In-Reply-To: <20241228190827.GB815586@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 28 Dec 2024 14:08:27 -0500")
References: <a69c4e2e-cbb0-c242-a34a-8997a84fefb7@libero.it>
	<87h66nk9uy.fsf@igel.home>
	<20241228190827.GB815586@coredump.intra.peff.net>
X-Yow: I have seen these EGG EXTENDERS in my Supermarket..
 ..  I have read the INSTRUCTIONS...
Date: Sat, 28 Dec 2024 20:39:55 +0100
Message-ID: <87cyhbk35g.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Dez 28 2024, Jeff King wrote:

> On Sat, Dec 28, 2024 at 06:15:01PM +0100, Andreas Schwab wrote:
>
>> On Dez 28 2024, crstml@libero.it wrote:
>> 
>> > My question is:
>> >      Is it possible when applying the method 2 to have (without pushing)
>> >      the local main branch connected to the remote origin/main branch as
>> >      in the case of method 1 which by cloning connects these branches.
>> 
>> You can establish the effect by setting two config entries:
>> 
>> $ git config branch.main.remote origin
>> $ git config branch.main.merge refs/heads/main
>
> Also:
>
>   git branch --set-upstream-to=origin/main main
>
> (sets the same config variables, but maybe a little more ergonomic).

That does not work if origin/main does not exist yet.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
