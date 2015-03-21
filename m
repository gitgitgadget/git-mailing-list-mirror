From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH/RFC/GSOC] make git-pull a builtin
Date: Sat, 21 Mar 2015 21:23:21 +0800
Message-ID: <CACRoPnQp-3RGAPmoo1aM2KUA-phi138J2o82FwP9annM+xvOXA@mail.gmail.com>
References: <1426600662-32276-1-git-send-email-pyokagan@gmail.com>
	<vpqwq2eyyzl.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Duy Nguyen <pclouds@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat Mar 21 14:23:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZJNG-0003Ng-PC
	for gcvg-git-2@plane.gmane.org; Sat, 21 Mar 2015 14:23:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbbCUNXY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2015 09:23:24 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:34919 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263AbbCUNXX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2015 09:23:23 -0400
Received: by lbcgn8 with SMTP id gn8so92134438lbc.2
        for <git@vger.kernel.org>; Sat, 21 Mar 2015 06:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=6DJA7AUYnVlk/MfSRi/8uC5MCFxQdZCoIlrAGHQWlD8=;
        b=STSx6tqwHgBZTbUfv6P20j9AM4QXye6hVDb4+OgtTNtTr4JfK3mFgdHDrSHCc31g2o
         18DRsDzlGHJTOV9J+wb10YwEZ5KIKtqLfJxCyuXbUu/Y5aXmVPOXPZPd19hmCpCsA1v9
         ErkHHSRT+Z8ShBBMfwndSfBNx0984NydufqHZL8efWVFdl8vVsVpbHvYFHFeDdhk+t8k
         pWxpd9bRC9iDGicduFg0OL4NUppSxZX9BXbT4atXSbNEJIZBO6T2TE0gfSbrLzq0Ky+S
         BzTh2LpbsykHk1CdmXqzGNz4r83BzeeXN1+plRFPWJogJEf8rVkgC46uva2m1n5J4zku
         xD6g==
X-Received: by 10.112.133.35 with SMTP id oz3mr74746963lbb.98.1426944201900;
 Sat, 21 Mar 2015 06:23:21 -0700 (PDT)
Received: by 10.112.130.228 with HTTP; Sat, 21 Mar 2015 06:23:21 -0700 (PDT)
In-Reply-To: <vpqwq2eyyzl.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266021>

Hi,

Thanks for the review, though I would like to work on the proposal now
before the deadline passes :)

On Thu, Mar 19, 2015 at 1:52 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Paul Tan <pyokagan@gmail.com> writes:
>
>> Ideally, I think the solution is to
>> improve the test suite and make it as comprehensive as possible, but
>> writing a comprehensive test suite may be too time consuming.
>
> time-consuming, but also very beneficial since the code would end up
> being better tested. For sure, a rewrite is a good way to break stuff,
> but anything untested can also be broken by mistake rather easily at any
> time.
>
> I'd suggest doing a bit of manual mutation testing: take your C code,
> comment-out a few lines of code, see if the tests still pass, and if
> they do, add a failing test that passes again once you uncomment the
> code.

Maybe code coverage tools could help here so we only need to focus on
the code paths that are untested by the test suite. At the minimum,
all of the non-trivial code paths in both the shell script and the
converted builtin must be covered by tests. This should help to
eliminate most sources of breakages. Anything further than that would
require an experienced understanding of all the possible important
inputs to be tested, which I personally feel would make the project
quite tedious.

I see git already has gcov support. For shell scripts, maybe kcov[1]
could be used. With some slight code changes, I managed to generate a
report for the git-pull tests[2] which should at least provide a good
starting point for how the tests can be improved.

[1] http://simonkagstrom.github.io/kcov/
[2] <http://www.googledrive.com/host/0B4O2AiYulllpfmJlTW4xT050OVVicnNWWS02dm52aTJ2TFIwQ2QwdWh0VHotSkU4eUNNWjg>

Regards,
Paul
