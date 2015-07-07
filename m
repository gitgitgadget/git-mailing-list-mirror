From: Junio C Hamano <gitster@pobox.com>
Subject: Re: refspecs with '*' as part of pattern
Date: Tue, 07 Jul 2015 09:28:45 -0700
Message-ID: <xmqqbnfo3paa.fsf@gitster.dls.corp.google.com>
References: <CA+P7+xoosLG3J5uUVakzwYoxVARs-NH4BJBtsMgw2NB39vyE6A@mail.gmail.com>
	<xmqqzj38yjpg.fsf@gitster.dls.corp.google.com>
	<alpine.LNX.2.00.1507062208580.2241@iabervon.iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jacob Keller <jacob.keller@gmail.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.iabervon.org>
X-From: git-owner@vger.kernel.org Tue Jul 07 18:29:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCVk2-0006u6-DV
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 18:29:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758093AbbGGQ26 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 12:28:58 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:33744 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757213AbbGGQ2s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 12:28:48 -0400
Received: by ieqy10 with SMTP id y10so138280959ieq.0
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 09:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=8bBqGVJtx3UUbLDK5nUcmQDKL7DViBWnqHNdFc5iY8g=;
        b=AN9h/XCe9/VH/kYJ5v54+GxyuL+3AzXQwgXfjatzbP1YiteMmPrAqQCyqNuayr3axT
         HNQUQ+g252Mi4+WH27UeaHg6W7fraDT3ixw5Revnj+uTNjjgsgLSoNQ4Mq6EtYTFaKEx
         9toeW+TeqiIyQF1Og1yr2UxxAGifk/PqAG6y8pX5Pt5DTVza4+mCPp+qXq3dHIlFYPIt
         jHVv8B9g/1cgxn1Lv+SRPZKxLT8Vfw0XqYC6F6Psrgbw1JrzX/rXjSuABGBTBK8aQFvk
         ygwHlUWr5HqGvUy532ldzXhcmNYd7aCq9bQgQvWuHSubYYspSkKEB2WwSEfVFeOEjmpn
         UaEQ==
X-Received: by 10.107.11.17 with SMTP id v17mr7436238ioi.83.1436286527407;
        Tue, 07 Jul 2015 09:28:47 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:7d74:6f43:1e30:fb1d])
        by smtp.gmail.com with ESMTPSA id x3sm12165609igl.2.2015.07.07.09.28.46
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 07 Jul 2015 09:28:46 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1507062208580.2241@iabervon.iabervon.org>
	(Daniel Barkalow's message of "Mon, 6 Jul 2015 22:20:24 -0400 (EDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273586>

Daniel Barkalow <barkalow@iabervon.iabervon.org> writes:

> On Mon, 6 Jul 2015, Junio C Hamano wrote:
>
>> I cannot seem to be able to find related discussions around that
>> patch, so this is only my guess, but I suspect that this is to
>> discourage people from doing something like:
>> 
>> 	refs/tags/*:refs/tags/foo-*
>> 
>> which would open can of worms (e.g. imagine you fetch with that
>> pathspec and then push with refs/tags/*:refs/tags/* back there;
>> would you now get foo-v1.0.0 and foo-foo-v1.0.0 for their v1.0.0
>> tag?) we'd prefer not having to worry about.
>
> That wouldn't be it, since refs/tags/*:refs/tags/foo/* would have the same 
> problem, assuming you didn't set up the push refspec carefully.

Thanks, I was wondering where you were ;-)  Nice to hear from you
from time to time.

> I think it was mostly that it would be too easy to accidentally do 
> something you don't want by having some other character instead of a 
> slash, like refs/heads/*:refs/heads-*.

Hmm, interesting thought.

But refs/heads/*:refs/heade/* would not be saved, so I do not think
that is it, either.
