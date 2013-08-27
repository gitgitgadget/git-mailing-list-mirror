From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [RFC/PATCH] Fix path prefixing in grep_object
Date: Tue, 27 Aug 2013 07:54:34 -0400
Message-ID: <CABURp0r6neiqhOA=JsT67Oxr-zUNLpsr71bVc7F_hWWM61KoGQ@mail.gmail.com>
References: <1377394558-371-1-git-send-email-hordp@cisco.com>
 <CABURp0qG7Nnjpp17MAO7Ltwf51EsswZ3GcT-qyt14Vs1tc9pGw@mail.gmail.com>
 <xmqqa9k6moif.fsf@gitster.dls.corp.google.com> <20130825042314.GE2882@elie.Belkin>
 <xmqqk3jal4t7.fsf@gitster.dls.corp.google.com> <xmqqfvtwkjp8.fsf@gitster.dls.corp.google.com>
 <CABURp0oGMTEgX3TKKEMAOxe6T0=uij+bAyc+5u0x_UHwEPo3CQ@mail.gmail.com>
 <xmqqr4dgifp5.fsf@gitster.dls.corp.google.com> <CABURp0odEGgZO1yWFgXS+akPb4wJHiTLoQcmqBd00oYnPZ77vA@mail.gmail.com>
 <xmqqbo4kicsm.fsf@gitster.dls.corp.google.com> <xmqqhaebhj3u.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>, Phil Hord <hordp@cisco.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 27 13:55:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEHrT-0001bp-Cb
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 13:55:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753344Ab3H0Ly4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 07:54:56 -0400
Received: from mail-ve0-f177.google.com ([209.85.128.177]:53683 "EHLO
	mail-ve0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753332Ab3H0Lyz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 07:54:55 -0400
Received: by mail-ve0-f177.google.com with SMTP id cz11so2985066veb.36
        for <git@vger.kernel.org>; Tue, 27 Aug 2013 04:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=0/LBQUhwwT8v9zK3EjOy/k9LKg/80bnGvFVVr94WoNg=;
        b=I9H8xcMzjLu57AI4b04cqxbPQJIjI4laH3AkNzgpcb1YU9esD7ihVAaQ65cjbek2T9
         c5+Tzx0lm3Zxs50hxIIUwUkA3G1FvGflxkhz+KRTh2T1jK5gdwfkae7SrPhH7qWcnpZ6
         3pm7Dcgp+Hb9mODwb6eyFPuBbv6lXgnUPoxoj6OG4vUxVCJOgGkGcreiBwE4qHnOZsmY
         fRDDpIfccTidFVslvHCqM4eMCmm4sCcKuHXUQFWBt34v+7kkfjg45mlJ1uRDBXP4AYqQ
         myCu2lGRjXZI4rhPe1GaIl1nEJuAcXmUIKWP3Eb1ymPflg43MTMIZbQ4RI5IcMHRXRto
         I2Bw==
X-Received: by 10.52.92.73 with SMTP id ck9mr16717407vdb.2.1377604494287; Tue,
 27 Aug 2013 04:54:54 -0700 (PDT)
Received: by 10.58.49.197 with HTTP; Tue, 27 Aug 2013 04:54:34 -0700 (PDT)
In-Reply-To: <xmqqhaebhj3u.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233084>

On Tue, Aug 27, 2013 at 12:07 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Not necessarily.  If the user is asking the question in a more
>> natural way (I want to see where in 'next' branch's tip commit hits
>> appear, by the way, I know I am only interested in builtin/ so I'd
>> give pathspec as well when I am asking this question), the output
>> does give <commit> <colon> <path>, so it is more than coincidence.
>
> This part needs to be qualified.  "Natural" is of course in the eyes
> of beholder.  If we assume that your #1 holds true (i.e. the tuple
> <in which tree object are we reporting, what path we saw hits> is
> important and merging them into one <in what blob we saw hits> lose
> information),

"My #1" is really "what I inferred from your statements."  I did not
think the tuple was important, but I agree that may be my
shortsightedness.  If the tuple is important, then it seems to me that
the --null behavior is a bug (the colon is left intact); but changing
it now seems senseless or harmful.

> then it is natural to ask "inside origin/master tree,
> where do I have hits?  By the way, I am only interested in builtin/"
> and get "origin/master:builtin/pack-objects.c" as an answer (this is
> from your earlier example), than asking "inside origin/master:builtin
> tree, where do I have hits?"
>
> If we do not consider #1 is false and the tree information can be
> discarded, then it does not matter if we converted the colon after
> origin/master to slash when we answer the latter question, and the
> latter question stops being unnatural.
>
>> ...
>> but it might be a good change to allow A:B:C to be parsed as a
>> proper extended SHA-1 expression and make it yield
>>
>>       git rev-parse $(git rev-parse $(git rev-parse A):B):C
>>
>> Right now, "B:C" is used as a path inside tree-ish "A", but I think
>> we can safely fall back, when path B:C does not appear in tree-ish
>> A, to see if path B appears in it and is a tree, and then turn it
>> into a look-up of path C in that tree A:B.
>
> And if we want to keep the <tree, path> tuple, but still want to
> make it easier to work with the output, allowing A:B:C to be parsed
> as an extended SHA-1 expression would be a reasonable solution, not
> a work-around. The answer is given to the question asked in either
> way (either "in origin/master, but limited to these pathspecs" or
> "in the tree origin/master:builtin/") without losing information,
> but the issue you had is that the answer to the latter form of
> question is not understood by the object name parser, which I
> personally think is a bug.

I am beginning to agree, though we discovered some other weird output
from grep which also does not parse. (origin/master:../relative/path).

It seems that fixing this bug could be very confusing for
get_sha1_with_context unless the context was rewritten to match the
traditional syntax.

P
