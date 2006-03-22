From: Jeff Garzik <jeff@garzik.org>
Subject: git daemon and v6-only
Date: Wed, 22 Mar 2006 00:04:52 -0500
Message-ID: <4420DAF4.7070406@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Mar 22 06:05:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FLvWp-0006kY-QT
	for gcvg-git@gmane.org; Wed, 22 Mar 2006 06:05:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWCVFEy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Mar 2006 00:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbWCVFEy
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Mar 2006 00:04:54 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:33984 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750761AbWCVFEx (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Mar 2006 00:04:53 -0500
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75] helo=[10.10.10.99])
	by mail.dvmed.net with esmtpsa (Exim 4.60 #1 (Red Hat Linux))
	id 1FLvWe-0003rB-Q6
	for git@vger.kernel.org; Wed, 22 Mar 2006 05:04:53 +0000
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
X-Spam-Score: -2.5 (--)
X-Spam-Report: SpamAssassin version 3.0.5 on srv5.dvmed.net summary:
	Content analysis details:   (-2.5 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17803>

Regarding the following code in daemon.c socksetup():

> #ifdef IPV6_V6ONLY
>                 if (ai->ai_family == AF_INET6) {
>                         int on = 1;
>                         setsockopt(sockfd, IPPROTO_IPV6, IPV6_V6ONLY,
>                                    &on, sizeof(on));
>                         /* Note: error is not fatal */
>                 }
> #endif

On Linux this causes you to bind separately to v4 and v6 interfaces, 
avoiding the default (desired) behavior of using a single socket for 
both v4 and v6.

	Jeff
