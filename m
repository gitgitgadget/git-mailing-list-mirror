From: "Jonathan del Strother" <maillist@steelskies.com>
Subject: Re: Serious bug with pretty format strings & empty bodies?
Date: Thu, 20 Dec 2007 11:38:25 +0000
Message-ID: <57518fd10712200338m19c1def9n747dc9353ae41615@mail.gmail.com>
References: <57518fd10712190632o490af924n61326fddf1819014@mail.gmail.com>
	 <20071219184457.GC3015@steel.home>
	 <57518fd10712191437s6f192feds50d006fdfc624444@mail.gmail.com>
	 <4769A7FB.1070904@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Alex Riesen" <raa.lkml@gmail.com>, git@vger.kernel.org
To: "=?ISO-8859-1?Q?Ren=E9_Scharfe?=" <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Dec 20 12:39:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5Jjp-0007Fs-7V
	for gcvg-git-2@gmane.org; Thu, 20 Dec 2007 12:38:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756993AbXLTLi1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2007 06:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756798AbXLTLi0
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Dec 2007 06:38:26 -0500
Received: from rv-out-0910.google.com ([209.85.198.189]:14320 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756536AbXLTLiZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2007 06:38:25 -0500
Received: by rv-out-0910.google.com with SMTP id k20so3013651rvb.1
        for <git@vger.kernel.org>; Thu, 20 Dec 2007 03:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=CqHxmNhcXFNWiaGrtXkqPVpgmY27Px4yOBebKPRTHfI=;
        b=oWwa/VGookVQPc9P23+ie917MoneIe+HyqzzjG/VDqe53AIw7rksKzWCxgMeRiiQVUjpwJJN0NicwtXsoiw8ePNNH/LX56hgPYMMON+n3S1LFXjsmoP8B54064tblSBBARt2ZgQK6J4S5HBhvTYKi9fIxrVSuvvitEttgy8lb0Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=He9tpSYMFEJtpHNEk6iz9utalFVG/KeD148ME87NTW3XzV0UV2XN1JHmh3ivCmGD3/GzqwrCLh0Ehqk8x8PK1XwE2oQSeYIz4io3T122Ge/TpFmgHiPv0xneT2DnvRuBkq+NxgXzCUCEV82yIw4Bq5YuD9ct9GxH/O5byAqlbwg=
Received: by 10.141.107.13 with SMTP id j13mr4532445rvm.276.1198150705287;
        Thu, 20 Dec 2007 03:38:25 -0800 (PST)
Received: by 10.140.134.14 with HTTP; Thu, 20 Dec 2007 03:38:25 -0800 (PST)
In-Reply-To: <4769A7FB.1070904@lsrfire.ath.cx>
Content-Disposition: inline
X-Google-Sender-Auth: 4c213c422bdbb710
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68992>

I ended up trying to filter-branch my repository, see if I could come
up with a version stripped of all our private code, suitable for
making public.  Disappointingly, filter-branch magically fixes all the
commits, even when simply run as "git filter-branch HEAD".

However, looking at the rewritten repository vs the original, they
share a lot of commits, then diverge halfway through their history.  I
can't see anything notable about the commit where they diverge, with
the exception that the rewritten commit has a newline after the
subject and the original doesn't.  Neither has a commit message body.
