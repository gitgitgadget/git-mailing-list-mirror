From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH] fmt-merge-msg: show those involved in a merged series
Date: Mon, 12 Mar 2012 17:37:57 -0400
Message-ID: <CABURp0oVn3s27Rtq2JQeLBgcXq1-R-=0qawcXVMxZ8qgOeZGkQ@mail.gmail.com>
References: <7vvcmj68iz.fsf@alter.siamese.dyndns.org> <CA+55aFzQ3+EFBVyE9PWOyH0XEC_oW+kUaBTYfixmi2wgMmiZvw@mail.gmail.com>
 <7vipii27ka.fsf@alter.siamese.dyndns.org> <CA+55aFw-sS_p7JXNXbSbpiwh9_bZhSrTtC3is4NtLa_n9Hzk5A@mail.gmail.com>
 <7vmx7uzq8h.fsf_-_@alter.siamese.dyndns.org> <4F57D18B.5090506@lsrfire.ath.cx>
 <7vzkbskr71.fsf@alter.siamese.dyndns.org> <4F58F06A.1070108@lsrfire.ath.cx> <7v1up2ew9u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 12 22:38:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7Cwi-0006mO-Fk
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 22:38:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753154Ab2CLViT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Mar 2012 17:38:19 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:35129 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751510Ab2CLViS convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 17:38:18 -0400
Received: by lahj13 with SMTP id j13so4059073lah.19
        for <git@vger.kernel.org>; Mon, 12 Mar 2012 14:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=BaKepmFAUnBZpVksLlblZEgHQ3DtgrjFMynV5+mG0xQ=;
        b=ZhcssLHBuHCDnx2MZlkpgquLjVAVTIrtUjoMaOAqrl5SosfplwX6hGFyBGahrJKrL2
         +3CrSQt74pB8owRT86DLD5BhT/YRaoSW5PlTjj1BC0yUO0T2UwQjLGJBJMm70DtA/ZW4
         dfnMuBknPlQm/66jF8QPrxQL74rpXXsouSam6rP+0xZOYnMQhkQ2olDtDCqr3IsiAaZn
         y2VhyjUUe/I2GTTQ6ccBPuldmafpr+IRZ9qLUbD1h7ECvsjishfwVILEHw9s9oh08RFI
         petZ82BkFwoyH2ABeCqytlEjwRUL0bcI98PxFw2DAFC7QGj6Oh8pAfUx5jUFh+T2OiLe
         cF8w==
Received: by 10.112.38.3 with SMTP id c3mr5112731lbk.94.1331588297274; Mon, 12
 Mar 2012 14:38:17 -0700 (PDT)
Received: by 10.112.55.43 with HTTP; Mon, 12 Mar 2012 14:37:57 -0700 (PDT)
In-Reply-To: <7v1up2ew9u.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192951>

On Thu, Mar 8, 2012 at 2:18 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Ren=E9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>
>> Am 07.03.2012 22:59, schrieb Junio C Hamano:
>>> Ren=E9 Scharfe<rene.scharfe@lsrfire.ath.cx> =A0writes:
>>>
>>>> Am 05.03.2012 22:34, schrieb Junio C Hamano:
>>>>
>>>>> +#define util_as_int(elem) ((intptr_t)((elem)->util))
>>>>
>>>> Something that actually returns an int would fit the name better. =
;)
>>>
>>> The particular type would not matter to the callers of the helper
>>> macro, would it?
>>
>> Three of the five callers introduced in that commit cast the result =
to
>> int and the remaining two don't care, so it actually does seem to
>> matter for most of them, strictly speaking. =A0When I see a nit, I c=
an't
>> resist the urge to pick it, apparently.
>
> Unfortunately, replacing intptr_t with int or casting the above
> again as int will result in
>
> builtin/fmt-merge-msg.c: In function 'record_person':
> builtin/fmt-merge-msg.c:213: error: cast to pointer from integer of d=
ifferent size
>
> So...

Out of the frying pan, into the fire...

   builtin/fmt-merge-msg.c: In function =91record_person=92:
   builtin/fmt-merge-msg.c:213:34: warning: cast from pointer to
integer of different size [-Wpointer-to-int-cast]
   builtin/fmt-merge-msg.c: In function =91cmp_string_list_util_as_int=92=
:
   builtin/fmt-merge-msg.c:219:9: warning: cast from pointer to
integer of different size [-Wpointer-to-int-cast]
   builtin/fmt-merge-msg.c:219:26: warning: cast from pointer to
integer of different size [-Wpointer-to-int-cast]
   builtin/fmt-merge-msg.c: In function =91add_people_count=92:
   builtin/fmt-merge-msg.c:229:8: warning: cast from pointer to
integer of different size [-Wpointer-to-int-cast]
   builtin/fmt-merge-msg.c:231:8: warning: cast from pointer to
integer of different size [-Wpointer-to-int-cast]
   builtin/fmt-merge-msg.c:235:8: warning: cast from pointer to
integer of different size [-Wpointer-to-int-cast]

I see slightly different code in pu than in next, but it produces the
same warnings on my 64-bit Linux machine.

Here's a fix against next:

-- >8 --

Subject: [PATCH] Appease compiler pedantry with an extra cast

Recently git repurposed a pointer as an integer to hold some
counter which git fancies.

Casting directly from 'pointer' to 'int' ((int)(void*)&x) causes a
possible size mismatch because pointers can be bigger than ints.
In such a situation, the compiler complains:

   warning: cast from pointer to integer of different size
            [-Wpointer-to-int-cast]

Cast the value through intptr_t first to quell compiler complaints
about how this gun appears to be aimed near our feet.  Then cast this
value to an int; this path assures the compiler we are smarter than we
look, or at least that we intend to aim the gun this way for a reason.
---
 builtin/fmt-merge-msg.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 8ddefb3..fee65e0 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -182,7 +182,7 @@ static void add_branch_desc(struct strbuf *out,
const char *name)
        strbuf_release(&desc);
 }

-#define util_as_int(elem) ((int)((elem)->util))
+#define util_as_int(elem) ((int)(intptr_t)((elem)->util))

 static void record_person(int which, struct string_list *people,
                          struct commit *commit)
--=20
1.7.9.3
