From: Patrick Palka <patrick@parcs.ath.cx>
Subject: Re: [PATCH] Improve contrib/diff-highlight to highlight
 unevenly-sized hunks
Date: Thu, 18 Jun 2015 16:23:42 -0400
Message-ID: <CA+C-WL9HmVVzwCou40ZFZQFyaETVpkoxQM5mpH2R0GfQPiwO7A@mail.gmail.com>
References: <1434388853-23915-1-git-send-email-patrick@parcs.ath.cx>
 <xmqqwpz1f22b.fsf@gitster.dls.corp.google.com> <CA+C-WL-CC9o13Rxrr+mKw+vbx=aEJmguLnwMwO=fE-JPJ2DqEg@mail.gmail.com>
 <xmqq1th8ga9b.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 22:24:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5gML-0000VX-Ce
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 22:24:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755747AbbFRUYG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 16:24:06 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:34903 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753860AbbFRUYE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 16:24:04 -0400
Received: by oiax193 with SMTP id x193so66000217oia.2
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 13:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=T3K30DildZdyXQn6/znZRt0WCb6w5n2CY9a4ICmm9Hk=;
        b=jB56Ulg0OB5Swfpcs+VPo1sJaxi2R0kVfRly92q90jmC+L+eRxN4MzKtf0Bmz3lhBa
         2V7ocesV2OOKubzESkL7EIXikBhJEYdj7rxJCzf275gbekQib8gWuBK6lJ+6ZMl1daTs
         0c6KencyEIxHq7ovz0nrjhH8s/KBAupL9rSDGv9Wg2z5+JRj5p7xrffEhyI5y2815Z/7
         kpVLS8y8eRNQKgKYNRcH0iyt0TCiJYMQUFkoQwgBNyEa3nkdEf0N94WUahVqKa38FOkj
         iyRyyEqUa9I52kvMBifbyZfR6oYwgR7vlERCkt1RnnkUKAf8ue2Vr775+tU6iUbYVAcS
         o1mQ==
X-Gm-Message-State: ALoCoQmrYaIS9Af2OzAPtok7YhDJsoEz+5RM3U+93dlkMjtODZla8r3Uu2jiIhpT9N3cpVb8/43H
X-Received: by 10.182.42.131 with SMTP id o3mr10568227obl.59.1434659043452;
 Thu, 18 Jun 2015 13:24:03 -0700 (PDT)
Received: by 10.182.96.167 with HTTP; Thu, 18 Jun 2015 13:23:42 -0700 (PDT)
X-Originating-IP: [67.83.172.216]
In-Reply-To: <xmqq1th8ga9b.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272067>

On Thu, Jun 18, 2015 at 2:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Patrick Palka <patrick@parcs.ath.cx> writes:
>
>>> I have this nagging feeling that it is just as likely that two
>>> uneven hunks align at the top as they align at the bottom, so while
>>> this might not hurt it may not be the right approach for a better
>>> solution, in the sense that when somebody really wants to do a
>>> better solution, this change and the original code may need to be
>>> ripped out and redone from scratch.
>>
>> Hmm, maybe. I stuck with assuming hunks are top-aligned because it
>> required less code to implement :)
>
> Yeah, I understand that.
>
> If we will need to rip out only this change but keep the original in
> order to implement a future better solution, then we might be better
> off not having this change (if we anticipate such a better solution
> to come reasonably soon), because it would make it more work for the
> final improved solution.  But if we need to rip out the original as
> well as this change while we do so, then having this patch would not
> make it more work, either.
>
> So as I said, I do not think it would hurt to have this as an
> incremental improvement (albeit going in a possibly wrong
> direction).
>
> Of course, it is a separate question if this change makes the output
> worse, by comparing unmatched early parts of two hunks and making
> nonsense highlight by calling highlight_pair() more often.  As long
> as that is not an issue, I am not opposed to this change, which was
> what I meant to say by "this might not hurt".
>

That makes sense.  The extra useless highlighting indeed is currently
a problem but it may yet be worked around.
