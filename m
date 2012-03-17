From: Tim Henigan <tim.henigan@gmail.com>
Subject: Re: [PATCH 0/9] difftool: teach command to perform directory diffs
Date: Fri, 16 Mar 2012 22:26:11 -0400
Message-ID: <CAFouetgqsLv9HUYiUXe8aw+NQ-i=k+OGosPRNKSrqePf5wUnQA@mail.gmail.com>
References: <1331949442-15039-1-git-send-email-tim.henigan@gmail.com>
	<7vlin0dlrm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: davvid@gmail.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 17 03:26:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8jLw-0002FH-4b
	for gcvg-git-2@plane.gmane.org; Sat, 17 Mar 2012 03:26:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752068Ab2CQC0N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Mar 2012 22:26:13 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61433 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751514Ab2CQC0M convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Mar 2012 22:26:12 -0400
Received: by iagz16 with SMTP id z16so6261495iag.19
        for <git@vger.kernel.org>; Fri, 16 Mar 2012 19:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Nr36Nr6+QtVYRbecD9O3PiTManQJ39mAVY2BQr1O0Ro=;
        b=Jtu/5KRWi4wDFEs9ZGDS/epQttfOO/FIJDRBJ9hi5+HagLUPLaJdmRkqO3KVXK8sEv
         HNiAtTPyMgt+4yVr9XQaLsDd+96lY6w03s+P6VGNY4Xum36P8ipo8num4VWQHvoGn+Ic
         c8RkOXyqSj8p19CRTIVOpwVTk0kWYCea6iCpFo1jpoqcE/iNsc6P1F33ZhvBWnPmJEPo
         JrhQDn7f+qe5yhql+EF8UzigftOMG+gtjOnOedEo34ZZvjLceJ7FhJlTWzcQeH/wj7pM
         JSADovCWLi1Wg4/bELpnU/ITBklGjpgrBCu2wUKYkx6S/eDeZR2R8j+LAOKWorfYO9FA
         t+Yg==
Received: by 10.50.212.101 with SMTP id nj5mr997277igc.41.1331951171584; Fri,
 16 Mar 2012 19:26:11 -0700 (PDT)
Received: by 10.42.218.65 with HTTP; Fri, 16 Mar 2012 19:26:11 -0700 (PDT)
In-Reply-To: <7vlin0dlrm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193300>

On Fri, Mar 16, 2012 at 10:06 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Tim Henigan <tim.henigan@gmail.com> writes:
>
>> This is the second phase of development for this feature. The first =
phase
>> was added as a separate command (git diffall) in 1252bbe (contrib: a=
dd
>> git-diffall script).
>
> Ummm. =C2=A0I do not think the first step is not even done yet; fixin=
g the
> whitespace-in-pathspec and whitespace-or-lf-in-paths issues now the s=
cript
> is in contrib/, while having people play with it.

I began fixing those issues in 'git-diffall' by rewriting the loop
that populates the tmp dirs in Perl.  By the time I changed the loop
to use 'git diff --raw -z' and handle working copy changes and
submodules, it seemed I was very near to finishing the things I wanted
to accomplish in "phase 2".  Finishing the work by updating 'difftool'
seemed to actually be easier than trying to update 'diffall'.

I realize the feature hasn't had any time to cook in
contrib/...perhaps I am over-enthusiastic.  However, the 'diffall'
concept has been in steady use by a small audience for nearly two
years (by people who downloaded/forked the GitHub project).  This past
week I was lucky enough to have some time to study the problem and
propose a solution.  If it needs to wait while 'diffall' cooks in
contrib, I will try to be more patient ;)

The changes in patches 1-6 may be useful regardless.  They cut the
length of the script in half without changing how it behaves.  The
only functional change in those patches is that `git difftool -h` now
finishes with exit(0) instead of exit(1).  I understand that may not
be enough reason to accept such a large change in working code...but
like I said, I was lucky enough to have time to study the problem in
detail this week.
