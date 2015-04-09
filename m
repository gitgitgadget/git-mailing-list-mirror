From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH] fix global bash variable leak on __gitcompappend
Date: Thu, 09 Apr 2015 10:55:00 +0200
Message-ID: <20150409105500.Horde.LF_geolXws6AivFm4yBs0w7@webmail.informatik.kit.edu>
References: <1428471958-12339-1-git-send-email-marcio3w@gmail.com>
 <1428471958-12339-2-git-send-email-marcio3w@gmail.com>
 <xmqqiod6ar9v.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?b?TcOhcmNpbw==?= Almada <marcio.web2@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 09 11:36:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yg8sU-00019x-91
	for gcvg-git-2@plane.gmane.org; Thu, 09 Apr 2015 11:36:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934658AbbDIJfp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Apr 2015 05:35:45 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:44515 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933442AbbDIIzF convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 9 Apr 2015 04:55:05 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1Yg8Em-0001FI-DQ; Thu, 09 Apr 2015 10:55:00 +0200
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1Yg8Em-0003SP-8l; Thu, 09 Apr 2015 10:55:00 +0200
Received: from x590d7e02.dyn.telefonica.de (x590d7e02.dyn.telefonica.de
 [89.13.126.2]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Thu, 09 Apr 2015 10:55:00 +0200
In-Reply-To: <xmqqiod6ar9v.fsf@gitster.dls.corp.google.com>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.2)
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1428569700.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266989>


Quoting Junio C Hamano <gitster@pobox.com>:

> "M=C3=A1rcio Almada" <marcio.web2@gmail.com> writes:
>
>> ---
>>  contrib/completion/git-completion.bash | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Nicely found and corrected.  Please sign-off your patch and Cc area
> experts if you can find them (I'll do that this time for you).
>
> Thanks.
>
>>
>> diff --git a/contrib/completion/git-completion.bash =20
>> b/contrib/completion/git-completion.bash
>> index 661a829..1620546 100644
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -186,7 +186,7 @@ fi
>>
>>  __gitcompappend ()
>>  {
>> -	local i=3D${#COMPREPLY[@]}
>> +	local x i=3D${#COMPREPLY[@]}
>>  	for x in $1; do
>>  		if [[ "$x" =3D=3D "$3"* ]]; then
>>  			COMPREPLY[i++]=3D"$2$x$4"

Looks good and obviously correct, imho even at -rc2 time.

Not sure whether it's maint-worthy, but just in case: it was =20
introduced in v1.8.3-rc0~59^2~2.
