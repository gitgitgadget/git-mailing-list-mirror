From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH] path_treatment: also ignore $GIT_DIR if it's not .git
Date: Mon, 02 Dec 2013 00:08:55 +0100
Message-ID: <877gbop3so.fsf@linux-1gf2.Speedport_W723_V_Typ_A_1_00_098>
References: <1385922611.3240.6.camel@localhost>
	<20131201190447.GA31367@kaarsemaker.net>
	<CACsJy8CxR+wj-P+fxF37DU=Tzk=su+V=UudbO7NkqTMS8qTn_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	Git Mailing List <git@vger.kernel.org>, ingy@ingy.net
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 02 00:09:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnG8Z-0000QY-MM
	for gcvg-git-2@plane.gmane.org; Mon, 02 Dec 2013 00:09:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752156Ab3LAXJL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Dec 2013 18:09:11 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:39563 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751063Ab3LAXJK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Dec 2013 18:09:10 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 7CBEC4D64FC;
	Mon,  2 Dec 2013 00:09:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id zuMD16K4xeHt; Mon,  2 Dec 2013 00:08:59 +0100 (CET)
Received: from linux-1gf2.Speedport_W723_V_Typ_A_1_00_098.thomasrast.ch (unknown [89.204.130.6])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id A122B4D64C4;
	Mon,  2 Dec 2013 00:08:58 +0100 (CET)
In-Reply-To: <CACsJy8CxR+wj-P+fxF37DU=Tzk=su+V=UudbO7NkqTMS8qTn_w@mail.gmail.com>
	(Duy Nguyen's message of "Mon, 2 Dec 2013 06:02:32 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238603>

Duy Nguyen <pclouds@gmail.com> writes:

> On Mon, Dec 2, 2013 at 2:04 AM, Dennis Kaarsemaker
> <dennis@kaarsemaker.net> wrote:
>> We always ignore anything named .git, but we should also ignore the git
>> directory if the user overrides it by setting $GIT_DIR
[...]
>> +       if (simplify_away(path->buf, path->len, simplify) || is_git_directory(path->buf))
>>                 return path_none;
>
> this adds 2 access, 1 lstat, 1 open, 1 read, 1 close to _every_ path
> we check. Is it worth the cost?

Moreover it is a much more inclusive check than what the commit message
claims: it will ignore anything that looks like a .git directory,
regardless of the name.  In particular GIT_DIR doesn't have anything to
do with it.

-- 
Thomas Rast
tr@thomasrast.ch
