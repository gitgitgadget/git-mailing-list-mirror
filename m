From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: inotify to minimize stat() calls
Date: Sun, 10 Feb 2013 00:26:44 +0530
Message-ID: <CALkWK0=5s0WoA5Y-2wmJRsthtckaMAcRK=JhqhduMty1Pr=Lqw@mail.gmail.com>
References: <CALkWK0=EP0Lv1F_BArub7SpL9rgFhmPtpMOCgwFqfJmVE=oa=A@mail.gmail.com>
 <7vehgqzc2p.fsf@alter.siamese.dyndns.org> <7va9rezaoy.fsf@alter.siamese.dyndns.org>
 <7vsj56w5y9.fsf@alter.siamese.dyndns.org> <9AF8A28B-71FE-4BBC-AD55-1DD3FDE8FFC3@gmail.com>
 <CALkWK0mttn6E+D-22UBbvDCuNEy_jNOtBaKPS-a8mTbO2uAF3g@mail.gmail.com>
 <CALkWK0nQVjKpyef8MDYMs0D9HJGCL8egypT3YWSdU8EYTO7Y+w@mail.gmail.com>
 <CACsJy8CEHzqH1X=v4yau0SyZwrZp1r6hNp=yXD+eZh1q_BS-0g@mail.gmail.com> <CALkWK0=6_n4rf6AWci6J+uhGHpjTUmK7YFdVHuSJedN2zLWtMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Robert Zeh <robert.allan.zeh@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Finn Arne Gangstad <finnag@pvv.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 09 19:57:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4FcA-00065T-5y
	for gcvg-git-2@plane.gmane.org; Sat, 09 Feb 2013 19:57:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760826Ab3BIS5H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2013 13:57:07 -0500
Received: from mail-ia0-f179.google.com ([209.85.210.179]:60529 "EHLO
	mail-ia0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760819Ab3BIS5G (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2013 13:57:06 -0500
Received: by mail-ia0-f179.google.com with SMTP id x24so5282054iak.24
        for <git@vger.kernel.org>; Sat, 09 Feb 2013 10:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=bsJ1c8tRoAxW/mlI/vNdqpN/dL3OpjZLiE+M6R0Sy9E=;
        b=EUwrzyw+BIQueQ3XuLWIUL/d7wHpIAT6iJx2WbIwdLOGSAvtH/8MyLcgSBYrnXg+Nd
         bKHXO7VJbUKpKlxN8Hw6mEYfg3ElWz7WRlx22lZOe8S2aODk0NOSlX6GESD0smaxwytP
         lQWi1rrnOCdpBS1H/BnGV+ocM6arOAqb8Czug1bDHqCs5skvtChim7sYpj27kZ27Bzdl
         c5sU8g/IjIb2a/F1uMi33c90yD20pDjVaFdl8PJFF8uoQuX8RqfZs96hJairfm+ki0Wy
         li2H9+2IMVeS8oiMOWtIxl60BMmAVoBehFfInxJWxPcus56H1soUXmr5WRJczs4Co6+v
         JkNg==
X-Received: by 10.50.108.235 with SMTP id hn11mr5891441igb.107.1360436224657;
 Sat, 09 Feb 2013 10:57:04 -0800 (PST)
Received: by 10.64.86.18 with HTTP; Sat, 9 Feb 2013 10:56:44 -0800 (PST)
In-Reply-To: <CALkWK0=6_n4rf6AWci6J+uhGHpjTUmK7YFdVHuSJedN2zLWtMA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215868>

Ramkumar Ramachandra wrote:
> Okay, now you're asking me to consider a system-wide daemon
> independent of systemd.  It has to run with root privileges so it has
> access to everyone's repositories, which means that people have to
> trust it beyond doubt.  What does it do?  It has a generic API to
> watch filesystem paths and report events over an IP socket.  Do you
> think that this will only be useful to git?  Every other version
> control system (and presumably many other pieces of software) will
> want to use it.  One huge downside I see of making this part of
> systemd is Ubuntu.  They've decided not to use systemd for some
> unfathomable reason.

After some thought, I've decided that extending systemd is not the way
to go.  And the dbus API is really an overkill.  Writing a simple
system-wide daemon shouldn't be a challenge; the hard part is getting
git to use it properly.
