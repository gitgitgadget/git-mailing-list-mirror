From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v2] git-am: Ignore whitespace before patches
Date: Thu, 12 Aug 2010 20:04:26 +0000
Message-ID: <AANLkTikGaqj1QWtWEy3k=_E8q=bKNKjgJwHCQTUpnZmo@mail.gmail.com>
References: <1273944188-9472-1-git-send-email-avarab@gmail.com>
	<1281556645-23361-1-git-send-email-avarab@gmail.com>
	<AANLkTinDHvwHLZfj6DDPtV39Z2xhDZREiqwdt5cjiaLP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 22:04:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oje10-00006b-Lw
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 22:04:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760461Ab0HLUE3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Aug 2010 16:04:29 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:54446 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760428Ab0HLUE1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Aug 2010 16:04:27 -0400
Received: by gwb20 with SMTP id 20so573340gwb.19
        for <git@vger.kernel.org>; Thu, 12 Aug 2010 13:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=mXvcZBXv4s0NXxRhQQkUgngJoB1603p/tPPLGVRrVrI=;
        b=OAVU+1KThFkFnsPLP1a4uC5FPpNaKAXsTYw+b6xLgynAOuYcBJgzdRzXKVy1wcCMXy
         0r4N7SmMwLuxV/o4RW15zpMm6zDdUM4+LepJqVxXrXNJPPvrc5gD2qfLJdjMvLU8gN5f
         f0f7JkF3TZ1P1AoS5c70F9E1YzSjrLhcIuKpA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=C1OyXEdcvsTl6UIFNycZnv73I7pD7ea2J0fwr5CxjGVsEOVZxkYlX4sO9iuk0020RU
         12tA4474LGbLla3rMvsTsg04QYuGM3gnBxHWDJlYFMbD1Uq7483X/OcjAwLw3xyuqsuY
         Q4fjEFPX2tqlg0GgbYQQAU7fq0SARNMOrkfIo=
Received: by 10.231.187.194 with SMTP id cx2mr346904ibb.165.1281643466640;
 Thu, 12 Aug 2010 13:04:26 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Thu, 12 Aug 2010 13:04:26 -0700 (PDT)
In-Reply-To: <AANLkTinDHvwHLZfj6DDPtV39Z2xhDZREiqwdt5cjiaLP@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153405>

On Thu, Aug 12, 2010 at 19:13, Jay Soffian <jaysoffian@gmail.com> wrote=
:
> On Wed, Aug 11, 2010 at 3:57 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmas=
on
> <avarab@gmail.com> wrote:
>>> Actually cut-and-paste is often a major source of whitespace breaka=
ge
>>> (including tabs silently being expanded), and I personally think a =
patch
>>> like this to encourage the practice is going in a wrong direction.
>>
>> I disagree and think git-am should be smarter. Any human looking at
>> something like a GMail mail.txt download will clearly see that it's =
a
>> patch, but git-am is pedantic and doesn't skip past whitespace at th=
e
>> beginning of the file.
>
> The point of git-am being pedantic is to prevent the original patch
> from being applied w/silent corruption (e.g., tabs-to-spaces).

The git-am code doesn't strike me as particularly pedantic. It'll fail
to spot any number of common pitfalls like patches being pasted inline
(recently discussed on list), double encoding, invalid author names /
E-Mail addresses etc. (which can e.g. happen when applying patches
from RT).

The parsing code just didn't think of this issue, I'm not aware of any
corruption that begins with whitespace being added to the beginning of
a patch, but I am aware of a non-corruption (GMail) that does that.

> Perhaps, before making git-am less strict

I don't think it's less strict with this patch, just more intelligent.

> we should modify format-patch to include a sha1 of the diff output
> so that corruption can be reliably detected by git-am.

There's a lot we could do in this department, and there was a previous
discussion on list about schemas like that (can't find it now).

We could do an ad-hoc checksum, but including more than the SHA would
be better, e.g.:

    --
    cs:<7 char SHA1> t:<NUM TABS> s:<NUM SPACES> c:<NUM CHARS ([^
\t])> ln:<NUM LINES>

That'd allow git-am to print more intelligent error messages than just
"ok/not ok", e.g.:

    * "your patch is $x lines, but the patch thinks it's $y, something
       may have gone wrong with wrapping"

    * "You have 0 tabs, but the patch thinks it has 20"

etc., but that's a project for another day.
