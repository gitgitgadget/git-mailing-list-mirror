From: Josh Triplett <josht@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/4] git-imap-send: Add support for SSL.
Date: Wed, 09 Jul 2008 08:14:44 -0700
Message-ID: <1215616484.3053.6.camel@josh-work.beaverton.ibm.com>
References: <1215555496-21335-2-git-send-email-robertshearman@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Robert Shearman <robertshearman@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 17:15:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGbOS-00022W-66
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 17:15:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752764AbYGIPOp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 11:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753456AbYGIPOp
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 11:14:45 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:49905 "EHLO e4.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751834AbYGIPOo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 11:14:44 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m69FEh8E000676
	for <git@vger.kernel.org>; Wed, 9 Jul 2008 11:14:43 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id m69FEhxM233136
	for <git@vger.kernel.org>; Wed, 9 Jul 2008 11:14:43 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m69FEhuv019012
	for <git@vger.kernel.org>; Wed, 9 Jul 2008 11:14:43 -0400
Received: from [9.47.18.119] (josh-work.beaverton.ibm.com [9.47.18.119])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id m69FEgLS018911
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 9 Jul 2008 11:14:43 -0400
In-Reply-To: <1215555496-21335-2-git-send-email-robertshearman@gmail.com>
X-Mailer: Evolution 2.22.3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87887>

On Tue, 2008-07-08 at 23:18 +0100, Robert Shearman wrote:
> --- a/Documentation/git-imap-send.txt
> +++ b/Documentation/git-imap-send.txt
> @@ -37,10 +37,11 @@ configuration file (shown with examples):
>      Tunnel = "ssh -q user@server.com /usr/bin/imapd ./Maildir 2> /dev/null"
>  
>  [imap]
> -    Host = imap.server.com
> +    Host = imaps://imap.example.com
>      User = bob
>      Pass = pwd
> -    Port = 143
> +    Port = 993
> +    sslverify = false
[...]
> @@ -1280,6 +1411,8 @@ git_imap_config(const char *key, const char *val, void *cb)
>  		server.port = git_config_int( key, val );
>  	else if (!strcmp( "tunnel", key ))
>  		server.tunnel = xstrdup( val );
> +	else if (!strcmp( "ssl_verify", key ))
> +		server.ssl_verify = git_config_bool( key, val );

The example and the code disagree on the name of the
sslverify/ssl_verify option.  Also, ssl_verify needs explanation.

- Josh Triplett
