From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/5] sequencer: Expose code that handles files in
 .git/sequencer
Date: Wed, 10 Aug 2011 10:53:32 -0500
Message-ID: <20110810155332.GB4076@elie.gateway.2wire.net>
References: <1312970151-18906-1-git-send-email-artagnon@gmail.com>
 <1312970151-18906-5-git-send-email-artagnon@gmail.com>
 <20110810152126.GE31315@elie.gateway.2wire.net>
 <CALkWK0nJUTtNgCHF6CE2-w+3ZwdBrscBRw0e0L8wX86Za0G=DA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 10 17:53:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrB6E-0003CS-Mq
	for gcvg-git-2@lo.gmane.org; Wed, 10 Aug 2011 17:53:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751851Ab1HJPxi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Aug 2011 11:53:38 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:61977 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922Ab1HJPxh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2011 11:53:37 -0400
Received: by gxk21 with SMTP id 21so746077gxk.19
        for <git@vger.kernel.org>; Wed, 10 Aug 2011 08:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=xeBcwz7xCSMSco2rAA4MR8LIz4mha13LU21PHfornig=;
        b=I8omFD5JIxmIXvVGs0WTqMe5FTkiz1V69Pryzq7R85wFzdGcnHcLKiKLs5OAHVVRa3
         Y3At35yR3pkI8a1TxQW9jswQ+162ePss1TedlsUZ5frG5JGTRYdIQXURkTcG/LBLQ2cr
         v/xabMjObEWfrqfqanKDHfIKq2oInrL4N1viw=
Received: by 10.236.178.101 with SMTP id e65mr7589165yhm.107.1312991616847;
        Wed, 10 Aug 2011 08:53:36 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-69-209-69-68.dsl.chcgil.sbcglobal.net [69.209.69.68])
        by mx.google.com with ESMTPS id c6sm1174458yhm.30.2011.08.10.08.53.35
        (version=SSLv3 cipher=OTHER);
        Wed, 10 Aug 2011 08:53:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0nJUTtNgCHF6CE2-w+3ZwdBrscBRw0e0L8wX86Za0G=DA@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179071>

Ramkumar Ramachandra wrote:

> So, we're
> really faced with two choices:
> 1. Make this patch enormous by moving as well as refactoring
> everything into a beautiful public API.  I suspect this won't be easy
> to review at all.
> 2. Keep this patch as it is, and introduce a future patch to clean up
> the API.  This is the approach I was going for.

Well, "beautiful public API" means "just what cmd_cherry_pick and
cmd_revert needs", right?  So I'd suggest:

 1. Figuring out what functions they need, and doing the minimal
    refactoring needed to make them separate functions.

 2. As patch #2, moving everything to sequencer.c and exposing those
    functions in sequencer.h.

 3. In later patches, making changes needed for what "git commit"
    needs.

Luckily step (1) is already done.  The functions are parse_args()
and pick_revisions() (though they could presumably use less generic
names).

Hmm?
Jonathan
