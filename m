From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: Re: [PATCH] t4205: don't rely on en_US.UTF-8 locale existing
Date: Thu, 4 Jul 2013 02:27:29 +0400
Message-ID: <20130703222729.GD6148@dell-note>
References: <f607decdc65b86b1759438e375ddf77fd5b91042.1372882590.git.john@keeping.me.uk>
 <7vr4ffcoel.fsf@alter.siamese.dyndns.org>
 <20130703215303.GG9161@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Jul 04 00:27:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuVWT-0004Uz-AL
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 00:27:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754047Ab3GCW1e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Jul 2013 18:27:34 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:57980 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751316Ab3GCW1d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 18:27:33 -0400
Received: by mail-la0-f45.google.com with SMTP id fr10so636485lab.32
        for <git@vger.kernel.org>; Wed, 03 Jul 2013 15:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=msko0qtes0HH28JiUob1AFHlNLKF1UTKJ1P1vnEICAs=;
        b=D10uK5vY+ho9kVJmmAJXvHG8uusXQa+S1hyjK34VFSP79zm6sR41zVdIJOXYxCAv2y
         1CSPXo90T+wSllo4ACHrpLZLue5D83WaGo+4CTzv4t5jYa57F5PsBbKp91eyrbC8cGVY
         rcHTZjWQBkHzz8a/xmfq/dTrm8LYhQEasCyQY4ypaRWIqcHaQSu38v9g7T1oBK3pDZp+
         7ThXevbd6NUPSo5Gppn6zt46xfeK7PCGNvDif8WZJ0pwvVGW7KBrkpz5uOywqIy/Sr6G
         aQieoKXbEriTGTTnL2SpHYlbAxr05wgebvUCGq8C5piMrCl5u4tOoT1IhiCxsL4yoYkB
         x1tQ==
X-Received: by 10.112.205.163 with SMTP id lh3mr2176564lbc.45.1372890451887;
        Wed, 03 Jul 2013 15:27:31 -0700 (PDT)
Received: from localhost (ppp91-77-20-80.pppoe.mtu-net.ru. [91.77.20.80])
        by mx.google.com with ESMTPSA id x8sm32801lae.10.2013.07.03.15.27.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 03 Jul 2013 15:27:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130703215303.GG9161@serenity.lan>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229541>

On Wed, Jul 03, 2013 at 10:53:03PM +0100, John Keeping wrote:
> On Wed, Jul 03, 2013 at 02:41:06PM -0700, Junio C Hamano wrote:
> > John Keeping <john@keeping.me.uk> writes:
> >=20
> > > My system doesn't have the en_US.UTF-8 locale (or plain en_US), w=
hich
> > > causes t4205 to fail by counting bytes instead of UTF-8 codepoint=
s.
> > >
> > > Instead of using sed for this, use Perl which behaves predictably
> > > whatever locale is in use.
> > >
> > > Signed-off-by: John Keeping <john@keeping.me.uk>
> > > ---
> > > This patch is on top of 'as/log-output-encoding-in-user-format'.
> >=20
> > Thanks.  I think Alexey is going to send incremental updates to the
> > topic so I won't interfere by applying this patch on top of the
> > version I have in my tree.
> >=20
> > But I do agree that using Perl may be a workable solution.
> >=20
> > An alternative might be not to use this cryptic 3-arg form of
> > commit_msg at all.  They are used only for these three:
> >=20
> > 	$(commit_msg "" "8" "..*$")
> > 	$(commit_msg "" "0" ".\{11\}")
> > 	$(commit_msg "" "4" ".\{11\}")
> >=20
> > I somehow find them simply not readable, in order to figure out wha=
t
> > is going on.
> >=20
> > Just using three variables to hold what are expected would be far
> > more portable and readable.
> >=20
> > # "anf=C3=A4nglich" whatever it means.
> > sample_utf8_part=3D$(printf "anf\303\244ng")
> >=20
> > commit_msg () {
> > 	msg=3D"initial. ${sample_utf8_part}lich";
> > 	if test -n "$1"
> > 	then
> > 		echo "$msg" | iconv -f utf-8 -t "$1"
> > 	else
> > 		echo "$msg"
> >         fi
> > }
> >=20
> > And then instead of writing in the expected test output.
> >=20
> > 	$(commit_msg "" "8" "..*$")
> > 	$(commit_msg "" "0" ".\{11\}")
> > 	$(commit_msg "" "4" ".\{11\}")
> >=20
> > we can just say
> >=20
> > 	initial...
> >         ..an${sample_utf8_part}lich
> > 	init..lich
> >=20
> > It is no worse than those cryptic 0, 4, 8 and 11 magic numbers we
> > see in the test, no?
>=20
> That's probably better since we don't need to rely on some other tool
> getting it right.
>=20
> Alexey, will you incorporate this change in your incremental updates?
Yes, of course!
Thank you for your additions
