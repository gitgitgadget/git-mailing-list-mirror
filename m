From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v14 4/6] parse-options.c: make OPTION_COUNTUP respect
 "unspecified" values
Date: Wed, 13 Apr 2016 23:13:56 +0530
Message-ID: <CAFZEwPPoNz0W8kqva1_nudvK2ZVjuC1zk0xzM8f6bzL1efU4OA@mail.gmail.com>
References: <010201540cb60832-9402a692-3caa-47a1-9e8e-ae5a1bc7eb2f-000000@eu-west-1.amazonses.com>
	<010201540cb60971-0bf3b786-4acd-4317-bd3c-3397dc2b51f9-000000@eu-west-1.amazonses.com>
	<CAPig+cQM_E9VgsxifBcT_XGyTCCaanNcfQEm6rU85pSNaQG7MQ@mail.gmail.com>
	<CAFZEwPMjDxFHOdbOgqXmBoud=2gmrpfiR4Aa83_7+bjka1bk4g@mail.gmail.com>
	<CAPig+cRUr2sgvQimGWy1WhRZ160d_RyafO-69q5hDrPCy4EMXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 19:44:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqOpk-0007GR-Tt
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 19:44:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754403AbcDMRoE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 13:44:04 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:35731 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754386AbcDMRoC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 13:44:02 -0400
Received: by mail-yw0-f194.google.com with SMTP id k197so7668822ywe.2
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 10:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=JypzskRZa1/V0cNr4V3b59Rg11TuOXRSVEDexSQxPJA=;
        b=kZd7V9nUUi0KuKmi/XgBehsg1feKXWfaGV3p4Rnt4GSQwhCYbrBBBY4j5B5KLzX8dU
         vj8vlHUs1pvDho/D46aELcWYLZlEWw20z0l3bWrwj93FCa8KSMh1n/WBK32U5xS9PhA6
         Bu2Q+NWCz824WFg8OID0zwbGnUlbn1mLDrKFAzsozfO8dgNBCmlwRTK1G0xKPobXKm1G
         qm6TrBECZCNeJvI6zYRFGRQSetDQ4HughsqoAL7voWEPajoeq8OTuPr0P2KPlXOfXAme
         QbJWn4/KTTI7HMqoNBaWu9mLQJhi2nMzu3PJV6Wgxv+Rs5oMMMV/o4d2Zga/KTZ3b9Fe
         guww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=JypzskRZa1/V0cNr4V3b59Rg11TuOXRSVEDexSQxPJA=;
        b=a8Xb8plAlSe335NwLSRzPsW9I+XzpFIwQH5iyXLGOoSTUhqu1JYIR0XQdZpcWMFAGh
         jdlFMDuHNNkXIgwz0B1wuoXzyWJuL6BRYJFCAUJUlA/5XcGp5nEEMJQoTnVZKqig+EZ6
         PcWc1BiivqZRMuGY8xMRtFTKSRbEYAeqz9Ht8Wg3TlJEMNnnCbhxz8dWNQAQ9anUU2F4
         yDDfXJxHBr8wcTs8tw5ygYZF3wskYN9QmANWz4oxn/EEDfiiEr4WHoek8nrv5DOMGLDj
         AxNY552NhXo8FSpQm8myBrKlB4URQOlwXjdAQ/3CgsthoZY8Tk+TFczVSayXqjIcrLfH
         HM+A==
X-Gm-Message-State: AOPr4FX3RVLcBNC7dWcfS2GcvmvyJTPl8YTSyHNwK/EOmu5Bl/hjEAXlJqtDxZHrY+QKSLOaTJhd5ICMr+1xaQ==
X-Received: by 10.129.134.133 with SMTP id w127mr5520704ywf.252.1460569436294;
 Wed, 13 Apr 2016 10:43:56 -0700 (PDT)
Received: by 10.13.219.81 with HTTP; Wed, 13 Apr 2016 10:43:56 -0700 (PDT)
In-Reply-To: <CAPig+cRUr2sgvQimGWy1WhRZ160d_RyafO-69q5hDrPCy4EMXw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291467>

On Wed, Apr 13, 2016 at 11:03 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Apr 13, 2016 at 4:39 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> On Wed, Apr 13, 2016 at 11:26 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> On Tue, Apr 12, 2016 at 7:02 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>>>> +test_expect_success 'OPT_COUNTUP() resets to 0 with --no- flag' '
>>>> +       test-parse-options --no-verbose >output 2>output.err &&
>>>> +       test_must_be_empty output.err &&
>>>> +       test_cmp expect output
>>>> +'
>>>
>>> In my v12 review, I noticed that neither --no-verbose nor --no-quiet
>>> was being tested by t0040 (which is conceptually independent of the
>>> OPT__COUNTUP change) and suggested[3] that you add a new patch to
>>> address that shortcoming. This idea was followed up by [1] saying that
>>> this test (here) could then be dropped since the case it checks would
>>> already be covered by the new patch. My impression was that you
>>> agreed[4] that that made sense, however, this test is still here. Did
>>> I misunderstand your response[4]?
>>>
>>> [1]: http://article.gmane.org/gmane.comp.version-control.git/290662
>>> [2]: http://article.gmane.org/gmane.comp.version-control.git/289991
>>> [3]: http://article.gmane.org/gmane.comp.version-control.git/290655
>>> [4]: http://article.gmane.org/gmane.comp.version-control.git/290787
>>
>> I actually did include the tests in the patch 3/6[1]. I mentioned in
>> my response[2] that I will include the tests between 2/5 and 3/5.
>> Since, after that no email was exchanged, I thought you agreed.
>
> I'm not sure that I understand what you are saying since the
> --no-verbose test does not seem to be included in the patch you cite
> (it is instead in the present patch under discussion).
>
> Perhaps there is some miscommunication and misunderstanding.

Sorry for being a bit unclear.
I will explain this. The patch 3/6 contains the test which tests the
quiet option thus in turn testing whether the variable quiet becomes 0
with --no flag. This patch ie. 4/6 contains the test which tests the
verbose options thus in turn testing whether the variable verbose
becomes 0 with no flag. Both of them test different behavior as quiet
is initially 0 while verbose is initially -1.

So finally what I wanted to achieve is that I should test --no-quiet
in 3/6 as till then this new behavior is not yet introduced. Thus, it
will confirm the wanted behavior which exists before 4/6.

This patch introduces a test to verify whether --no-verbose makes the
variable 0. This patch introduces a new "unspecified" behavior. Thus
we can test this new behavior with this.

I hope now it is a bit clear on what I want to do.

>> [1]: http://article.gmane.org/gmane.comp.version-control.git/291310
>> [2]:http://article.gmane.org/gmane.comp.version-control.git/290787
