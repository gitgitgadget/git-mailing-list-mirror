From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC/PATCH 1/4] test-lib: add test_dir_is_empty()
Date: Wed, 26 Mar 2014 20:22:45 +0100
Message-ID: <53332905.2050808@web.de>
References: <5331B6F6.60501@web.de> <5331B717.5010600@web.de> <xmqq4n2mknqf.fsf@gitster.dls.corp.google.com> <53328FD8.4050907@web.de> <5332AF6B.1050108@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder p <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Heiko Voigt <hvoigt@hvoigt.net>
To: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 26 20:23:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WStPf-0000ix-Tv
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 20:23:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755896AbaCZTW4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2014 15:22:56 -0400
Received: from mout.web.de ([212.227.15.3]:65467 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754037AbaCZTWz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 15:22:55 -0400
Received: from [192.168.178.41] ([84.132.147.65]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MGRVU-1WFg0f3Uie-00DDdt; Wed, 26 Mar 2014 20:22:49
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <5332AF6B.1050108@alum.mit.edu>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:c1q92TUq6fEs948Df/y1TkSUPsCYW/nXTmBh3HK1TQ8S0UACnnN
 z+ytFf9iRFqKsfzeSnuEBuElBNvb+Uz5taXxqqxdAy8OwBsbJ15pWR3YBZ6aXRldLRg9e2u
 sb5m18pWwEF2CM2Wt7UcAMFcmXY16a8+EWuopMou+hrr5R65PzXp1FcD2iRwiaVfmPEhd/p
 8kdfzEl05gfQkdRBv2e1A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245215>

Am 26.03.2014 11:43, schrieb Michael Haggerty:
> On 03/26/2014 09:29 AM, Jens Lehmann wrote:
>> Am 25.03.2014 21:49, schrieb Junio C Hamano:
>>> Jens Lehmann <Jens.Lehmann@web.de> writes:
>>>>  t/test-lib-functions.sh | 11 +++++++++++
>>>>  1 file changed, 11 insertions(+)
>>>>
>>>> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
>>>> index 158e10a..93d10cd 100644
>>>> --- a/t/test-lib-functions.sh
>>>> +++ b/t/test-lib-functions.sh
>>>> @@ -489,6 +489,17 @@ test_path_is_dir () {
>>>>  	fi
>>>>  }
>>>>
>>>> +# Check if the directory exists and is empty as expected, barf otherwise.
>>>> +test_dir_is_empty () {
>>>> +	test_path_is_dir "$1" &&
>>>> +	if test $(ls -a1 "$1" | wc -l) != 2
>>>> +	then
>>>> +		echo "Directory '$1' is not empty, it contains:"
>>>> +		ls -la "$1"
>>>> +		return 1
>>>> +	fi
>>>> +}
>>>> +
>>>>  test_path_is_missing () {
>>>>  	if [ -e "$1" ]
>>>>  	then
> 
> Why not do something like
> 
>     test -z "$(ls -a1 "$1" | egrep -v '^\.\.?$')"
> 
> I.e., make the test ignore "." and ".." without depending on their
> existence?

Thanks, will do so in the next round.
