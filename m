From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 0/3] Another approach to large transactions
Date: Mon, 20 Apr 2015 17:31:11 -0700
Message-ID: <CAGZ79kY842JXB37++nwYjkX1WK9ja5m-G1aDj=QgLN-qKLo9Lg@mail.gmail.com>
References: <1429226259-21622-1-git-send-email-sbeller@google.com>
	<xmqq8udqheb5.fsf@gitster.dls.corp.google.com>
	<xmqqsibyo141.fsf@gitster.dls.corp.google.com>
	<CAGZ79kZvE+YJeKCYXN-RD3MFmP17VkqW8WUUssk6UgK_38iWrg@mail.gmail.com>
	<CAGZ79kYEbnZvgdhjPvc2rR7QKp-CjUB3Ytqsp8JK2QBqzuUowA@mail.gmail.com>
	<CAGZ79kZWm=Mi6o4jMNthiDRcR9irs_5MyRuEmHdDSrn-JFpQ=g@mail.gmail.com>
	<xmqqzj62ifc9.fsf@gitster.dls.corp.google.com>
	<CAGZ79kYk_3E1RMdNvA_OrCj6EdaJ2Xdps9pUxEkWwvDNazb6Gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 02:31:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkM5u-0006h2-Hh
	for gcvg-git-2@plane.gmane.org; Tue, 21 Apr 2015 02:31:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751819AbbDUAbO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 20:31:14 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:33108 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751180AbbDUAbM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2015 20:31:12 -0400
Received: by igbpi8 with SMTP id pi8so76332286igb.0
        for <git@vger.kernel.org>; Mon, 20 Apr 2015 17:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=CoOzggWVmX9ucy9mQNY5CotH4clRvnJufyB8Q3HBEWA=;
        b=C9yRFOyZSHRdCVZtsdq0ZOfQ1VXfnZfNEnDN/m5IyzF1ChMZTmUi9cLdOux2e7cgL9
         FFIj1oKVkj0veaehwRaQwTPzyeGn/igEvsfxLv8+UKoQ/Da7Q4laJTssAQM+ZTvslLpT
         IRwK77A+EWXp9bVtfV+CcRzXLvhi/HsZx1HoOYOMblO43mo4PwreiBZbrOE/CeanVXc6
         0BWs6CTKbQHWnjY8n1hmCj+ODG8TWbRFomwqEcEq3iR/w3tUT9rW8w3Tpnxs6drqqvTo
         1m74K1dMUWs5JJ25Skx2W8Uw38xXeqvMk7FGckEGaj+QWFfCMQ65g0cNNPoDXo0aCmRe
         nxNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=CoOzggWVmX9ucy9mQNY5CotH4clRvnJufyB8Q3HBEWA=;
        b=kHDr1ebgRANHwgOYzWESGTdCofCz/bBMnB+uor/bFU22AxqXvjm863j82LYnZ20LmS
         A3Cy0+UPd57sKRUYTmF4A6vXNnfFrVxgRZSMNKkSrXKxVLUNzLev6tYmuh3fGNt21vDy
         rR/TyVFGLmtWhSCVfntjZUp//RfgCY+Bj8clBlM4w+ZhLQjTViOZsknp4WY54hg6/qp3
         HGLXRNkGMwlNRKAtZbBQN7/6OckFQo3SBAMxFltwzJGBqEDQa+ZTDrPkXgw3zd7OA825
         82Rt0QkZf//QZMzMsdGWVXHzcISY4tmf/23IUZdVnLHcItxlt9oUF5eX5JllTQoI8fW4
         vqeg==
X-Gm-Message-State: ALoCoQl/2MwAuo6hrW9kKYbsnp7zXbqu72JmRLzOjvvNScOYD2kb4HDBA1Lk5QZiLXfMjtqTvYBv
X-Received: by 10.42.30.141 with SMTP id v13mr510706icc.76.1429576271825; Mon,
 20 Apr 2015 17:31:11 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Mon, 20 Apr 2015 17:31:11 -0700 (PDT)
In-Reply-To: <CAGZ79kYk_3E1RMdNvA_OrCj6EdaJ2Xdps9pUxEkWwvDNazb6Gg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267513>

On Mon, Apr 20, 2015 at 4:07 PM, Stefan Beller <sbeller@google.com> wrote:
> On Mon, Apr 20, 2015 at 3:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> The problem comes from guessing the number of fds we're allowed to use.
>>> At first I thought it was a fundamental issue with the code being broken, but
>>> it turns out we just need a larger offset as we apparently have 9 files open
>>> already, before the transaction even starts.
>>> I did not expect the number to be that high, which is why I came up with the
>>> arbitrary number of 8 (3 for stdin/out/err, maybe packed refs and reflog so I
>>> guessed, 8 would do fine).
>>>
>>> I am not sure if the 9 is a constant or if it scales to some unknown
>>> property yet.
>>> So to make the series work, all we need is:
>>>
>>> - int remaining_fds = get_max_fd_limit() - 8;
>>> + int remaining_fds = get_max_fd_limit() - 9;
>>>
>>> I am going to try to understand where the 9 comes from and resend the patches.
>>
>> I have a suspicion that the above is an indication that the approach
>> is fundamentally not sound.  9 may be OK in your test repository,
>> but that may fail in a repository with different resource usage
>> patterns.
>
> You put my concerns in a better wording.
>
>>
>> On the core management side, xmalloc() and friends retry upon
>> failure, after attempting to free the resource.  I wonder if your
>> codepath can do something similar to that, perhaps?
>
> But then we'd need to think about which fds can be 'garbage collected'.
> The lock files certainly can be closed and reopened. The first 3 fd not so.
> So we'd need to maintain a data structure of file descriptors good/bad
> for this reclaiming.
>
>>
>> On the other hand, it may be that this "let's keep it open as long
>> as possible, as creat-close-open-write-close is more expensive" may
>> not be worth the complexity.  I wonder if it might not be a bad idea
>> to start with a simpler rule, e.g. "use creat-write-close for ref
>> updates outside transactions, and creat-close-open-write-close for
>> inside transactions, as that is likely to be multi-ref updates" or
>> something stupid and simple like that?
>
> I thought about any ref about goes through transaction nowadays.
> Having the current patches the first n locks are creat-write-close,
> while the remaining locks have the  creat-close-open-write-close
> pattern, so it slows only the large transactions.
>
> My plan is to strace all open calls and check if the aforementioned
> 9 open files are just a constant.

When running the test locally, i.e. not in the test suite, but typing
the commands
myself into the shell, Git is fine with having just 5 file descriptors left.
The additional 4 required fds come from beign run inside the test suite.

When strace-ing git, I cannot see any possible other fds which would require
having some left over space required. So I'd propose we'd just take a reasonable
number not too small for various test setups like 32 and then go with the
proposed patches.

I'll just resend the patches to have a new basis for discussion.

>
>>
>> Michael?
>>
>>
