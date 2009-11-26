From: =?ISO-8859-15?Q?Martin_Storsj=F6?= <martin@martin.st>
Subject: Re: [PATCH/RFC 01/11] mingw: add network-wrappers for daemon
Date: Thu, 26 Nov 2009 10:24:08 +0200 (EET)
Message-ID: <alpine.DEB.2.00.0911261015140.14228@cone.home.martin.st>
References: <1259196260-3064-1-git-send-email-kusmabite@gmail.com> <1259196260-3064-2-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: msysgit@googlegroups.com, git@vger.kernel.org,
	dotzenlabs@gmail.com, Erik Faye-Lund <kusmabite@gmail.com>
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Nov 26 09:24:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDZeF-0002af-6E
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 09:24:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759454AbZKZIYF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 03:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759377AbZKZIYF
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 03:24:05 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:46717 "EHLO jenni1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759450AbZKZIYE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 03:24:04 -0500
Received: from dsl-tkubrasgw1-ffc4c100-75.dhcp.inet.fi (88.193.196.75) by jenni1.inet.fi (8.5.014)
        id 4A776AE60435AF21; Thu, 26 Nov 2009 10:24:08 +0200
X-X-Sender: martin@cone.home.martin.st
In-Reply-To: <1259196260-3064-2-git-send-email-kusmabite@gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133776>

Hi,

First of all, great that you're working on adding daemon support for 
windows!

On Thu, 26 Nov 2009, Erik Faye-Lund wrote:

> +static void wsa_init(void)
>  {
> +	static int initialized = 0;
>  	WSADATA wsa;
>  
> +	if (initialized)
> +		return;
> +
>  	if (WSAStartup(MAKEWORD(2,2), &wsa))
>  		die("unable to initialize winsock subsystem, error %d",
>  			WSAGetLastError());
>  	atexit((void(*)(void)) WSACleanup);
> +	initialized = 1;
> +}

Something similar to this was merged into master recently as part of my 
mingw/ipv6 patches, so by rebasing your patch on top of that, this patch 
will probably get a bit smaller.

Also, the getaddrinfo-compatibility wrappers perhaps may need some minor 
updates to handle the use cases needed for setting up listening sockets.

// Martin
