From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v4 4/4] notes: teach git-notes about notes.<ref>.merge option
Date: Wed, 12 Aug 2015 12:16:43 -0700
Message-ID: <CA+P7+xournf+1Cqnr-AAO+EzUee3KfEevFQLhXkqyfQGBvPRpQ@mail.gmail.com>
References: <1439326641-9447-1-git-send-email-jacob.e.keller@intel.com>
 <1439326641-9447-5-git-send-email-jacob.e.keller@intel.com>
 <CALKQrgeDuRkXm2LzDOuZDZLOBRXjLmmRvhtXfXScWfLKX+9t=g@mail.gmail.com>
 <xmqqy4hhmedb.fsf@gitster.dls.corp.google.com> <CA+P7+xrSAo43=-3q-7SPxerYPKU3+T75dG5dTE=H8odicRDxSg@mail.gmail.com>
 <xmqqa8twl3x9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johan Herland <johan@herland.net>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Git mailing list <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 21:17:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPbWP-0003oU-MU
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 21:17:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751839AbbHLTRF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2015 15:17:05 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:33184 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443AbbHLTRE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2015 15:17:04 -0400
Received: by igbpg9 with SMTP id pg9so118856637igb.0
        for <git@vger.kernel.org>; Wed, 12 Aug 2015 12:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Ar0stGAbqcHOYHtJ/dafjwWsQlTtE1Ako1ed1H/E0Ao=;
        b=lVa+Dl//zdtV0xi1dZBFJq3VvkN+GoduQB3zj35IizPa6UyL/RhXBEUb91atb9Dixi
         dYSUkGYSRBDNgqDLJpxkqgejwi4TQ/K2qp8RUlpYB/pm+F7E/ptT5hKEUTZ2/UCyyBFY
         uQVyJkWXSIwuL4CEphnGRJRVAFJN/MIWmoi5314FRfPppoD+Um2yGI04DzrIaiMtEnlz
         e/vVFDTv3xYqyZTiHNBUfuxrTZPOXTfiAs57DOH0061XnJnuqD66LZctV1XGSJkz6aOZ
         PUn2TBBlaiorx3F0q5VcrTtgAbq+sP3AuFvjOJ1hxrDr4hAZdMlqfLThshZ4OQNIwe8R
         XF4Q==
X-Received: by 10.50.78.161 with SMTP id c1mr26325106igx.35.1439407023008;
 Wed, 12 Aug 2015 12:17:03 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Wed, 12 Aug 2015 12:16:43 -0700 (PDT)
In-Reply-To: <xmqqa8twl3x9.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275802>

On Wed, Aug 12, 2015 at 12:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
>
>> On Tue, Aug 11, 2015 at 7:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Johan Herland <johan@herland.net> writes:
>>>
>>>> I know that we don't yet have a "proper" place to put remote notes refs,
>>>> but the <ref> in notes.<ref>.merge _must_ be a "local" notes ref (you even
>>>> use the <localref> notation in the documentation below). Thus, I believe
>>>> we can presume that the local notes ref must live under refs/notes/*,
>>>> and hence drop the "refs/notes/" prefix from the config key (just like
>>>> branch.<name>.* can presume that <name> lives under refs/heads/*).
>>>
>>> I am OK going in that direction, as long as we promise that "notes
>>> merge" will forever refuse to work on --notes=$ref where $ref does
>>> not begin with refs/notes/.
>>
>> It appears that notes merge already allows operating on refs not in "refs/notes"
>
> If that is the case, then the only sane choice left to us is to
> accept only fully qualified refname, e.g. refs/notes/commit, in
> notes.<ref>.mergestrategy, without shortening, I would think.

Oh interesting. I did a test. If you provide a fully qualified ref not
inside refs/notes, then it assumes you meant refs/notes/refs/foo/y
rather than refs/foo/y

I need to do some more digging on this to determine the exact thing going on...

Regards,
Jake
