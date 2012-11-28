From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Python extension commands in git - request for policy change
Date: Wed, 28 Nov 2012 03:06:09 +0100
Message-ID: <CAMP44s1jzUWm8BKxJR29RNWTWnxReExTeDTAKhk3mF3WJYNE0w@mail.gmail.com>
References: <20121125024451.1ADD14065F@snark.thyrsus.com>
	<CAMP44s18MzmWRNRiRjL6hvpK1cm=S-97fB2ep-_0RAhnfs5cvA@mail.gmail.com>
	<50B1F684.5020805@alum.mit.edu>
	<CAMP44s0WYiV3hTE7u28_Wd59FkGfu3o_psS0gocpnibzN4--Fg@mail.gmail.com>
	<20121127143510.GA15831@google.com>
	<CAMP44s10krOPD73dL0Ancie=kussk89jK7V5adR3hw=a73CVWw@mail.gmail.com>
	<20121128005128.GB23224@sigill.intra.peff.net>
	<CAMP44s0FiNRbFHbTtZJiWLDRQmy0VZ_FNGxE40eZrXwCFJ5P7A@mail.gmail.com>
	<20121128013943.GA23776@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?B?TWFnbnVzIELDpGNr?= <baeck@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	"Eric S. Raymond" <esr@thyrsus.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 28 03:06:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdX2l-0000uf-88
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 03:06:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308Ab2K1CGL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 21:06:11 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:47705 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961Ab2K1CGK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 21:06:10 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so13090314oag.19
        for <git@vger.kernel.org>; Tue, 27 Nov 2012 18:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=fvDKlkcLnHqv3HXvzDAjQEi5xMWvFDvCzv608XGcUvU=;
        b=VaLFjtKCBYjkK+volMvBpAiaXkNwWimhltpl9M8nikJzmoolSVkMMV9Z/kyqOA2yQI
         e+8KCZN/LtXyJC9qhWIEt1ZddmNGev66RfQLG+tvrXx73bpEfCFU2dyGnkkp1rlBhXd5
         Us7llVzZgZjrjVt/BN2DcPkoTqA3Pb42GozX7MG3PkdvGTzcXeHJ1AycKQr6Aqrut8Gj
         UWQ2mLk1ZStsq8qYn0rKkooTby1eW3LUBn1K2IW+Mjt/PgC497nWcanWUgMBzbi2hdwb
         SRKBABKEb2Ap+a7H8rrsPUkTtiUE/kW92yROq0qEVEQBjFcnsKqFAx2GGD8U+09itbyq
         udrg==
Received: by 10.182.17.72 with SMTP id m8mr1541267obd.55.1354068369527; Tue,
 27 Nov 2012 18:06:09 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Tue, 27 Nov 2012 18:06:09 -0800 (PST)
In-Reply-To: <20121128013943.GA23776@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210668>

On Wed, Nov 28, 2012 at 2:39 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Nov 28, 2012 at 02:22:09AM +0100, Felipe Contreras wrote:
>
>> Sure, you will argue that we don't see the *real* issues, because they
>> were fixed preemptively, but the fact of the matter is that we will
>> never know. All we know is the reality we can observe, and the reality
>> is that we hit very few *real* issues outside the test system (feel
>> free to provide evidence to the contrary).
>
> I think reports of breakage in the test scripts are relevant, because
> they are indicative that people _do_ run platforms that care about these
> issues, and if we were to write a lot of shell scripts, we would run
> across them more frequently. But the fact of the matter is that we don't
> write a lot of non-test shell scripts these days, which is part of the
> reason limiting your search to the last 2 years did not turn up many
> fixes outside the tests.

If we were to write a lot of shell scripts, and we were to apply the
same standards as we do with the tests, which most likely wouldn't be
the case; end-user scripts are way more important, specially
porcelain.

> There was a big push in 2006 and 2007 to port some of the hairier
> scripts to C. Try:
>
>   git log --no-renames --diff-filter=D \
>           --diff-filter=D --format='%ad %s' --date=short \
>           -- 'git-*.sh'
>
> A lot of it was motivated by portability and decent performance for
> common commands under Windows.

Good stuff indeed. I look forward to the day all main git porcelain
commands are written in C (git-rebase I'm looking at you), there are
not many left:

git-am
git-bisect
git-citool
git-gui
git-pull
git-rebase
git-stash
git-submodule

> Anyway, there is not much point in debating the exact level of pain that
> shell portability causes us. Even if you accept that there is some, it
> is clearly not a major problem for the project.

Indeed.

-- 
Felipe Contreras
