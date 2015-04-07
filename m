From: KES <kes-kes@yandex.ua>
Subject: git diff bug? what problem may be here
Date: Tue, 07 Apr 2015 09:04:34 +0300
Message-ID: <2396461428386674@web25m.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 07 08:04:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfMcu-0007Bn-1X
	for gcvg-git-2@plane.gmane.org; Tue, 07 Apr 2015 08:04:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbbDGGEj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2015 02:04:39 -0400
Received: from forward13m.cmail.yandex.net ([5.255.216.144]:44490 "EHLO
	forward13m.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751036AbbDGGEi (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Apr 2015 02:04:38 -0400
Received: from web25m.yandex.ru (web25m.yandex.ru [37.140.138.116])
	by forward13m.cmail.yandex.net (Yandex) with ESMTP id B99D620D35
	for <git@vger.kernel.org>; Tue,  7 Apr 2015 09:04:35 +0300 (MSK)
Received: from 127.0.0.1 (localhost [127.0.0.1])
	by web25m.yandex.ru (Yandex) with ESMTP id 422A720E2C65;
	Tue,  7 Apr 2015 09:04:35 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1428386675; bh=IywrF72UD1CYXj0zwEaiSbuMoE88rbxttCBL5xxpo40=;
	h=From:To:Subject:Date;
	b=sSvbrDwvlWrfFPcXcrmGG7wiSmHqUlrTJiPfdZiAWelaBBolsB4Z0rRUB/3Q+w74c
	 cZG0C6M7akKF6Qod9fRyNmrmSH72WBrB5kjG5c+FNRBMulP1pFDGZFBB5i8NoZT0Q7
	 XD8np6uAQK+ZFq6+aiIR1KGjx04LGRd/bVOvxny0=
Received: by web25m.yandex.ru with HTTP;
	Tue, 07 Apr 2015 09:04:34 +0300
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266901>

When after editing I get this:
 mdi.Application= this;

 mdi.Class.TApplication.baseConstructor.apply( this, arguments );


git diff shows:
 
  mdi.Application= this;
- mdi.Class.TApplication.baseConstructor.apply( this, arguments );
 
- //We must not create/show application node because of this is the 'document.bo
- //It exists always so apply application properties to 'document.body' only
- this.updateDomNode();
+ mdi.Class.TApplication.baseConstructor.apply( this, arguments );
 },{

Notice same lines:
- mdi.Class.TApplication.baseConstructor.apply( this, arguments );
+ mdi.Class.TApplication.baseConstructor.apply( this, arguments );


But when I edit like this (notice no new line between mdi.Application and mdi.Class):

 mdi.Application= this;
 mdi.Class.TApplication.baseConstructor.apply( this, arguments );

Git diff shows:
  mdi.Application= this;
  mdi.Class.TApplication.baseConstructor.apply( this, arguments );
-
- //We must not create/show application node because of this is the 'document.body'.
- //It exists always so apply application properties to 'document.body' only
- this.updateDomNode();
 },{

Why new line cause same line in patch added and removed?
