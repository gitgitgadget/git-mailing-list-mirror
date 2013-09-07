From: Lee Carver <Lee.Carver@servicenow.com>
Subject: Re: PATCH] Allow git-filter-branch to process large repositories
 with lots of branches.
Date: Sat, 7 Sep 2013 20:37:54 +0000
Message-ID: <CE50DC35.191A8%lee.carver@corp.service-now.com>
References: <87ppskgytz.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "gitster@pobox.com" <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Lee Carver <leeca@pnambic.com>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sat Sep 07 22:38:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIPGo-0008Ha-RF
	for gcvg-git-2@plane.gmane.org; Sat, 07 Sep 2013 22:38:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751889Ab3IGUh5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Sep 2013 16:37:57 -0400
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:50980 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751834Ab3IGUh4 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 7 Sep 2013 16:37:56 -0400
Received: from smtprelay.corp.service-now.com ([4.71.115.101]) (using TLSv1) by na3sys009aob109.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUiuOpGT+bi7ov3wFigvDP+qWqjNTRUlF@postini.com; Sat, 07 Sep 2013 13:37:56 PDT
Received: from SJC4EXDAG01-01.corp.service-now.com
 ([fe80::9d9c:f9e1:ea7b:618c]) by SJC4EXHTCAS02.corp.service-now.com ([::1])
 with mapi id 14.02.0347.000; Sat, 7 Sep 2013 13:37:55 -0700
Thread-Topic: PATCH] Allow git-filter-branch to process large repositories
 with lots of branches.
Thread-Index: AQHOrAf7PaTuVgvf1EmGYHtpFR3jZ5m6ueXugAACSgA=
In-Reply-To: <87ppskgytz.fsf@igel.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.15.239.100]
Content-ID: <9CCB4231B0D0F745A283DF15B3A32BC0@corp.service-now.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234145>

Andreas -

So that's what the "eval set -- " does!

We actually got it to work with a temporary file =8A I'll send that pat=
ch in
a minute.

Thanks
   Lee

On 9/7/13 1:29 PM, "Andreas Schwab" <schwab@linux-m68k.org> wrote:

>Lee Carver <Lee.Carver@servicenow.com> writes:
>
>> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
>> index ac2a005..d7e0fae 100755
>> --- a/git-filter-branch.sh
>> +++ b/git-filter-branch.sh
>> @@ -255,8 +255,6 @@ else
>>  	remap_to_ancestor=3Dt
>>  fi
>> =20
>> -rev_args=3D$(git rev-parse --revs-only "$@")
>> -
>>  case "$filter_subdir" in
>>  "")
>>  	eval set -- "$(git rev-parse --sq --no-revs "$@")"
>
>Here the arguments are reset.
>
>> @@ -267,8 +265,9 @@ case "$filter_subdir" in
>>  	;;
>>  esac
>> =20
>> +git rev-parse --revs-only "$@" | \
>
>So this is using a different argument list than before.
>
>Andreas.
>
>--=20
>Andreas Schwab, schwab@linux-m68k.org
>GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 =
4ED5
>"And now for something completely different."
