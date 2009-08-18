From: Tomasz Kontusz <roverorna@gmail.com>
Subject: Re: Continue git clone after interruption
Date: Tue, 18 Aug 2009 08:58:55 +0200
Message-ID: <1250578735.2885.40.camel@cf-48>
References: <1250509342.2885.13.camel@cf-48>
	 <alpine.DEB.1.00.0908171430010.4991@intel-tinevez-2-302>
	 <vpqskfphe2k.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 18 08:59:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdIfO-00082L-MQ
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 08:59:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752551AbZHRG67 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 02:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752343AbZHRG67
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 02:58:59 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:49827 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752499AbZHRG66 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 02:58:58 -0400
Received: by bwz22 with SMTP id 22so2738980bwz.18
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 23:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:in-reply-to
         :references:content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=Ahtih41pKbQFoqg0d3hq84glIaQdY+04fThnqdKYy6M=;
        b=cJ18D1z54rwd6SogV3eRHNF+hHWIsceu4hjprcRYhfwpLEHwB3ugBfpUMcPFCB7nYy
         9V2ysKMsMa/jwxqzFDLai3zGD0UK3pDLoKW4itQn5Vlf73trroRsmu6/rR8gFR+NYiV3
         w3X1Y4fbJAKgvv/nTqoShlFLVX1R0k8oxPKb0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:in-reply-to:references:content-type:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        b=ps84/ZIIs8DgG9tMx6p0lHSehSGcgy5M0yI/NxbD9rc8EPqwTY9WqOFDrs/wSoR5J+
         1GH5PQGVkSmP4nWpHD3iezGKRhcoe/Dv30xq7cSVEIohBfGoqpjhLNzyxJpbL0wyMJ7H
         Td1DeSerqtfzr/JKqDsCip2rxm+vsLhTbP6bE=
Received: by 10.103.37.25 with SMTP id p25mr1711288muj.42.1250578738931;
        Mon, 17 Aug 2009 23:58:58 -0700 (PDT)
Received: from ?192.168.11.117? (pub-177-87.czarnet.pl [77.252.177.87])
        by mx.google.com with ESMTPS id n7sm22710750mue.28.2009.08.17.23.58.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 17 Aug 2009 23:58:58 -0700 (PDT)
In-Reply-To: <vpqskfphe2k.fsf@bauges.imag.fr>
X-Mailer: Evolution 2.26.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126353>

Dnia 2009-08-18, wto o godzinie 07:43 +0200, Matthieu Moy pisze:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Hi,
> >
> > On Mon, 17 Aug 2009, Tomasz Kontusz wrote:
> >
> >> is anybody working on making it possible to continue git clone after 
> >> interruption? It would be quite useful for people with bad internet 
> >> connection (I was downloading a big repo lately, and it was a bit 
> >> frustrating to start it over every time git stopped at ~90%).
> >
> > Unfortunately, we did not have enough GSoC slots for the project to allow 
> > restartable clones.
> >
> > There were discussions about how to implement this on the list,
> > though.
> 
> And a paragraph on the wiki:
> 
> http://git.or.cz/gitwiki/SoC2009Ideas#RestartableClone

Ok, so it looks like it's not implementable without some kind of cache
server-side, so the server would know what the pack it was sending
looked like.
But here's my idea: make server send objects in different order (the
newest commit + whatever it points to first, then next one,then
another...). Then it would be possible to look at what we got, tell
server we have nothing, and want [the newest commit that was not
complete]. I know the reason why it is sorted the way it is, but I think
that the way data is stored after clone is clients problem, so the
client should reorganize packs the way it wants.

Tomasz K.
