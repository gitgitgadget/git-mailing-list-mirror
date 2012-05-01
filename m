From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [PATCH] gitweb-lib.sh: Set up PATH to use perl from /usr/bin
Date: Tue, 01 May 2012 18:23:37 +0200
Message-ID: <4FA00E09.2090708@in.waw.pl>
References: <201205011323.45190.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jnareb@gmail.com, git@vger.kernel.org
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue May 01 18:24:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPFs3-0007Ox-Ai
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 18:24:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757218Ab2EAQYG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 May 2012 12:24:06 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:35781 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754191Ab2EAQYF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 12:24:05 -0400
Received: from abbp130.neoplus.adsl.tpnet.pl ([83.6.205.130] helo=[192.168.1.12])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SPFru-0003fU-RC; Tue, 01 May 2012 18:24:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.3) Gecko/20120329 Icedove/10.0.3
In-Reply-To: <201205011323.45190.tboegi@web.de>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196689>

On 05/01/2012 01:23 PM, Torsten B=C3=B6gershausen wrote:
> When there are different version of perl installed on the machine,
> the $PATH may point out a different version of perl than /usr/bin.
> One example is to have /opt/local/bin/perl before /usr/bin/perl.
>=20
> Sanitize the PATH by adding /usr/bin at the beginning
Hm, I see that most scripts have #!/usr/bin/perl, and only two have
#!env perl [1]. So in general we usally rely on using perl in /usr/bin.

But your patch affects other stuff than perl, and unconditionally
changing PATH set by the user is not nice, as it affect programs called
recursively. Wouldn't simply replacing all calls to bare perl in
t/gitweb-lib.sh with invocations of /usr/bin/perl be better?

[1]
% git grep 'env perl\b'
git-relink.perl:#!/usr/bin/env perl
git-svn.perl:#!/usr/bin/env perl

-
Zbyszek
