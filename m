From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: msgmft segfaulting on ubuntu gutsy (clean)
Date: Tue, 4 Mar 2008 02:07:35 -0500
Message-ID: <20080304070735.GU8410@spearce.org>
References: <46a038f90802211559w457c5460k7447ba8b38352713@mail.gmail.com> <20080222065836.GE8410@spearce.org> <46a038f90802220957y7db67d8nb6b7ad784124546a@mail.gmail.com> <47C5A974.7080207@gmail.com> <alpine.LSU.1.00.0802271825330.22527@racer.site> <47C5AEFA.5020004@gmail.com> <alpine.LSU.1.00.0802272203270.22527@racer.site> <7vablmqc7q.fsf@gitster.siamese.dyndns.org> <20080228003212.GP8410@spearce.org> <47CCF40C.2070203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Gabriel =?utf-8?Q?Salda=C3=B1a?= <gsaldana@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 08:09:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWRH2-0003qt-Nh
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 08:09:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755903AbYCDHIe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 02:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755521AbYCDHId
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 02:08:33 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:47509 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756056AbYCDHId (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 02:08:33 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JWRFQ-0002Yq-5r; Tue, 04 Mar 2008 02:07:36 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id EF3B320FBAE; Tue,  4 Mar 2008 02:07:35 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <47CCF40C.2070203@gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76038>

Gabriel Saldaa <gsaldana@gmail.com> wrote:
> I'm getting the msgmft error message when compiling git 1.5.4.3 on a 
> clean install of Ubuntu Gutsy. Installed dependencies using "apt-get 
> build-dep git-core".
> 
> Here's make output:
> 
> GITGUI_VERSION = 0.9.2.7.g3bae
>     * new locations or Tcl/Tk interpreter
>     GEN git-gui
>     INDEX lib/
>     MSGFMT    po/de.msg 371 translated.
>     MSGFMT    po/fr.msg 371 translated.
>     MSGFMT    po/hu.msg 371 translated.
>     MSGFMT    po/it.msg 370 translated, 1 untranslated.
>     MSGFMT    po/ja.msg 371 translated.
>     MSGFMT    po/ru.msg 367 translated, 4 untranslated.
>     MSGFMT    po/sv.msg 371 translated.
>     MSGFMT po/zh_cn.msg 53 translated, 57 fuzzy, 253 untranslated.
>     SUBDIR gitk-git
>     GEN gitk-wish
> Generating catalog po/de.msg
> msgfmt --statistics --tcl po/de.po -l de -d po/
> make[1]: msgfmt: Command not found
> make[1]: *** [po/de.msg] Error 127
> make: *** [all] Error 2
> 
> It is very similar to Tiger's error message.

Rebuild with "NO_MSGFMT=1", or install GNU msgfmt first.

The issue is gitk's Makefile is missing the fallback rule that
git-gui has, which is use our Tcl based msgfmt work-a-like if msgfmt
is not found.  That's exactly what you see above; git-gui fell back
automatically to its work-a-like but gitk did not.

-- 
Shawn.
