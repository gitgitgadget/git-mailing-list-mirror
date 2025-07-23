Received: from mailgate01.uberspace.is (mailgate01.uberspace.is [95.143.172.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9962F4A
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 05:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.172.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753250114; cv=none; b=hfQwz+QKKwjGYRKH7Z7+RQPbGqv+otH2G0IGI9TDEnjrK11IF4fmuubvTFVQlcyQmXilWdxjMw9pV6DdNgPXJyxtC/9zUOYMabdI9+iJLZV+ldKovwquTYVJuC+2JbvInDUJ1Wbhdwf7yEtf+NXvAywdGaeOP6/IHpiEiUthyr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753250114; c=relaxed/simple;
	bh=ZylhGz3fps8pn/f5ZNdnRkcL2iJFWtfGyvZmhIiDjb0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PvHTHc7uOXcg5MNm32uT6Oosc23z+GfA/HrhUa4+ySTXjEIc6c8x83u/DNmHY7SrSSbMB+Z8ozNYL0YblMkRTyR+uwF6yr9PF8UORpxcz5sQJSmmaN3rJIy+IO4pTRFTq2v7h4b4faZPC7AbLq0IAVUv8yr6b2DMYl0lFF8xatY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=arnes.space; spf=pass smtp.mailfrom=arnes.space; dkim=pass (4096-bit key) header.d=arnes.space header.i=@arnes.space header.b=Qb80EEHf; arc=none smtp.client-ip=95.143.172.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=arnes.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnes.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=arnes.space header.i=@arnes.space header.b="Qb80EEHf"
Received: from machholz.uberspace.de (machholz.uberspace.de [185.26.156.167])
	by mailgate01.uberspace.is (Postfix) with ESMTPS id E003A60B83
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 07:47:01 +0200 (CEST)
Received: (qmail 18413 invoked by uid 990); 23 Jul 2025 05:47:01 -0000
Authentication-Results: machholz.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by machholz.uberspace.de (Haraka/3.0.1) with ESMTPSA; Wed, 23 Jul 2025 07:47:01 +0200
From: hi@arnes.space
To: git@vger.kernel.org
Subject: git-diff: --ignore-matching-lines has no effect on the output when
 --name-only is used
Date: Wed, 23 Jul 2025 07:47:00 +0200
Message-ID: <87a54v8nmz.fsf@arnes.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Bar: /
X-Rspamd-Report: BAYES_HAM(-0.000014) MIME_GOOD(-0.1)
X-Rspamd-Score: -0.100014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=arnes.space; s=uberspace;
	h=from:to:subject:date;
	bh=ZylhGz3fps8pn/f5ZNdnRkcL2iJFWtfGyvZmhIiDjb0=;
	b=Qb80EEHf2UWFF5O25cugWkmY1T9Q2drHJdZb24L5d7DqzrB+Z6nJ1AQRMQ5ZEPuFRMFPGkZ4+E
	CUbv+RwOZi2v5IxccZ6VCdmn4Ktg1phj53sJnq75Vc7gRu3AdbzJCOuC4hzj2CDfYlhQD7zQqThn
	hDzR+/OY743xuHhTGmHe7gi4hXynhoSHefCjn/bxvEIyqVGXxJudicOUO2CautgeymmsymaUMtEx
	AqfqP+Awr4uOxEFp+tTX3QCEoRPmgQMWfrNzzR6Bn2whAn2n4sOJNTOSrNz5HY1NWpadOqLAh0lU
	VC0eszv7kgxvUPAJPU6oyNPiZ9EVhLtJAsH+/aX3gsCB+zgPdt8Z3IGfB42btMjinPrB1ZAB9It9
	LOOH94pHTBITKgzJnHlac9gxJNOU9On+oCOOVjM4xnEePjNVnc0dGNOsfYFgfPcZK1+vPByFSiqD
	9QAybqdFTF7iPUDhkLcMFeEWfT/3vkARNmwInDhSIIGfFXAnifJVk9W8PTdKiqTxCLBalnoaUSN+
	aSRcXHbRMglH4sz2+eqZ0FHpfVn+RP9nUcjtGOojyTTa2CSuViM7K/Li7wIsAgWMcBi+oOXjKjdV
	CDLcaJ8gppZX7sXpsaxSLz+1uX/8oDy8o3kp0G4esO3cOeKCeB3OtqziwznfqlBeCGOtt+2Lr7tr
	E=

I discovered that diff output is not filtered when the `--name-only`
flag is given, it always lists all affected files. Is this a known bug?
I could not find anything in the documentation.

Perhaps related, `--ignore-matching-lines` is ignored by my external
diff helper difftastic[1]. I'm not sure if this is an upstream issue, or
if the way external diff helpers are implemented is related to this at all.

The behavior can be observed in git 2.49.0 using `git diff --no-ext-diff
--name-only --ignore-matching-lines`.

Best,
Arne

[1]: https://difftastic.wilfred.me.uk/
