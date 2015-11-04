From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv3 00/11] Expose the submodule parallelism to the user
Date: Wed, 4 Nov 2015 10:08:36 -0800
Message-ID: <CAGZ79kZhgVThVrR-gOZj3zaicG43JNgv1FTxk2S5mr__7YB5Yg@mail.gmail.com>
References: <1446597434-1740-1-git-send-email-sbeller@google.com>
	<xmqqk2pxbqft.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Eric Sunshine <ericsunshine@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 19:08:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zu2UE-0006ZQ-PN
	for gcvg-git-2@plane.gmane.org; Wed, 04 Nov 2015 19:08:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756207AbbKDSIi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2015 13:08:38 -0500
Received: from mail-yk0-f177.google.com ([209.85.160.177]:33203 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754063AbbKDSIh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2015 13:08:37 -0500
Received: by ykft191 with SMTP id t191so86536012ykf.0
        for <git@vger.kernel.org>; Wed, 04 Nov 2015 10:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=0r+mx3QfrDplr75S6Nk5DEuvKe0kUdJ0OgFz+eGSwFA=;
        b=AI9ZuvH761s7STA86B3TG1ZN2icvlkk46RP84/sadCBdK2nCN7BwlTbEdCwgvu3wfm
         K8xQgsuB1Ke9DmTuUdW/UTmZiSLEWJbR+5LthAHAOhIdUKR8MGsAA2t9wZ/tjmJIIFkb
         Wm1olpYO3137I/Rv3F21imtdezRMoAfa8XMDyuRpcLoCWkFWcQZeAmVik7gdbgIg8Ul+
         hYxC6C7Ati+vRaYK5dvUH8HFPIwXPJp0R697FqWOpi5XC4R2g8eKCu0Tl6tcSyRBs1Pg
         oBLJ90hT6IUNnj9zrG3T0nYy4Vs6h4+btYODgyiTlenTJlz+fqRyTeq/YOIXJCaZL0o2
         oAdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=0r+mx3QfrDplr75S6Nk5DEuvKe0kUdJ0OgFz+eGSwFA=;
        b=DWQtLHdQDJXLhU9SJMX8CQ34Ui6wQTgidAjygAFFgsx+4bLdiL0ZFm9fBxwGkhEs9f
         Woc/Vy5jQJEncU5Uc9hANtlLhkL3wHoWVWxaML+uLfXKaV7IIN61lgTg+qp2sE5MBzk+
         HDRVOavpmRgM+P0hSdHfQOzVtYYvhVE3qBYRYDMmd7GWOJxFHmooanvEv0BmrKAoWH9e
         sDAni6oZkTGHgYQ/LLsinyJElWFmJWbNNkoFk23KE8lvaiaJCa55g4eJ45eKQtTcpW6G
         igDjQKMSPqYIjq7jX+9Gn3jWU272l7B/K98+gC3BjqCzs20zXI96KcltcTzkz+j1+mrL
         ooxw==
X-Gm-Message-State: ALoCoQli9dMCaBZ8gl4XJPXWxYrU7BFocB262TF88BZP1quYbZNqq5OPonWAnLwSjZrKDPl4AGJ9
X-Received: by 10.129.40.147 with SMTP id o141mr2292939ywo.199.1446660516698;
 Wed, 04 Nov 2015 10:08:36 -0800 (PST)
Received: by 10.37.29.213 with HTTP; Wed, 4 Nov 2015 10:08:36 -0800 (PST)
In-Reply-To: <xmqqk2pxbqft.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280862>

On Wed, Nov 4, 2015 at 9:54 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Where does it apply?
>> ---
>> This series applies on top of d075d2604c0f92045caa8d5bb6ab86cf4921a4ae (Merge
>> branch 'rs/daemon-plug-child-leak' into sb/submodule-parallel-update) and replaces
>> the previous patches in sb/submodule-parallel-update
>>
>> What does it do?
>> ---
>> This series should finish the on going efforts of parallelizing
>> submodule network traffic. The patches contain tests for clone,
>> fetch and submodule update to use the actual parallelism both via
>> command line as well as a configured option. I decided to go with
>> "submodule.jobs" for all three for now.
>
> The order of patches and where the series builds makes me suspect
> that I have been expecting too much from the "parallel-fetch" topic.
>
> I've been hoping that it would be useful for the project as a whole
> to polish the other topic and make it available to wider audience
> sooner by itself (both from "end users get improved Git early"
> aspect and from "the core machinery to be reused in follow-up
> improvements are made closer to perfection sooner" perspective).  So
> I've been expecting that "Let's fix it on Windows" change directly
> on top of sb/submodule-parallel-fetch to make that topic usable
> before everything else.

I can resend the patches on top of sb/submodule-parallel-fetch
(though looking at sb/submodule-parallel-fetch..d075d2604c0f920
[Merge branch 'rs/daemon-plug-child-leak' into sb/submodule-parallel-update]
I don't expect conflicts, so it would be a verbatim resend)


> Other patches in this series may require
> the child_process_cleanup() change, so they may be applied on top of
> the merge between sb/submodule-parallel-fetch (updated for Windows)
> and rs/daemon-plug-child-leak topic.

I assumed the rs/daemon-plug-child-leak topic is no feature, but cleanup.
Which is why I would have expected a sb/submodule-parallel-fetch-for-windows
pointing at maybe the third patch of the series on top of
rs/daemon-plug-child-leak

>
> That does not seem to be what's happening here (note: I am not
> complaining; I am just trying to make sure expectation matches
> reality).  Am I reading you correctly?

I really wanted to send out just one series, my bad.
The ordering made sense to me (first the run-command related fixes
and then the new features in later patches)

>
> I think sb/submodule-parallel-fetch + sb/submodule-parallel-update
> as a single topic would need more time to mature to be in a tagged
> release than we have in the remainder of this cycle.

I agree on that.

>  It is likely
> that the former topic has a chance to get rebased after 2.7 happens.
> And that would allow us to (1) use the child_process_cleanup() from
> get-go instead of _deinit and to (2) get the machinery right both
> for UNIX and Windows from get-go.  Which would make the result
> easier to understand.  As this is one of the more important areas,
> it matters to keep the resulting code and the rationale behind it
> understandable by reading "log --reverse -p".

So you are saying that reading the Windows cleanup patch
before the s/deinit/clear/ Patch by Rene makes it way easier to understand?
Which is why you would prefer another history. (Merging an updated
sb/submodule-parallel-fetch again to  rs/daemon-plug-child-leak or even
sb/submodule-parallel-update)

Thanks,
Stefan
