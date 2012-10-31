From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] test-lib: avoid full path to store test results
Date: Wed, 31 Oct 2012 02:59:55 +0100
Message-ID: <CAMP44s1xAeW2QZsNwRVRx+DEhYVVdiKbw-y-aNuo6unuv7pYZQ@mail.gmail.com>
References: <1351570377-894-1-git-send-email-felipe.contreras@gmail.com>
	<20121030044609.GA10873@elie.Belkin>
	<CAMP44s3ap19TDsSo_fmNqJp+ROWo2Ka8bc35YQmR3mMw375WsQ@mail.gmail.com>
	<20121031012730.GY15167@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 03:00:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTNbH-0004b7-1d
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 03:00:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756508Ab2JaB75 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 21:59:57 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:64498 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753716Ab2JaB74 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 21:59:56 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so960033obb.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 18:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=0A0666sa+srK5P0MtfTAqo6XuyTBPlgQvnHfnlpAnNU=;
        b=OOOtppoNQvRvSqNW5ahoyGPAoHfotJcMC+rpK5irY1zscna+QFXRvqrv3EUxrBzMYf
         5sWNCqkI8fE3/XWbBjLVHOtAc1bmOYYHNvoTM6ds4jhLkKJTkR2346nKqhsafmCH94St
         hsPPtczI7TC1XGduHfPqVUcG08sKMWxFCHC5Z+00antUSGkbBrWr3uFDk4jMMZz3Cmll
         vjlzIv1S/nkm5efGVmQa0gbGgudYz5YHNN1DOZDNQ1BGov/yrZuovHTIG9ZN6EQKfVD8
         L6u/gIGgQVjWt8lfP46bZ+4/D2VAnkJcf3YeicifZsFPLN0Y1dCOM6Y3HF7j2PQ0YP3f
         jtxQ==
Received: by 10.182.10.6 with SMTP id e6mr29091772obb.16.1351648795959; Tue,
 30 Oct 2012 18:59:55 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Tue, 30 Oct 2012 18:59:55 -0700 (PDT)
In-Reply-To: <20121031012730.GY15167@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208783>

On Wed, Oct 31, 2012 at 2:27 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Felipe Contreras wrote:
>> On Tue, Oct 30, 2012 at 5:46 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> > Felipe Contreras wrote:
>
>>>> No reason to use the full path in case this is used externally.
>>>>
>>>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>>>
>>> "No reason not to" is not a reason to do anything.  What symptoms does
>>> this prevent?  Could you describe the benefit of this patch in a
>>> paragraph starting "Now you can ..."?
>>
>> ./test-lib.sh: line 394:
>> /home/felipec/dev/git/t/test-results//home/felipec/dev/git/contrib/remote-hg/test-21865.counts:
>> No such file or directory
>
> Ok, so a description for this patch is
>
>         test: use test's basename to name results file

Is this solving an actual problem or is it just something nice to do?
Like in all good novels, one has to read more find out...

>         Running a test using its full path produces an error:

I'm not sure what that even means. Do you mean this produces an error?

% make -C t $PWD/t9902-completion.sh

Well, sure it does, but this patch doesn't fix that.

If you want a precise explanation of what kind of usages are enabled
by this patch, that would require some work, and no I haven't done it,
and no, I'm not sure.

>                 $ ~/dev/git/contrib/remote-hg/test-21865.sh
>         [...]
>                 ./test-lib.sh: line 394: /home/felipec/dev/t/\
>                 test-results//home/felipec/dev/git/contrib/remote-hg/\
>                 test-21865.counts: No such file or directory

Except that I didn't do this. So the fact that this happens is an
assumption, and I'm not willing to make that.

Most likely if somebody does that they are doing something wrong; they
didn't define the TESTDIR variable (or something like that).

It's all fun and games to write explanations for things, but it's not
that easy when you want those explanations to be actually true, and
corrent--you have to spend time to make sure of that.

>         In --tee and --valgrind modes we already use the basename
>         to name the .out and .exit files; this patch teaches the test-lib
>         to name the .counts file the same way.

I don't see the point of listing each and every place where this
already happens. As a matter of fact, the base-name is used in other
places as well, and just saying "This is already done in other
places", is more than enough. But who says they are not the ones doing
it wrong? Maybe this part of the code is right, and it's the others
that need fixing. I don't see how saying "Others are doing it" makes
the patch better or worse in any way. There might also be different
reasons for why they do it that doesn't apply here.

> That is still not enough to tell if it is a good change, though.
> Should the test results for contrib/remote-hg/test-* be included with
> the results for t/t*.sh when I run "make aggregate-results"?
>
> Before 60d02ccc, git-svn had its own testsuite under contrib/, with
> glue in contrib/git-svn/t/lib-git-svn.sh to use test-lib --- maybe
> that code could provide some inspiration for questions like these.

Or maybe they are the ones that should look for inspiration in
contrib/remote-hg.

The patch is obviously correct; it's generally good not to name files
with slashes in them, and $0 is not guaranteed not to have slashes.
Even if you run all the tests inside the 't' directory, this script is
not only used by git, and others might want sub-directories, and not
thousands of tests on the same directory like git.

Either way, if obvious fixes that are one-liners require an essay for
you, I give up.

Cheers.

-- 
Felipe Contreras
