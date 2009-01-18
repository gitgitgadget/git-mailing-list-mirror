From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/3] Teach read_tree_recursive() how to traverse into 
 submodules
Date: Sun, 18 Jan 2009 22:55:34 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901182244310.3586@pacific.mpi-cbg.de>
References: <1232275999-14852-1-git-send-email-hjemli@gmail.com>  <1232275999-14852-2-git-send-email-hjemli@gmail.com>  <1232275999-14852-3-git-send-email-hjemli@gmail.com>  <alpine.DEB.1.00.0901181635290.3586@pacific.mpi-cbg.de> 
 <8c5c35580901180945u17a69140vff2736765ee6073@mail.gmail.com>  <alpine.DEB.1.00.0901181929220.3586@pacific.mpi-cbg.de>  <8c5c35580901181145x2e14fe0fq4ab0e94c13bad38a@mail.gmail.com>  <alpine.DEB.1.00.0901182201140.3586@pacific.mpi-cbg.de>
 <8c5c35580901181331v5e54f82fxc6a042962ff1cd06@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 18 22:57:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOfdb-00080A-SN
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 22:57:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749AbZARVze (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 16:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751529AbZARVze
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 16:55:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:56148 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751108AbZARVzd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 16:55:33 -0500
Received: (qmail invoked by alias); 18 Jan 2009 21:55:31 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp021) with SMTP; 18 Jan 2009 22:55:31 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+3EOk8jv+3vMRV437jVp+2bCEFsiJhOqnmNqcSIx
	l3ChrPIJzO0p+G
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <8c5c35580901181331v5e54f82fxc6a042962ff1cd06@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106290>

Hi,

On Sun, 18 Jan 2009, Lars Hjemli wrote:

> So, would you rather have something like `git archive --submodules=foo 
> --submodules=bar HEAD` to explicitly tell which submodule paths to 
> include in the archive when executed in a bare repo?

That does not quite say what you tried to do, does it?  You tried to 
traverse submodules whose commit can be found in the object database.

Setting aside the fact that we usually try to avoid accessing unreachable 
objects, which your handling does not do, our "git submodule" does not do 
that either; it only handles submodules that are checked out.

Now, this behavior might be wanted, in bare as well as in non-bare 
repositories, but I think it should be triggered by an option, such as 
"--submodules=look-in-superprojects-odb".

I know, I know, the naming is horrible, but I find it just wrong to 
introduce a behavior that would only confuse users because it introduces 
inconsistent behavior.  As it is, we see too many confused users in #git 
already with consistent behavior [*1*].

Ciao,
Dscho

[*1*] Maybe we should allow cloning empty repositories (with no default 
branch at all), disable pushing into checked out branches by default, and 
make "git add empty-dir/" add a .gitignore and add that -- to squash at 
least half of the questions inside #git so that we can go back to fooling 
around there.
