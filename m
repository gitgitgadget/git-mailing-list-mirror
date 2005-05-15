From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: git-rev-list  in local commit order
Date: Sun, 15 May 2005 21:48:53 +0200
Organization: linutronix
Message-ID: <1116186533.11872.152.camel@tglx>
References: <4127.10.10.10.24.1116107046.squirrel@linux1>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 15 21:48:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXP5J-00059J-DT
	for gcvg-git@gmane.org; Sun, 15 May 2005 21:47:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbVEOTrr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 May 2005 15:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbVEOTrr
	(ORCPT <rfc822;git-outgoing>); Sun, 15 May 2005 15:47:47 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:14498
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S261157AbVEOTro
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2005 15:47:44 -0400
Received: from mail.tec.linutronix.de (unknown [192.168.0.1])
	by mail.tglx.de (Postfix) with ESMTP id A997265C003;
	Sun, 15 May 2005 21:47:31 +0200 (CEST)
Received: from tglx.tec.linutronix.de (tglx.tec.linutronix.de [192.168.0.68])
	by mail.tec.linutronix.de (Postfix) with ESMTP id A725F2829A;
	Sun, 15 May 2005 21:47:44 +0200 (CEST)
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <4127.10.10.10.24.1116107046.squirrel@linux1>
X-Mailer: Evolution 2.2.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 2005-05-14 at 17:44 -0400, Sean wrote:
> Attached is a preliminary hackish patch to sort git-rev-list in local
> commit order. 

+unsigned long sha1_local_date(const unsigned char *sha1)
+{
+       struct stat st;
+       if (find_sha1_file(sha1, &st))
+               return st.st_mtime;
+       return 0;
+}

Do you really want to base workflow and history information on file
times ?


File times are local and completely error prone in distributed
environments. 


tglx


