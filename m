From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCHv6 1/4] Read (but not write) from $XDG_CONFIG_HOME/git/config
 file
Date: Fri, 8 Jun 2012 14:57:42 +0200
Message-ID: <CABPQNSYXDZ==NckcFw6BjGdZTD3HcNYFRKe4h8ZczRpGSACMJQ@mail.gmail.com>
References: <1338754481-27012-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
 <1338988885-21933-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
 <7vpq9aenl0.fsf@alter.siamese.dyndns.org> <20120608142601.Horde.Tq7UO3wdC4BP0e9ZGAy1EwA@webmail.minatec.grenoble-inp.fr>
 <CABPQNSbSVznFbnm=iy4HdZ4PDC70UfbrqvvSKx9moy+9AOk+Rw@mail.gmail.com> <20120608145423.Horde.qT2BG3wdC4BP0fX-GHdFAeA@webmail.minatec.grenoble-inp.fr>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>, git@vger.kernel.org,
	Matthieu.Moy@grenoble-inp.fr,
	NGUYEN Huynh Khoi Nguyen <nguyenhu@ensibm.imag.fr>,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: nguyenhu@minatec.inpg.fr
X-From: git-owner@vger.kernel.org Fri Jun 08 14:58:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Scyln-0005cu-47
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 14:58:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753527Ab2FHM6X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Jun 2012 08:58:23 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:45987 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753363Ab2FHM6W convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jun 2012 08:58:22 -0400
Received: by pbbrp8 with SMTP id rp8so2515828pbb.19
        for <git@vger.kernel.org>; Fri, 08 Jun 2012 05:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=okCsr/JOdqP/8+k6mbunaTlLdDTgXS4otNe6HJgLBCY=;
        b=fIi7xlb+jy7blG8zkakx5755IydpJyGnzS/+hhvGqTg+4KDhIBMWXAWsrP/5QYzH/q
         parcJIasy/uDfI4mVvRLZSQVdIBnjBXmRlBmiLtLh/tGliRCsw5E6Yy0TSq5EIWZuG7j
         w42A42eIfaIEW9L7jg+Dd7yydbTj6CMqNBQmWER5qSwk6bHmSDE2nYOu8YvEsjM+EnuN
         UG92P1Ryko5RxRApRcZaJkNwMnX174cHXrxjC93Jj5cIuTF/flv2fUYwqxsD2pD3EK8t
         S7T/BrS5JjeGa8+Z0Q8Vt0EP6bI7O6Kxo4dgVGoQNQjruFIf2yRd7i3jBHOBIcvtEEcI
         H6UA==
Received: by 10.68.217.166 with SMTP id oz6mr19755342pbc.136.1339160302277;
 Fri, 08 Jun 2012 05:58:22 -0700 (PDT)
Received: by 10.68.40.98 with HTTP; Fri, 8 Jun 2012 05:57:42 -0700 (PDT)
In-Reply-To: <20120608145423.Horde.qT2BG3wdC4BP0fX-GHdFAeA@webmail.minatec.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199486>

On Fri, Jun 8, 2012 at 2:54 PM,  <nguyenhu@minatec.inpg.fr> wrote:
>
> Erik Faye-Lund <kusmabite@gmail.com> a =E9crit=A0:
>
>
>>> char *mkpathdup(const char *fmt, ...)
>>> {
>>> =A0 =A0 =A0 =A0char *path;
>>> =A0 =A0 =A0 =A0struct strbuf sb =3D STRBUF_INIT;
>>> =A0 =A0 =A0 =A0va_list args;
>>>
>>> =A0 =A0 =A0 =A0va_start(args, fmt);
>>> =A0 =A0 =A0 =A0strbuf_vaddf(&sb, fmt, args);
>>> =A0 =A0 =A0 =A0va_end(args);
>>> =A0 =A0 =A0 =A0path =3D sb.buf;
>>>
>>> =A0 =A0 =A0 =A0strbuf_release(&sb);
>>> =A0 =A0 =A0 =A0return xstrdup(cleanup_path(path));
>>>
>>> }
>>
>>
>> No, strbuf_release(&sb) frees 'sb.buf', causing 'path' to point to
>> unallocated memory. You can fix that by doing something along these
>> lines on top:
>>
>> =A0 =A0 =A0 =A0va_end(args);
>> - =A0 =A0 =A0 path =3D sb.buf;
>> + =A0 =A0 =A0 path =3D xstrdup(cleanup_path(path));
>>
>> =A0 =A0 =A0 =A0strbuf_release(&sb);
>> - =A0 =A0 =A0 return xstrdup(cleanup_path(path));
>> + =A0 =A0 =A0 return path;
>> =A0}
>
>
> You are right, but I think you rather mean this, no?
>
>
> =A0 =A0 =A0 =A0va_end(args);
> - =A0 =A0 =A0 path =3D sb.buf;
> + =A0 =A0 =A0 path =3D xstrdup(cleanup_path(sb.buf));
>
>
> =A0 =A0 =A0 =A0strbuf_release(&sb);
> - =A0 =A0 =A0 return xstrdup(cleanup_path(path));
> + =A0 =A0 =A0 return path;
> =A0}
>

Yes, sorry for the fat fingers :)
