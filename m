From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 0/4] make open/unlink failures user friendly on windows using retry/abort
Date: Sun, 7 Nov 2010 16:49:20 +0100
Message-ID: <201011071649.20617.j6t@kdbg.org>
References: <87ocbitd33.fsf@fox.patthoyts.tk> <201009282252.25688.j6t@kdbg.org> <cover.1289139299.git.hvoigt@hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	msysgit@googlegroups.com, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sun Nov 07 16:49:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PF7Up-0002hf-8r
	for gcvg-git-2@lo.gmane.org; Sun, 07 Nov 2010 16:49:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753390Ab0KGPtZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Nov 2010 10:49:25 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:38136 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753309Ab0KGPtY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Nov 2010 10:49:24 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 24CA1A7EB0;
	Sun,  7 Nov 2010 16:49:21 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id D479419F5C0;
	Sun,  7 Nov 2010 16:49:20 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <cover.1289139299.git.hvoigt@hvoigt.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160885>

On Sonntag, 7. November 2010, Heiko Voigt wrote:
> j6t: I have not changed your error code in mingw_rename since you
> explicitely compare with the windows error code ERROR_ACCESS_DENIED and
> do not use the err_win_to_posix() function. Did you do this on purpose or
> should I also refer to ERROR_SHARING_VIOLATION ?

IIRC, I dumped the error code before I implemented the retry logic, and the 
error was ERROR_ACCESS_DENIED. Did you verify that the occasions where you 
want to retry the operations indeed fail due to ERROR_SHARING_VIOLATION, or 
do you trust the documentation?

In any case, it is better to check for the Windows error code (which ever you 
finally choose) rather than errno, IMO.

-- Hannes
