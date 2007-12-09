From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Something is broken in repack
Date: Sun, 9 Dec 2007 10:19:23 -0500
Message-ID: <9e4733910712090719g713972a9p1c18bc149dc0237c@mail.gmail.com>
References: <9e4733910712071505y6834f040k37261d65a2d445c4@mail.gmail.com>
	 <alpine.LFD.0.99999.0712072032410.555@xanadu.home>
	 <7vodd0vnhv.fsf@gitster.siamese.dyndns.org>
	 <7vprxgs36w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Nicolas Pitre" <nico@cam.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 09 16:19:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1NwY-000176-EK
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 16:19:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbXLIPTY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 10:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750905AbXLIPTY
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 10:19:24 -0500
Received: from wa-out-1112.google.com ([209.85.146.180]:45486 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138AbXLIPTX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 10:19:23 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2756343wah
        for <git@vger.kernel.org>; Sun, 09 Dec 2007 07:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=MNzycelI8M/e8yizZmnwm4tt7J0BXSs8x6cOIUSLuUY=;
        b=uK2GT3nrpeuIMCb9jlElmpTGKAKMR2lWRS0RF0aaM3vFMkOUO/1bYP+6ZJF4qntvy1rRmDUodVunUAR/BuXR/NNXQNjGeREWLpX82xJciabbfLMMpcuFwKMKDntq8qT9/cg1l/PSYrdjfiTOVn53ElHsUwWRYxG/SLtVsEDQGV8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BhEbqkhSs7gvnykcMmfnPZC19C0EiYGfBr1DtD/lDlDLY2xLBUg7bV7mJt0VgmBwg/sDUfkxpg630FH87pfO0IXWRKaiG7hyKFoZhET3hUhlZwogFrMGrmXmydB/OCBddrHaQ59ArVe5x2iqk751GRQ5gtNpBoceXKaUBwYneSA=
Received: by 10.114.58.1 with SMTP id g1mr5631705waa.1197213563189;
        Sun, 09 Dec 2007 07:19:23 -0800 (PST)
Received: by 10.114.208.17 with HTTP; Sun, 9 Dec 2007 07:19:23 -0800 (PST)
In-Reply-To: <7vprxgs36w.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67625>

On 12/9/07, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Nicolas Pitre <nico@cam.org> writes:
> >
> >> On Fri, 7 Dec 2007, Jon Smirl wrote:
> >>
> >>> Starting with a 2GB pack of the same data my process size only grew to
> >>> 3GB with 2GB of mmaps.
> >>
> >> Which is quite reasonable, even if the same issue might still be there.
> >>
> >> So the problem seems to be related to the pack access code and not the
> >> repack code.  And it must have something to do with the number of deltas
> >> being replayed.  And because the repack is attempting delta compression
> >> roughly from newest to oldest, and because old objects are typically in
> >> a deeper delta chain, then this might explain the logarithmic slowdown.
> >>
> >> So something must be wrong with the delta cache in sha1_file.c somehow.
> >
> > I was reaching the same conclusion but haven't managed to spot anything
> > blatantly wrong in that area.  Will need to dig more.
>
> Does this problem have correlation with the use of threads?  Do you see
> the same bloat with or without THREADED_DELTA_SEARCH defined?
>

I just started a non-threaded one. It will be four or five hours
before it finishes.

-- 
Jon Smirl
jonsmirl@gmail.com
