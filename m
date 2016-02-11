From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv9 0/6] Expose submodule parallelism to the user
Date: Thu, 11 Feb 2016 12:33:40 -0800
Message-ID: <CAGZ79kZE51PwFMtZL2BaUtiD87QbGJ67gBnxE2rK7LWzJbnoFA@mail.gmail.com>
References: <1455051274-15256-1-git-send-email-sbeller@google.com>
	<xmqq4mdh36o8.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYt9bw9MreiBhA_ZQNjS+1Xi71aNGwkjcfC1hwxkOoyYA@mail.gmail.com>
	<xmqqziv91qzi.fsf@gitster.mtv.corp.google.com>
	<xmqqlh6rvvwb.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 11 21:33:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTxvu-0008GH-0R
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 21:33:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbcBKUdm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 15:33:42 -0500
Received: from mail-ig0-f169.google.com ([209.85.213.169]:33040 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081AbcBKUdl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 15:33:41 -0500
Received: by mail-ig0-f169.google.com with SMTP id y8so19380423igp.0
        for <git@vger.kernel.org>; Thu, 11 Feb 2016 12:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=dK5LQq7U7HznspYg+eYK775HLNqo2BKBsTjLD8zaQ30=;
        b=edFVGSc1338mq2yVRDHbblmu3L8ab+IWuwyFdMnzfKCILwkZofU9sQqSOIya6tCelp
         VjFwwtS1upF932/zrR2HFjf0lfqWqt2PPjYULPa9X5YN7xD8Kgd5+sErH2tSAtoe8qsJ
         1GeWmWv2WUIEdwzjaCkaM3V99b0xZelSmAr2Ux+tScpZLdTFRwPo7t/LUZdFaxhCz1Jm
         mePSwyn9EPspvcFBmZIRCd7HMKUAfBCqz/ucw/DnHORJ+tnPIrogw/mjJiHFxaJc3+h0
         57TOzOIQjJphvQwcJIP4CTgQQRtZ6SXMOTG3kViyD8b8O3JJ7L6kOOelOvJxk/llu0VY
         cTlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=dK5LQq7U7HznspYg+eYK775HLNqo2BKBsTjLD8zaQ30=;
        b=Eft16ni/xfrDt0LwcQinAvR3QvIn7kNQ7gN6heY0CldqDmUW5TizJ8JMdgIv6trzTa
         3qZS1psF577ui5x07nzP76eifvpbMi1pHHjop0R6e22YliXkXKnfnsHf2tG10MN8/qnZ
         kI9UzdptiauA13hlXqr32yGR5bJYYuHY4i2r+3HwrRpsrJ2e+GyZTcouSKAkpm/Eeftg
         vhkWXYiK2iWs+GLiVPj9rJQgRBKSqSs+C9vTXeufyPORhvQf46C6HkrF9Jnx9o28uVrF
         9i4cvf97xATLijmBt1qEDbJKjzn5XD5oNookdnG6/WLqqANqCHLDiUolyGDVYo+ltQ2w
         V9og==
X-Gm-Message-State: AG10YOT2gf4QtAD28Hu9S+HEYDzp35FOalMPb7PeIdZbohbBGR9FUCvKL/S1S4XFZvzl2MbdgWrDLdypuTcvNxim
X-Received: by 10.50.88.74 with SMTP id be10mr441263igb.93.1455222820706; Thu,
 11 Feb 2016 12:33:40 -0800 (PST)
Received: by 10.107.4.210 with HTTP; Thu, 11 Feb 2016 12:33:40 -0800 (PST)
In-Reply-To: <xmqqlh6rvvwb.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285997>

On Thu, Feb 11, 2016 at 12:23 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Stefan Beller <sbeller@google.com> writes:
>>
>>>>> * This seems to clash with 00/20] refs backend.
>>>>>> Applied this on top of a merge between the current 'master' and
>>>>>> 'sb/submodule-parallel-update' topic to untangle the dependency;
>>>>>> otherwise there is no way for this topic to make progress X-<.
>>>>>
>>>>> Anything I can do to help with easing the clash?
>>>>
>>>> Perhaps try to rebase the series on top of such a merge (with this
>>>> updated series) yourself and propose it as a basis for the next
>>>> reroll for David?  In short, working together with topic(s) that
>>>> touch the same area?
>>>
>>> Ok, I'll see if I can find a better commit to base this series on.
>>
>> That is not what I meant.  I meant rebasing the refs-backend series
>> on top of a merge between this one and 'master', just like the way I
>> queued the refs-backend series on top of a merge between the
>> previous round of this series and 'master'.
>>
>> These two topics want to update the same piece of code, so another
>> possibility is to rebase this series on top of a merge between
>> refs-backend and 'master', but the current iteration of refs-backend
>> already depends on the previous round of this topic.  Rebasing this
>> on top of refs-backend would involve first adjusting parts of
>> refs-backend that touched the same code as the previous round of
>> submodule-parallel-update touched so that refs-backend would work
>> directly on top of 'master', and then including the necessary change
>> to the refs-backend code while rebuilding submodule-parallel-update
>> on top of the result.  So I do not think you would go in that
>> direction.
>
> Having said that, at least for this round, I do not think there is
> nothing to do at this point on your end; I just created a merge
> between master and your updated sb/submodule-parallel-update and
> then rebased the LMDB series on top of it.  It at least applies
> cleanly and I expect it would test OK as well (the test is still
> running).

I was about to send another round of this series with all the discussion
addressed and then take a look how to resolve any conflicts if any.

This sounds promising.

>
> On your plate is to adjust the submodule-init topic so that it knows
> that the .update field no longer is a string (but is now an enum).

After the reroll of this series.

>
> I did try doing that myself to see the extent of necessary changes
> but did not finish it myself, because I suspect that
> sb/submodule-parallel-update may need further updates.

I would hope to address that all within the next round, as the review
discussion seemed to have died down and I'll be fixing all the issues
pointed at.

Thanks,
Stefan

>
> Thanks.
