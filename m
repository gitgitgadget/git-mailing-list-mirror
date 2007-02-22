From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Add git-bundle: move objects and references by archive
Date: Wed, 21 Feb 2007 22:28:05 -0500 (EST)
Message-ID: <alpine.LRH.0.82.0702212224510.31945@xanadu.home>
References: <Pine.LNX.4.63.0702220157130.22628@wbgn013.biozentrum.uni-wuerz
 burg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Mark Levedahl <mdl123@verizon.net>,
	Junio C Hamano <junkio@cox.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 22 04:28:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HK4cw-00060F-DM
	for gcvg-git@gmane.org; Thu, 22 Feb 2007 04:28:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbXBVD2I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Feb 2007 22:28:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbXBVD2I
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Feb 2007 22:28:08 -0500
Received: from relais.videotron.ca ([24.201.245.36]:37267 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340AbXBVD2H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Feb 2007 22:28:07 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JDU00KADHMTHRQ0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 21 Feb 2007 22:28:06 -0500 (EST)
In-reply-to: <Pine.LNX.4.63.0702220157130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40333>

On Thu, 22 Feb 2007, Johannes Schindelin wrote:

> diff --git a/index-pack.c b/index-pack.c
> index fa9a0e7..5ccf4c4 100644
> --- a/index-pack.c
> +++ b/index-pack.c
> @@ -457,8 +457,8 @@ static void parse_pack_objects(unsigned char *sha1)
>  	/* If input_fd is a file, we should have reached its end now. */
>  	if (fstat(input_fd, &st))
>  		die("cannot fstat packfile: %s", strerror(errno));
> -	if (S_ISREG(st.st_mode) && st.st_size != consumed_bytes)
> -		die("pack has junk at the end");
> +	if (input_fd && S_ISREG(st.st_mode) && st.st_size != consumed_bytes)
> +		die("pack has junk at the end: 0%o, %d, %d %d", st.st_mode, (int)st.st_size, (int)consumed_bytes, input_fd);
>  
>  	if (!nr_deltas)
>  		return;

What is this supposed to mean?


Nicolas
