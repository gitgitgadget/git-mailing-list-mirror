From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH/RFC 1/4] grep: prepare for re-using the space of the
 regexp member in struct grep_pat
Date: Mon, 2 May 2011 16:25:11 +0200
Message-ID: <BANLkTimMOg45VrfftbMWQdu6gkF35gwZBw@mail.gmail.com>
References: <cover.1304321122.git.bert.wesarg@googlemail.com>
	<cover.1304318972.git.bert.wesarg@googlemail.com>
	<f768ea6e107cdd229a18df0bac3bf583eb1f9fc5.1304321122.git.bert.wesarg@googlemail.com>
	<BANLkTi=5Rr2t-u9dJCg6EpcbfEALJDY4wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 02 16:25:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGu3q-0005Lw-TF
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 16:25:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759253Ab1EBOZN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 May 2011 10:25:13 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61363 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758821Ab1EBOZM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2011 10:25:12 -0400
Received: by fxm17 with SMTP id 17so3655581fxm.19
        for <git@vger.kernel.org>; Mon, 02 May 2011 07:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ubDHqqO1gBCRFkqkEcsdrvkDWMJu0E5nXNVKyxZixmE=;
        b=JCRynbSWhF639nsFmbBuQgc1kotGdcCvmv7mpkZ32hQfUoyD6UxrsdMdUrU2aBXTY8
         7AxNBYpFphXHkc1eMIKFz1szdaaChtg9YCHOloZL/ZRvXF8SwYXYDTPxNVLlq3mgV/w4
         neImAqX2DFDoQLNNpivULlpsY5ZJq6ZD+P4cg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=TPoflhEND4PrRDk9hMurT5rmNnTLxMpowSm3dDr2RStY048FqG+IoMqnTykxPsrMCH
         Cp81wN2PR5nPWUf+HaEu1b4zVJw0gkQriAEiUUXv9c7HLR1rF7rn/G+19qryXvXFMIY7
         v5Xr4ReFHCaZD5I0LuYWC28ZuOLKAlbuA7oTM=
Received: by 10.223.5.3 with SMTP id 3mr1462398fat.56.1304346311412; Mon, 02
 May 2011 07:25:11 -0700 (PDT)
Received: by 10.223.71.205 with HTTP; Mon, 2 May 2011 07:25:11 -0700 (PDT)
In-Reply-To: <BANLkTi=5Rr2t-u9dJCg6EpcbfEALJDY4wQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172593>

On Mon, May 2, 2011 at 15:27, Thiago Farina <tfransosi@gmail.com> wrote=
:
> On Mon, May 2, 2011 at 8:39 AM, Bert Wesarg <bert.wesarg@googlemail.c=
om> wrote:
>> diff --git a/grep.h b/grep.h
>> index 06621fe..9912c11 100644
>> --- a/grep.h
>> +++ b/grep.h
>> @@ -32,7 +32,9 @@ struct grep_pat {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *pattern;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t patternlen;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0enum grep_header_field field;
>> - =C2=A0 =C2=A0 =C2=A0 regex_t regexp;
>> + =C2=A0 =C2=A0 =C2=A0 union {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 regex_t regexp;
>> + =C2=A0 =C2=A0 =C2=A0 } u;
>
> Instead of u, would be worth to rename it to something more descripti=
ve?

I followed struct grep_expr, where u is also used. But I'm open for a
better name, if you have one.

Bert
