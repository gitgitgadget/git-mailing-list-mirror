From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Add Gitweb support for LZMA compressed snapshots
Date: Sat, 1 Aug 2009 18:13:04 +0400
Message-ID: <20090801141304.GB10264@dpotapov.dyndns.org>
References: <E0C39B59-E2C5-4C28-9570-D33FEA2A44EB@uwaterloo.ca> <m3r5vy1siq.fsf@localhost.localdomain> <alpine.DEB.1.00.0907301042300.7467@intel-tinevez-2-302> <94a0d4530907310845k51dbafbfy8e240467113dfc16@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Mark A Rada <marada@uwaterloo.ca>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 01 16:14:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXFLo-0002NM-T1
	for gcvg-git-2@gmane.org; Sat, 01 Aug 2009 16:14:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751732AbZHAOOM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Aug 2009 10:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751712AbZHAOOM
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Aug 2009 10:14:12 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:46041 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751687AbZHAOOL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Aug 2009 10:14:11 -0400
Received: by ewy10 with SMTP id 10so2088000ewy.37
        for <git@vger.kernel.org>; Sat, 01 Aug 2009 07:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Wt4lLF+MkMvAl80DnTXAfxWU8RRi3ZLRaE+9bGVIm8w=;
        b=dB1wJzjBhW36DNBfWR0PuIUQGWDPWVC9pz1/I70YDAT6O3lmffjFiMPeV+nxzQGafj
         Pai9a2VSe8akkeJKEUp8nSEcVIxydqQdIox9KAzWQls3q5IYdyjDyCGWjoRtG10dxogu
         2ARM/QYN3jm1uYDLxy4CVK/hGaMsy+DVaO3Sk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=GekgbWn5zsrqtBXVeIkT+fYPBw6Ibm+GO02y7S14gUDcNaI+qqwcTl4+ZNf51p83z1
         nrXVp1wiHPHOfdL0EuooI9X0qUk1+W7CipgDV8nIfXgyvoiYy4RGGSW0VBZ4K7/HaZAu
         3NdLhh4C4y+PJYNk/dRrh4p9EIWfh4MqPFFA0=
Received: by 10.210.51.10 with SMTP id y10mr2422581eby.40.1249136049875;
        Sat, 01 Aug 2009 07:14:09 -0700 (PDT)
Received: from localhost (ppp91-76-18-53.pppoe.mtu-net.ru [91.76.18.53])
        by mx.google.com with ESMTPS id 28sm2249053eye.4.2009.08.01.07.14.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 01 Aug 2009 07:14:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <94a0d4530907310845k51dbafbfy8e240467113dfc16@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124624>

On Fri, Jul 31, 2009 at 03:45:02PM +0000, Felipe Contreras wrote:
> 
> bzip2 has no advantages whatsoever. AFAIK xz is superior to other
> formats and it would be nice to see git make a technological stance
> encouraging xz.

git is not about encouraging any compression. If you have not noticed,
git-archive produces tar and not tgz (though it would not be difficult
to implement it, because we use zlib anyway). If you like xz and it is
installed on your system, you can always compress tar with it:

git archive HEAD | xz > my-archive.tar.xz

So, I see no reason to have this compression coupled with git.

> 
> > The only reason we have inbuilt gzip and zip support is because the format
> > is so similar to Git's own compression.
> 
> Personally I don't see the point of having zip support.

zip is still a popular format on Windows. If git archive was not able to
produce then creating would require creating tar first, extracting it to
some temporary directory and then creating a zip file. It is not very
efficient process and requires extra efforts, so because we use zlib
compression anyway, it makes perfect sense that we can create zip file
directly.

Dmitry
