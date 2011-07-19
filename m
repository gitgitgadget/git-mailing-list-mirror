From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 11/17] revert: Save data for continuing after conflict
 resolution
Date: Tue, 19 Jul 2011 07:21:02 -0500
Message-ID: <20110719122102.GA26330@elie.gateway.2wire.net>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-12-git-send-email-artagnon@gmail.com>
 <20110712193716.GB14909@elie>
 <CALkWK0nyu6W2Nd=qcrjZZwkAdFGqTqAe53FmecS_n2cK_4UWMg@mail.gmail.com>
 <20110717184057.GD27787@elie>
 <CALkWK0kZ3nWnnGe1OHXWgiZ8ik9iNW803wi2d6kUiNDpiOWNDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 19 14:21:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qj9J0-0003rb-Sw
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 14:21:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751705Ab1GSMVi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jul 2011 08:21:38 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57653 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751032Ab1GSMVh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2011 08:21:37 -0400
Received: by iyb12 with SMTP id 12so4016093iyb.19
        for <git@vger.kernel.org>; Tue, 19 Jul 2011 05:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=hVG8F75BbGJv1C2rceNnXxHasnOzM+sCT6i0l1RwNnU=;
        b=mnvP1s3FvI75swGupNOTZeTi+qF/qwBTvMVblHC8sYI5lVNZfF+JYPj4aC4zCHKUQ3
         7g8GHbsBniwgzfA55kEi2hSbkkCYJ1ybqzrdGwWQJy4tOVpq+3nno1Z301Ve+EKYbGTa
         V5nLkgkyrAo2i6PaOR20hXDW4woxn90lbR18o=
Received: by 10.231.150.4 with SMTP id w4mr7017972ibv.119.1311078096725;
        Tue, 19 Jul 2011 05:21:36 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-69-209-74-225.dsl.chcgil.ameritech.net [69.209.74.225])
        by mx.google.com with ESMTPS id d3sm3553232iba.6.2011.07.19.05.21.32
        (version=SSLv3 cipher=OTHER);
        Tue, 19 Jul 2011 05:21:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0kZ3nWnnGe1OHXWgiZ8ik9iNW803wi2d6kUiNDpiOWNDA@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177452>

Ramkumar Ramachandra wrote:

> 3. Instead of just saying "fatal: Malformed instruction sheet" like we
> do now, we can put in something a little more helpful like "error:
> Cannot cherry-pick during a revert" before this message.  So:
>
> $ git cherry-pick moo
> ... conflict ...
> # resolve conflict
> $ git revert --continue
> error: Cannot cherry-pick during a revert
> fatal: Malformed instruction sheet
>
> This makes it clear to the user that the instruction sheet is to
> blame, and in what way.

Makes sense.  Would it be possible to rephrase the message "Malformed
instruction sheet" to encompass this error?  After all, the
instruction sheet is grammatically well formed and the only mistake it
made was to do something unexpected.

Maybe

	error: cannot resume a cherry-pick with "git revert --continue"
	fatal: unusable instruction sheet

or something along those lines.  I dunno.
