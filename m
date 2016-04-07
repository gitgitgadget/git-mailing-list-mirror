From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 0/6] tag: move PGP verification code to tag.c
Date: Thu, 7 Apr 2016 12:19:37 -0400
Message-ID: <CAPig+cQxmovGckrbwuEoeA=hW1idukj3qKTfjmr8B+AM7E2J0A@mail.gmail.com>
References: <1459872449-7537-1-git-send-email-santiago@nyu.edu>
	<CAPig+cQ4n5j4Q-WF-0cd=2+5eSAaimh3A7La+8Fe9Ox4anjtBQ@mail.gmail.com>
	<20160407034007.GC17848@LykOS>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Santiago Torres <santiago@nyu.edu>
X-From: git-owner@vger.kernel.org Thu Apr 07 18:19:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoCel-0000Va-GK
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 18:19:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755631AbcDGQTj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 12:19:39 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:34920 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751345AbcDGQTi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 12:19:38 -0400
Received: by mail-io0-f193.google.com with SMTP id q128so12714845iof.2
        for <git@vger.kernel.org>; Thu, 07 Apr 2016 09:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=uPgb+rReBHsLCOrI4ZX87tLB5htibHYWb/3etSuBbhI=;
        b=n9Zm+FhR/Togbg1fqo6MtJBYfWRl4K5QseDWP2XuSBW86GGiQUnevBj0E9CzPHEznu
         ELECpwayGuNdotUt3pyhFcN8hinT2GUenJb16wu6l+zluWFgtxr+3WJNu7MGLLRSsVsZ
         ggI8vr/x7bpAnL4LgFhm2B7rlyc/vy+kkmOfF5RgNXKczVkFyLVlvc9PCUZDY9I5zvlV
         iZliIdkbhRjFYI7RJPI5gdwb+S+y3P/ixKKbU2TAoQW4aYyGJvE3S4cokzSwHBviDutI
         kl3vTmBcS5E/7XEOSlLtSbdpSFlBUu8Q6DLyJeO5sO3DyBsYBj4IvemkG2gXwjiktcwO
         06xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=uPgb+rReBHsLCOrI4ZX87tLB5htibHYWb/3etSuBbhI=;
        b=IUYYAwUsUTVHA6dWo7LwLLifD+ZxTpqqGNkm6Y4ZoNyx6NxmKBjR14oQWpNpz5Gwpw
         9tWhvWsuBPTpPlLiaTA85uLfLz6hciltDk4k4O+I/gJSVsq+MnxPzp9JFXtug1W5sIZy
         8/LCiCSBu+pdmeuTynm9BztB7VGdlV50inDIRdEDdF5K0O36EADR/AUAX1+CoqNL3GzG
         Vd24qo6f/uZhousLSxs+QWEHyT07Dq73Mqxkms6z0XyzlI7U052x9y2lM5BXUOr2atXx
         6Mcn92e/1NZgsiFLCflGarV749GDEyC1lYsWB5BnC4jxk5v67oMHp3BMt/fFoM1DvlwP
         1jVw==
X-Gm-Message-State: AD7BkJL9B9SeH3WevF3RFfctCmRzZpjxBHfYJ+bIoqCvGJoLjmSUk7RwSxjfRadIOWikPzadG9N912/sC2/cpw==
X-Received: by 10.107.8.141 with SMTP id h13mr4923304ioi.34.1460045977185;
 Thu, 07 Apr 2016 09:19:37 -0700 (PDT)
Received: by 10.79.139.2 with HTTP; Thu, 7 Apr 2016 09:19:37 -0700 (PDT)
In-Reply-To: <20160407034007.GC17848@LykOS>
X-Google-Sender-Auth: VdqCFcsZw22f8ly3gLkyY5rpuvk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290923>

On Wed, Apr 6, 2016 at 11:40 PM, Santiago Torres <santiago@nyu.edu> wrote:
>> > v5 (this):
>> > Added helpful feedback by Eric
>> >
>> >  * Reordering of the patches, to avoid temporal inclusion of a regression
>> >  * Fix typos here and there.
>> >  * Review commit messages, as some weren't representative of what the patches
>> >    were doing anymore.
>> >  * Updated t7030 to include Peff's suggestion, and added a helped-by line here
>> >    as it was mostly Peff's code.
>> >  * Updated the error-handling/printing issues that were introduced when.
>> >    libifying the verify_tag function.
>>
>> This version is a more pleasant read, easier to digest and understand.
>> All of my review comments were minor; nothing demanding a re-roll. As
>> such, this version is:
>>
>>     Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
>>
>> If you do happen to re-roll based upon the review comments, feel free
>> to add my Reviewed-by: (but not if you make larger changes).
>
> Thanks! I'll add your and Junio's in another re-roll.

I don't think Junio explicitly gave his Reviewed-by: (indicating his
approval of the patches as-is), so you wouldn't want to include his
Reviewed-by:.

If you make any changes beyond the minor ones mentioned in my reviews
or beyond plagiarizing commit message enhancements offered by my or
Junio's reviews, then you'd also probably want to hold off adding my
Reviewed-by: since I wouldn't yet have reviewed whatever new changes
you're making. (And, if you do make changes beyond ones I mentioned,
and if I review them and consider them issue-free, I can always
re-extend my Reviewed-by:.)
