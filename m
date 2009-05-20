From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [TopGit PATCH] tg-graph: print dependency graph like git log 
	--graph
Date: Wed, 20 May 2009 08:07:05 +0200
Message-ID: <36ca99e90905192307m67c11b83y7af44ccdb48f43e0@mail.gmail.com>
References: <1242711875-25666-1-git-send-email-bert.wesarg@googlemail.com>
	 <20090519132854.GA9606@piper.oerlikon.madduck.net>
	 <36ca99e90905190633l46fff979jecb61d4d0d907815@mail.gmail.com>
	 <20090519184402.GA27352@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: martin f krafft <madduck@debian.org>, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org, Adam Simpkins <adam@adamsimpkins.net>
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Wed May 20 08:08:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6exR-0007An-Vb
	for gcvg-git-2@gmane.org; Wed, 20 May 2009 08:07:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751869AbZETGHI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 May 2009 02:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751756AbZETGHH
	(ORCPT <rfc822;git-outgoing>); Wed, 20 May 2009 02:07:07 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:35597 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009AbZETGHG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 May 2009 02:07:06 -0400
Received: by bwz22 with SMTP id 22so199306bwz.37
        for <git@vger.kernel.org>; Tue, 19 May 2009 23:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=TrzXXS7Ndw7rze9vuzSuTpRJMAlC7cpNO9qG+JcuTHY=;
        b=p0xSsyuU6jnAR5sE4n+RLR68uNQ0HmWZ+paN+VUNlyrE6pZTB6sqvL8oE22CO3x4eV
         7Y5UY04MTy6xQqmDBR4ytT2ve0Vp/Vt38DCq9nzRPSRdwueXkcN2xW2EPLQvRmXk4sL2
         UvFENTIMJEZtqSo8K0iI84HODGPe5z6/ddARQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=KBB0zMUn9IBHadvJvJSY7OnFOEol5q7hNcLnXe2Ox24VLFMjY1MLo6hXVomBhwCDnd
         og/tNB77XsQARVb4KdjSWz9F1UquP7wclZG7t0xLz+MV8B6W+mONBTsOLqFCiR1vhVgh
         iW/5pw2ePYU5hBzcAIrBUCeBIY1b+aWlFqG4U=
Received: by 10.223.115.193 with SMTP id j1mr547623faq.85.1242799625392; Tue, 
	19 May 2009 23:07:05 -0700 (PDT)
In-Reply-To: <20090519184402.GA27352@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119584>

2009/5/19 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>:
> Hi Bert,
>
> On Tue, May 19, 2009 at 03:33:16PM +0200, Bert Wesarg wrote:
>> On Tue, May 19, 2009 at 15:28, martin f krafft <madduck@debian.org> =
wrote:
>> > also sprach Bert Wesarg <bert.wesarg@googlemail.com> [2009.05.19.0=
744 +0200]:
>> >> @@ -62,12 +70,33 @@ git for-each-ref refs/top-bases |
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 continue
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fi
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if [ -n "$graphv=
iz" ]; then
>> >> +
>> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if [ -n "$graphviz_verbose" ]; then
>> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 type=3D"header"
>> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 lines=3D0
>> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "\t\"$name\" ["
>> >
>> > You need to pass -e to echo for it to honour escape sequences. Tha=
t
>> > should solve Michael's problem. Alternatively, just use ^I directl=
y.
>> Correct, thanks. Looks like a feature from bash or dash to honor
>> escape sequences without -e'
> quoting
> http://www.gnu.org/software/hello/manual/autoconf/Limitations-of-Buil=
tins.html#Limitations-of-Builtins:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0It is not possible to use `echo' portably =
unless both options
> =C2=A0 =C2=A0 =C2=A0 =C2=A0and escape sequences are omitted.
>
> ... use printf instead.
Thank you for this valuable link, Will switch to printf.

Bert
>
> Best regards
> Uwe
