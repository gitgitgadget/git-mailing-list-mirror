From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Adding a cache of commit to patch-id pairs to speed up
 git-cherry
Date: Mon, 2 Jun 2008 19:22:01 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806021918590.13507@racer.site.net>
References: <7f9d599f0806012054y33b4fc10ha109aa4afbc7ca78@mail.gmail.com>  <alpine.DEB.1.00.0806020649110.13507@racer.site.net>  <7f9d599f0806020750g78e6816dl884d36bb903c707b@mail.gmail.com> <7f9d599f0806021023r64affb36ne491792a962d455c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Geoffrey Irving <irving@naml.us>
X-From: git-owner@vger.kernel.org Mon Jun 02 20:24:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3Ehm-0003hk-IH
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 20:24:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751885AbYFBSXU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 14:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751660AbYFBSXU
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 14:23:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:60782 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751297AbYFBSXT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 14:23:19 -0400
Received: (qmail invoked by alias); 02 Jun 2008 18:23:14 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.2]) [141.5.10.38]
  by mail.gmx.net (mp006) with SMTP; 02 Jun 2008 20:23:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+O3x1dGcmOc+GEH/Lq8PZWI0s33pf6U26RGriZeD
	c0xW2Z3qg6tDqr
X-X-Sender: gene099@racer.site.net
In-Reply-To: <7f9d599f0806021023r64affb36ne491792a962d455c@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83552>

Hi,

On Mon, 2 Jun 2008, Geoffrey Irving wrote:

> On Mon, Jun 2, 2008 at 7:50 AM, Geoffrey Irving <irving@naml.us> wrote:
>
> I'll switch to mmapping.
> 
> The git_mmap function in compat/mmap.c dies if NO_MMAP is defined and 
> the map isn't MAP_PRIVATE.  If I want to write an entry, will the memory 
> be automatically updated if I write directly to the file descriptor (I 
> haven't used mmap before)?

I think that you should only mmap() with MAP_PRIVATE, because you can 
corrupt the data easily when a write failure is not handled properly.

So I'd suggest mmap() for reading, and writing to a locked file (I think 
you did that already).

Ciao,
Dscho
