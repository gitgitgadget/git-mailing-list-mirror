From: Kazutoshi Satoda <k_satoda@f2.dion.ne.jp>
Subject: Re: [PATCH 1/1] t9115: Skip pathnameencoding=cp932 under HFS
Date: Thu, 17 Mar 2016 02:37:07 +0900
Message-ID: <56E999C3.4040802@f2.dion.ne.jp>
References: <20160208225806.GA3487@dcvr.yhbt.net>
 <1456597724-26497-1-git-send-email-tboegi@web.de>
 <20160228045945.GA14289@dcvr.yhbt.net> <56D333F1.9050905@web.de>
 <20160315015954.GB25295@dcvr.yhbt.net> <56E79C54.8000606@web.de>
 <20160315070930.GA24036@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Mar 16 18:37:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agFOB-0000gb-F3
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 18:37:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934867AbcCPRhW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Mar 2016 13:37:22 -0400
Received: from mail-ae1-f7.auone-net.jp ([106.187.231.7]:41722 "EHLO
	dmta02.auone-net.jp" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934545AbcCPRhT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 13:37:19 -0400
Received: from amlmta045.auone-net.jp (amlmta045-MM [10.188.23.24])
	by dmta02.auone-net.jp (au one net mail) with ESMTP id BDE3F4009AD
	for <git@vger.kernel.org>; Thu, 17 Mar 2016 02:37:16 +0900 (JST)
Received: from [0.0.0.0] ([195.154.93.144])
	by amlmta045.auone-net.jp id 56e999c7000e7df4000009af000037aa800008c6d120;
	Thu, 17 Mar 2016 02:37:11 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
In-Reply-To: <20160315070930.GA24036@dcvr.yhbt.net>
X-MXM-DELIVERY-TYPE: 3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289004>

On 2016/03/15 16:09 +0900, Eric Wong wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> wrote:
>> On 03/15/2016 02:59 AM, Eric Wong wrote:
>> >[]
>> >I just edited locally and pushed those out to Junio:
>> >
>> >http://mid.gmane.org/20160315015726.GA25295@dcvr.yhbt.net
>> >
>>=20
>> The new TC 11/12 don't pass under cygwin.
>>=20
>> Do we need cp932 ?
>=20
> Not sure, both CP932 and ISO8859-1 work fine for me on
> GNU/Linux.   Anyways I'm fine skipping this patch for 2.8
> while we hash it out, too.
>=20
> Kazutoshi: can you answer?  Thanks.

I tried the patch. The test works (pass with my fixes, and fails
without fixes) with ISO8859-1 for me on Cygnus. The change sounds
good.


>> If not, we may use the paych from here:
>> https://github.com/tboegi/git/commit/379c01bf52464f8a50065b11af51612=
7e9144045
>>=20
>> Date:   Tue Mar 15 05:03:18 2016 +0100
>>=20
>>     t9115: Use funcky file names that work under unicode FS

"funcky" looks a typo.

>>     Don't use funky file names, that can not be created under
>>     HFS or NTFS.

The file can be created on my Cygnus environment, which is under FONTS.
So it looks a bit inaccurate.

I think a quote from the actual error message may be useful. It will
likely tell what was wrong, accurately. And also, someone may search fo=
r
that message.

>> -       neq=3D$(printf "\201\202") &&
>> -       git config svn.pathnameencoding cp932 &&
>> +       neq=3D$(printf "\303\244") &&
>> +       git config svn.pathnameencoding ISO8859-1 &&

The variable name "new" was for "NOT EQUAL TO" (0x8182 in cp932 =3D U+2=
260).
http://unicode.org/Public/MAPPINGS/VENDORS/MICSFT/WINDOWS/CP932.TXT
Then it should be changed, too. A more abstract one may be appropriate.

>> -       inf=3D$(printf "\201\207") &&
>> -       git config svn.pathnameencoding cp932 &&
>> +       inf=3D$(printf "\303\226") &&
>> +       git config svn.pathnameencoding ISO8859-1 &&

Ditto. (0x8187 in cp932 =3D U+221E, INFINITY)

--=20
k_satoda
