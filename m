From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC/PATCH 0/4] parallel fetch for submodules
Date: Thu, 6 Aug 2015 13:44:41 -0700
Message-ID: <CAGZ79kZquSJmLQYQqp3DW3KU4tMaNaaSD0==0Sky6TdiD1F8kw@mail.gmail.com>
References: <1438882524-21215-1-git-send-email-sbeller@google.com>
	<55C3BEDB.20809@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Aug 06 22:45:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNS2b-0004zM-Rr
	for gcvg-git-2@plane.gmane.org; Thu, 06 Aug 2015 22:45:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756146AbbHFUpU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2015 16:45:20 -0400
Received: from mail-yk0-f174.google.com ([209.85.160.174]:35472 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756707AbbHFUom (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2015 16:44:42 -0400
Received: by ykcq64 with SMTP id q64so67982096ykc.2
        for <git@vger.kernel.org>; Thu, 06 Aug 2015 13:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=e/MX4qgvMtbspwLsvQPFVltfDDeYB7jOGn5owUrd640=;
        b=J/LBJAzXv/8xW5KtnuFvGlJndJoXMNsOtjiQDh71/1gaQTofyMv+TsRu1GEfRmXV8X
         v+UzVto/ou5APrZcfLDmmXF6O8IgZWmUkftXvU73xsvVnOxBH6F7rVACYCzB07K2Pq6j
         oO8Y2cjnJnH45SJC7LDofsmVOA7QXLaO1gkdWpqQAj3m9vRUfezYQ1bOKiPYH5Ln6Yf3
         YJYtr7O0x1Y0fT41t0CbT3OOryUKNGp3keZouTk/V6DlvuZnxDhca5zK76nQ1O/jtRUr
         OqALIM/6uqsfLHm1+ExcSOMgojfgrbgtslNCUQz9uJzkXVxin5fCOo9LTM0CQhSAMFJi
         nxOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=e/MX4qgvMtbspwLsvQPFVltfDDeYB7jOGn5owUrd640=;
        b=muXFTwWlMXjqv4/5ax345RU5H6QMUBxYATSbSuU0EoLFKy7MitcLc5QC8UPmXH9x0r
         T+5XtXBU9K0n4280YXiCS03zS9obEzxgUl/VkrvFN4F/il+ZC2yEtJtpUBYYee7qccIa
         seYNVslOZVSy/F/BACtJambkUqFn/TqbU2Vb8V/bCqp894O7K4TVdCtlRVpEk06Z9cKt
         ZxuEdRnwGM+KnQ6AQTpAB6j6t42TZZFLvZWFAoqRnc6w7SAa9bCnaQKULqho6Tzvez0r
         It51AXI/CRKECJYkY4ENf5sEcPrGBbHJoFDCTCglPUs0fy4kgqNaSQUlDPCbZ8ZKne0N
         yTWg==
X-Gm-Message-State: ALoCoQmu5jT8s4j3H+hyfoaV/t/AbN359ARWZEIcgtcitQpsY3Ln2Wl6TDLwSE/e/9tRl0uF6UKa
X-Received: by 10.170.135.138 with SMTP id b132mr3393602ykc.16.1438893881499;
 Thu, 06 Aug 2015 13:44:41 -0700 (PDT)
Received: by 10.37.21.129 with HTTP; Thu, 6 Aug 2015 13:44:41 -0700 (PDT)
In-Reply-To: <55C3BEDB.20809@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275444>

On Thu, Aug 6, 2015 at 1:08 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> Am 06.08.2015 um 19:35 schrieb Stefan Beller:
>>
>> When I was looking at the branches of Jens for work done on submodules
>> not yet upstream I found a commit "WIP threaded submodule fetching[1],
>> and I was side tracked wanting to present a different approach to that.
>
>
> Cool. I didn't follow that route further than building a proof of
> concept because I ran into a nasty DNS-timeout on my router at home
> and at work we host all repos on a not-so-beefy server making parallel
> fetch rather pointless. But I suspect this approach will bring down
> fetch times for some users.

The difference between your proof of concept and mine is to have the number
of threads easier configurable. (Think of "git fetch --recurse-submodules=yes
 -j4", similar to "make -j4" splitting work up to 4 different programs
at the same
time. And that thing would be possible to add in this series)

If you fetch lots of submodules, both the client and server load should come
in an ping-pong on-off pattern as the client waits for the server to
prepare stuff
and get it sent to it and then the client needs time to resolve deltas
and write to
disk. Depending on the duty cycle of each, a different number of
parallel threads
make sense (I would expected that they shift their phases against each other
by pure randomness, i.e. one thread is currently resolving deltas
while the other
thread is telling the server to get some work done, so both the client
and server
get utilized at the same time).

>
> Maybe we could also re-use parallel fetch for multiple upstreams in
> the superproject when doing a "git fetch --all" without too much
> extra work?

That's why I tried advertising RFC patch 2/4 as I believe it could be
easily reused for such things like "git fetch --all", but maybe other
people see problems with it (over/under engineered, wrong things
added, but other critical things missing) so I'd like to hear opinions
on that. :)
