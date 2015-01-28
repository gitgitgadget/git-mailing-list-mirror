From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] refs.c: clean up write_ref_sha1 returns
Date: Wed, 28 Jan 2015 13:35:23 -0800
Message-ID: <CAGZ79kY1Hy7xAZ4JSRev2EUoORFNbdhSeNysBwo0jhmskKgvvw@mail.gmail.com>
References: <CAGZ79kbQiVQJyZC8mKaSUnOpY6YJc0TYdX=msuZDXLd7DxmTmQ@mail.gmail.com>
	<1422306638-23785-1-git-send-email-sbeller@google.com>
	<xmqq8ugonc0h.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Loic Dachary <loic@dachary.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 04:48:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGg5q-0000UA-Mz
	for gcvg-git-2@plane.gmane.org; Thu, 29 Jan 2015 04:48:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753998AbbA2BZN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2015 20:25:13 -0500
Received: from mail-ie0-f180.google.com ([209.85.223.180]:53273 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752326AbbA2BZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2015 20:25:09 -0500
Received: by mail-ie0-f180.google.com with SMTP id rl12so27530597iec.11
        for <git@vger.kernel.org>; Wed, 28 Jan 2015 17:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=gPHx+k43gSVlBKK0SF/FZm/hSCxTw3PiDDdnVqVMJs8=;
        b=L9yPXiK/Q06V/3T8mwqL3il5j/H8cHhst7x5YSqcQrvtGiRAYIjPeYcy6pKtiWnnKe
         krs9uSU0ZpW5qNdmdDQ5L3nmWaytazht5kQ6wNyQPxNqIZaEfHxEHL2ndKMxlViE4xgQ
         R37HlpUclqlSzxG3uhBDPrkp/Rh3sqH4Jf+hTN+WQdaf+sf/lMNg3QnN0l0LOVFEMZ5U
         TN1TQktCTBBct9h+E57ZkXSHWMigpoizyNElVzbr5fIhUo87NTc2q3KQLuVn0fFrIUEr
         j1YNkff1whTysW2+r9dsudKLLLjlgINxQI/fCmwt7N5lkGRoVnSSUxZFuLJiyJYibufC
         Ymnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=gPHx+k43gSVlBKK0SF/FZm/hSCxTw3PiDDdnVqVMJs8=;
        b=U55l3kRhr0Mko3zP+rWck6m0zQmK68o38dutDrQL3TsqJOej+PXAStl/zYfykHu9DI
         vyU2VPI/+NwVgxMKEAcRFjrPVkGUBICiiPxjtZ1Ki9YcFy8Q9n93ik1mbGp1K1bd0jFY
         ZCHyV8NaJT2i2xm0KUEx03HMT2R7UEhXnuLPoSTD+LlIFtBCgOmEsyVAVlnW/QWJKYzT
         s6VvUveYdTDJYQeOjmls/Ol49CGygDfn7zb/CU2U2tfGoyY1MdVxPYNiBLX1GMuf1TEs
         FvNWxa9yUdK63aFM6Mg5CY2XEJ5u+2o8VYPNwBx9ZjwL1Xc7QhUP0Uq1x/oY16tiSgp3
         8G8g==
X-Gm-Message-State: ALoCoQnsqdywhVKeQWfFYJRLTDPZ8BdfTMPKzFaW1sYjWRiXA60QLALS3SSEFXAO9QwUKp6nGODr
X-Received: by 10.50.85.44 with SMTP id e12mr6304331igz.48.1422480923868; Wed,
 28 Jan 2015 13:35:23 -0800 (PST)
Received: by 10.50.26.42 with HTTP; Wed, 28 Jan 2015 13:35:23 -0800 (PST)
In-Reply-To: <xmqq8ugonc0h.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263137>

On Mon, Jan 26, 2015 at 7:22 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>     I can redo the atomic-push-fix series with this cleanup merged
>>     into the appropriate patches or you could just queue it on top
>>     of said series.
>
> Yeah, I do not think we are expecting to fast track these two series
> through 'next' to 'master' before 2.3 final, so I think it would be
> better to use this patch _only_ to see if the final shape of the
> code this patch represents makes sense, so that we can expedite the
> final submission in the next development cycle, at which time we
> will have a chance to refresh 'next', hence a chance to clean-up
> atomic-push series in place.

I tried to rip this patch and its 3 previous patches apart to see if it could be
done another way. The outcome was to actually sqquash this patch
completely into b1c6da0a13 (refs.c: remove unlock_ref and commit_ref
from write_ref_sha1).

Looking at the end result the write_ref_sha1 function it has a good
design contract. Either you get 0 returned and all is good, or -1 is returned
and errno is set to a meaningful value which seems to adress your concerns
on that patch:

> I am not sure if it is sensible to call that "correct but hard to
> understand".  I'd rather see us admit that its behaviour is screwey
> and needs fixing for better code health longer term.


>> @@ -2880,7 +2877,6 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
>>               error("unable to lock %s for update", newrefname);
>>               goto rollback;
>>       }
>> -     lock->force_write = 1;
>>       hashcpy(lock->old_sha1, orig_sha1);
>
> Is this hashcpy() still necessary?

Thanks for catching that! It is not necessary any more and will be
removed in a reroll.
I think I'll wait for rerolling the atomic-push-fix series until 2.3
is out then?
