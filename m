From: Marcus Griep <marcus@griep.us>
Subject: Re: [PATCH] Git.pm: Make File::Spec and File::Temp requirement lazy
Date: Fri, 15 Aug 2008 15:46:19 -0400
Message-ID: <48A5DD0B.8050204@griep.us>
References: <20080814065800.GA16918@untitled>	 <1218813032-18203-1-git-send-email-marcus@griep.us> <3e8340490808151231p700ca76fub16700708f2942bb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>
To: Bryan Donlan <bdonlan@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 15 21:47:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KU5Gj-0007oS-2G
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 21:47:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754907AbYHOTq0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Aug 2008 15:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754942AbYHOTq0
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 15:46:26 -0400
Received: from wr-out-0506.google.com ([64.233.184.224]:43117 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754907AbYHOTqZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 15:46:25 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1180533wri.5
        for <git@vger.kernel.org>; Fri, 15 Aug 2008 12:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=FJZm+9PVVdMaeFFP2yKJU891DylGjxp3NL3NevqZTKo=;
        b=p3FCTiwkyXK7PEDMU9tnQUoFUH0TlinXWuyz8eMEZeQ1fUpk2kJIKLc/rGaF6jT6lV
         4e2O9ypw6PdhlOc7QIg393f0uBHn2A9wXfFn/lagJ+I86DquFKPfTmJffF9zZFKo2GYF
         r+gtQcX78j/lMcWzpf+lLkA7H9G4q/PnMmN7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding:sender;
        b=s86J0xJar6dZnbTw7XXuyEpFPwLyqnRTRaOnKzbZFel6XPOn3hUhRLgPm9DDg+zQtw
         tli7WWKxgYd8OPyiHVgK/o0G1/taVZw+5AtyZEXBJ1Pq/94me5n4XVsfcOj4pRE+2JbF
         McH08OBHiTYHsVoMhWftZMOYqCJ6LuyHW3F5E=
Received: by 10.90.101.17 with SMTP id y17mr4169836agb.72.1218829584298;
        Fri, 15 Aug 2008 12:46:24 -0700 (PDT)
Received: from ?10.95.36.106? ( [4.79.245.132])
        by mx.google.com with ESMTPS id g5sm2274151wra.35.2008.08.15.12.46.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 Aug 2008 12:46:23 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <3e8340490808151231p700ca76fub16700708f2942bb@mail.gmail.com>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92514>

Bryan Donlan wrote:
> perl's 'require' will only attempt to load a module the first time it
> is used; subsequent attempts will result in a quick no-op, so there's
> no need to further cache. Unless you mean to cache a negative result?
> In which case, the require should be quite fast, as it'll quickly get
> a 'file not found' error without needing to do any compilation.

Aha.  Point taken.  I was under the mistaken impression that an entirel=
y
new context was set up in an 'eval', but it is much more lightweight
than that.  A simplified patch is forthcoming.

--=20
Marcus Griep
GPG Key ID: 0x5E968152
=E2=80=94=E2=80=94
http://www.boohaunt.net
=D7=90=D7=AA.=CF=88=CE=BF=C2=B4
