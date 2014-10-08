From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: let git grep consider sub projects
Date: Wed, 08 Oct 2014 08:48:09 +0200
Message-ID: <5434DE29.2010200@web.de>
References: <20141007082914.GA2729@aepfle.de>	<xmqq8ukrg2j2.fsf@gitster.dls.corp.google.com> <CAHYJk3Qrj3QfBK-MkcCS2AmyTz=AgCcruq7Df-YZKW24LMWTHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Olaf Hering <olaf@aepfle.de>, git <git@vger.kernel.org>
To: Mikael Magnusson <mikachu@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 08 08:48:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xbl2v-00080u-8o
	for gcvg-git-2@plane.gmane.org; Wed, 08 Oct 2014 08:48:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754193AbaJHGsV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2014 02:48:21 -0400
Received: from mout.web.de ([212.227.17.12]:57961 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751191AbaJHGsU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2014 02:48:20 -0400
Received: from [192.168.178.41] ([79.193.66.158]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0LrK0u-1YKfeD3Tps-01348t; Wed, 08 Oct 2014 08:48:13
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.2
In-Reply-To: <CAHYJk3Qrj3QfBK-MkcCS2AmyTz=AgCcruq7Df-YZKW24LMWTHg@mail.gmail.com>
X-Provags-ID: V03:K0:90w1oxf5kBiA9m1MOQG65VbnTmyfPgHX/bRl9t7W25R5bPXF9jI
 8SioKiyviX2OhArAwEERFipBhiWBUYte/BmMl+I7mfAp2eGsXfQXO3WTdiHIXgTuVCSU0iU
 6GYPjMcO4I2NpjYr356LX9jvbClNYaEXtkBE38Vl6OPF6LYO7VFExwMrPhUISNxwkKXlGii
 9ZmcCfhTXN0JvwKQBbu1Q==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.10.2014 um 21:12 schrieb Mikael Magnusson:
> On 7 October 2014 20:25, Junio C Hamano <gitster@pobox.com> wrote:
>> Olaf Hering <olaf@aepfle.de> writes:
>>
>>> How can I teach 'git grep $string' to also consider subprojects?
>>>
>>> The build system of xen.git clones 4 other trees into a directory in its
>>> source tree during build. It would be nice if my 'git grep' searches
>>> also in these cloned subdirs. Somehow there must be some knowledge
>>> because 'git clean -dfx' leaves them alone, while 'git clean -dffx'
>>> wipes everything.
>>>
>>> Olaf
>>>
>>> PS: Sometimes I miss a 'git clean -dfx --also-sub-repos' useful to
>>> really clean everything before starting over.
>>
>> Is "submodule foreach" under-advertised or with less than adequate
>> features?
>
> It sounds like in these use cases, you would want the commands to run
> on all the submodules but also in the parent repo, am I wrong in
> thinking that git submodule foreach does only the former part? So you
> would either need to make a wrapper thing yourself or run the command
> twice.

Yep, the workaround for a command "git foo" that hasn't learned the
--recurse-submodules option yet is

    git foo && git submodule foreach --recursive git foo

> In the first case with the git grep, I can also imagine that with some
> nontrivial patterns, having to quote the metacharacters not only once,
> but twice, can be a significant annoyance. Eg, first protect it from
> git submodule foreach parsing it, and then from the shell running the
> individual commands.

The long term goal is to teach git grep and git clean - and others -
the --recurse-submodules option. I'd be happy to help if someone
wants to work on that, as I'm busy working on another topic.
