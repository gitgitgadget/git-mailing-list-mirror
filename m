From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3] ref-filter: fallback on alphabetical comparison
Date: Thu, 29 Oct 2015 00:25:27 +0530
Message-ID: <CAOLa=ZSF5bJocJkMG70x0kTaU139pj0-ONypC=V2Tdnu3yQtow@mail.gmail.com>
References: <1445972456-5621-1-git-send-email-Karthik.188@gmail.com> <xmqq7fm8ozu9.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 19:56:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrVtG-000273-3A
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 19:56:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756103AbbJ1Sz7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 14:55:59 -0400
Received: from mail-vk0-f51.google.com ([209.85.213.51]:35795 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754874AbbJ1Sz5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 14:55:57 -0400
Received: by vkfw189 with SMTP id w189so11591410vkf.2
        for <git@vger.kernel.org>; Wed, 28 Oct 2015 11:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=GtmiiJlGloO7Z5wcRj1M7iQi7iC1d5Ggt1xCSzGGndg=;
        b=l7w0Aq+uNl4Oi+eHzk3AFFnBlpo6BmwdXIEnqmRbXgSD2uemI5qDb7/oUN98iAqSC/
         b8KZhvsqLaTUi7HQAFx/NF6T6YanjOpQwE4lVv0lxbCrvWb7CbrHANNlxQPj0Rc4NjDG
         bM1MjhoC3bc4mcbEJEMYBhMTgtVg5ntTnBCnZXk9QIrXuPxRa8L3cORdsQy0UPATxzoV
         Pfr4arU6jyR0StJlC4yFo17dXQlD9zZsTgV6fxG0cDGx0U1AKRvGaxDiPChetkKjztyx
         YumYF24+YQcpGZZ8ZkqnKgFXDjygQZ8wVm00otzLYeGXNDhlgCsBQ9hzEpTc/CKCt/YD
         77/A==
X-Received: by 10.31.49.10 with SMTP id x10mr35829756vkx.46.1446058556623;
 Wed, 28 Oct 2015 11:55:56 -0700 (PDT)
Received: by 10.103.0.7 with HTTP; Wed, 28 Oct 2015 11:55:27 -0700 (PDT)
In-Reply-To: <xmqq7fm8ozu9.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280390>

On Wed, Oct 28, 2015 at 1:20 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Hence, fallback to alphabetical comparison based on the refname
>> whenever the other criterion is equal. Fix the test in t3203 in this
>> regard.
>
> It is unclear what "in this regard" is.  Do you mean this (I am not
> suggesting you to spell these out in a very detailed way in the
> final log message; I am deliberately being detailed here to help me
> understand what you really mean)?
>
>     A test in t3203 was expecting that branch-two sorts before HEAD,
>     which happened to be how qsort(3) on Linux sorted the array, but
>     (1) that outcome was not even guaranteed, and (2) once we start
>     breaking ties with the refname, "HEAD" should sort before
>     "branch-two" so the original expectation was inconsistent with
>     the criterion we now use.
>

Exactly what you're saying, they happened to have the same objectsize.
Hence sorting them would put them together, but since we compare the
refname's the "HEAD" ref would come before "branch-two".

>     Update it to match the new world order, which we can now depend
>     on being stable.
>
> I am not sure about "HEAD" and "branch-two" in the above (it may be
> comparison between "HEAD" and "refs/heads/branch-two", for example).
>

It actually is, we consider "refs/heads/branch-two rather then the shortened
version of this. It makes sense to classify refs this way, even though this
was a side effect of this commit.

-- 
Regards,
Karthik Nayak
