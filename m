From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 2/2] Teach @{-1} to git merge
Date: Sat, 14 Feb 2009 23:52:42 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902142332210.10279@pacific.mpi-cbg.de>
References: <7v4oyxzeay.fsf@gitster.siamese.dyndns.org> <76718490902132311j5add87bcpb103c951a8192b05@mail.gmail.com> <7vzlgpxz4g.fsf@gitster.siamese.dyndns.org> <7vskmhuzla.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Jay Soffian <jaysoffian@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 23:53:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYTNu-0005SJ-8t
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 23:53:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752477AbZBNWvv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 17:51:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752365AbZBNWvu
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 17:51:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:36429 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752300AbZBNWvu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 17:51:50 -0500
Received: (qmail invoked by alias); 14 Feb 2009 22:51:48 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp026) with SMTP; 14 Feb 2009 23:51:48 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18HS+p1syEHa3MKhg+PUEG6dxIQA1Vyj2cIXzdfFg
	srtfBZSyZOroSi
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vskmhuzla.fsf_-_@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109947>

Hi,

On Sat, 14 Feb 2009, Junio C Hamano wrote:

>  * I know "show-branch @{-1} HEAD" does not dereference @{-1}, but I
>    suspect there may be many others.

I scanned command-list.txt briefly, and could verify (by testing rather 
than code inspection) that

- bundle works as expected (thanks to dwim_ref()),

- fast-export (like bundle, dwim_ref() makes it work),

- so does filter-branch, thanks to rev-parse --symbolic-full-name 
  resolving @{-<n>} correctly,

- log and reflog also substitute @{-<n>} by the branch name,

- update-ref does _not_ interpret @{-<n>} as the branch name (which I 
  find okay, as update-ref is plumbing), but instead creates the file 
  '.git/@{-<n>}' (which I think is a bug).

Now, show-branch indeed does not substitute the branch _name_, but 
otherwise it works correctly, no?  And given the fact that show-branch 
does not substitute "HEAD" with the current branch name, either, I wonder 
if show-branch needs fixing at all.

Ciao,
Dscho
