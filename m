From: Olivier Andrieu <oandrieu@nerim.net>
Subject: Re: git-viz tool for visualising commit trees
Date: Thu, 21 Apr 2005 13:31:36 +0200 (CEST)
Message-ID: <20050421.133136.78712855.oandrieu@nerim.net>
References: <20050420100824.GB25477@elte.hu>
	<20050421.034227.104037433.oandrieu@nerim.net>
	<20050421092120.GA20626@elte.hu>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: pasky@ucw.cz, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 13:31:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOZth-00078A-MG
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 13:31:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbVDULfE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 07:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbVDULc3
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 07:32:29 -0400
Received: from smtp-104-thursday.nerim.net ([62.4.16.104]:61705 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261313AbVDULbo
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2005 07:31:44 -0400
Received: from localhost (karryall.dnsalias.org [62.4.18.180])
	by kraid.nerim.net (Postfix) with ESMTP
	id 577584176B; Thu, 21 Apr 2005 13:31:37 +0200 (CEST)
To: mingo@elte.hu
In-Reply-To: <20050421092120.GA20626@elte.hu>
X-Mailer: Mew version 4.1 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

 > Ingo Molnar [Thu, 21 Apr 2005]:
 > 
 > * Olivier Andrieu <oandrieu@nerim.net> wrote:
 > 
 > > There, here's a tarball :
 > >   http://oandrieu.nerim.net/monotone-viz/git-viz-0.1.tar.gz
 > 
 > i'm trying to build it under Fedora Core 4 (devel), and there are two 
 > problems:
 > 
 >  - the build scripts seem to assume that "." is in PATH (or that the 
 >    needed viz_style.ml/etc. scripts are in the PATH).

I'm not sure what's wrong here. It works fine for me when I run make
in the source directory and I don't have "." in PATH.

 > adding "." to the PATH worked around this issue, a number of files built 
 > fine, but then it hit the next problem:
 > 
 >  ocamlopt.opt  -I /usr/lib/ocaml/lablgtk2 -I glib -I crypto -pp  -c viz_style.ml
 >  sh: - : invalid option
 >  Usage:  sh [GNU long option] [option] ...
 >          sh [GNU long option] [option] script-file ...
 >  GNU long options:
 >  [...]
 >  Preprocessor error
 >  make: *** [viz_style.cmx] Error 2

That's probably because the configure script didn't find
camlp4. Camlp4 is a preprocessor for ocaml, it's needed for compiling
this file (viz_style.ml). Camlp4 is built with the ocaml compilers but
some package it separately. Try to find and install some ocaml-camlp4
(or camlp4) package and then re-run configure.

The configure script should signal an error when it doesn't find
camlp4, I'll change that.

-- 
   Olivier
