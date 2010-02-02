From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] git-gui: use themed tk widgets with Tk 8.5
Date: Tue, 02 Feb 2010 09:25:39 +0100
Message-ID: <4B67E183.3010800@viscovery.net>
References: <878wbln0oa.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue Feb 02 09:26:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcE5E-0004pw-P3
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 09:26:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755469Ab0BBIZo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 03:25:44 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:64145 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755443Ab0BBIZm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 03:25:42 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NcE4p-0005UR-Um; Tue, 02 Feb 2010 09:25:40 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id A3E111660F;
	Tue,  2 Feb 2010 09:25:39 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <878wbln0oa.fsf@users.sourceforge.net>
X-Spam-Score: 1.9 (+)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138701>

Pat Thoyts schrieb:
> This patch enables the use of themed Tk widgets with Tk 8.5 and above.

With this patch, the sizes of the file lists are not restored correctly
anymore. The upper list (unstage files) always appears in the "native"
size. A fix for this would be appreciated.

However!

It has always been the case that the (restored) height and width of the
list of unstaged files could not be larger than the "original" window size
(i.e., the size before the stored geometry is applied).

Appearently, the pane widgets restrict its sash sizes to their total size,
and the total window geometry was applied only after sash sizes were set.

As a work-around for this problem I have modified git-gui to start up with
a much larger list of unstaged files (400x600 or so) so that the initial
"original" size is also much larger, and then the restored size can be
anything smaller than [this size plus the size of the widgets around it].
This work-around does not work anymore. The list of unstaged files always
opens with the same (tiny) size. .git/config contains this after exiting
git-gui:

[gui]
        geometry = 1183x906+88+32 184 204
        wmstate = normal

The sash sizes are stored correctly in .git/config, but are not restored.
Perhaps you have an idea to fix this?

(I'm on Windows, btw.)

-- Hannes
