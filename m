Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE28199E89
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 05:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729490182; cv=none; b=u9c28nCDAfcuGcGnAtvF+Jtorjw6UY3jEVyKw+8u0VA9w1LedzLmBazbUz3238dSPqyfjvMCxqLqRuwtfTGZw37BnU/xf4SUBM3NlxgPYdXK9zGlOYNet9lktTO2KGYQFQa1PkopHKRPL/n+n0zQ/66K7grVXdNuv5OsvVGzkf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729490182; c=relaxed/simple;
	bh=3TJF0ogXmx1MF41o4B1s5RQKeNgWGzzJFzLRx5DYxkc=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=uRDKYs19eZbmYS0sMgSkBhYj+MB8wX+mr7FN7Mm+O5+sbYrNTlyftCYkCP6EIaFZFbdZ3TCNj67zdp4MLW5IAebn3b8qotq7b3Mqhenb+8xOsgMJBHuJ551ki47/qKMWe3XP705zN/ZHJV0RtgMsQ1TTHWQjR2RhF/DqgzVt/Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axiom-networks.org; spf=pass smtp.mailfrom=axiom-networks.org; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axiom-networks.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiom-networks.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id C6CA260008
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 05:56:16 +0000 (UTC)
Message-ID: <db95aa3f-f270-4939-ba3f-a964d46e2325@axiom-networks.org>
Date: Sun, 20 Oct 2024 22:56:11 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
From: Freya Starshade <saoirse@axiom-networks.org>
Subject: Git build failure: v2.47.0 on Solaris 10 SPARC64
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: saoirse@axiom-networks.org

Hi,


Reporting a build failure on version 2.47.0 of git, grabbed from the 
official sources. Our environment is:


Compiler: gcc (GCC) 9.5.0

Linker: GNU ld (GNU Binutils) 2.43

Target machine triplet: SPARC64-SUN-SOLARIS2.10

Target machine hardware: Sun Blade 150 UltraSPARC IIe workstation

Target OS: SunOS 5.10 Generic_150400-59 sparc SUNW,Sun-Blade-100 Solaris 
Sun Microsystems SunOS 5.10 Generic_150400-59 PATCH January 2018

After running ./configure, which succeeds, running `make all` gives:


root@iris:/usr/src/depot/progress/git-2.47.0# make all
     CC daemon.o
In file included from daemon.c:3:
git-compat-util.h:1012:13: error: conflicting types for 'inet_ntop'
  1012 | const char *inet_ntop(int af, const void *src, char *dst, 
size_t size);
       |             ^~~~~~~~~
In file included from git-compat-util.h:314,
                  from daemon.c:3:
/usr/include/arpa/inet.h:68:20: note: previous declaration of 
'inet_ntop' was here
    68 | extern const char *inet_ntop(int, const void *_RESTRICT_KYWD,
       |                    ^~~~~~~~~
make: *** [Makefile:2795: daemon.o] Error 1
root@iris:/usr/src/depot/progress/git-2.47.0#


Anyone know what's going on here?

