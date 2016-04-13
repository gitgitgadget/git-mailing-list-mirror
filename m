From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v14 4/6] parse-options.c: make OPTION_COUNTUP respect
 "unspecified" values
Date: Wed, 13 Apr 2016 13:50:26 -0400
Message-ID: <CAPig+cQ9DvpJBBqwngfweX2KwC7mTG3TO+M+B84Rcrhw9JH-Mw@mail.gmail.com>
References: <010201540cb60832-9402a692-3caa-47a1-9e8e-ae5a1bc7eb2f-000000@eu-west-1.amazonses.com>
	<010201540cb60971-0bf3b786-4acd-4317-bd3c-3397dc2b51f9-000000@eu-west-1.amazonses.com>
	<CAPig+cQM_E9VgsxifBcT_XGyTCCaanNcfQEm6rU85pSNaQG7MQ@mail.gmail.com>
	<CAFZEwPMjDxFHOdbOgqXmBoud=2gmrpfiR4Aa83_7+bjka1bk4g@mail.gmail.com>
	<CAPig+cRUr2sgvQimGWy1WhRZ160d_RyafO-69q5hDrPCy4EMXw@mail.gmail.com>
	<CAFZEwPPoNz0W8kqva1_nudvK2ZVjuC1zk0xzM8f6bzL1efU4OA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 19:50:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqOw3-0001tJ-JG
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 19:50:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753552AbcDMRue (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 13:50:34 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:33177 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752351AbcDMRu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 13:50:28 -0400
Received: by mail-io0-f194.google.com with SMTP id g185so7861533ioa.0
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 10:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=VoILDx7xqadORqO4RCLa3Foi1cZjPcZcQE4S7nU7vqw=;
        b=qGdArVlY/skh1OSOx4l9vDEKDSBLcHdKCXPN6/8iVGrBIeRWmNzAbpx+hqnQLTXhgC
         xYsGXJpPieURwpN+knyk+rZpXBgUhGEMa9dhIk2mXxkHqYSZa8LfuwubkrdIpgZLTosl
         FgMMfPo0ids+PbYFP2DlAsRB4lJpnhrrUVC3y48uLtzxbifJukW36r0iWHL7Easzd256
         Eetpk7PAlqtAuS4YprxlxYHCCV1UIMe6tWBSJCOng6HZcaW/wn3ZiMlJKPq5a2o2tWNP
         ioICayuJxRqGTvYj9FKozs2/psqpU2np1d1THzi4Eg4XGusBUyipUCXUFLf/NvuOmnPJ
         gdBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=VoILDx7xqadORqO4RCLa3Foi1cZjPcZcQE4S7nU7vqw=;
        b=HNfGC9G6wS1MoWHfnImL7DRGy+my1W0flyJ1aO87e3q9lOgxihLvLkVkCF4WTyJP+a
         XSF1nL03/2BUP3K3AkeJu1gJUrF4EHeGly2eTLXlTdwNlUrFGUP0n4qJwZP9GjEGn6g1
         ZgudaKOpu7KG8kU3NR+yK1SMynxulsv4wPm73LJyNZiPd6FcwoLfGKeFATMpt6ShBsVu
         uFfVYB2XlQF8sxeUytNCYNvoOJdCk6GigEkVxhfTTZce94IkeIUdiybckpAHz0076Gc3
         f4F8Mwdky6LinM9foKHnnMMWegWV1ogroQ+sN0Z6Hcu0IcfhSeDUEgBPAaiij+h1H1I5
         6Z/A==
X-Gm-Message-State: AOPr4FWHhrRQUIyQHcgLBTgqNv7IuEYDZJdCReeM1W2wCJn4BXWpRj3V1Lsx1Qc8EX1dNYb61mSr8BiYilUUFQ==
X-Received: by 10.107.8.141 with SMTP id h13mr12875406ioi.34.1460569826821;
 Wed, 13 Apr 2016 10:50:26 -0700 (PDT)
Received: by 10.79.139.71 with HTTP; Wed, 13 Apr 2016 10:50:26 -0700 (PDT)
In-Reply-To: <CAFZEwPPoNz0W8kqva1_nudvK2ZVjuC1zk0xzM8f6bzL1efU4OA@mail.gmail.com>
X-Google-Sender-Auth: YRdXl0okI3py6g_MNuH1wvrh73I
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291471>

On Wed, Apr 13, 2016 at 1:43 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> On Wed, Apr 13, 2016 at 11:03 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Wed, Apr 13, 2016 at 4:39 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>>> On Wed, Apr 13, 2016 at 11:26 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>>> On Tue, Apr 12, 2016 at 7:02 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>>>>> +test_expect_success 'OPT_COUNTUP() resets to 0 with --no- flag' '
>>>>> +       test-parse-options --no-verbose >output 2>output.err &&
>>>>> +       test_must_be_empty output.err &&
>>>>> +       test_cmp expect output
>>>>> +'
>>>>
>>>> In my v12 review, I noticed that neither --no-verbose nor --no-quiet
>>>> was being tested by t0040 (which is conceptually independent of the
>>>> OPT__COUNTUP change) and suggested[3] that you add a new patch to
>>>> address that shortcoming. This idea was followed up by [1] saying that
>>>> this test (here) could then be dropped since the case it checks would
>>>> already be covered by the new patch. My impression was that you
>>>> agreed[4] that that made sense, however, this test is still here. Did
>>>> I misunderstand your response[4]?
>>>>
>>>> [1]: http://article.gmane.org/gmane.comp.version-control.git/290662
>>>> [2]: http://article.gmane.org/gmane.comp.version-control.git/289991
>>>> [3]: http://article.gmane.org/gmane.comp.version-control.git/290655
>>>> [4]: http://article.gmane.org/gmane.comp.version-control.git/290787
>>>
>>> I actually did include the tests in the patch 3/6[1]. I mentioned in
>>> my response[2] that I will include the tests between 2/5 and 3/5.
>>> Since, after that no email was exchanged, I thought you agreed.
>>
>> I'm not sure that I understand what you are saying since the
>> --no-verbose test does not seem to be included in the patch you cite
>> (it is instead in the present patch under discussion).
>>
>> Perhaps there is some miscommunication and misunderstanding.
>
> Sorry for being a bit unclear.
> I will explain this. The patch 3/6 contains the test which tests the
> quiet option thus in turn testing whether the variable quiet becomes 0
> with --no flag. This patch ie. 4/6 contains the test which tests the
> verbose options thus in turn testing whether the variable verbose
> becomes 0 with no flag. Both of them test different behavior as quiet
> is initially 0 while verbose is initially -1.
>
> So finally what I wanted to achieve is that I should test --no-quiet
> in 3/6 as till then this new behavior is not yet introduced. Thus, it
> will confirm the wanted behavior which exists before 4/6.
>
> This patch introduces a test to verify whether --no-verbose makes the
> variable 0. This patch introduces a new "unspecified" behavior. Thus
> we can test this new behavior with this.
>
> I hope now it is a bit clear on what I want to do.

Sorry, it's not clearer. I understand what you're trying to do, but it
still seems to be the a less desirable (and more complex) approach
since it's mixing conceptually distinct notions and mismatching them
with changes in the wrong patches. But, perhaps my notion of
"conceptually distinct" is different from yours and vice-versa.
