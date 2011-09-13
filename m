From: John Szakmeister <john@szakmeister.net>
Subject: Re: [RFC/PATCH] t9159-*.sh: Don't use the svn '@<rev>' syntax
Date: Tue, 13 Sep 2011 05:15:00 -0400
Message-ID: <CAEBDL5W3pEz6Bcdt3B1PPvbF_HrvgXTLbaNUCeR=+M5bUgRJSw@mail.gmail.com>
References: <4E21D295.7020600@ramsay1.demon.co.uk>
	<7vvcuy82kn.fsf@alter.siamese.dyndns.org>
	<4E269AB6.8070207@drmicha.warpmail.net>
	<4E27098B.906@vilain.net>
	<4E6BA0FA.9070103@ramsay1.demon.co.uk>
	<20110913075726.GA15066@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Sam Vilain <sam@vilain.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>, mhagger@alum.mit.edu
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Sep 13 11:15:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3P5K-0003Cw-EZ
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 11:15:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167Ab1IMJPE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Sep 2011 05:15:04 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:52760 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751121Ab1IMJPC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Sep 2011 05:15:02 -0400
Received: by qyk30 with SMTP id 30so2395357qyk.19
        for <git@vger.kernel.org>; Tue, 13 Sep 2011 02:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zInbSYgjyPquKH5a9w9cSIeIW1PEPX7VqJL3Uwu36mA=;
        b=EKRAxUm4JejSI9Jlq16a9MPQ1MImOImmU26epnsWBtw2koYxyGuD6xIui7WXB6zTEE
         14vFwVOYK2xob/paU59Wi0UjcVVSjw0J+gMyZ9xTGHhZicBKhx/Xk4T+KTdcEPeKJO5E
         IsMm62Q9sk1OucN4BCtcJFFKSe5mV1BDKrK4w=
Received: by 10.52.112.163 with SMTP id ir3mr1183281vdb.124.1315905301796;
 Tue, 13 Sep 2011 02:15:01 -0700 (PDT)
Received: by 10.52.160.196 with HTTP; Tue, 13 Sep 2011 02:15:00 -0700 (PDT)
In-Reply-To: <20110913075726.GA15066@dcvr.yhbt.net>
X-Google-Sender-Auth: G2Zdnm3hPLzSpmjMsmkG-1_-Yl0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181277>

On Tue, Sep 13, 2011 at 3:57 AM, Eric Wong <normalperson@yhbt.net> wrot=
e:
> Ramsay Jones <ramsay@ramsay1.demon.co.uk> wrote:
>> Hmm, I was hoping that someone would say something like:
>>
>> =C2=A0 =C2=A0"This test does not depend on the difference between th=
e peg revision
>> and the operative revision, because the history represented in the t=
est
>> repo is so simple that there *is* no difference, so Acked By: ... "
>
> Unfortunately, I remain perpetually confused w.r.t peg revisions vs "=
-r"
> and how it's handled differently between different SVN versions.

I haven't followed this conversation, but I can explain what peg
revisions are.  It used to be the only way to talk about a version of
a file or path was to use '-r REVNUM'.  IIRC, what would happen is
that the url you provided would refer to the now current name of the
file, and Subversion would walk back in history to look up the
specified version of the file.  However, that becomes a problem when
the file no longer exists, or has been renamed.  It's compounded if
there is a new file with the same name in HEAD, because it would look
up the wrong history.  So peg revisions were introduced to say "start
looking here @PEGREV and search forward or backwards for the version
in REVNUM."  So the difference is that old clients always looked at
HEAD to start the search, whereas new clients will use PEGREV if
specified, and HEAD otherwise.

There is a pretty thorough discussion of it in the SVN book:
    <http://svnbook.red-bean.com/en/1.6/svn.advanced.pegrevs.html>

Hope that helps!

-John
