From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Extend sample pre-commit hook to check for non ascii
 filenames
Date: Mon, 18 May 2009 14:04:08 +0200
Message-ID: <4A114EB8.60609@viscovery.net>
References: <20090512214250.GA22974@macbook.lan> <200905122356.00659.jnareb@gmail.com> <20090514175850.GA26267@macbook.lan> <7vbpputewv.fsf@alter.siamese.dyndns.org> <419AD153-53B4-4DAB-AF72-4127C17B1CA0@gmail.com> <200905122356.00659.jnareb@gmail.com> <20090514175850.GA26267@macbook.lan> <200905151657.47225.jnareb@gmail.com> <20090518095044.GB910@heiko-voigts-macbook.local> <4A113B09.6040301@viscovery.net> <20090518115002.GA3374@heiko-voigts-macbook.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Esko Luontola <esko.luontola@gmail.com>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon May 18 14:04:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M61aC-0005Sw-Hv
	for gcvg-git-2@gmane.org; Mon, 18 May 2009 14:04:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754629AbZERMEQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2009 08:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754515AbZERMEP
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 08:04:15 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:14374 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752494AbZERMEN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2009 08:04:13 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1M61Zi-00029C-LJ; Mon, 18 May 2009 14:04:10 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 4A7C1FCD2; Mon, 18 May 2009 14:04:10 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <20090518115002.GA3374@heiko-voigts-macbook.local>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119439>

Heiko Voigt schrieb:
> Are there any problems with '\0' and tr other than swallowing of it.

I can't tell. But the commits ae90e16..aab0abf are interesting to study in
w.r.t. portability.

> In
> case not I would just change
> 
> 	tr "\0" "\n"
> to
>   	tr -d '\0'

In which case I'd suggest that you call tr only once, in isascii():

     tr -d '[ -~]\0'

-- Hannes
