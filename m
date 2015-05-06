From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: forcing a user@ into the URL if not present
Date: Wed, 06 May 2015 06:52:32 +0200
Message-ID: <55499E10.2050003@web.de>
References: <CABU7BddjAZOk0LyybQ8phO0S4705MrZtLSYEsjzUBKUD=H++RQ@mail.gmail.com>	<CABU7BddHuiYK4s+_+Z9v15D+Nj8icMQSWNY13TZ77wq8Vo6r+A@mail.gmail.com>	<20150430202342.GC5015@vauxhall.crustytoothpaste.net>	<CABU7BdcuJp3f6_cN8TpJX-brDUWL6-0Q5M0Yvpg2ND-k--yEbw@mail.gmail.com>	<CABU7BddLGe-+b4cEiPi9MCd6xY5kpBU6aZuy4Vn7j+NgPdLwuA@mail.gmail.com>	<231730bb9947a6ddbbd8f3bda36c89f2@www.dscho.org> <xmqqmw1iex4m.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Dan Langille <dlangille@sourcefire.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	=?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed May 06 07:14:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YprfT-0007vU-TC
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 07:14:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752632AbbEFFOn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2015 01:14:43 -0400
Received: from mout-xforward.web.de ([82.165.159.34]:49493 "EHLO
	mout-xforward.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752547AbbEFFOm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2015 01:14:42 -0400
X-Greylist: delayed 1217 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 May 2015 01:14:42 EDT
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0LnB1F-1ZRurB202n-00hNKB; Wed, 06 May 2015 06:53:56
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Icedove/31.5.0
In-Reply-To: <xmqqmw1iex4m.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:ZvcTeX95akI6DSJLew4mYaFeqgWQQMSnL0Qv5zKSbQgYTds+ng+
 S99Zq63WV0tehpuWGrXdzMLk7Kqcpgqu84IttqOzrSO2cd1eXXXpyi3tIWpS9srq4xSfCfI
 6EJFzrqMl0iacT5cg6jWVwVZ/sFZv13PrFtd+jtoMLa0X0TEuh4KoUN/ZSYW/oUf3eNjcRa
 A+xeEEM1j0q7mBwTWu7nQ==
X-UI-Out-Filterresults: junk:10;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268446>

On 05/05/2015 07:45 PM, Junio C Hamano wrote:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>
>> Having stumbled over [this
>> ticket](https://github.com/git-for-windows/git/issues/92) recently, it
>> appears to me as if the following should work for you:
>>
>> git clone https://:@repo.example.org/
> Wow.
>
> Is this a windows-only SSPI thing, or is this a widely accepted URL
> convention?  I haven't seen anybody use such a URL but I would say
> that is a natural thing to expect to work, as both username and
> password are missing so they should default to some sensible values,
> in this case "current user, shouldn't need password", just like
> "scheme://site:/" is "port missing so it should default to some
> sensible value, appropriate for the scheme".
>
> I think Torsten recently added a bit more test for our URL parsing
> code, especially for "scheme://site:/" (missing port), but I do not
> think we have "scheme://:site/" (missing user or password).  Perhaps
> we would want to have additional tests to cover this shape of URL?
>
I have added tests for URL parsing, but for host names/port numbers.
Not for usernames/passwords (passwords shouldn't be there,
recommends RFC 3986)

And only for the ssh:// protocol, as well as git://.
http:// and https:// are not handled by connect.c at all,
and I'm not really familiar with curl, nor kerberos.

In other words: I can not help very much at the moment.
