From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] submodule: Port resolve_relative_url from shell to C
Date: Thu, 14 Jan 2016 21:50:28 +0100
Message-ID: <56980A14.1060605@web.de>
References: <1452708927-9401-1-git-send-email-sbeller@google.com>
 <xmqq4mehm92b.fsf@gitster.mtv.corp.google.com>
 <CAGZ79ka0rxYK7GRSjh13XOsg887EgqYtc5B60z9qU=tAoJGERQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
To: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 21:50:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJor3-0002sa-6F
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 21:50:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755238AbcANUup (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 15:50:45 -0500
Received: from mout.web.de ([212.227.15.3]:53036 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754432AbcANUuo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 15:50:44 -0500
Received: from [192.168.178.41] ([79.211.122.98]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0MWS0g-1aeHHV20Ec-00XbTh; Thu, 14 Jan 2016 21:50:35
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <CAGZ79ka0rxYK7GRSjh13XOsg887EgqYtc5B60z9qU=tAoJGERQ@mail.gmail.com>
X-Provags-ID: V03:K0:mXcrAiW62aqXO1XLgNf4ppcA/ly/VTXTPGmL1dHlB+mi6irnpK3
 yYYkOv0QpiEd4t9GbsCGUPWUtumL4hP8MVw2jTIrU4bCq1cy4AdXCKifHi4F3HfGxjdmC0D
 QXtE/MwRd9KjCKEXEO5t85zO+INALWwsU5FijxK1u4ECIRz3FFAXfTOOo5yBwaF83wnA5Ad
 xraMe1EQmQpwiwK/RhL8A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:U8In+u+FuzU=:ztBnHMvWjmB6A7Tl4zWJQy
 1P/7j1Dmk38Pa6xgslJ2+IlqrKrG+mM+TiX+GdcadWfqtORxE/AzfbrZTH0pZHyF2B64E/JnA
 wtxWfvdRqHlXjJaFTGPvKBsyVUtqxxugwM7jP7WiY8E9opM6o8IYuo8nrHi32WO7JgGH3mrN2
 HnoDvOR46SLM5MmU5WzzbvW7vybDbst+YPtBgg9RANDpFvVcsGOzDpMY40xTVSb+9K2Lf+YUH
 SKcuUF6Jkkl9XXmSsAM+Y4ZV2vnPUnycYin0Ho/rSBEJhcoyrbUQXTZYfaSWaL26VPZLKBAVL
 PPor7d7was8ZKF1Jahih6l+ATymCv/AyuUi7OpAuLYtRubwgX6NxXRl4J6adKJw2q27O8un+9
 SOnvl9DuCjA05gJ2/ith+w0eGTNv1VtsJCuuHkIyWEZZUVHjVJnGAWGmi4LXRjZhyjmsHEPxz
 QRcGkuU8hetHz44y6pPNjyQbo/9P6asliWGw7kgIY6tFfIJDba6lgdNLEg2nJky2s6Ebx/RIW
 qANOXdLjZ+4XxFyUC1Fxmvk+Sh991k/J/JT9SudbYjKaODp6C4AZfuZpRBm8Kz6Yhj/HdCoY0
 xi4aqT+PVZ4vs/zPdPgyrQKH+3JoAFN3m3vOriwWf1U6nB06J9MJfdIHzQlLEEZQq3qV66N6k
 /2Ngta4nx2ddnxXYDBpL4R0SWjPB0YrMxkO1464FmUgFZ9aK3B85iQR1Cpk48yLI/BHhANcJd
 aRgbYyu4PJiZPvLYRyeAlCYsFqDMwI7F18cTomc6cKbe32oQ9krAAug/wuhbSzygU9t3xNub 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284090>

Am 13.01.2016 um 23:47 schrieb Stefan Beller:
> On Wed, Jan 13, 2016 at 2:03 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> Later on we want to deprecate the `git submodule init` command and make
>>> it implicit in other submodule commands.
>>
>> I doubt there is a concensus for "deprecate" part to warrant the use
>> of "we want" here.  I tend to think that the latter half of the
>> sentence is uncontroversial, i.e. it is a good idea to make other
>> "submodule" subcommands internally call it when it makes sense, and
>> also make knobs available to other commands like "clone" and
>> possibly "checkout" so that the users do not have to do the
>> "submodule init" as a separate step, though.
>
> Maybe I need to rethink my strategy here and deliver a patch series
> which includes a complete port of `submodule init`, and maybe even
> options in checkout (and clone) to run `submodule init`. That way the
> immediate benefit would be clear on why the series is a good idea.

I think that makes lots of sense. It looks to me like clone already
has that option (as --recurse-submodules must init the submodules),
but it might make sense to add such an option to checkout to init
(and then also update) all newly appearing submodules (just like
"git submodule update" has the --init option for the same purpose).

> The current wording is mostly arguing to Jens, how to do the submodule
> groups thing later on, but skipping the immediate steps.

I really believe that in the future a lot of users will hop on to the
automatically-init-and-update-submodules train once we have it (and I
think users of the groups feature want to be on that train by default).

But I also believe we'll have to support the old school init-manually
and update-when-I-want-to use cases for a very long time, as lots of
work flows are built around that.
