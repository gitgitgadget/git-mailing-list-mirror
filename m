From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] modify/delete conflict resolution overwrites untracked file
Date: Mon, 15 Dec 2008 17:09:22 -0800 (PST)
Message-ID: <m3r649c4e7.fsf@localhost.localdomain>
References: <20081210201259.GA12928@localhost>
	<20081215004651.GA16205@localhost>
	<7v63lm1c76.fsf@gitster.siamese.dyndns.org>
	<7vmyeyyuuh.fsf@gitster.siamese.dyndns.org>
	<20081215095949.GA7403@localhost>
	<7vskopwxej.fsf@gitster.siamese.dyndns.org>
	<7vej09w0hy.fsf@gitster.siamese.dyndns.org>
	<20081215230205.GA19538@localhost>
	<7vprjtug8u.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org,
	johannes.schindelin@gmx.de, raa.lkml@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 16 02:10:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCOSS-0002m5-Fb
	for gcvg-git-2@gmane.org; Tue, 16 Dec 2008 02:10:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbYLPBJ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 20:09:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbYLPBJ0
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 20:09:26 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:56893 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769AbYLPBJZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 20:09:25 -0500
Received: by ewy10 with SMTP id 10so3404410ewy.13
        for <git@vger.kernel.org>; Mon, 15 Dec 2008 17:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=yC6zL773bb5vOhTpPvVUKPrI+g38kb/WG7XqkRQ+tl8=;
        b=I/JO9wFI+HeZmd04WpoC7sGMPvL95P/u89PsQhlomNzCtrKPW++ESb5+YMZ4KGr1Qa
         IIMAGfIYugZr7f3sqhLmRDzoVXTyNyho4VPSNSS9ANfibEGpApuzU5dfgD2vj5q40YMu
         r600hLd4yHeUOkaQZnrjNzIrLrOI4tMsVDBSo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=wbXvmqMy3QZSKjxOVake87+F+YHIj90bqBsUyA/LyzNH7eViQM99ce89fWMoVtsgI2
         Qt60nm+5JT6j7MOwt9kQrpn3IY/WNL0Gpne7MznCRkflivZDatl06boTtLPVeUDwO0Bf
         WTsW/+aByst9CJdVy2mZvNYEPSs769Ow3maxQ=
Received: by 10.210.50.5 with SMTP id x5mr8577366ebx.3.1229389763693;
        Mon, 15 Dec 2008 17:09:23 -0800 (PST)
Received: from localhost.localdomain (abve222.neoplus.adsl.tpnet.pl [83.8.202.222])
        by mx.google.com with ESMTPS id 20sm1217501eyc.13.2008.12.15.17.09.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 15 Dec 2008 17:09:22 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mBG19NB5006288;
	Tue, 16 Dec 2008 02:09:23 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mBG19LVi006284;
	Tue, 16 Dec 2008 02:09:21 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vprjtug8u.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103226>

Junio C Hamano <gitster@pobox.com> writes:

> Clemens Buchacher <drizzd@aon.at> writes:
> 
> > I strongly disagree. With the suggested behavior I would have to
> > double-check every single untracked file in my tree for conflicts before
> > trying a throw-away merge followed by git reset --hard, for example.
> 
> AFAICS, that's not "suggested behaviour" for merge, but it is the
> behaviour that has been true for eternity.
> 
> You can suggest to fix "reset --hard", though.

Errr... what about using "reset --merge" instead?
-- 
Jakub Narebski
Poland
ShadeHawk on #git
