From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Bump core.deltaBaseCacheLimit to 96m
Date: Mon, 05 May 2014 13:03:33 +0200
Message-ID: <vpqwqe0a3ne.fsf@anie.imag.fr>
References: <1399223637-29964-1-git-send-email-dak@gnu.org>
	<CACsJy8BG8fRPk74R_-YABCGMn-YwbDcLHtjUNX7KE66jX1mR4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Kastrup <dak@gnu.org>, Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 06 18:36:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whhxp-0005Yp-Ee
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:11:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753305AbaEELDo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 07:03:44 -0400
Received: from mx2.imag.fr ([129.88.30.17]:39257 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751085AbaEELDn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 07:03:43 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s45B3WPQ001488
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 5 May 2014 13:03:32 +0200
Received: from anie.imag.fr (ensi-vpn-228.imag.fr [129.88.57.228])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s45B3XKB008411;
	Mon, 5 May 2014 13:03:33 +0200
In-Reply-To: <CACsJy8BG8fRPk74R_-YABCGMn-YwbDcLHtjUNX7KE66jX1mR4A@mail.gmail.com>
	(Duy Nguyen's message of "Mon, 5 May 2014 17:26:56 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 05 May 2014 13:03:33 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s45B3WPQ001488
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1399892616.26761@WPPyFZM+wU4i61cmDpKfpQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248143>

Duy Nguyen <pclouds@gmail.com> writes:

> On Mon, May 5, 2014 at 12:13 AM, David Kastrup <dak@gnu.org> wrote:
>> The default of 16m causes serious thrashing for large delta chains
>> combined with large files.
>>
>> Here are some benchmarks (pu variant of git blame):
>>
>> time git blame -C src/xdisp.c >/dev/null
>
> ...
>
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index 1932e9b..21a3c86 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -489,7 +489,7 @@ core.deltaBaseCacheLimit::
>>         to avoid unpacking and decompressing frequently used base
>>         objects multiple times.
>>  +
>> -Default is 16 MiB on all platforms.  This should be reasonable
>> +Default is 96 MiB on all platforms.  This should be reasonable
>>  for all users/operating systems, except on the largest projects.
>>  You probably do not need to adjust this value.
>
> So emacs.git falls exactly into the "except on the largest projects"
> part. Would it make more sense to advise git devs to set this per repo
> instead?

What's the impact of changing the default for small projects?

My guess is that changing from 16 to 96Mb is just following Moore's law.
Machines average RAM has increased a lot since the time 16Mb has been
chosen, and few people would actually notice the difference in RAM usage
nowadays.

If increasing the default does not harm small projects and benefits to
big projects, then we should obviously go this way.

(perhaps adding advices for people using Git on machines with low RAM)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
