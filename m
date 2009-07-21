From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] configure: use AC_SEARCH_LIBS instead of AC_CHECK_LIB
Date: Tue, 21 Jul 2009 10:34:30 -0500
Message-ID: <qSl_KXgcJD_1H47Nrg3FwRdtL-WxwLP1_aueDE8gN-By3M0uJOpw1w@cipher.nrlssc.navy.mil>
References: <m34ot9c67t.fsf_-_@localhost.localdomain> <a52be8ba36206abc5ff5c91a759036a931e2658c.1248007036.git.nicolas.s.dev@gmx.fr> <6WnEB0at_uuAu9kicWjrHLsBbTv58WtCNOANkKzk-SqTgqjuWyh8WA@cipher.nrlssc.navy.mil> <4A65DCB9.3030207@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
	David Syzdek <david@syzdek.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Tue Jul 21 17:34:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTHMi-0005bi-07
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 17:34:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754742AbZGUPeo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 11:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754328AbZGUPen
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 11:34:43 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:33850 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752635AbZGUPen (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 11:34:43 -0400
Received: by mail.nrlssc.navy.mil id n6LFYVNj031497; Tue, 21 Jul 2009 10:34:31 -0500
In-Reply-To: <4A65DCB9.3030207@gnu.org>
X-OriginalArrivalTime: 21 Jul 2009 15:34:30.0954 (UTC) FILETIME=[BD9398A0:01CA0A18]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123668>

Paolo Bonzini wrote:
> 
>> With AC_SEARCH_LIBS, which of [action-if-found] or [action-if-not-found]
>> is executed if the function is found in the standard c library i.e.
>> "calling
>> `AC_LINK_IFELSE([AC_LANG_CALL([], [function])])' first with no
>> libraries"?
>> Is the answer neither?  If the answer is [action-if-found], won't the
>> NEEDS_LIBGEN=YesPlease be set when the function is found in the c
>> library?
> 
> It evaluates the action-if-found and adds nothing to LIBS.  Instead, if
> it is found in a library, it evaluates the action-if-found after adding
> (actually prepending) -lBLAH to LIBS.

That's what I suspected.  It means we can't have NEEDS_SOMETHING=true in
the action-if-found parameter when using AC_SEARCH_LIBS since that may cause
the Makefile to append a library requirement when none is necessary.

-brandon
