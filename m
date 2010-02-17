From: Larry D'Anna <larry@elder-gods.org>
Subject: Re: [PATCH v3 2/4] Refactoring: connect.c: move duplicated code to
 a new function 'get_host_and_port'
Date: Tue, 16 Feb 2010 19:04:56 -0500
Message-ID: <20100217000456.GA28433@cthulhu>
References: <cover.1266360267.git.michael.lukashov@gmail.com>
 <0d6d0066fecc892bd5b6afda64e1aa5591347504.1266360267.git.michael.lukashov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Lukashov <michael.lukashov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 01:05:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhXPi-0003tb-Vl
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 01:05:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933705Ab0BQAE6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 19:04:58 -0500
Received: from cthulhu.elder-gods.org ([140.239.99.253]:42563 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933697Ab0BQAE5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 19:04:57 -0500
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id 6E6DA822010; Tue, 16 Feb 2010 19:04:56 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <0d6d0066fecc892bd5b6afda64e1aa5591347504.1266360267.git.michael.lukashov@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140186>

* Michael Lukashov (michael.lukashov@gmail.com) [100216 18:43]:

> @@ -170,30 +192,14 @@ static const char *ai_name(const struct addrinfo *ai)
>  static int git_tcp_connect_sock(char *host, int flags)
>  {
>  	int sockfd = -1, saved_errno = 0;
> -	char *colon, *end;
>  	const char *port = STR(DEFAULT_GIT_PORT);
>  	struct addrinfo hints, *ai0, *ai;
>  	int gai;
>  	int cnt = 0;
>  
> -	if (host[0] == '[') {
> -		end = strchr(host + 1, ']');
> -		if (end) {
> -			*end = 0;
> -			end++;
> -			host++;
> -		} else
> -			end = host;
> -	} else
> -		end = host;
> -	colon = strchr(end, ':');
> -
> -	if (colon) {
> -		*colon = 0;
> -		port = colon + 1;
> -		if (!*port)
> -			port = "<none>";
> -	}
> +	get_host_and_port(&host, &port);
> +	if (!*port)
> +		*port = "<none>";

Again, isn't this wrong?  This doesn't even compile for me.  Shouldn't it be

port = "<none>";

??

What am I missing?

     --larry
