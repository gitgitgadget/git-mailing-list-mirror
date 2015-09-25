From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 20/43] refs-be-files.c: add methods for the ref iterators
Date: Fri, 25 Sep 2015 17:28:53 -0400
Organization: Twitter
Message-ID: <1443216533.8657.8.camel@twopensource.com>
References: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
	 <1441245313-11907-21-git-send-email-dturner@twopensource.com>
	 <xmqqeghm2p98.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu,
	David Turner <dturner@twitter.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 25 23:29:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfaY9-00061n-8a
	for gcvg-git-2@plane.gmane.org; Fri, 25 Sep 2015 23:29:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933224AbbIYV25 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2015 17:28:57 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:35836 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757021AbbIYV24 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2015 17:28:56 -0400
Received: by qkap81 with SMTP id p81so47727214qka.2
        for <git@vger.kernel.org>; Fri, 25 Sep 2015 14:28:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=FSY1+VoE1vzLiOQVHilLmEVXUjb7q1cLXWkYYP3qIQs=;
        b=HDhpxoTWIdknv7iS9tEYOSjinwd4Zb1SNovWedXZHGiPEr0T9WYVmg5cgVEx2cdNAO
         4Hu79fZFzsDztidz/S7z7haFkg8LuHXuxYgPh6SYpvJBGBeT1UYekkf0EOpAFeK2Ln2/
         qIu6r8Bins3vwr09RDXRDqHd+2pKEneyXwcbv9ixXHal2uCEcyCgZ6Sr9tJI7sDLkTJD
         1IPenBA8TSAQCtBH1Ylw2RdY8nJbJqF/UxyNsAbGWq0dNHc2K6wRvgHQBphRX2/cw/ND
         AkrnRVVdA6vwHfHwdOIWLOXE9+QQzjCXdzMLG7SNlBY29QbYn+HRsukA/b7B8jyk+Q3U
         S4tA==
X-Gm-Message-State: ALoCoQnDfakfI+MoXNprZAHsJYQE6NjEqK2dzx7fEQM04pd2btB6bJfJEihzFMt9XW9Ao+cUoQuP
X-Received: by 10.55.204.66 with SMTP id r63mr8811522qki.10.1443216535530;
        Fri, 25 Sep 2015 14:28:55 -0700 (PDT)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id k5sm2246960qkl.15.2015.09.25.14.28.54
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Sep 2015 14:28:54 -0700 (PDT)
In-Reply-To: <xmqqeghm2p98.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278681>

On Fri, 2015-09-25 at 13:54 -0700, Junio C Hamano wrote:
> Up to high-teens in this 43 patch series, the changes all looked
> "separate filesystem backend specific part from refs.c to
> refs-be-files.c" without other questionable changes, but I have to
> give up at this step for now, as conflicts between the patch and the
> current codebase is getting a bit too much to manually adjust the
> patch only to make sure there is no funnies other than a straight
> rename of static functions going on.

Unfortunately, as long as there continue to be changes to refs.c, this
will continue to be an issue.   I can rebase, fix the conflicts, and
re-send.

Later, you say

> * Pick 'next', 'jch' and 'pu' as the starting point, attempted to

Do you mean that you merged these branches together, or that you tried
each of the three?  Which would you like me to rebase on?

> We seem to have added a few more iterators in refs.c that would need
> to be also wrapped as methods, so this step would need to be redone.

Will fix in the re-roll.

> Regarding [03/43], it is a straight rename without any content
> change, so you probably could have done "format-patch -M".  But that
> original commit, if I am not mistaken, left an empty ref.c instead
> of removing, which was somewhat funny (and Makefile still expects
> refs.o can be produced from refs.c).
> 
> The other side of the same coin is that [04/43] expects an empty
> refs.c to be in the original; it should be creating a new file
> instead.

This was intentional.  Ronnie Sahlberg's original version of this patch
simply removed refs.c (without changing Makefile), which broke the
build.  I didn't like that.  So instead I simply left an empty file. 

It looks like you would prefer that 03/43 move refs.c and update
Makefile, then have 04/43 create a new file and update Makefile again.
I'll do that instead.
