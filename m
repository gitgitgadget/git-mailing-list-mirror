From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] blame: avoid -lm by not using log().
Date: Mon, 6 Mar 2006 00:36:03 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0603060032410.32270@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060305110351.GA23448@c165.ib.student.liu.se>
 <7vbqwlgkhk.fsf@assigned-by-dhcp.cox.net> <20060305123800.GD23448@c165.ib.student.liu.se>
 <7vhd6cechf.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Mon Mar 06 00:36:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FG2lk-0002Bo-LL
	for gcvg-git@gmane.org; Mon, 06 Mar 2006 00:36:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbWCEXgF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Mar 2006 18:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751077AbWCEXgF
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Mar 2006 18:36:05 -0500
Received: from wrzx35.rz.uni-wuerzburg.de ([132.187.3.35]:40383 "EHLO
	mailrelay.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751299AbWCEXgE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Mar 2006 18:36:04 -0500
Received: from virusscan.mail (mail03.mail [172.25.1.102])
	by mailrelay.mail (Postfix) with ESMTP id 4739C1B20;
	Mon,  6 Mar 2006 00:36:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 3AE33A9E;
	Mon,  6 Mar 2006 00:36:03 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id F1522A73;
	Mon,  6 Mar 2006 00:36:02 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhd6cechf.fsf_-_@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17252>

Hi,

On Sun, 5 Mar 2006, Junio C Hamano wrote:

> -	max_digits = 1 + log(num_blame_lines+1)/log(10);
> +	for (max_digits = 1, i = 10; i <= num_blame_lines; max_digits++)
> +		i *= 10;

According to my late-night maths skills, these two methods do not do the 
same thing: if num_blame_lines == 9, the log method assigns 2 to 
max_digits, but the for loop stops at max_digits == 1. A trivial fix would 
be to test for i <= num_blame_lines + 1.

Ciao,
Dscho
