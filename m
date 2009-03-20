From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Define a version of lstat(2) with posix semantics
Date: Fri, 20 Mar 2009 15:20:17 +0100
Message-ID: <81b0412b0903200720w5990786cpe79718c617640448@mail.gmail.com>
References: <81b0412b0903190327l7745bf01i479fb84fae777af0@mail.gmail.com>
	 <alpine.DEB.1.00.0903191155300.10279@pacific.mpi-cbg.de>
	 <20090319214001.GA6253@blimp.localdomain>
	 <alpine.DEB.1.00.0903200025170.10279@pacific.mpi-cbg.de>
	 <81b0412b0903200130s594ce3beyae21eb0b5cc8fe0@mail.gmail.com>
	 <alpine.DEB.1.00.0903201015270.10279@pacific.mpi-cbg.de>
	 <81b0412b0903200639v6d99067csb7715d9a5a3f0ba4@mail.gmail.com>
	 <alpine.DEB.1.00.0903201446590.6865@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>, layer <layer@known.net>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 20 15:22:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lkfbl-000281-K1
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 15:22:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754225AbZCTOUZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 10:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753523AbZCTOUX
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 10:20:23 -0400
Received: from mail-gx0-f208.google.com ([209.85.217.208]:51349 "EHLO
	mail-gx0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752603AbZCTOUU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 10:20:20 -0400
Received: by gxk4 with SMTP id 4so3122105gxk.13
        for <git@vger.kernel.org>; Fri, 20 Mar 2009 07:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=AobOT9Lc9gtuG5dLVYBeECGB7sz5AhZHG88VjVIJkWs=;
        b=gao4N0TSwkBnlnbLcQWXsftVDmMeEQNutz8g5ntdS9uGDvjOuRTRvOrAvZKm5cUJTA
         UkZlwQ0osqLpG2L/JbxFOnWANyErNF6IcfJC5EWimrFWj4IwNa3c700yqpSVNOZnnvHO
         r9MA3nDnqoJQZCriKKDXDXBU3QG7zWNrXq7Yc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Sr+Qkk1+C9k/UMYFFlNUQtPcDlOPnvOM7hK/JGUmqF37tdvcVpIsMG5vSg6slZXkff
         p4vQBroM6QXp4lIx6pHSCEX5HHdbtSHXNDS8pzMM3kYHZaI+VFzwLIhn4zovK3J+vxim
         TEbS0SDFysPMYH2JILh0Nm8wHE3D2nLzJICkU=
Received: by 10.100.142.15 with SMTP id p15mr1571719and.20.1237558817964; Fri, 
	20 Mar 2009 07:20:17 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0903201446590.6865@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113962>

2009/3/20 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> On Fri, 20 Mar 2009, Alex Riesen wrote:
> (Unfortunately, a few important parts of Git are still implemented as
> shell scripts: bisect, pull and rebase being the most obvious to me, but
> repack, stash and submodule are not too unimportant, either.)

I can't imagine not using bisect or rebase.

>> My other problem is that the cygwin programs, and the worst of all - a
>> proprietary compiler based on cygwin, must be in PATH. AFAIR, the
>> presence of cygwin in PATH broken shell scripting.
>
> If it is a PATH issue, then it should be fixable by teaching msysGit to
> prepend $GIT_ROOT/bin and $GIT_ROOT/libexec/git-core to the PATH, but
> AFAIR we already do that.
>
> *clicketyclick*
>
> Yep, from reading setup_path() in exec_cmd.c, it appears that we prepend
> the PATH correctly.
>
> Traditionally, we did have problems with Cygwin, that is correct, but I
> think with your help we can resolve the interaction issues.

Ok. I guess it is a time for me to take another look at mingw port.
