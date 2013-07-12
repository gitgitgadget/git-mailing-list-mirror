From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 3/4] t4203: test mailmap functionality directly rather
 than indirectly
Date: Thu, 11 Jul 2013 17:55:17 -0700
Message-ID: <20130712005517.GA8482@google.com>
References: <1373554528-15775-1-git-send-email-sunshine@sunshineco.com>
 <1373554528-15775-4-git-send-email-sunshine@sunshineco.com>
 <7vhag0rk3u.fsf@alter.siamese.dyndns.org>
 <CAPig+cS7rxFzY8Q3gfTtJkggp-K62SVqsjCotbM3Bkm47L44gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Jul 12 02:55:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxRdx-0006bn-T3
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 02:55:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287Ab3GLAz0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 20:55:26 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:37198 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932209Ab3GLAzZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 20:55:25 -0400
Received: by mail-pd0-f171.google.com with SMTP id y14so7991673pdi.30
        for <git@vger.kernel.org>; Thu, 11 Jul 2013 17:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=2Gu6nPEmShVl+Yr23MYtt6Wo68Cu90ylsCno9p1avyI=;
        b=jrClgN4IVy3G5HgZDvnkYFU5bo823QtmfspPcETvVs8wzJZkWfGd705Qukx1iYCk7C
         5nLwII3Gtj37gX9Wogll3Gs8qzvIIRBYCGic+aXLJC4DYDvekQWv+krMOL4izy/qKnwX
         idO56iBPmkAOodtoC+K5gFwebU88vXMbbW5tT2ELwiKYuEeBzDAFjSg1WAuRZvq64K9/
         UJ+h94bWYtRMSwtPynCImQ5Q2WxL+8nJrTBmCC59ryybSDs3iUoTHWPv9NoEY6vOzg0i
         zF49p2fq76W9j67C8iK3mVqmFVZuyaP+RRtpGA+RbKyyjrsN1XNDsxM+btJ0Hq+xgDmj
         lG3g==
X-Received: by 10.68.219.42 with SMTP id pl10mr962944pbc.170.1373590524961;
        Thu, 11 Jul 2013 17:55:24 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id rb1sm29700480pbb.29.2013.07.11.17.55.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 11 Jul 2013 17:55:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAPig+cS7rxFzY8Q3gfTtJkggp-K62SVqsjCotbM3Bkm47L44gg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230156>

Eric Sunshine wrote:
> On Thu, Jul 11, 2013 at 3:07 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Eric Sunshine <sunshine@sunshineco.com> writes:

>>> With the introduction of check-mailmap, it is now possible to check
>>> .mailmap functionality directly rather than indirectly as a side-effect
>>> of other commands (such as git-shortlog), therefore, do so.
>>
>> Does this patch mean that we will now ignore future breakages in
>> shortlog and blame if their mailmap integration becomes buggy?
>>
>> I am not convinced it is a good idea if that is what is going on.
>
> I meant to mention in the cover letter that this patch was open for
> debate, however, it does not eliminate all testing of these other
> commands.
>
> The tests in which git-check-mailmap is substituted for git-shortlog
> all worked against a simplistic two-commit repository. Those tests
> were checking the low-level mailmap functionality under various
> conditions and configurations; they were not especially checking any
> particular behavior of git-shortlog.
>
> There still remain a final eight tests which cover git-shortlog,
> git-log, and git-blame. These tests do check mailmap-related behavior
> of those commands, and they do so using a more involved seven-commit
> repository with "complex" mappings, so we have not necessarily lost
> any checks of mailmap integration for those commands.
>
> Would this patch become more palatable if I stated the above in the
> commit message?

My current thinking is "no" --- the patch has as a justification "Now
we can test these aspects of .mailmap handling directly with a
low-level tool instead of using the tool most people will use, so do
so", which sounds an awful lot like "Reduce test coverage of commonly
used tools, because we can".

But I imagine the actual motivation was something other than "because
we can".  For example, maybe the idea is that after this patch, it
should be easier to make cosmetic improvements to the shortlog, log,
and blame output and only have to change those final 8 tests that are
adequately covering the output?  If you have such plans and this patch
makes them easier, it could sound like a good patch as a stepping
stone toward that.

Thanks and hope that helps,
Jonathan
