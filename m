From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: correct git merge behavior or corner case?
Date: Tue, 21 Apr 2009 11:00:30 +0200
Message-ID: <fabb9a1e0904210200j5f82e9ci440b99ab18016938@mail.gmail.com>
References: <4ac8254d0904191540j68246cd8qa36a034209d4c800@mail.gmail.com> 
	<alpine.DEB.1.00.0904201148150.6955@intel-tinevez-2-302> <41354.bFoQE3daRhY=.1240222235.squirrel@webmail.hotelhot.dk> 
	<20090421024433.GC14479@coredump.intra.peff.net> <7vskk2bt3x.fsf@gitster.siamese.dyndns.org> 
	<fabb9a1e0904210148w4c6b869l396122baef1c0ee3@mail.gmail.com> 
	<alpine.DEB.1.00.0904211055160.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Anders Melchiorsen <mail@cup.kalibalik.dk>,
	Tuncer Ayaz <tuncer.ayaz@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 21 11:02:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwBry-00050d-Bv
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 11:02:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752734AbZDUJAs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2009 05:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752483AbZDUJAr
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 05:00:47 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:54268 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751766AbZDUJAr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2009 05:00:47 -0400
Received: by fxm2 with SMTP id 2so2396880fxm.37
        for <git@vger.kernel.org>; Tue, 21 Apr 2009 02:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=syPkMTQTw/MezD5GbKJ1NkBvMgpaTCo6+JzWt/on3jk=;
        b=ni/lxTF1hJ6puQaTFd78dSs3UOFFbUT1uBIBR38VCoshPVXtiPjWQvA0vFGqWZ3k9N
         aZagwPCEUOEVtnBymn7h5Wz3HCgC4mzgZBDGx4iFskLXu/Bt7K+FOa4WC/WZ2qgD7qFD
         S2S/pDz79ucKqW8Ccne2edBYpIuYhD2f1nVJg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=sFNFbkrAih7nqWjAcJc3K6q6uasvfjpJ3Aqik9uJny9w4ytlbQYtAIPogiFSLvv1FW
         riRQHLu5A+4y3EVJ41dgbJrNoR9xqCOgIy4MY6pmDBqFbgqxQb4gzPsswQneq6EA9qsp
         i9UXEP+4nV2ZkJlisCwQ7loZ2MC+dQVuVYcvo=
Received: by 10.103.2.14 with SMTP id e14mr3644450mui.41.1240304445087; Tue, 
	21 Apr 2009 02:00:45 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0904211055160.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117109>

Heya,

On Tue, Apr 21, 2009 at 10:56, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> But they would be a good example why we do _not_ want rename detection
> there.

Yes, I would agree that they are indeed a good example. The other day
I moved a directory in a python project (containing several
sub-directories and as such several empty __init__.py files), and it
renamed them rather wrongly :P.

The diff looked something like:
Renamed root/old/a/__init__.py to root/new/b/__init__.py
Renamed root/old/b/__init__.py to root/new/c/__init__.py
Renamed root/old/c/__init__.py to root/new/a/__init__.py

While of course, a better result would have been:
Renamed root/old/a/__init__.py to root/new/a/__init__.py
Renamed root/old/b/__init__.py to root/new/b/__init__.py
Renamed root/old/c/__init__.py to root/new/c/__init__.py

-- 
Cheers,

Sverre Rabbelier
