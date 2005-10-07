From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH] close clobbers mmap's errno in read_cache
Date: Fri, 07 Oct 2005 23:48:45 +0200
Message-ID: <20051007214845.GH8383MdfPADPa@greensroom.kotnet.org>
References: <20051007214551.GA8893@steel.home>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 07 23:50:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EO05P-0002Vp-Rl
	for gcvg-git@gmane.org; Fri, 07 Oct 2005 23:49:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932623AbVJGVsu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Oct 2005 17:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932677AbVJGVsu
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Oct 2005 17:48:50 -0400
Received: from smtp18.wxs.nl ([195.121.6.14]:27133 "EHLO smtp18.wxs.nl")
	by vger.kernel.org with ESMTP id S932623AbVJGVst (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Oct 2005 17:48:49 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp18.wxs.nl (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with SMTP id <0IO000AVBF9AFP@smtp18.wxs.nl> for git@vger.kernel.org; Fri,
 07 Oct 2005 23:48:46 +0200 (CEST)
Received: (qmail 6356 invoked by uid 500); Fri, 07 Oct 2005 21:48:46 +0000
In-reply-to: <20051007214551.GA8893@steel.home>
To: Alex Riesen <raa.lkml@gmail.com>
Mail-followup-to: Alex Riesen <raa.lkml@gmail.com>,
 Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9820>

On Fri, Oct 07, 2005 at 11:45:51PM +0200, Alex Riesen wrote:
>  	}
> +	i = errno;
>  	close(fd);
>  	if (map == MAP_FAILED)
> -		die("index file mmap failed (%s)", strerror(errno));
> +		die("index file mmap failed (%s)", strerror(i));
>  

Why don't you just move the close after the test ?
There's no point in closing if you're going to die.

skimo
