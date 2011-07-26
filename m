From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: feature request: git add--interactive --patch on regex-matched
 hunks only
Date: Tue, 26 Jul 2011 10:03:31 +0700
Message-ID: <CACsJy8Db_sYFsQ2GcbcumJJYrXZDkKmuuULSM0_Z=HWvbYh8Bg@mail.gmail.com>
References: <CACsJy8B1B25DZ1yrzHq69vwgzQyM2ouTXCHb8oPRpb_cAX+JZQ@mail.gmail.com>
 <20110725215553.GA23145@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 26 05:04:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlXwI-0005VJ-FY
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 05:04:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751968Ab1GZDEF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Jul 2011 23:04:05 -0400
Received: from mail-ey0-f171.google.com ([209.85.215.171]:55073 "EHLO
	mail-ey0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376Ab1GZDED convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jul 2011 23:04:03 -0400
Received: by eye22 with SMTP id 22so22706eye.2
        for <git@vger.kernel.org>; Mon, 25 Jul 2011 20:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=9zyilzz2lUvA0A3HKQmqkgSZhL/VqYbr9tmjXngEmIs=;
        b=fqXOm6Xc/kYQ7pnGoE00WQSlwhuSx/XcrDMc4ChlNJfl//NvxjsbKgsU/T7oDVwUG1
         7nDmgz5QJFYR/P8iutDrTDPhPhvYrN9j9UZDHtWnQPcV3NF07mJMGNI+EQYYvlQcXNt3
         ulrqC/03OPS1H+oYDWd/+6+xqv4q7l5d3eQGY=
Received: by 10.204.35.207 with SMTP id q15mr1615276bkd.244.1311649441262;
 Mon, 25 Jul 2011 20:04:01 -0700 (PDT)
Received: by 10.204.121.142 with HTTP; Mon, 25 Jul 2011 20:03:31 -0700 (PDT)
In-Reply-To: <20110725215553.GA23145@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177837>

On Tue, Jul 26, 2011 at 4:55 AM, Jeff King <peff@peff.net> wrote:
> On Sun, Jul 24, 2011 at 12:11:29PM +0700, Nguyen Thai Ngoc Duy wrote:
>
>> Can we have "git add--interactive --patch --match=3Dregex" where onl=
y
>> (splitted if possible) hunks that match regex are shown?
>
> The patch below does this,

Thanks!

> but there are a lot of unanswered questions.
> Such as:
>
> =C2=A01. What does it mean to be "shown"? My patch auto-marks non-mat=
ching
> =C2=A0 =C2=A0 hunks as "do not stage". That means you can still switc=
h back to
> =C2=A0 =C2=A0 them in the hunk list and enable them if you want. Anot=
her option
> =C2=A0 =C2=A0 would be to omit them entirely, and pretend that those =
hunks don't
> =C2=A0 =C2=A0 exist.

Either way is ok. Maybe the option in this case could be changed to
--nostage=3Dregex to reflect the behavior.

> =C2=A02. What should we do with non-text changes, like mode changes a=
re
> =C2=A0 =C2=A0 full-file deletion?

Probably invalid use case for --match.

> =C2=A03. What should be shown for a file with no matching hunks? Prob=
ably
> =C2=A0 =C2=A0 nothing (i.e., as if it had been limited away by pathna=
me)? My
> =C2=A0 =C2=A0 patch shows the header, but that is easy to fix.

Printing "Nothing to add" would be nice.

> However, I'm not sure I would trust my regex to actually get all of t=
he
> changes needed for the refactoring (e.g., there might be nearby hunks
> related to the refactoring that are not specifically in the same hunk=
 as
> the word "foo"). So I tend to just "git add -p" and flip through the
> changes manually.

Well, I do "git diff --cached" and "git diff"  (the search in the
diff) before committing just to make sure I don't miss any changes.

> You can already skip around in the hunk list using "/regex". Might th=
at
> be enough for you? I think you're stuck typing "/yoursearch" over and
> over, though. It would be nice if doing just "/" would search again f=
or
> the previous regex.

Yes I'm stuck typing /mysearch. Yes, "/" alone would be nice, but in
this case I really want mass ignore certain changes so I can focus on
important strings first.
--=20
Duy
