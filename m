From: Mark Wooding <mdw@distorted.org.uk>
Subject: Re: [PATCH] Trivial warning fix for imap-send.c
Date: Sun, 12 Mar 2006 10:44:09 +0000 (UTC)
Organization: Straylight/Edgeware development
Message-ID: <slrne17urp.fr9.mdw@metalzone.distorted.org.uk>
References: <20060311192954.GQ16135@artsapartment.org>
X-From: git-owner@vger.kernel.org Sun Mar 12 11:44:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIO3q-00031C-7X
	for gcvg-git@gmane.org; Sun, 12 Mar 2006 11:44:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbWCLKo1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Mar 2006 05:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbWCLKo0
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Mar 2006 05:44:26 -0500
Received: from excessus.demon.co.uk ([83.105.60.35]:58054 "HELO
	metalzone.distorted.org.uk") by vger.kernel.org with SMTP
	id S932104AbWCLKo0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Mar 2006 05:44:26 -0500
Received: (qmail 20850 invoked by uid 110); 12 Mar 2006 10:44:09 -0000
To: git@vger.kernel.org
Received: (qmail 20837 invoked by uid 9); 12 Mar 2006 10:44:09 -0000
Path: not-for-mail
Newsgroups: mail.vger.git
NNTP-Posting-Host: metalzone.distorted.org.uk
X-Trace: metalzone.distorted.org.uk 1142160249 20601 172.29.199.2 (12 Mar 2006 10:44:09 GMT)
X-Complaints-To: usenet@distorted.org.uk
NNTP-Posting-Date: Sun, 12 Mar 2006 10:44:09 +0000 (UTC)
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17508>

"Art Haas" <ahaas@airmail.net> wrote:

> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -945,7 +945,7 @@ imap_open_store( imap_server_conf_t *srv
>  				_exit( 127 );
>  			close( a[0] );
>  			close( a[1] );
> -			execl( "/bin/sh", "sh", "-c", srvc->tunnel, 0 );
> +			execl( "/bin/sh", "sh", "-c", srvc->tunnel, NULL );
>  			_exit( 127 );
>  		}

This is not the right fix.  NULL can be simply a #define for 0 (see
6.3.2.3#3 and 7.17).  You need to write (char *)0 or (char *)NULL.  I
prefer to avoid the macro NULL entirely, since its misleading behaviour
is precisely what got us into this mess.

-- [mdw]
