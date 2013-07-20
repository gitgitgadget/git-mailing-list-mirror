From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] Cygwin has trustable filemode
Date: Sat, 20 Jul 2013 20:52:22 +0100
Message-ID: <51EAEA76.9060502@ramsay1.demon.co.uk>
References: <1373818390-14451-1-git-send-email-mlevedahl@gmail.com> <1374245631-15955-1-git-send-email-mlevedahl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 21 15:07:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0tMA-0003DG-Eh
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jul 2013 15:07:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755465Ab3GUNHQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jul 2013 09:07:16 -0400
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:34067 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755206Ab3GUNHP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jul 2013 09:07:15 -0400
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 1569F400883;
	Sun, 21 Jul 2013 14:07:14 +0100 (BST)
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 37E96400531;
	Sun, 21 Jul 2013 14:07:13 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP;
	Sun, 21 Jul 2013 14:07:12 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <1374245631-15955-1-git-send-email-mlevedahl@gmail.com>
X-MDF-HostID: 19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230934>

Mark Levedahl wrote:
> The supported Cygwin distribution on supported Windows versions provides
> complete support for POSIX filemodes, so enable this by default. git as
> distributed by the Cygwin project is configured this way.
> 
> This fixes one testsuite failure:
> t3300 test 17 (diff-index -M -p with mode change quotes funny filename)
> 
> Historical notes: Cygwin version 1.7 supports Windows-XP and newer, thus 
> dropped support for all OS variants that lack NTFS and/or the full win32 
> api, and since late 1.5 development, Cygwin maps POSIX modes to NTFS ACLs 
> by default.  Cygwin 1.5 supported OS variants that used FAT as the native 
> file system, and had optional methods for providing POSIX file modes on 
> top of FAT12/16 and NTFS, though not FAT32.  Also, support for POSIX modes 
> on top of FAT were dropped later in 1.5.  Thus, POSIX filemode support 
> could not be expected by default on a Cygwin 1.5 installation, but is 
> expected by default on a 1.7 installation.
> 
> Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
> ---
> Junio - The above notes are more accurate than in my previous commit message,
> so if this commit survives into next/master, I would prefer this version as
> opposed to the one now on pu (da875762)

Again, I have to ask; should you not "revert" commit c869753e ("Force core.filemode
to false on Cygwin.", 30-12-2006)?  After this commit, there is no longer any user
of the NO_TRUSTABLE_FILEMODE build variable, and no real prospect of anyone else
wanting to use it.

ATB,
Ramsay Jones
