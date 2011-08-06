From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH 00/40] test whitespace - perform trivial whitespace clean
 ups of test scripts.
Date: Sat, 6 Aug 2011 19:36:50 +1000
Message-ID: <CAH3AnrpOyFojqDWSxES3NNkn5zY=JOLM4oga3Mk6f5sQ8j-bVg@mail.gmail.com>
References: <1312620119-18369-1-git-send-email-jon.seymour@gmail.com>
	<20110806092029.GA7645@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Aug 06 11:37:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpdJZ-0000CC-IM
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 11:37:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755365Ab1HFJgy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Aug 2011 05:36:54 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:35798 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754026Ab1HFJgv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Aug 2011 05:36:51 -0400
Received: by vxi9 with SMTP id 9so1494405vxi.19
        for <git@vger.kernel.org>; Sat, 06 Aug 2011 02:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=NNRGZ/2jvw6XHj5WP9Ac6fa/X/isLCMR7fZk9nN9EIc=;
        b=OxtmFbc8kIH0r7FPmI45EvG5IqrlTTLaTjL7O2b6qxVGcFqw/Z7RDKnMRtkPxO2d51
         PgKx3bd8ACiNmtHD4n59YmdFtrRaxD2J6sRZzI8kWdj1F+eIn/LTSHX1qmVM1hB4tPl3
         Um1du5qVSZhNeWQruWDpE6mbHqmSNhehQURWg=
Received: by 10.52.67.235 with SMTP id q11mr2718518vdt.332.1312623410660; Sat,
 06 Aug 2011 02:36:50 -0700 (PDT)
Received: by 10.52.183.134 with HTTP; Sat, 6 Aug 2011 02:36:50 -0700 (PDT)
In-Reply-To: <20110806092029.GA7645@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178877>

On Sat, Aug 6, 2011 at 7:20 PM, Jeff King <peff@peff.net> wrote:
> On Sat, Aug 06, 2011 at 06:41:59PM +1000, Jon Seymour wrote:
>
>> The series applies cleanly to both master and pu.
>>
>> The first patch contains a script, t/test-cleaner.sh, that can
>> automate whitespace cleanup of tests.
>
> Hmm. Can't we do something similar using git itself, and clean up all
> sorts of whitespace errors?
>

Right. That's probably a better way to implement the test and cleanup,
since it ensures the desired heuristic is used.

I will revise accordingly.

I guess the additional advantage of test-cleaner.sh is that it
automates the testing and creation of patches, at least for tests.

As mentioned in another note, it would probably be useful to
generalize this to files other than tests but one would have to use a
more complicated discovery procedure in that case (in order to make it
efficient - one doesn't want to have to run the full test suite to
test every single edit).

> I tried:
>
> =C2=A0rm t/t1006-cat-file.sh
> =C2=A0git diff -R | git apply --whitespace=3Dfix
>
> and ended up with the same blob as your script.
>
> In theory you could do the whole tree:
>
> =C2=A0git ls-files -z | xargs -0 rm
> =C2=A0git diff -R --binary | git apply --whitespace=3Dfix
>
> though it reports 604 whitespace errors, but only 489 lines fixed. An=
d
> t1006 is not among the modified files. So I wonder if this is a bug i=
n
> git-apply, or am I missing something.
>

Not sure - I'll dig into it.

jon.
