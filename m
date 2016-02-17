From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v5 02/12] ref-filter: use strbuf_split_str_omit_term()
Date: Wed, 17 Feb 2016 22:34:59 +0530
Message-ID: <CAOLa=ZQO065j5VfJabbV6jww5Z2f3jbaRQDfDcG9NY4x2txrFQ@mail.gmail.com>
References: <1455649215-23260-1-git-send-email-Karthik.188@gmail.com>
 <1455649215-23260-3-git-send-email-Karthik.188@gmail.com> <20160216192231.GA16567@sigill.intra.peff.net>
 <CAPig+cTiwHs+dD+jqAp8SNkwjQ2OzDsC8yopRgF7gctrGi5uUw@mail.gmail.com>
 <20160216204954.GC27484@sigill.intra.peff.net> <CAPig+cQDs35Uirm5cG552tR8iCFOstNJoOzLCZiXCgnq+g7MRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 18:05:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aW5Xj-0001Cd-9x
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 18:05:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030447AbcBQRFb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 12:05:31 -0500
Received: from mail-vk0-f47.google.com ([209.85.213.47]:34526 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030430AbcBQRF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 12:05:29 -0500
Received: by mail-vk0-f47.google.com with SMTP id e185so20242401vkb.1
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 09:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=aidKGxqHDdVW/LO93OBwAwdfyHydZEYwUnZ9J2It3xA=;
        b=rcFkkIBNhke57rBZVYJrSsUluoW2fS1mrr6bCg4zCusrRAd8Tpu/zmdOk5d4rFTicf
         jHOVFaCz2M2HXauGcHS9QPIMj9WUljBD3tAMm8ovkZZ/Hz+3r79pOCQdBtIV8MiTpquT
         PZ+6m3zqQHTt1UhHJL2PsSSaKpP/KJS9RNoVGJNW5YlUx8BlakCojudgpzLOk7gKGNCZ
         kScJj8G3DXssS3bfECUhRedXUI2iTKssdN86P2hC2iPeLH5Kld69mz0gG7GpvHFPAIJ0
         IzOgGgyUYcuaQpqayxHAolw74Z+vR8wM+LTBln5n2trhHhM2UcMHLXm40B3sx6zvjCQc
         UZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=aidKGxqHDdVW/LO93OBwAwdfyHydZEYwUnZ9J2It3xA=;
        b=RrAgGWIMoJn6P9001ECmhEh9Zpsu2gQNdR7+IWu3BctVNKmRNksKrI4PCElLWCtZQB
         kFkXO5qy5R2KbHsY6jDlceqEcIfEZoQRfjxrVsxJ9ONtCzGZZJUZ2gXvTqlUO1d66D9X
         XC3irExFbtasWRQsc8fYiOzdE3mgB2MYzQcXUZHCrm4D5PKCMXIfNGSQgSOCgfL2RCOC
         wWiUn6br9Wg7c3LQjNu4BRHDQQXltyCL7vKxwRyvXPa9EmKYHuhcFNkpH7F08IAOneoj
         CC2AiCtupeEmMTC9O8xNJb21NbA5hOIGJPhKBBXJKhO2jbipvl2CELCd+CV7am0rsJ7/
         ApkA==
X-Gm-Message-State: AG10YOQsSue2Szi5/D3OWquOhuOtkeHDijSOJ07BfAvFr9dpmNJjJELXGcVOWQl9gcLSt6YTu0mxU0B1Ms4ktg==
X-Received: by 10.31.167.75 with SMTP id q72mr2326767vke.71.1455728728881;
 Wed, 17 Feb 2016 09:05:28 -0800 (PST)
Received: by 10.103.82.133 with HTTP; Wed, 17 Feb 2016 09:04:59 -0800 (PST)
In-Reply-To: <CAPig+cQDs35Uirm5cG552tR8iCFOstNJoOzLCZiXCgnq+g7MRQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286512>

On Wed, Feb 17, 2016 at 2:39 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Feb 16, 2016 at 3:49 PM, Jeff King <peff@peff.net> wrote:
>> On Tue, Feb 16, 2016 at 03:12:29PM -0500, Eric Sunshine wrote:
>>> > Did you consider just using string_list_split for this? AFAICT, you
>>> > don't care about the results being strbufs themselves, and it would do
>>> > what you want without having to bother with patch 1. [...]
>>>
>>> That's a nice idea, however, I'm not sure if making it part of this
>>> series this late in the game is a good idea. The series has gone
>>> through major changes and heavy review in each of the preceding
>>> versions, and turnaround time has been consequently quite slow (due
>>> both to the amount of work required by Karthik for each version, and
>>> to the amount of time needed by reviewers to digest all the new
>>> changes). v4 was the first one which had settled to the point where
>>> only minor changes were needed, and we were hoping to land the series
>>> with v5. [...]
>>>
>>> With that in mind, it might be better to make this change as a
>>> followup to this series. On the other hand, as you say, waiting would
>>> expand the strbuf_split interface undesirably, so the alternative
>>> would be for Karthik to submit v6 with this change only (to wit: drop
>>> patch 1 and rewrite patch 2 as you've shown). While such a change will
>>> again require careful review, at least it is well localized, and
>>> Karthik's turnaround time shouldn't be too bad. So...
>>
>> Yeah, I don't insist, and like I said, I'm not 100% sure we can get rid
>> of the strbuf_split interface anyway. I thought it might actually make
>> things easier by making the series _shorter_ (so my regret was that
>> mentioning earlier could have saved reviewing effort on patch 1).
>>
>> It does mean extra review of the patch I posted, but my hope was that
>> it's small and localized, and wouldn't impact the later stuff seriously
>> (there are some textual tweaks to carry it forward, though).
>
> My initial reaction was negative due to the heavy review burden this
> series has demanded thus far, however, my mind was changing even as I
> composed the above response. In retrospect, I think I'd be okay seeing
> a v6, for the following reasons:
>
> - I already ended up reviewing the the suggested new changes pretty
> closely as a side-effect of reading your proposal.
>
> - It would indeed be nice to avoid introducing
> strbuf_split_str_omit_term() in the first place; thus one less thing
> to worry about if someone ever takes on the task of retiring the
> strbuf_split interface.
>
> - It should be only a minimal amount of work for Karthik, thus
> turnaround time should be short.
>
> So, I think I'm fine with it, if Karthik is game.

Sounds good to me.

I just read the conversation between Jeff, Junio and You about the whitespace
counter-argument and I think its good to go ahead with v6 with Jeff's suggested
change.

Since he's already pushed the changes on top of my changes to:

 git://github.com/peff/git.git jk/tweaked-ref-filter

I'll just have a look and push that to the list as v6.

-- 
Regards,
Karthik Nayak
