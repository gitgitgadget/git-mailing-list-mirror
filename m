From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] Respect crlf attribute in "git add" even if core.autocrlf has not been set
Date: Thu, 24 Jul 2008 21:05:53 +0400
Message-ID: <20080724170553.GX2925@dpotapov.dyndns.org>
References: <alpine.DEB.1.00.0807222255450.8986@racer> <7vy73tihl6.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807230203350.8986@racer> <alpine.DEB.1.00.0807230229410.8986@racer> <719E03C0-E8C3-4C35-AE9C-9BD5A7BCDF03@zib.de> <20080723114022.GP2925@dpotapov.dyndns.org> <FCAEAB20-750E-47B9-B58D-9BB0CB1EEAFF@zib.de> <alpine.DEB.1.00.0807241334340.8986@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Steffen Prohaska <prohaska@zib.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 24 19:07:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM4HT-00038g-KQ
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 19:07:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbYGXRGH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jul 2008 13:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750930AbYGXRGG
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 13:06:06 -0400
Received: from mu-out-0910.google.com ([209.85.134.190]:39425 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910AbYGXRGE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 13:06:04 -0400
Received: by mu-out-0910.google.com with SMTP id w8so2142835mue.1
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 10:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=jePWMqD9rxyQGPTNAUrVQLtFHMQU9dVSsouammGx2qA=;
        b=PjNP8XBMhCdtFAkqAsYVFUjfVI6nVLGW/Qu5D5BY8iv/ndTrqKjOe2dZBkthsoc0wh
         88dfxzI085roN1JwIoRurovu5laKu+t0rI1SbHMVe5hLMJHbSh3t93Zi3vIjzK7AnBfr
         Uj4KxUcSMQuHfHRmpmE1WcDMytpokXga2eV9Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Te/fgmu6y2Ff/k13QPlIQKFaffgNHwwp59dN2XR49ohZXXp+UDekFzkSocbVLJhr5U
         hfC3ZW8tswyBJb8O2mwNtnfq76eBerznnqxZwwgjgvxquLZSCDScPWyz7/ySfmYffeLF
         A1/IpC00Mf2sKWHxG2APZYYp0UgMd/WAYPws4=
Received: by 10.103.246.17 with SMTP id y17mr248608mur.55.1216919157640;
        Thu, 24 Jul 2008 10:05:57 -0700 (PDT)
Received: from localhost ( [85.140.170.251])
        by mx.google.com with ESMTPS id s10sm23668962mue.16.2008.07.24.10.05.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 24 Jul 2008 10:05:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807241334340.8986@racer>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89913>

On Thu, Jul 24, 2008 at 01:39:34PM +0100, Johannes Schindelin wrote:
>=20
> Well, seems I will just continue shouting "why did you commit that=20
> CR-ridden file?" and get shouted back with "why does this =A7&%&%&!=B0=
 Git=20
> tool not fix it for me automatically?  Even _Subversion_ can do it."

Actually, no... With Subversion, if you do not have correct auto-props
then every newly added file will have incorrect end-of-lines. So, each
user has to manually add all possible text extensions in the auto-props
section of his/her subversion config file. In practice, it means that
with SVN you have far less problems with EOLs in first few days when
users just existing files, but then the problem reemerge every time whe=
n
someone adds a new file... So, it is not much better...

In constrast, Git provides automatic text detection and EOL conversion,
but it is not enabled where it should... at least, on Windows, and for
those who copies file directly from Windows through network shares or b=
y
other means.

Dmitry
