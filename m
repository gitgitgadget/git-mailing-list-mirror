From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 4/5] Test and fix normalize_path_copy()
Date: Sun, 8 Feb 2009 09:52:53 +0100
Message-ID: <200902080952.53478.j6t@kdbg.org>
References: <498CAF73.6050409@lsrfire.ath.cx> <1234019311-6449-5-git-send-email-j6t@kdbg.org> <200902080108.50550.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: rene.scharfe@lsrfire.ath.cx,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sun Feb 08 09:54:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LW5Qo-00021z-8K
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 09:54:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752668AbZBHIw7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 03:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752658AbZBHIw6
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 03:52:58 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:9047 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752637AbZBHIw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 03:52:58 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 0A61D10014;
	Sun,  8 Feb 2009 09:52:53 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id E6698426CB;
	Sun,  8 Feb 2009 09:52:53 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <200902080108.50550.robin.rosenberg.lists@dewire.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108932>

On Sonntag, 8. Februar 2009, Robin Rosenberg wrote:
> For Windows leading // is special indicating a UNC
> path and should not be changed to /.
>
> //foo/bar is different from /foo/bar

Indeed. But stripping the double-dash would bite you only if you are using 
GIT_CEILING_DIRECTORIES or if you tend to call eg. git add with absolute 
paths; and that only if your repository lives in a UNC share, which is a 
rather odd use-case.

In particular, it does *not* affect fetch and push etc. so that you can have a 
remote repository on an UNC share.

-- Hannes
