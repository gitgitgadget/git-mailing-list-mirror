From: Greg Brockman <gdb@MIT.EDU>
Subject: Re: [PATCHv3] Updated patch series for providing mechanism to list 
	available repositories
Date: Mon, 26 Jul 2010 17:20:28 -0700
Message-ID: <AANLkTikqA3kNif+7Bi+=xkJ2FgCFAsfCj0N5dft5pnFR@mail.gmail.com>
References: <1279725355-23016-1-git-send-email-gdb@mit.edu>
	<AANLkTin+EMYHrr11Dba9Mob+b_Dar_cedWmTsDF=AHFt@mail.gmail.com>
	<AANLkTilSqePFPkteFd7DBgmdhqJHfUDuW_qhkbWVVb3Y@mail.gmail.com>
	<20100726232855.GA3157@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	j.sixt@viscovery.net, gitster@pobox.com, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 27 02:20:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdXuR-0006UY-4H
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 02:20:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754831Ab0G0AUd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Jul 2010 20:20:33 -0400
Received: from DMZ-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.34]:53978 "EHLO
	dmz-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752729Ab0G0AUc convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 20:20:32 -0400
X-AuditID: 12074422-b7bb6ae0000009fa-c9-4c4e2650a918
Received: from mailhub-auth-3.mit.edu (MAILHUB-AUTH-3.MIT.EDU [18.9.21.43])
	by dmz-mailsec-scanner-5.mit.edu (Symantec Brightmail Gateway) with SMTP id D4.4D.02554.0562E4C4; Mon, 26 Jul 2010 20:20:33 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-3.mit.edu (8.13.8/8.9.2) with ESMTP id o6R0KUxB024637
	for <git@vger.kernel.org>; Mon, 26 Jul 2010 20:20:31 -0400
Received: from mail-iw0-f174.google.com (mail-iw0-f174.google.com [209.85.214.174])
	(authenticated bits=0)
        (User authenticated as gdb@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o6R0KTq7004107
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Mon, 26 Jul 2010 20:20:30 -0400 (EDT)
Received: by iwn7 with SMTP id 7so3190978iwn.19
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 17:20:29 -0700 (PDT)
Received: by 10.231.19.7 with SMTP id y7mr7960605iba.152.1280190029155; Mon, 
	26 Jul 2010 17:20:29 -0700 (PDT)
Received: by 10.231.144.140 with HTTP; Mon, 26 Jul 2010 17:20:28 -0700 (PDT)
In-Reply-To: <20100726232855.GA3157@burratino>
X-Brightmail-Tracker: AAAAAhVGFPIVRtIh
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151906>

>>> Just sending a reminder about this patch series--I haven't seen any
>>> comments on it yet, so I assume it's gotten lost in the flurry of
>>> other list activity.
>>
>> It would probably help if you re-send the entire thing again.
>
> Wait wait, it=92s only been about five days!
>
> I mean, you are free to re-send, but it is probably better to
> send a link to the gmane archive, like this:
>
> =A0http://thread.gmane.org/gmane.comp.version-control.git/151398
>
> so people can catch up with the earlier discussion.
Haha, ok.  Any rules of thumb for how long to wait until resending
everything is appropriate?

> In this case, I am nervous about the impact for existing installation=
s
> with git-shell deployed. =A0If a person can smuggle in an unpleasant
> git-shell-commands directory somehow, the effect would not be good.
> Maybe there should be a way to disable this feature systemwide for th=
e
> paranoid (or maybe not; I=92m only vaguely worried).
You may have a point.  Although, if someone can drop in the
git-shell-commands directory, he or she can probably also edit one of
the git repo's hooks directories.  I'd be curious to hear others'
opinions on the matter.

> Patch 1 still uses execv(), which is not available on Windows.
It seems to me that the existing git-shell calls execv_git_cmd, which
uses execvp internally.  I know ~nothing about exec on Windows, but
presumably it doesn't have just one of execv or execvp.  If it does,
it would be easy enough to switch the execv to execvp, as the commands
that are being run are already guaranteed to have a slash.  Or am I
missing something silly again?

> Have you tried out these patches "in the wild"? =A0If so, that would =
be
> interesting to hear about.
Not yet.  My $project has deployed an earlier prototype of the patches
in our dev environment, but we haven't moved it to prod yet.  We'll
probably do that next week.

Greg
