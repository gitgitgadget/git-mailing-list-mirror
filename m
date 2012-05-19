From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Add comment lines to patch format
Date: Sat, 19 May 2012 11:54:51 +0700
Message-ID: <CACsJy8C-+VwpR4XEBqxhpwhtfZ=cxo6uKSp6Ov7K6aLGxqR=Sw@mail.gmail.com>
References: <20120518132228.GA27970@do> <20120519001410.GC765@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 19 06:55:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVbhR-00005J-I4
	for gcvg-git-2@plane.gmane.org; Sat, 19 May 2012 06:55:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752082Ab2ESEzX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 May 2012 00:55:23 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:34486 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751815Ab2ESEzW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 May 2012 00:55:22 -0400
Received: by wgbdr13 with SMTP id dr13so3333561wgb.1
        for <git@vger.kernel.org>; Fri, 18 May 2012 21:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=yrb4yOy7VZbBgP5mcaGccH4tD31bItV1hIAXAF3JsIw=;
        b=m7C/lRJ31vMf149rOKDqe1zZivu6ZULLpT9P2Y+ijaOj3A0AAWyuViCRFsPqZkLwSp
         wNWC2+t5fQ19dR0cWSiRmeNw5aT3L1kULZSgwCU72fxTS0Hu3PoTiK1Eqo3pmtfxOc6J
         i1caaDgHghjkenUz1B2XKBefdGhB2l5rbKn2xmzLRTKJJnYgoziPBKXvsPU95d6uUN9N
         FLZBnoLa3TNWCSXFaAa0tqpilAl9BLEDqQj0QlASg5MyOxTjbZ9pL4YN5/EHxfKw67/H
         /Of0VvqXjuP8wkZAe+2A054y7Pe2xiYuVX7EwpeQvILJFcSQ2wIGqNb8jm2glBjPa7CQ
         KVhw==
Received: by 10.180.99.70 with SMTP id eo6mr7406250wib.17.1337403321220; Fri,
 18 May 2012 21:55:21 -0700 (PDT)
Received: by 10.223.64.208 with HTTP; Fri, 18 May 2012 21:54:51 -0700 (PDT)
In-Reply-To: <20120519001410.GC765@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198013>

On Sat, May 19, 2012 at 7:14 AM, Jeff King <peff@peff.net> wrote:
> On Fri, May 18, 2012 at 08:22:28PM +0700, Nguyen Thai Ngoc Duy wrote:
>
>> One thing is trailing space, like demonstrated in the patch below,
>> because trailing spaces may be intentional sometimes. But I'd like t=
o
>> incorporate some word-diff goodness in patch format using this comme=
nt
>> line to spot few/single character addition/removal.
>> [...]
>> If anyone knows a tool with similar feature, I'd greatly appreciate =
it
>> (as the Internet taught me, everything I think of is already thought
>> of/implemented by someone)
>
> Have you looked at contrib/diff-highlight?

I didn't. Its output looks too packed though.

> I think your approach is interesting because it can annotate much mor=
e
> than just "this part is interesting". Sometimes when I send a patch, =
I'd
> like to be able to comment in-line, like:
>
> =C2=A0+ =C2=A0 =C2=A0 =C2=A0 if (bar > 3)
> =C2=A0+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 foo(bar);
> =C2=A0=3D Yeah, this magic "3" is ugly, and we should handle it
> =C2=A0=3D through $whatever in the re-roll.
> =C2=A0+ =C2=A0 =C2=A0 =C2=A0 else
> =C2=A0+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 something_el=
se();
>
> I usually just write something in the cover letter, or reply to mysel=
f
> with comments inline. I don't know how much I would use it in practic=
e,
> but it might be a neat thing for "git apply" to simply ignore comment
> lines in the middle of a hunk.

Yeah. That's a good thing about in-patch comments.

One thing that's still bugging me is that we don't have a way to send
machine-readable conflict resolutions in text form. But that's
probably something else.

> Of course, this feature might not be worth breaking compatibility wit=
h
> every existing version of "git apply" and "patch" out there.

It's opt-in. And it's quite easy to convert back. A simple "sed -i
'/^=3D/d'" would do.
--=20
Duy
