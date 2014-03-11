From: Sandy Carter <sandy.carter@savoirfairelinux.com>
Subject: Re: [PATCH] status merge: guarentee space between msg and path
Date: Tue, 11 Mar 2014 16:22:04 -0400
Message-ID: <531F706C.1080901@savoirfairelinux.com>
References: <1394555447-1805-1-git-send-email-sandy.carter@savoirfairelinux.com> <xmqqeh28pkuu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 21:20:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNTA1-0005Fb-M3
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 21:20:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755047AbaCKUUT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Mar 2014 16:20:19 -0400
Received: from mail.savoirfairelinux.com ([209.172.62.77]:60515 "EHLO
	mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754268AbaCKUUS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 16:20:18 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id C6A1D10D73B7;
	Tue, 11 Mar 2014 16:20:17 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FXy63-kutrxQ; Tue, 11 Mar 2014 16:20:17 -0400 (EDT)
Received: from [192.168.49.85] (mtl.savoirfairelinux.net [208.88.110.46])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 52B2010D73B6;
	Tue, 11 Mar 2014 16:20:17 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <xmqqeh28pkuu.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243891>

Le 2014-03-11 15:59, Junio C Hamano a =E9crit :
> Sandy Carter <sandy.carter@savoirfairelinux.com> writes:
>
>> diff --git a/wt-status.c b/wt-status.c
>> index a452407..69e0dfc 100644
>> --- a/wt-status.c
>> +++ b/wt-status.c
>> @@ -264,7 +264,7 @@ static void wt_status_print_unmerged_data(struct=
 wt_status *s,
>>   	case 6: how =3D _("both added:"); break;
>>   	case 7: how =3D _("both modified:"); break;
>>   	}
>> -	status_printf_more(s, c, "%-20s%s\n", how, one);
>> +	status_printf_more(s, c, "%-19s %s\n", how, one);
>>   	strbuf_release(&onebuf);
>>   }
>
> Thanks; I have to wonder if we would want to do something similar to
> what 3651e45c (wt-status: take the alignment burden off translators,
> 2013-11-05) to the other parts of the output, though.
>

I could, do this. It would be cleaner, but there's just the issue of th=
e=20
colon (:) which requires a space before it in the french language[1]. A=
s=20
you can see in po/fr.po, the french translators have done a good job at=
=20
including it [2].

3651e45c takes the colon out of the control of the translators.

+       if (status =3D=3D DIFF_STATUS_COPIED || status =3D=3D DIFF_STAT=
US_RENAMED)
+               status_printf_more(s, c, "%s:%.*s%s -> %s",
+                                  what, len, padding, one, two);
+       else
+               status_printf_more(s, c, "%s:%.*s%s",
+                                  what, len, padding, one);


[1] https://en.wikipedia.org/wiki/Colon_%28punctuation%29#Spacing
[2] https://github.com/git/git/blob/master/po/fr.po#L585
