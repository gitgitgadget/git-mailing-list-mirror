From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv3 02/11] run-command: report failure for degraded output
 just once
Date: Wed, 4 Nov 2015 13:04:31 -0800
Message-ID: <CAGZ79kbwJrQ9SrGkJsSx9oUcP98dn9wP=ZvgQLRjmPaZtOzanA@mail.gmail.com>
References: <1446597434-1740-1-git-send-email-sbeller@google.com>
	<1446597434-1740-3-git-send-email-sbeller@google.com>
	<xmqqd1vpbpik.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaiRKHd2RS9eNeZt_VZqqBF0HS0D=x1HbOTPXYOphu8pg@mail.gmail.com>
	<xmqq8u6da448.fsf@gitster.mtv.corp.google.com>
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
X-From: git-owner@vger.kernel.org Wed Nov 04 22:04:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zu5ET-0000Xc-FX
	for gcvg-git-2@plane.gmane.org; Wed, 04 Nov 2015 22:04:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030850AbbKDVEd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2015 16:04:33 -0500
Received: from mail-yk0-f176.google.com ([209.85.160.176]:36627 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030567AbbKDVEc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2015 16:04:32 -0500
Received: by ykba4 with SMTP id a4so95656584ykb.3
        for <git@vger.kernel.org>; Wed, 04 Nov 2015 13:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Sfina4S4zk4fQZQJZySMTRhqLoDO+xfS4fbb1YUZKSg=;
        b=Fn1LtxvmxhsknpuAJBvUCxjpXkZNW0GPazP1BlEooCbHSQBg/wrPp5Qzc5r8HYc6Ea
         KZ+Oa428+dNWnx4xXt27W/B8Qm5Bs6B0KPJuo8W6RM8m+CcEGsRFhm3vzHdFrMT1fJuQ
         4xphaoCT8glNK3QTyE/KMj4dzjVJBg8cN80ou6KbJyOwjuXlycB2MD6in5xesXDNRvcv
         s3Y8U0TlkPYDO1XMqxszXpVy0GZLTtFUq52VoW+bppLRaYeB2fKMXlIEP1X9AXrwemCE
         vnQFw1OwpA68O9gTJ4QLEXhZusEwAeQZgb2KsBgNEgXDTyq2olD8Dkd+52ssTRSOj2Jr
         lbuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Sfina4S4zk4fQZQJZySMTRhqLoDO+xfS4fbb1YUZKSg=;
        b=WV7dJBiFvjjcqjoBzO2n/ZOo9CXTn/ddaTgWj17IfZV1glWHGtSUI+oIUYEVspS0Dd
         6biID5SxDN6ymnmM0x+qEP1HKsL4kuAngYwQOZI9VpvB+ywR4PIKkD2C6ng0rBw2GVdz
         oGoB060q3eyZH96kvZT5sTgFaQf9tgss9V0j5QoHvNSQn5WMNwuzjkEvwFZdq8W4GBo9
         YCaaByGjSOj5rg8gFsQ8JiJKjPDANhVB43Hv4uExXkmnaupGqbNThFCKLsWeYIMNYhOc
         9sxMsoOJ7Q8XrwftwRE1q8p93PNPkasi6WDxn3nyfahDn5dN0iqiUkAC9eGW6IFfmujs
         TkqQ==
X-Gm-Message-State: ALoCoQk/6dPulHhCtaqORabfJOCXvijdMnYF9wWD/EIIt7G8eXrWnNpX6orpAgJ+ue7cEyBuujNh
X-Received: by 10.129.75.131 with SMTP id y125mr3499495ywa.48.1446671071713;
 Wed, 04 Nov 2015 13:04:31 -0800 (PST)
Received: by 10.37.29.213 with HTTP; Wed, 4 Nov 2015 13:04:31 -0800 (PST)
In-Reply-To: <xmqq8u6da448.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280885>

On Wed, Nov 4, 2015 at 12:42 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Another approach would be to test if we can set to non blocking and if
>> that is not possible, do not buffer it, but redirect the subcommand
>> directly to stderr of the calling process.
>>
>>     if (set_nonblocking(pp->children[i].process.err) < 0) {
>>         pp->children[i].process.err = 2;
>>         degraded_parallelism = 1;
>>     }
>>
>> and once we observe the degraded_parallelism flag, we can only
>> schedule a maximum of one job at a time, having direct output?
>
> I would even say that on a platform that is _capable_ of setting fd
> non-blocking, we should signal a grave error and die if an attempt
> to do so fails, period.

So more like:

    if (platform_capable_non_blocking_IO())
        set_nonblocking_or_die(&pp->children[i].process.err);
    else
        pp->children[i].process.err = 2; /* ugly intermixed output is possible*/

>
> On the other hand, on a platform that is known to be incapable
> (e.g. lacks SETFL or NONBLOCK), we have two options.
>
> 1. If we can arrange to omit the intermediary buffer processing
>    without butchering the flow of the main logic with many
>    #ifdef..#endif, then that would make a lot of sense to do so, and
>    running the processes in parallel with mixed output might be OK.
>    It may not be very nice, but should be an acceptable compromise.

>From what I hear this kind of output is very annoying. (One of the
main complaints of repo users beside missing atomic fetch transactions)

>
> 2. If we need to sprinkle conditional compilation all over the place
>    to do so, then I do not think it is worth it.  Instead, we should
>    keep a single code structure, and forbid setting numtasks to more
>    than one, which would also remove the need for nonblock IO.

So additional to the code above, we can add the
platform_capable_non_blocking_IO() condition to either the ramp up process,
or have a

    if (!platform_capable_non_blocking_IO())
        pp.max_processes = 1;

in the init phase. Then we have only 2 places that deal with the
problem, no #ifdefs
elsewhere.

>
> Either way, bringing "parallelism with sequential output" to
> platforms without nonblock IO can be left for a later day, when we
> find either (1) a good approach that does not require nonblock IO to
> do this, or (2) a good approach to do a nonblock IO on these
> platforms (we know about Windows, but there may be others; I dunno).
>
