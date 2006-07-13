From: Edgar Toernig <froese@gmx.de>
Subject: Re: [PATCH 5/5] daemon: new option --detach to run git-daemon in
 background
Date: Thu, 13 Jul 2006 15:37:03 +0200
Message-ID: <20060713153703.05f862ee.froese@gmx.de>
References: <E1G0zj7-0001c1-8q@moooo.ath.cx>
	<E1G0znB-0002If-8A@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 13 15:37:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G11NR-0008JP-59
	for gcvg-git@gmane.org; Thu, 13 Jul 2006 15:37:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030209AbWGMNhI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Jul 2006 09:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030221AbWGMNhI
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Jul 2006 09:37:08 -0400
Received: from mail.gmx.de ([213.165.64.21]:43715 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030209AbWGMNhH (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Jul 2006 09:37:07 -0400
Received: (qmail invoked by alias); 13 Jul 2006 13:37:06 -0000
Received: from p50902F5F.dip0.t-ipconnect.de (EHLO dialup) [80.144.47.95]
  by mail.gmx.net (mp001) with SMTP; 13 Jul 2006 15:37:06 +0200
X-Authenticated: #271361
To: Matthias Lederhofer <matled@gmx.net>
In-Reply-To: <E1G0znB-0002If-8A@moooo.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23835>

Matthias Lederhofer wrote:
>
> [daemonize]
> +	if ((devnull = open("/dev/null", O_RDWR, 0)) == -1)
> +		die("open /dev/null failed: %s", strerror(errno));
> +	if (dup2(devnull, 0) != 0 ||
> +		dup2(devnull, 1) != 1 ||
> +		dup2(devnull, 2) != 2)
> +		die("dup2 failed: %s", strerror(errno));
> +}

Hmm... leaks devnull.  Why not simply close(0/1/2) and
let sanitize_stdfds take care of the rest?

Ciao, ET.
