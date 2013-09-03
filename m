From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 4/4] t: branch: improve test rollback
Date: Tue, 3 Sep 2013 18:03:09 -0500
Message-ID: <CAMP44s1Q6YjVnVz3OnT=cE+ozUddBxFzM1r_WT5QoR7sP6-9Sg@mail.gmail.com>
References: <1377923511-20787-1-git-send-email-felipe.contreras@gmail.com>
	<1377923511-20787-5-git-send-email-felipe.contreras@gmail.com>
	<xmqqwqmxr9a7.fsf@gitster.dls.corp.google.com>
	<CAMP44s2BU86zZ_KE78BPYpsjBZJ7Mj0MJqM4Lj28AKxYfeLVDQ@mail.gmail.com>
	<xmqqtxi1o6kf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 04 01:03:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGzd0-0002ID-5H
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 01:03:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761066Ab3ICXDO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 19:03:14 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:32968 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755840Ab3ICXDM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 19:03:12 -0400
Received: by mail-lb0-f180.google.com with SMTP id q8so5505611lbi.39
        for <git@vger.kernel.org>; Tue, 03 Sep 2013 16:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=FzvaVYwxRZKHGU5vLtZ/p7kcWa9A1SR1jJd08ISTtig=;
        b=ARs6UX0qIwBQbzq5VkRgmaGWRKXO+SxVWxKkacooI230XecrCp1ECLrHGvOeqNWE8S
         mbkAkbGieBiF/0bZI44MEP/15RU1HWKairjKeCH9NJxTXHT7mMHK8baIyMQOH00ZVFvR
         mMu2k68daSSYLt9XAHUYtq2d+HhBe+EDaIjSb3IpOas+7QrU6/t+hJGOHHy4nTslUrPm
         cq7JoK2KrKyZbP80/+qKeduijn1nL8DAMQ4cO1Ky2kQ7ITICXuC7JFAgPgid3mB4e0Fy
         hu+AtnKecX5IkHMHrse7DemZE98OdmWKzvuRsX+Hj88BQpTSgCJ/V+FK1f5kytTb6yQu
         Bw1w==
X-Received: by 10.112.184.135 with SMTP id eu7mr504lbc.65.1378249390007; Tue,
 03 Sep 2013 16:03:10 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Tue, 3 Sep 2013 16:03:09 -0700 (PDT)
In-Reply-To: <xmqqtxi1o6kf.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233797>

On Tue, Sep 3, 2013 at 5:59 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Tue, Sep 3, 2013 at 2:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>>>  test_expect_success 'refuse --edit-description on unborn branch for now' '
>>>> +     test_when_finished "git checkout -" &&
>>>
>>> I am not sure if this is a good change.  Depending on the outcome of
>>> the "git checkout" in the test (it may succeed and set @{-1} to the
>>> branch we were on when we entered the test, or it may fail and leave
>>> @{-1} to the branch before we were on when we entered the test),
>>> this will take us to a different place, no?
>>
>> It is better than leaving Git in an unborn branch.
>
> True, but it falls short of "After every test the environment should
> be as close as to how it was before as possible.", doesn't it?

No it doesn't. Closer is closer.

> I think the fix is just to use the name of a concrete branch,
> instead of "-", which could be far quickly done than making excuses
> like that.

The fix is to write a test_checkout that would save the previous HEAD
and restore it after the test, or something similar. But I'm not going
to write that, and I bet nobody else is, so unless you want the tests
to remain in the crappy state they are, "git checkout -" is the best
sensible option.

-- 
Felipe Contreras
