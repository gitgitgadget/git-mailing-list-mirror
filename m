From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH nd/wildmatch] Correct Git's version of isprint and isspace
Date: Tue, 13 Nov 2012 11:50:15 -0800
Message-ID: <CA+55aFynRG-CbSp-aLoo1iZTvfBWMgt6kwrPiQjSZJ0ZzraDKQ@mail.gmail.com>
References: <507E9FDE.7080706@cs.tu-berlin.de> <1352803572-14547-1-git-send-email-pclouds@gmail.com>
 <50A29C3A.1070000@lsrfire.ath.cx> <CA+55aFwsjpOop=4mVkx4e=zw5LH41sD9x-b_WMo4Hvo7ygjEtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, schnhrr@cs.tu-berlin.de
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Nov 13 20:50:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYMVZ-0008J1-BZ
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 20:50:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755494Ab2KMTuk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 14:50:40 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:53605 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754329Ab2KMTuj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 14:50:39 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so611793obb.19
        for <git@vger.kernel.org>; Tue, 13 Nov 2012 11:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=OtWb8axOPRJIe4MC+WwThYOXcrptOEPze3dXD6OtGrw=;
        b=SctHCPow3UUgX8cQFaePUsJf9hSoj3CE7+kGtQLtJpRLNflmldA3ZkPcRAkYBXMxIS
         mIM5gTc7mJK2BRS3OLNVdogNmC+4qPnZyAqLPF9EvjU0J3dlCE2c+2QXPiAs1yVHyb/H
         7VIAnAGcmsqHmdA5C07737VK4CZGDbpdtbnNwHCDnIPmk9SLF7OoAA+MVxBCcol2b1Nu
         cyj2zDStAgZXb4R3XXAFQGHdYQZqIy72rD3kEpmlLD6KMon8x0kHZo54bNTWDFYvKFrj
         kwQZjMCq/EFzOWF0bYeQUtY3j5JnXrqFzolh9kYl1UUjIXfDIhmr+WCQzQExF2fo8/Ey
         bVcg==
Received: by 10.60.32.135 with SMTP id j7mr17853203oei.132.1352836235633; Tue,
 13 Nov 2012 11:50:35 -0800 (PST)
Received: by 10.76.2.242 with HTTP; Tue, 13 Nov 2012 11:50:15 -0800 (PST)
In-Reply-To: <CA+55aFwsjpOop=4mVkx4e=zw5LH41sD9x-b_WMo4Hvo7ygjEtQ@mail.gmail.com>
X-Google-Sender-Auth: su3BpnEyqYkq8w5Jlo7NwNz3dts
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209663>

On Tue, Nov 13, 2012 at 11:40 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I have to wonder why you care? As far as I'm concerned, the only valid
> space is space, TAB and CR/LF.
>
> Anything else is *noise*, not space. What's the reason for even caring?

Btw, expanding the whitespace selection may actually be very
counter-productive. It is used primarily for things like removing
extraneous space at the end of lines etc, and for that, the current
selection of SPACE, TAB and LF/CR is the right thing to do.

Adding things like FF etc - that are *technically* whitespace, but
aren't the normal kind of silent whitespace - is potentially going to
change things too much. People might *want* a form-feed in their
messages, for all we know.

So I really object to changing things "just because". There's a reason
we do our own ctype.c: it avoids the crazy crap. It avoids the idiotic
localization issues, and it avoids the ambiguous cases.

So just let it be, unless you have some major real reason to actually
care about a real-world case. And if you do, please explain it. Don't
change things just because.

               Linus
