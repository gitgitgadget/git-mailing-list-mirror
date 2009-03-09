From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/3] config: set help text for --bool-or-int
Date: Mon, 9 Mar 2009 23:50:09 +0200
Message-ID: <94a0d4530903091450gdcad625g95cd9550cfb724fa@mail.gmail.com>
References: <1236446046-18319-1-git-send-email-peff@peff.net>
	 <1236446046-18319-3-git-send-email-peff@peff.net>
	 <94a0d4530903071307p46092810rb1637bfc853ee4d1@mail.gmail.com>
	 <20090307224807.GA18548@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 09 22:51:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgnO0-0004We-Uv
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 22:51:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751725AbZCIVuQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Mar 2009 17:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752393AbZCIVuP
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 17:50:15 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:22140 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954AbZCIVuM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Mar 2009 17:50:12 -0400
Received: by fg-out-1718.google.com with SMTP id 16so888564fgg.17
        for <git@vger.kernel.org>; Mon, 09 Mar 2009 14:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=YEc3z8yFgUNNgh9CuSAr25v8pogWUr1uD+GfUqwLtc4=;
        b=gFf91LOPNyzkevpAMSTDBdPiS08Aaeft6ZhbLVNmIp9P4Up9X+0TLmuZ99T8TqXt8p
         ezHmiNLR5wfL2BXSxxh2Tf4nVczjdbUHzC0hnSnl5szBmIyAzv7OVmt9RWD6Ohy/E/iy
         x7/noReoT01mAyWe+aFD1lRKV6T5YPJ9hYoSw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kat3P2QGBOpUoMyaVI7ybKexkMcO9q42XvxU4TMyoE6OPo0jc7HvRhAtPGP9mhiNde
         QGc1OBJvjHosr2mgRS7KFrqrzXMql9kEBvgj54P9gg34ahVc8jwwntdrvFEvur0MjJUU
         NylNlXoBXCy5Zj5TKK8P1V34Jvs2IT1dEUSao=
Received: by 10.86.74.4 with SMTP id w4mr4466481fga.21.1236635409555; Mon, 09 
	Mar 2009 14:50:09 -0700 (PDT)
In-Reply-To: <20090307224807.GA18548@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112748>

On Sun, Mar 8, 2009 at 12:48 AM, Jeff King <peff@peff.net> wrote:
> On Sat, Mar 07, 2009 at 11:07:46PM +0200, Felipe Contreras wrote:
>
>> On Sat, Mar 7, 2009 at 7:14 PM, Jeff King <peff@peff.net> wrote:
>> > The conversion to parse_opt left this as NULL; on glibc
>> > systems, the usage message prints
>> >
>> > =C2=A0 --bool-or-int =C2=A0 (null)
>> >
>> > and on other ones, segfaults.
>>
>> Shouldn't then OPT_BIT make sure there is no crash?
>
> Perhaps, but it doesn't (and I assume you mean usage_with_help, as
> OPT_BIT is just filling in the struct). It's not clear what a NULL he=
lp
> parameter should do, though. Hide the option? Show no help descriptio=
n?
> There are already ways to accomplish both of those.

Yeah, I meant usage_with_help. I don't know what should be done, but I
think two things should be achieved:

a) don't crash
b) encourage the options to always have a description

Perhaps not showing the option at all, or perhaps showing "**EMPTY**".

>> I was surprised when it didn't complain. I thought on making it "" b=
ut
>> I wanted to make it visible that there was no documentation for that=
,
>> which is the reason I left it that way.
>
> OK. I think there are really valid options:
>
> =C2=A01. it's there with a description (which is what my patch does)
>
> =C2=A02. it's there without a description, because it's obvious what =
it does
> =C2=A0 =C2=A0 coming after --bool and --int

I don't think it's obvious, that partly why I didn't fill the descripti=
on.

> =C2=A03. it's hidden
>
> I really don't care which. But what is there now is broken.

Definitely, your patch must be applied ASAP.

Minor nitpick: "value is interpreted either as bool or int"

The value is what it is, the --boo-or-int option doesn't change the
value, just how it is interpreted.

--=20
=46elipe Contreras
