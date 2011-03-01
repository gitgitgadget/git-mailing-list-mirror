From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Git changes permissions on directories when deleting files.
Date: Tue, 01 Mar 2011 21:43:58 +0100
Message-ID: <vpqmxlea7w1.fsf@bauges.imag.fr>
References: <AANLkTikJcOgBAZS=cCWULFYz4U_Mxx1gFMg51+r9qDo0@mail.gmail.com>
	<AANLkTinCjaGMe3TnheqORe7Y_qWYTAr3p6UEsK3u4VyE@mail.gmail.com>
	<AANLkTikFMg_yLWmanqyHveDMR==bw8kxjZgr4mSOmY-2@mail.gmail.com>
	<AANLkTimw+TLYv3ANf_Gx6G3SaLwRnRf6PF1YUv86rC5J@mail.gmail.com>
	<AANLkTimx7s94wjPasgdY7O9eoyzXXmhWm6f+CB0_2sv3@mail.gmail.com>
	<AANLkTimBrUo_O6sjhSEf2sPKrYhjMcr24hwRe0kH4CgO@mail.gmail.com>
	<20110301194428.GD10082@sigill.intra.peff.net>
	<AANLkTimCzBwsz4TV=jEGeSEScVtgwmGEiDWOomaeTgWD@mail.gmail.com>
	<20110301200805.GA18587@sigill.intra.peff.net>
	<AANLkTint3PARNNN4cpic8XG6HsM3AAGuX5a+oeXfFNx=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>,
	Computer Druid <computerdruid@gmail.com>, git@vger.kernel.org
To: Chad Joan <chadjoan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 21:44:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuWQV-0003dI-8V
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 21:44:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757482Ab1CAUoF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 15:44:05 -0500
Received: from mx1.imag.fr ([129.88.30.5]:34503 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757361Ab1CAUoE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 15:44:04 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p21KhsaB030857
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 1 Mar 2011 21:43:54 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PuWQI-0007LD-Gy; Tue, 01 Mar 2011 21:43:58 +0100
In-Reply-To: <AANLkTint3PARNNN4cpic8XG6HsM3AAGuX5a+oeXfFNx=@mail.gmail.com>
	(Chad Joan's message of "Tue, 1 Mar 2011 15:30:39 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 01 Mar 2011 21:43:54 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p21KhsaB030857
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1299617035.01799@KEsRJrIzTqsax0/3/+mWvA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168256>

Chad Joan <chadjoan@gmail.com> writes:

> I'll do that, but it will probably take a long long time for me to see
> the patch.  I'm hoping there's some cheap hack I can use to work
> around it in the meantime.

I'd say grep for "rmdir" is Git's source code, and replace the calls
with a wrapper that does roughly

rmdir_wrapper(dir) {
	rmdir(dir);
	if (stat(dir, &buf))
		chmod(dir, buf.st_mode | 0777);
}

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
