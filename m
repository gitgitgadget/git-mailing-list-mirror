From: David Aguilar <davvid@gmail.com>
Subject: Re: Status of conflicted files resolved with rerere
Date: Sat, 14 Aug 2010 19:24:43 -0700
Message-ID: <D06701C5-E581-46AA-BC7D-3DA7C4127D44@gmail.com>
References: <20100812212828.GA17825@jpl.local> <AANLkTi=tVV5gL2b2LfXALXahzabJXzVjB5z9-OSztOMJ@mail.gmail.com>
Mime-Version: 1.0 (iPhone Mail 7D11)
Content-Type: text/plain; charset=utf-8;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Magnus_B=C3=A4ck?= <magnus.back@sonyericsson.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 15 04:25:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkSug-0004eL-Le
	for gcvg-git-2@lo.gmane.org; Sun, 15 Aug 2010 04:25:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757076Ab0HOCY4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Aug 2010 22:24:56 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:53931 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756451Ab0HOCY4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Aug 2010 22:24:56 -0400
Received: by pzk26 with SMTP id 26so1365322pzk.19
        for <git@vger.kernel.org>; Sat, 14 Aug 2010 19:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:x-mailer
         :mime-version:subject:date:cc;
        bh=Nu02PM26KdZvjo5j4l/R/QEEOStJlAggr6xLJ/i+32w=;
        b=nBgOYGSOwgBqvsqWvDLRNnJcUzweos39FnzFy5Gt54ORD4z9VlzWap0mEDvEE2GbBF
         bcyYngwS9+qeDkkwu893lFM8LCLVPouUjKMl6uMINuQE4hHkekYFBHJk6k2AxUZSNl22
         D4gScaCm2wMT69vU8P9vy2AoLegUdoTE5v2Mc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=references:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:x-mailer:mime-version:subject:date:cc;
        b=oLghvJALpWI5ZufAEnZ4Wy9ukrZ2/p5trPMfy9Va8yEEKOvtH4N45M3nG3uASanXHu
         jrajy/bg3IrVl0N9YFWbB6OHTqTsvr/Pzkj0RCdy8xJGy90Ln1KFxUXcrV73CEDLQOBY
         yN8JtRtN6cPprdgLReiJaFhAVVR3Rd2fOTmTo=
Received: by 10.142.211.6 with SMTP id j6mr2996254wfg.126.1281839095695;
        Sat, 14 Aug 2010 19:24:55 -0700 (PDT)
Received: from [10.45.134.126] ([166.205.139.123])
        by mx.google.com with ESMTPS id g5sm5762179wfd.19.2010.08.14.19.24.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 14 Aug 2010 19:24:54 -0700 (PDT)
In-Reply-To: <AANLkTi=tVV5gL2b2LfXALXahzabJXzVjB5z9-OSztOMJ@mail.gmail.com>
X-Mailer: iPhone Mail (7D11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153592>


On Aug 12, 2010, at 2:36 PM, Avery Pennarun <apenwarr@gmail.com> wrote:

> On Thu, Aug 12, 2010 at 5:28 PM, Magnus B=C3=A4ck
> <magnus.back@sonyericsson.com> wrote:
>> I played around with git rerere today and was surprised by the =20
>> results.
>> When a conflict has been resolved automatically by rerere, the file
>> isn't added to the index like other files are where Git just used =20
>> one of
>> the regular merge resolution algorithms. What's worse, if git =20
>> mergetool
>> is invoked -- which is what I normally do when git merge needs help =
=20
>> --
>> it has no idea that the file actually has been merged already, and
>> launches the merge tool with the three files involved in the merge. =
=20
>> If
>> the user hasn't been paying attention to each line of the git merge
>> output (stating the files who were automatically resolved) it's =20
>> easy to
>> trash rerere's work.
> [...]
> It sounds like the real problem here though it the mergetool stuff.
> Why is it disregarding all the automated merging that git has done an=
d
> starting over from scratch?  If git, in its infinite cleverness, has
> resolved *some* parts of the file but not others, wouldn't we want it
> to keep those resolutions?  It sounds like mergetool is actually
> making things *more* work instead of less.
>
> Is there some way to teach the mergetool stuff to be smarter?  At the
> very least, having it auto-skip files that have no *remaining*
> conflicts might be a good idea.
>
> Have fun,
>
> Avery

Right, that would be a great enhancement.

The problem is that mergetool always uses local, remote, and base.  It =
=20
uses the unmerged flag in the index when deciding which files to =20
consider.

Here's what we'd need in order to improve rerere and mergetool =20
interaction:  the ability to answer the question, "has this file been =20
rerere merged?"

Once we have that then we can make mergetool skip these files by =20
default. We would also need a command line flag to override the =20
behaviour.

Perhaps a naive grep for merge markers in the worktree file would =20
suffice?  Heuristics have gone a long way in git so doing something =20
like that wouldn't seem too atrocious.

It'd also have the benefit that mergetool would skip files merged by =20
$EDITOR.

If anyone has any tips I'm all ears.  Does this seem reasonable, and =20
if so, what would be a good name for the command line flag to get the =20
existing behavior?  My gut feeling is that it shouldn't have a =20
corresponding config variable.

Cheers,
--=20
         David