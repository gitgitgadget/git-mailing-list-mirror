From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] Handle double slashes in make_relative_path()
Date: Sat, 23 Jan 2010 14:09:29 +0100
Message-ID: <201001231409.30706.j6t@kdbg.org>
References: <379d55c6a4110736aadb8ace3b050de879a9deab.1264118830.git.trast@student.ethz.ch> <4B59637D.4090503@viscovery.net> <201001231240.28138.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Jan 23 14:11:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYfmE-00029Z-8M
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 14:11:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755293Ab0AWNKj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 08:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751649Ab0AWNKj
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 08:10:39 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:62250 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751082Ab0AWNKi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 08:10:38 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 759A9A7EB7;
	Sat, 23 Jan 2010 14:10:34 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id E97BC19F6D1;
	Sat, 23 Jan 2010 14:09:30 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <201001231240.28138.robin.rosenberg@dewire.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137840>

On Samstag, 23. Januar 2010, Robin Rosenberg wrote:
> It seems this function does something unhealthy when you pass a path of the
> form //server/share. On windows dropping the double // at the beginning
> makes it a different path since // is the UNC prefix.

There is no problem in practice.

The function returns either the input unmodified, or it strips also at least 
one directory component, except when base is only "/" (or "//" or "///"...). 
I said in practice, because on Windows it does not make sense to invoke git 
with (literally)

   git --git-dir=//server/share/repo.git --work-tree=/ ...

i.e., without a drive prefix before the slash of --work-tree.

-- Hannes
