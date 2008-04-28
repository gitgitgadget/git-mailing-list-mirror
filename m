From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Dumb idea on git library for script languages
Date: Mon, 28 Apr 2008 11:28:48 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804281125330.5399@eeepc-johanness>
References: <1209366216.17090.4.camel@prosumer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: tsgates <tsgatesv@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 12:29:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqQc4-000843-AA
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 12:29:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755149AbYD1K2k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 06:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752963AbYD1K2k
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 06:28:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:41088 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753793AbYD1K2j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 06:28:39 -0400
Received: (qmail invoked by alias); 28 Apr 2008 10:28:37 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO eeepc-johanness.st-andrews.ac.uk) [141.5.11.5]
  by mail.gmx.net (mp009) with SMTP; 28 Apr 2008 12:28:37 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Yjr98eIjYet518UNxC5WlT/RtT00ctk+AJqYbnr
	gKW6y0NCeB4iyJ
X-X-Sender: user@eeepc-johanness
In-Reply-To: <1209366216.17090.4.camel@prosumer>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80523>

Hi,

On Mon, 28 Apr 2008, tsgates wrote:

> malloc_hook( size ) {
>   void * rtn = malloc( size )
>   if ( rtn ) {
>      add_to_mem_record( thread_id, rtn )
>   }
> }
> 
> free_hook( ptr ) {
>   if ( free( ptr ) ) {
>      del_mem_record( thread_id, ptr )
>   }
> }
> 
> clean_mem() {
>   for_each ( mem_records ) 
>     free( ptr )
> }

This is not enough.  We have quite some static variables which point 
directly or indirectly to these allocated regions.

I think you'd need to implement some resetter functions if you were to 
libify libgit.a.  The easier way would definitely be to go with 
libgit-thin, as Jakub suggested.

Ciao,
Dscho
