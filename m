From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 05/10] ref-filter: add support to sort by version
Date: Mon, 27 Jul 2015 22:33:59 +0530
Message-ID: <CAOLa=ZQrBbgeYjnVaLf4EV+S1aRYBjJ-G==K_1J8XbGUCp5mmg@mail.gmail.com>
References: <1437764685-8633-1-git-send-email-Karthik.188@gmail.com>
 <1437764685-8633-6-git-send-email-Karthik.188@gmail.com> <xmqqd1zfkgi3.fsf@gitster.dls.corp.google.com>
 <CAOLa=ZQ89Vz82ro_V8mTgYKZ0UUgbsbAW6zgSgyiZ1gpwjTOHA@mail.gmail.com> <xmqqvbd5ipy1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 27 19:04:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJlpK-0007TY-B2
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jul 2015 19:04:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752294AbbG0RE3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2015 13:04:29 -0400
Received: from mail-oi0-f52.google.com ([209.85.218.52]:36028 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803AbbG0RE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2015 13:04:29 -0400
Received: by oibn4 with SMTP id n4so54876101oib.3
        for <git@vger.kernel.org>; Mon, 27 Jul 2015 10:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=bhYwzwnFpG2PsXHByJjyETQ6eqa/Lgor/BYx4yAE8jk=;
        b=nyaR8XlQzN/ZZzyLW0GNNkpriiVQZ202rT6O/WouLKZ4fZ8SCIPSUBRRksJlkxtHPH
         WH/lJkK2w5yAEOiE3XrFvYWppuBF3SM5BiyTyUoFClcHN6gGnwdmHUj1SwlAd/P4AB3C
         7yNRHcAFtvVMS5LxjTOKlnuUjedXHsTF60KsS4Va1+LgNyRncZjfZfXHbVCkIjVMsp/w
         nMxoz2G80PtRkzzIuos6RRSZJWqpcCTgj7+dQ5SNBMhOBD2WgiK/LtQlxQfWY9Kz6dVx
         d6cc9andhxenRUgSEZM9aSyRzDWD81wQ82r937AdvP9gYJLf31qdVVrcPJkdNv8VDbXA
         93bA==
X-Received: by 10.202.186.132 with SMTP id k126mr28122222oif.60.1438016668568;
 Mon, 27 Jul 2015 10:04:28 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Mon, 27 Jul 2015 10:03:59 -0700 (PDT)
In-Reply-To: <xmqqvbd5ipy1.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274691>

On Mon, Jul 27, 2015 at 8:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> On Sun, Jul 26, 2015 at 4:10 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>>> Without looking at the callers, s->version looks like a misdesign
>>> that should be updated to use the same cmp_type mechanism?  That
>>> would lead to even more obvious construct that is easy to enhance,
>>> i.e.
>>>
>>>         switch (cmp_type) {
>>>         case CMP_VERSION:
>>>                 ...
>>>         case CMP_STRING:
>>>                 ...
>>>         case CMP_NUMBER:
>>>                 ...
>>>         }
>>>
>>> I dunno.
>>>
>>> Other than that (and the structure of that "format-state" stuff we
>>> discussed separately), the series was a pleasant read.
>>>
>>> Thanks.
>>
>> That was the previous design, but Duy asked me to do this so
>> that we could support all atoms. And I agree with him on this.
>>
>> http://article.gmane.org/gmane.comp.version-control.git/273888
>
> I am not objecting, but $gmane/273888 does not immediately read, at
> least to me, as suggesting using a mechanism different from cmp_type
> but a dedicated field s->version.  Puzzled...
>

What I mean was since "version"/"v" aren't atoms as such, their processing is
done before we parse through atoms and fill used_atoms and used_atom_type.
cmp_type is obtained from the used_atom_type, which isn't filled by
"version"/"v".
Hence the dedicated field, just like reverse.

-- 
Regards,
Karthik Nayak
