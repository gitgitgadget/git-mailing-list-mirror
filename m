From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/4] ref-filter: add ref-filter API
Date: Thu, 21 May 2015 14:40:38 -0400
Message-ID: <CAPig+cTT+MEUtRJ6=sf5x-q0S2neL=xeNq_gEQAEy4VSRZga7A@mail.gmail.com>
References: <555C88C2.8060902@gmail.com>
	<1432127904-21070-2-git-send-email-karthik.188@gmail.com>
	<CAPig+cTiYk_oGj98QttMMDjyJDFV256yOwu9b8_znOMnaMt7-A@mail.gmail.com>
	<555E161C.1080504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Christian Couder <christian.couder@gmail.com>
To: karthik nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 21 20:40:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvVOe-0004my-AJ
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 20:40:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756107AbbEUSkk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 14:40:40 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:35620 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754083AbbEUSkj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 14:40:39 -0400
Received: by igbyr2 with SMTP id yr2so17472572igb.0
        for <git@vger.kernel.org>; Thu, 21 May 2015 11:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Wz8ABtz/nJWt7cit/46ih5IBGPDMwG0Mgy6OjOmHlOw=;
        b=LRv0llikBBIulWQi7x+LJoBjiB/lCZ/XyosAwZLyP39gDW4wLQD2U6/osNuxypVvek
         tfiAQj6/ufw7MEjbZ67Fllu1ysilPQUJNj3Fl8DfCRXvMwXIQSj4QejtgNWvzACDbQfK
         BoS4MDY0QU4OiUGzyVk6Pi6yGZBtrpxe9u19SPAtSN8M5NGOv1qlYtrUdMfilBEG5GtE
         zcD0TKy0H7Rqf/Wc/H774OQMut5fUX2T3dK5N0IdBFYr/rfLzZVloi9614ElQqZ5IY/H
         nqjOUwfRHlISxhGDgQVKJ7IPEyRIBXMiUQwQwxPMjJtbEgBAF8AIVx5zQPb4+f/yaIoy
         VDqA==
X-Received: by 10.42.146.202 with SMTP id k10mr4968562icv.34.1432233638999;
 Thu, 21 May 2015 11:40:38 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Thu, 21 May 2015 11:40:38 -0700 (PDT)
In-Reply-To: <555E161C.1080504@gmail.com>
X-Google-Sender-Auth: K8hwgIge2YjYR-MlszECTNjNcNg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269642>

On Thu, May 21, 2015 at 1:30 PM, karthik nayak <karthik.188@gmail.com> wrote:
> On 05/21/2015 12:37 AM, Eric Sunshine wrote:
>> On Wed, May 20, 2015 at 9:18 AM, Karthik Nayak <karthik.188@gmail.com>
>> wrote:
>>>   Makefile     |  1 +
>>>   ref-filter.c | 73
>>> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>   ref-filter.h | 47 ++++++++++++++++++++++++++++++++++++++
>>>   3 files changed, 121 insertions(+)
>>>   create mode 100644 ref-filter.c
>>>   create mode 100644 ref-filter.h
>>
>> A shortcoming of this approach is that it's not blame-friendly.
>> Although those of us following this patch series know that much of the
>> code in this patch was copied from for-each-ref.c, git-blame will not
>> recognize this unless invoked in the very expensive "git blame -C -C
>> -C" fashion (if I understand correctly). The most blame-friendly way
>> to perform this re-organization is to have the code relocation (line
>> removals and line additions) occur in one patch.
>>
>> There are multiple ways you could arrange to do so. One would be to
>> first have a patch which introduces just a skeleton of the intended
>> API, with do-nothing function implementations. A subsequent patch
>> would then relocate the code from for-each-ref.c to ref-filter.c, and
>> update for-each-ref.c to call into the new (now fleshed-out) API.
>
> Did you read Junio's suggestion on how I should re-order this WIP patch
> series ?
> That's somewhat on the lines of what you're suggesting. I'll probably be
> going ahead with that, not really sure about how blame works entirely so
> what do you think about that?

Yes, Junio's response did a much better job of saying what I intended.
Also, his response said something I meant to mention but forgot:
namely that, to ease the review task, code movement should be pure
movement, and not involve other changes.

Anyhow, follow Junio's advice. He knows what he's talking about. ;-)
