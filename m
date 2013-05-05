From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 0/2] remote-bzr: couple of fixes
Date: Sun, 5 May 2013 13:42:22 -0500
Message-ID: <CAMP44s1D7LOhDGkZguosPiXyuJ5cP2hmgq4AWagwadrJYK1Pgg@mail.gmail.com>
References: <1367627467-15132-1-git-send-email-felipe.contreras@gmail.com>
	<7vd2t5uvi2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 05 20:42:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZ3tP-00021y-N5
	for gcvg-git-2@plane.gmane.org; Sun, 05 May 2013 20:42:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751977Ab3EESmY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 May 2013 14:42:24 -0400
Received: from mail-we0-f170.google.com ([74.125.82.170]:37473 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751910Ab3EESmY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 May 2013 14:42:24 -0400
Received: by mail-we0-f170.google.com with SMTP id z53so2429143wey.15
        for <git@vger.kernel.org>; Sun, 05 May 2013 11:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=G4FjRq3UMRMNqloZ/ymigOjtberrigX9P3H1YqG6i2c=;
        b=ugTtQSF3RGQyh3EZEoHzBsPfeXoBK7Fy37i+rF4bvhePSOPv+bTUQKhs9i34Tk3zPZ
         3Ii/DvJnBzpKzji+gcwCD3Lm1mqL0U+dPdxjol6GsIgZnErGoOedKtAz4W7WRD7OXre+
         Z3LJUVpy2Yt4tJBZA5P+0GkX5h7LXPwe6SwonHRyvFR8tIrCgDbTUE7j7/U2AL2yBaWo
         esSB0b4wTAAB2XQ2BIA3vtSSVrfDzJfbUKw163R97FuGj0b9RKE8rvC8oKpNEW+TTLOm
         Q1O8HqHUtxc5XtSncRd9gZ52V7VFI41iNS5htRk8wx98W3nFn/2NnL0L+BUAfYnLFy0m
         esZg==
X-Received: by 10.180.185.179 with SMTP id fd19mr5503830wic.1.1367779342787;
 Sun, 05 May 2013 11:42:22 -0700 (PDT)
Received: by 10.194.240.135 with HTTP; Sun, 5 May 2013 11:42:22 -0700 (PDT)
In-Reply-To: <7vd2t5uvi2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223413>

On Sun, May 5, 2013 at 1:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> The previous version had an indentation bug (did I mention I hate python?).
>>
>> A few fixes to be applied on top of the massive changes already queued. Nothing
>> major.
>
> [2/2] may not matter much in the context of my tree (people would
> use post 1.8.2 fast-export if they are using remote-bzr from 1.8.3
> from my tree ;-),

Maybe, but if even if they have the latest git, pushing a tag will
fail miserably, and with the patch it would fail nicely :)

> but [1/2] sounds like it is a good thing to have
> in 1.8.3 (not "on top of that 'massive' series").
>
> Assuming the "otherwise some version of bzr might barf" problem is
> that repo.generate_revision_history() in those versions may not
> apply str() to its first parameter and the caller is expected to
> pass a string there, or something?

No, there's no change to repo.generate_revision_history(), because we
already convert the elements of the array to strings, it's the other
callers of Marks::to_rev() that see a change, namely code that pushes
to a remote, I think.

And BTW, they are already strings, but unicode strings, because they
come from a json file, somehow bazaar doesn't like that, but it works
fine in my machine without the patch. Shrugs.

Also, the emacs developers seem to be fine with all these changes,
there's only one patch pending that I need to cleanup.

Cheers.

-- 
Felipe Contreras
