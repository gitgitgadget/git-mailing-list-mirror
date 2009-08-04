From: "sn_" <sn_@gmx.net>
Subject: Re: [PATCH] Fix compiler warning by properly initialize failed_errno
Date: Tue, 04 Aug 2009 11:27:59 +0200
Message-ID: <20090804092759.24120@gmx.net>
References: <1249241675-77329-1-git-send-email-sn_@gmx.net>
 <7vmy6g6rj1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: j6t@kdbg.org, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 11:28:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYGJy-0007T9-VV
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 11:28:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932729AbZHDJ2D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 05:28:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755287AbZHDJ2D
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 05:28:03 -0400
Received: from mail.gmx.net ([213.165.64.20]:53663 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755240AbZHDJ2B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 05:28:01 -0400
Received: (qmail 24954 invoked by uid 0); 4 Aug 2009 09:28:00 -0000
Received: from 85.180.64.96 by www113.gmx.net with HTTP;
 Tue, 04 Aug 2009 11:27:59 +0200 (CEST)
In-Reply-To: <7vmy6g6rj1.fsf@alter.siamese.dyndns.org>
X-Authenticated: #4427663
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
X-Provags-ID: V01U2FsdGVkX19Zq9hcykxZf4P151hwGxwvR/ULeGCGqLDQ4nwzL3
 h6nKf2XtwJnQAXTW3EEbC3LVVuMpPElVruSw== 
X-GMX-UID: GcdBAyROQEV/Hri5KnVpNxVCNzg2NcL2
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124772>


> The potentially uninitialized use your compiler is worried about is inside
> if (cmd->pid < 0) after #ifdef/#else/#endif.
> 
>  (1) if not on MINGW32, we would have already assigned to failed_errno
>      after fork() returns negative value to cmd->pid;
> 
>  (2) if on MINGW32, we would have assigned to failed_errno unconditionally
>      after calling mingw_spawnvpe().
> 
> so its worry is unfounded.

The worry is definatly unfounded, but I think it's still worth to apply the attached patch to get rid of the warning using the i686-apple-darwin9-gcc-4.0.1 (GCC) 4.0.1 (Apple Inc. build 5490) compiler. I sended a corrected version of the patch to the ml.

-- 
Jetzt kostenlos herunterladen: Internet Explorer 8 und Mozilla Firefox 3 -
sicherer, schneller und einfacher! http://portal.gmx.net/de/go/atbrowser
