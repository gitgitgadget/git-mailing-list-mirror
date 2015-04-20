From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 0/3] Another approach to large transactions
Date: Mon, 20 Apr 2015 16:07:32 -0700
Message-ID: <CAGZ79kYk_3E1RMdNvA_OrCj6EdaJ2Xdps9pUxEkWwvDNazb6Gg@mail.gmail.com>
References: <1429226259-21622-1-git-send-email-sbeller@google.com>
	<xmqq8udqheb5.fsf@gitster.dls.corp.google.com>
	<xmqqsibyo141.fsf@gitster.dls.corp.google.com>
	<CAGZ79kZvE+YJeKCYXN-RD3MFmP17VkqW8WUUssk6UgK_38iWrg@mail.gmail.com>
	<CAGZ79kYEbnZvgdhjPvc2rR7QKp-CjUB3Ytqsp8JK2QBqzuUowA@mail.gmail.com>
	<CAGZ79kZWm=Mi6o4jMNthiDRcR9irs_5MyRuEmHdDSrn-JFpQ=g@mail.gmail.com>
	<xmqqzj62ifc9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 01:07:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkKmx-0004UW-At
	for gcvg-git-2@plane.gmane.org; Tue, 21 Apr 2015 01:07:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753478AbbDTXHf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 19:07:35 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:34751 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751705AbbDTXHd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2015 19:07:33 -0400
Received: by iedfl3 with SMTP id fl3so1570867ied.1
        for <git@vger.kernel.org>; Mon, 20 Apr 2015 16:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Y/8juoRCDPXUvTtc6KZDPk/0nciTZ3kBL2okfJf4BS8=;
        b=dwoaM+KP3KpFDAPr+zgHuAC1jyX0q3vhD1tAw3lIBqCNMv4Ik0Sv6KJQ6ymsRDOU0M
         Ey/ea/EcpXfqvZ6wx0yHsF8Ai2Tg10Nmj3+xwaDHyNbztrC2xrDUG6uEsG1WgSEF1uoR
         OmZOxploBc3abQFMJckDmMaVF1SPv+b0hQe2Ws7uT2DIxFSVoZVw2L0ClooxCpgZh+q/
         b13COrJ6IRJmmlkei+qF2yJmWa1s5bjMaeXISosq7nGabClXEGgiiXZ4AbQl4udkndzF
         +rd1Skgmmbtm76Yp7Q1M0yAgtsf2f0eBRCLDUMZdyCuARaG2UI1/TqA7n8sv7bO+8C6J
         e4eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Y/8juoRCDPXUvTtc6KZDPk/0nciTZ3kBL2okfJf4BS8=;
        b=OByIQrd9AOnnYef4BWxWtg3QzcIOavZQZi0Jwaw45cvXlfWYJX+tNaCsVsEcPi1jwT
         0EfXQJPvwSO9kLfU4eFka8j8ePnP0f6Tweh7bCx4FPgGW91pE4StcEpj1C+ufazn87h4
         UmrVMeZTR8d8pEyWVP9fzZZODNyL8nxBi162ClgD9QrPZuPg7qMPmD10L+5ajKDEfq4C
         mdCki9RZRRXNGfkMGVBtfmtfEbV8EYi1tJi+lCS8xRsm8oyaeNZiB9y3wVhEnuVpHpIK
         HAvY8w5ribvvqdBzdoeZugFVjO6IjsRpJilQSowf4SDbSBpE0MDRdrbo2Uo6nnt0rkX+
         CKOg==
X-Gm-Message-State: ALoCoQlutapx3giUQn6kDo7Ait0361XBze6aSEAGiivmUhJPX774s1cgWQUuohu9K8MUKTLs1ks7
X-Received: by 10.42.188.19 with SMTP id cy19mr216139icb.92.1429571252258;
 Mon, 20 Apr 2015 16:07:32 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Mon, 20 Apr 2015 16:07:32 -0700 (PDT)
In-Reply-To: <xmqqzj62ifc9.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267511>

On Mon, Apr 20, 2015 at 3:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> The problem comes from guessing the number of fds we're allowed to use.
>> At first I thought it was a fundamental issue with the code being broken, but
>> it turns out we just need a larger offset as we apparently have 9 files open
>> already, before the transaction even starts.
>> I did not expect the number to be that high, which is why I came up with the
>> arbitrary number of 8 (3 for stdin/out/err, maybe packed refs and reflog so I
>> guessed, 8 would do fine).
>>
>> I am not sure if the 9 is a constant or if it scales to some unknown
>> property yet.
>> So to make the series work, all we need is:
>>
>> - int remaining_fds = get_max_fd_limit() - 8;
>> + int remaining_fds = get_max_fd_limit() - 9;
>>
>> I am going to try to understand where the 9 comes from and resend the patches.
>
> I have a suspicion that the above is an indication that the approach
> is fundamentally not sound.  9 may be OK in your test repository,
> but that may fail in a repository with different resource usage
> patterns.

You put my concerns in a better wording.

>
> On the core management side, xmalloc() and friends retry upon
> failure, after attempting to free the resource.  I wonder if your
> codepath can do something similar to that, perhaps?

But then we'd need to think about which fds can be 'garbage collected'.
The lock files certainly can be closed and reopened. The first 3 fd not so.
So we'd need to maintain a data structure of file descriptors good/bad
for this reclaiming.

>
> On the other hand, it may be that this "let's keep it open as long
> as possible, as creat-close-open-write-close is more expensive" may
> not be worth the complexity.  I wonder if it might not be a bad idea
> to start with a simpler rule, e.g. "use creat-write-close for ref
> updates outside transactions, and creat-close-open-write-close for
> inside transactions, as that is likely to be multi-ref updates" or
> something stupid and simple like that?

I thought about any ref about goes through transaction nowadays.
Having the current patches the first n locks are creat-write-close,
while the remaining locks have the  creat-close-open-write-close
pattern, so it slows only the large transactions.

My plan is to strace all open calls and check if the aforementioned
9 open files are just a constant.

>
> Michael?
>
>
