From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH/RFC v7 1/2] Add infrastructure for translating Git with 
	gettext
Date: Sat, 5 Jun 2010 03:30:38 +0000
Message-ID: <AANLkTilSJ_1STKGvat0llqYVZRI8_tQriE-hIBJPEldn@mail.gmail.com>
References: <1275704035-6552-1-git-send-email-avarab@gmail.com>
	<1275704035-6552-2-git-send-email-avarab@gmail.com>
	<20100605030059.GB2019@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 05 05:30:45 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKk5s-0007Ms-J6
	for gcvg-git-2@lo.gmane.org; Sat, 05 Jun 2010 05:30:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756489Ab0FEDaj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Jun 2010 23:30:39 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56574 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756162Ab0FEDaj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Jun 2010 23:30:39 -0400
Received: by iwn37 with SMTP id 37so1709254iwn.19
        for <git@vger.kernel.org>; Fri, 04 Jun 2010 20:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=tspsrzB6tn7qDZKkss9Ka+h6Zjdsx4842CCGF/RavUc=;
        b=U86gi+SjPKLQEHFQfF6hxmDwrS/C8CHzOpAxjzYQJJIm7xEIetTdBZC2I+8x1PYcMh
         sQ3ESXY5hkWvCOWLVaaDxjXMVZTOGXkAE0tUa0Ypu/PJ/eHCycgHBI6oewwKUpSS+3J0
         icRkNScDixPgGREqIfgGZMEfT4XsFPr+ZC6Zw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bgk0K9x1+MB09QNMLOKfmaKJUL5DF+81nvAuyaOhC9eYBskspzgNyPhfSBWKrd1Yw5
         O8U2Hy7uo5VhqchsYckbJtm+tfxDH07KsuVm1eoSaAl82jFF0LwCsPpyn0HPy+MbkUxz
         jl7eDsS8N64nBxtfU3ZSPFIzarDgntrjWH0hU=
Received: by 10.231.124.40 with SMTP id s40mr1735574ibr.172.1275708638421; 
	Fri, 04 Jun 2010 20:30:38 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Fri, 4 Jun 2010 20:30:38 -0700 (PDT)
In-Reply-To: <20100605030059.GB2019@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148454>

On Sat, Jun 5, 2010 at 03:01, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
>> diff --git a/gettext.c b/gettext.c
>> new file mode 100644
>> index 0000000..22cdcc1
>> --- /dev/null
>> +++ b/gettext.c
>> @@ -0,0 +1,25 @@
>> +#ifdef NO_GETTEXT
>> +void git_setup_gettext(void) {}
>> +#else
>> +#include "exec_cmd.h"
>> +#include <libintl.h>
>> +#include <stdlib.h>
>> +
>> +void git_setup_gettext(void) {
> [...]
>
> Could this conditional be taken care of by gettext.h and the Makefile
> and avoid complicating the main source file? =C2=A0i.e., something li=
ke
>
> =C2=A0#ifdef NO_GETTEXT
> =C2=A0static inline void git_setup_gettext(void) {}
> =C2=A0#endif
>
> and
>
> =C2=A0ifndef NO_GETTEXT
> =C2=A0LIB_OBJS +=3D gettext.o
> =C2=A0endif

Sure, but that would be putting code in a header file, which is
usually taboo. It looks like there's some prior art on that though.
Like strbuf.h.

I don't care either way, what do you think?
