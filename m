From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: git-tag bug? confusing git fast-export with double tag objects
Date: Thu, 14 May 2009 15:16:26 +0200
Message-ID: <81b0412b0905140616h69ac2919j26734f02455a5f5c@mail.gmail.com>
References: <op.utv93sdo1e62zd@merlin.emma.line.org>
	 <op.utwdsutn1e62zd@merlin.emma.line.org>
	 <7v8wl01iev.fsf@alter.siamese.dyndns.org>
	 <op.utwyczlf1e62zd@merlin.emma.line.org>
	 <81b0412b0905140516k4bc84606scb71981936966caf@mail.gmail.com>
	 <op.utw7buoi1e62zd@balu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Matthias Andree <matthias.andree@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 14 15:17:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4ao4-0008Fs-UN
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 15:17:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761093AbZENNQ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 09:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760423AbZENNQ2
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 09:16:28 -0400
Received: from mail-bw0-f174.google.com ([209.85.218.174]:42630 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760337AbZENNQ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 09:16:27 -0400
Received: by bwz22 with SMTP id 22so1282238bwz.37
        for <git@vger.kernel.org>; Thu, 14 May 2009 06:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=12HuyBx/dn3ODgE7wv9JZQKtcAVEDgWltQewmaK/LyI=;
        b=Qa5Nf8rv1FAeBTkItmVV9gyHniSaZXsRFEcMVJJXMalwGetUcqIAf7Az7+6gqpA5Us
         yt1s2TDRazqf6whtTS4s1oiI/BFD70UR3Q7oaMiO6tAn8NMjS7Roi7Sv91kf0icXfVOd
         D7c5G8RYpv3oAxW7Wq1Q7qYkw093xSuAnFXgM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=q3P8fr2VlA9U51+81cekbklWqzRm0aoAXtE2lPgkgth2/wklOToIlIG1pMexyQ/lQq
         yt+42Jnn1+DlA1R45+hzJS6VTNPM2DoLhyKslnMTNe7O5XOiOLbrBGXLFzHmn5mpF7B+
         f3hDSbmPcqF8vc4Doa2aUMb8unFsWWWYnakt8=
Received: by 10.204.118.207 with SMTP id w15mr2099131bkq.126.1242306986524; 
	Thu, 14 May 2009 06:16:26 -0700 (PDT)
In-Reply-To: <op.utw7buoi1e62zd@balu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119189>

2009/5/14 Matthias Andree <matthias.andree@gmx.de>:
> Am 14.05.2009, 14:16 Uhr, schrieb Alex Riesen <raa.lkml@gmail.com>:
>>
>> As soon as an object is not referenced anymore by any reference (including
>> references from refs/tags/), reference log or index it will be removed by
>> garbage collection (gc, prune) at the next opportunity.
>
> Irrelevant, because your assumption "not referenced anymore" is false. This
> was clearly written in my earlier message, which please see.

Yes, in your case it stays referenced, through the new tag which the reference
refs/tags/foo _now_ points to. Tough luck. In this particular case you could
just remove the reference (that's refs/tags/foo now), repack and re-tag
(properly).

It may be not what your wanted, but it is how it is expected to work. If git tag
would reduce its arguments down to commits, it would be impossible to sign
tags at all (strictly speaking: it would be impossible to create a
tag, referencing
another tag). Which is useful thing to have.
