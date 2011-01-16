From: Joe Corneli <holtzermann17@gmail.com>
Subject: Re: [PATCH] Optionally parse author information
Date: Sun, 16 Jan 2011 02:17:22 +0000
Message-ID: <AANLkTi=ddJYT8YiUDYy80xobkxJnvuREN-09=464P_vB@mail.gmail.com>
References: <AANLkTimKbS3ECzOaGtNgvx7DThJGH_DkPmg4ehKXGtwc@mail.gmail.com>
	<201101120830.47016.wjl@icecavern.net>
	<20110113032300.GB9184@burratino>
	<AANLkTikCvjDqUpL-=srVKcMQx+NM6bV7FabmJ+4sPqD7@mail.gmail.com>
	<20110114080554.GA1735@kytes>
	<20110114082931.GC11343@burratino>
	<F0299861-B36C-459C-972E-856212A92615@kth.se>
	<20110114101636.GA22970@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?Love_H=F6rnquist_=C5strand?= <lha@kth.se>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 16 03:17:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PeIBN-0001xf-It
	for gcvg-git-2@lo.gmane.org; Sun, 16 Jan 2011 03:17:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754349Ab1APCRY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Jan 2011 21:17:24 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36307 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754339Ab1APCRX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jan 2011 21:17:23 -0500
Received: by iwn9 with SMTP id 9so3688665iwn.19
        for <git@vger.kernel.org>; Sat, 15 Jan 2011 18:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Evk/6XT+MvpN6jPy3lngymGntPjG4x7iXy4hC9Y3Wd0=;
        b=UVzkoMB6ykeWM22eTxaoCsSoq0IJLjV2jvAFpP6KWLuoqhpdivxIs95oiWT6b6DkLP
         mTUbih1li0/6jPFQwIhty5tAZNKNsNLEt3TaM1TnOHVPHwXuFXl6JsnKJI/nR3VwQIK9
         FcOhq3S1+TxepZrwr/knmenO3xK54OEFuO88Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=C7dL/wLHrA7aI924UQ3LY9mTm8EOyl4NzyHLPLzQaBMITbeOQ66aLo3A+pOirz3HEH
         LNoUPJP5YeMRbhBhey27ulLuygKSy8g2Ao3u3/B2B40OAOMOpVx8VonziEErd64kaDVx
         EInh4qkTDG/oHDskpLvP4LnjKso67kH2YWFIE=
Received: by 10.231.15.133 with SMTP id k5mr2419111iba.187.1295144242952; Sat,
 15 Jan 2011 18:17:22 -0800 (PST)
Received: by 10.231.145.1 with HTTP; Sat, 15 Jan 2011 18:17:22 -0800 (PST)
In-Reply-To: <20110114101636.GA22970@kytes>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165155>

I tested it, and it seems to use email handle instead of author name
(perhaps that's intentional, though in my case it's not so desirable)
but, quite critically, it gets the dates wrong:

~/pmhistory.svn$ svn log -l 5
------------------------------------------------------------------------
r53127 | majordomo | 2011-01-10 18:31:58 -0500 (Mon, 10 Jan 2011) | 1 line


------------------------------------------------------------------------
r53126 | majordomo | 2011-01-10 18:31:58 -0500 (Mon, 10 Jan 2011) | 1 line


------------------------------------------------------------------------
r53125 | majordomo | 2011-01-10 18:31:58 -0500 (Mon, 10 Jan 2011) | 1 line


------------------------------------------------------------------------
r53124 | majordomo | 2011-01-10 18:31:57 -0500 (Mon, 10 Jan 2011) | 1 line


------------------------------------------------------------------------
r53123 | majordomo | 2011-01-10 18:31:57 -0500 (Mon, 10 Jan 2011) | 1 line

~/pmhistory.git$ git log -5
commit 411b8698e494ee12799300611fed0c8029e76ad3
Author: milogardner <majordomo@planetmath.org>
Date:   Thu Dec 16 14:11:57 2010 +0000

commit d12f8472cc06feec1a0e3a652e4ac14d7869fb3f
Author: milogardner <majordomo@planetmath.org>
Date:   Thu Dec 16 14:00:13 2010 +0000

commit 5febb4767563255280d95091ff9b2b0207042071
Author: Mathprof <majordomo@planetmath.org>
Date:   Wed Dec 15 23:02:47 2010 +0000

commit 61b11b97c4e503c353af5c1cd68e17b053d12b8e
Author: pahio <majordomo@planetmath.org>
Date:   Mon Dec 13 17:59:12 2010 +0000

commit 14d66e2dcd6151eb7214a9afbab159459912da6d
Author: pahio <majordomo@planetmath.org>
Date:   Mon Dec 13 17:54:21 2010 +0000
