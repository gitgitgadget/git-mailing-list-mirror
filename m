From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] mingw: avoid const warning
Date: Fri, 06 Jun 2014 12:13:58 -0700
Message-ID: <xmqq1tv1rguh.fsf@gitster.dls.corp.google.com>
References: <20140529104329.GA24021@camelia.ucw.cz>
	<20140529104716.GC24021@camelia.ucw.cz> <5391D956.7050903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Stepan Kasal <kasal@ucw.cz>,  GIT Mailing-list <git@vger.kernel.org>,  Erik Faye-Lund <kusmabite@gmail.com>,  msysgit@googlegroups.com
To: Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBCG77UMM3EJRB7NFZCOAKGQEHUCBZVY@googlegroups.com Fri Jun 06 21:14:06 2014
Return-path: <msysgit+bncBCG77UMM3EJRB7NFZCOAKGQEHUCBZVY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f189.google.com ([209.85.217.189])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRB7NFZCOAKGQEHUCBZVY@googlegroups.com>)
	id 1WszaY-00068J-EX
	for gcvm-msysgit@m.gmane.org; Fri, 06 Jun 2014 21:14:06 +0200
Received: by mail-lb0-f189.google.com with SMTP id 10sf373984lbg.26
        for <gcvm-msysgit@m.gmane.org>; Fri, 06 Jun 2014 12:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-transfer-encoding;
        bh=JUXiyjOdVcUf9PQLAXVVaQlFQ12W18NxBdUDtg0GmqI=;
        b=MgVe6gpTkLJWzX80G4xw69TICqtKPyT51JdXDjJYgh8lEY96kofNMV0IwhNQYI+eGA
         zJFA93IQHHB9OPmxpGpXRAv3c6lntbd/3DRvKdYIG/vBmnoRNIlda+lnf71uctIKPZcx
         JxUybICIJo9x/+djvqLRceps2oBesioc0HQ5EMXJfWvPebSC9XAY/1naHdsSCpIe7ViJ
         PP6w9LG1R1N6U8k9G8fQUnik/jr/FXcRl07hDPdj/3VUQLSvJx0IdqhNcst0OZqrSVjd
         vvb/OzuGJO3vstBBTgKdt/BXt3EekGlsbwPkLHf2kdff2fiXxUaWDrG/Y3w2eylQ+Fu/
         27EQ==
X-Received: by 10.152.37.200 with SMTP id a8mr46796lak.19.1402082046187;
        Fri, 06 Jun 2014 12:14:06 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.153.6.12 with SMTP id cq12ls144697lad.86.gmail; Fri, 06 Jun
 2014 12:14:05 -0700 (PDT)
X-Received: by 10.152.36.226 with SMTP id t2mr1923826laj.1.1402082045067;
        Fri, 06 Jun 2014 12:14:05 -0700 (PDT)
Received: from smtp.pobox.com (smtp.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id ci7si2338107qcb.1.2014.06.06.12.14.04
        for <msysgit@googlegroups.com>;
        Fri, 06 Jun 2014 12:14:04 -0700 (PDT)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 926D31C8B2;
	Fri,  6 Jun 2014 15:14:04 -0400 (EDT)
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 867441C8B1;
	Fri,  6 Jun 2014 15:14:04 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 978FD1C8A1;
	Fri,  6 Jun 2014 15:14:00 -0400 (EDT)
In-Reply-To: <5391D956.7050903@gmail.com> (Karsten Blees's message of "Fri, 06
	Jun 2014 17:08:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B7490F28-EDAE-11E3-8545-9903E9FBB39C-77302942!pb-smtp0.pobox.com
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted
 sender) smtp.mail=junio@pobox.com;       dkim=pass header.i=@pobox.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250958>

Karsten Blees <karsten.blees@gmail.com> writes:

> Am 29.05.2014 12:47, schrieb Stepan Kasal:
>> Fix const warnings in http-fetch.c and remote-curl.c main() where is
>> argv declared as const.
>>=20
>> The fix should work for all future declarations of main, no matter
>> whether the second parameter's type is "char**", "const char**", or
>> "char *[]".
>
> I'm 100% in favor of a solution that doesn't restrict main to non-const c=
har**! Thanks.
>
>> Signed-off-by: Stepan Kasal <kasal@ucw.cz>
>> ---
>>  compat/mingw.h | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/compat/mingw.h b/compat/mingw.h
>> index 15f0c9d..8745d19 100644
>> --- a/compat/mingw.h
>> +++ b/compat/mingw.h
>> @@ -369,10 +369,11 @@ extern CRITICAL_SECTION pinfo_cs;
>>  void mingw_startup();
>>  #define main(c,v) dummy_decl_mingw_main(); \
>>  static int mingw_main(c,v); \
>> -int main(int argc, char **argv) \
>> +int main(c, char **main_argv_not_used) \
>>  { \
>> +	typedef v, **argv_type; \
>>  	mingw_startup(); \
>> -	return mingw_main(__argc, __argv); \
>> +	return mingw_main(__argc, (argv_type)__argv); \
>>  } \
>>  static int mingw_main(c,v)
>> =20
>
> I have to admit I had trouble understanding what 'typedef v,
> **arv_type;' does (looks invalid at first glance), and why you
> would need main_argv_not_used instead of just main(c,v).
>
> So, I'd like to award +10 points for cleverness, but -10 for
> obscurity ;-) Probably deserves a comment or an explanation in the
> commit message.

Agreed.  The "typedef" one is a cute hack.

I am wondering why the solution is not a more obvious "drop const
that is not ANSI C", though.  I only have a ready-access to N1570
draft but in it I find:

    5.1.2.2.1 Program startup

    The function called at program startup is named main. The
    implementation declares no prototype for this function. It shall
    be de=EF=AC=81ned with a return type of int and with no parameters:

    int main(void) { /* ... */ }

    or with two parameters (referred to here as argc and argv,
    though any names may be used, as they are local to the function
    in which they are declared):

    int main(int argc, char *argv[]) { /* ... */ }

    or equivalent;10) or in some other implementation-de=EF=AC=81ned manner=
.

    ---
    10) Thus, int can be replaced by a typedef name de=EF=AC=81ned as int,
    or the type of argv can be written as char ** argv, and so on.

> A simpler solution that works with all definitions of main() is to
> cast to void* (tell the compiler all responsibility is on
> us).

Can you cast away the constness that way, though?

--=20
--=20
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github =
accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den

---=20
You received this message because you are subscribed to the Google Groups "=
msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
