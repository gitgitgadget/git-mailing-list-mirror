From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 2/3] Move copy_note_for_rewrite + friends from
 builtin/notes.c to notes-utils.c
Date: Wed, 12 Jun 2013 21:14:43 +0200
Message-ID: <CALKQrgfPktWOcUKnWecQcE-wMVwTqMES112nHcqnCrZzLLqOeg@mail.gmail.com>
References: <7vehc8a05n.fsf@alter.siamese.dyndns.org>
	<1370995981-1553-1-git-send-email-johan@herland.net>
	<1370995981-1553-3-git-send-email-johan@herland.net>
	<CAMP44s2pUW_+w6B_R-A=vxOg1Ay6iLmc4MQsA_sfDF+GP-XsWw@mail.gmail.com>
	<CALKQrgfxrKz5bB=AAmL1ZtBFRK2Bx6TrRd1AsMEVv8bTAH0KCg@mail.gmail.com>
	<CAMP44s3KAeDPo1Cw8eFsU=A6H7oUGmf+eLAMvGV+R2_hPXHLbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: gitster@pobox.com, git@vger.kernel.org, jrnieder@gmail.com,
	pclouds@gmail.com, artagnon@gmail.com, john@keeping.me.uk,
	vfr@lyx.org, peff@peff.net, torvalds@linux-foundation.org,
	Thomas Rast <trast@inf.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 12 21:14:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmqVT-0000UP-4k
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 21:14:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756085Ab3FLTOu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jun 2013 15:14:50 -0400
Received: from mail12.copyleft.no ([188.94.218.224]:59308 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755220Ab3FLTOt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 15:14:49 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1UmqVL-0006Ho-59
	for git@vger.kernel.org; Wed, 12 Jun 2013 21:14:47 +0200
Received: from mail-oa0-f41.google.com ([209.85.219.41])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1Umpr5-000EdE-23
	for git@vger.kernel.org; Wed, 12 Jun 2013 20:33:11 +0200
Received: by mail-oa0-f41.google.com with SMTP id n10so3142826oag.28
        for <git@vger.kernel.org>; Wed, 12 Jun 2013 12:14:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=FXhe/t4P449EWp2sAOzQHmESBUg6EmF2cUPFWK2xgO0=;
        b=hha8ALFc6codBPOC4IeafHhwZDpXOEdTBopI6jPFsAbma9zvf2cWes98jUJnyQm/lb
         0Fnh1F0+AaYU0ZSObWsnQLJqzhOsK1NEMEn71tD1zyOYq2ZCuSGI4P3c5PWPjDqoJGoI
         hPi7s2aaSdRu1A2wW/bFNeXl9UXH3UDZdYYhGtEhRi3GHX4iSioGDZyq7vgW2pMjl3Pr
         ufFFtxMuJIqDN3l5Y6oBmFX/8ZWYCobd/DjPGO8dg+XHkJGT2y4TLoS7IGsvuYQxedxY
         umSL2KevrVlOYwYbJscW41Ods2gIBIKvA15F3NfFE+BziGiF6eyS9M0fDfrlrntcF3zb
         qSOw==
X-Received: by 10.182.16.137 with SMTP id g9mr14449464obd.17.1371064483272;
 Wed, 12 Jun 2013 12:14:43 -0700 (PDT)
Received: by 10.182.102.5 with HTTP; Wed, 12 Jun 2013 12:14:43 -0700 (PDT)
In-Reply-To: <CAMP44s3KAeDPo1Cw8eFsU=A6H7oUGmf+eLAMvGV+R2_hPXHLbw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227665>

On Wed, Jun 12, 2013 at 8:28 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Wed, Jun 12, 2013 at 2:10 AM, Johan Herland <johan@herland.net> wrote:
>> On Wed, Jun 12, 2013 at 2:32 AM, Felipe Contreras <felipe.contreras@gmail.com> wrote:
>>> On Tue, Jun 11, 2013 at 7:13 PM, Johan Herland <johan@herland.net> wrote:
>>>> This is a pure code movement of the machinery for copying notes to
>>>> rewritten objects. This code was located in builtin/notes.c for
>>>> historical reasons. In order to make it available to builtin/commit.c
>>>> it was declared in builtin.h. This was more of an accident of history
>>>> than a concious design, and we now want to make this machinery more
>>>> widely available.
>>>>
>>>> Hence, this patch moves the code into the new notes-utils.[hc] files
>>>> which are included into libgit.a. Except for adjusting #includes
>>>> accordingly, this patch merely moves the relevant functions verbatim
>>>> into the new files.
>>>>
>>>> Cc: Thomas Rast <trast@inf.ethz.ch>
>>>> Signed-off-by: Johan Herland <johan@herland.net>
>>>
>>> I wonder where you got that idea from. Did you come up with that out thin air?
>>
>> Obviously not. I should add
>>
>> Suggested-by: Junio C Hamano <gitster@pobox.com>
>
> You are still not explaining where the idea came from. And you are
> doing that with the express purpose of annoying.

Truly, I am not trying to annoy anyone. I have not followed the
preceding discussion closely, and I wrote the patch based solely on
one paragraph from Junio's email[1].

> Where did the idea come from?

I got it from Junio. I do not know if I might have accidentally
plagiarized something you already submitted to the mailing list,
although I would be surprised if that was the case, since - as far as
I understand - you are opposed to this solution. Furthermore, I
thought you might not like having your name mentioned in a patch you
do not agree with, but if you think differently I have no problem
adding your name. I don't know what kind of attribution you would
prefer though:

Originally-envisioned-by: Felipe Contreras <felipe.contreras@gmail.com>?
NAKed-by: Felipe Contreras <felipe.contreras@gmail.com>?
Something else?


...Johan


[1]: Quoted from <7vehc8a05n.fsf@alter.siamese.dyndns.org>:
On Tue, Jun 11, 2013 at 9:59 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> There is only one right solution.  If a useful function is buried in
> builtin/*.o as a historical accident (i.e. it started its life as a
> helper for that particular command, and nobody else used it from
> outside so far) and that makes it impossible to use the function
> from outside builtin/*.o, refactor the function and its callers and
> move it to libgit.a.

-- 
Johan Herland, <johan@herland.net>
www.herland.net
