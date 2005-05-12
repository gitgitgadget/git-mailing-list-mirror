From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Overwriting files in Makefile
Date: Thu, 12 May 2005 11:56:27 -0400
Message-ID: <200505121556.j4CFuRVS010004@laptop11.inf.utfsm.cl>
X-From: git-owner@vger.kernel.org Thu May 12 17:49:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWFvn-0002Co-Dc
	for gcvg-git@gmane.org; Thu, 12 May 2005 17:48:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262059AbVELP4f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 11:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbVELP4f
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 11:56:35 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:9113 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262059AbVELP43 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 May 2005 11:56:29 -0400
Received: from laptop11.inf.utfsm.cl (fw.inf.utfsm.cl [200.1.19.2])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id j4CFrVrJ020714
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Thu, 12 May 2005 11:53:32 -0400
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.4/8.13.1) with ESMTP id j4CFuRVS010004
	for <git@vger.kernel.org>; Thu, 12 May 2005 11:56:27 -0400
To: git@vger.kernel.org
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.19.1]); Thu, 12 May 2005 11:53:32 -0400 (CLT)
X-Virus-Scanned: ClamAV version 0.84, clamav-milter version 0.84e on localhost
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The current setup disturbs me. The Makefile copies the scripts into the
destination, and then edits them in place. Why not just generate them from
.in files before installing, i.e. by a rule something like

%: %.in
   sed -e 's;@LIBDIR@;$(sedlibdir);g' $^ > $@

with '@LIBDIR@' in the .in file whereever the substitution should take
place. This way you also avoid the possible loss of the permission bits
when fooling around (any SUID/SGID would get lost; not that it matters
here).

In any case, the '\/'s (LTS, "Leaning Toothpick Syndrome") when futzing
around with file paths can be avoided by using something else than '/' as
delimiter for sed(1)'s substitute command, like ';' here.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
