From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: Re: [PATCH] connect: display connection progress
Date: Mon, 7 May 2007 07:54:52 +0300
Message-ID: <20070507045451.GE30339@mellanox.co.il>
References: <20070506195230.GA30339@mellanox.co.il>
	<20070506222123.GB2439@steel.home>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 07 06:55:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkvFP-0006Dp-F3
	for gcvg-git@gmane.org; Mon, 07 May 2007 06:54:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753949AbXEGEyw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 00:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753952AbXEGEyw
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 00:54:52 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:45709 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753949AbXEGEyv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 00:54:51 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1049022uga
        for <git@vger.kernel.org>; Sun, 06 May 2007 21:54:50 -0700 (PDT)
Received: by 10.66.219.11 with SMTP id r11mr2830899ugg.1178513690017;
        Sun, 06 May 2007 21:54:50 -0700 (PDT)
Received: from ?127.0.0.1? ( [85.250.212.226])
        by mx.google.com with ESMTP id q1sm1752124uge.2007.05.06.21.54.48;
        Sun, 06 May 2007 21:54:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20070506222123.GB2439@steel.home>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46407>

> @@ -511,10 +537,19 @@ static int git_tcp_connect_sock(char *host)
>  
>  		if (connect(sockfd, (struct sockaddr *)&sa, sizeof sa) < 0) {
>  			saved_errno = errno;
> +			fprintf(stderr, "%s[%d: %s]: net=%s, errno=%s\n",
> +				host,
> +				cnt,
> +				inet_ntoa(*(struct in_addr *)&sa.sin_addr),
> +				hstrerror(h_errno),
> +				strerror(saved_errno));
>  			close(sockfd);
>  			sockfd = -1;
>  			continue;
>  		}
> +		fprintf(stderr, "using %s[%s]\n",
> +			host,
> +			inet_ntoa(*(struct in_addr *)&sa.sin_addr));
>  		break;
>  	}

My manual says:
	The inet_ntoa() function shall convert the Internet host address
	specified by in to a string in the Internet standard dot notation.

does it work for IPv6?

-- 
MST
