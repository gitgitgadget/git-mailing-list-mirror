From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: How to check new commit availability without full fetch?
Date: Mon, 11 Jan 2010 09:57:51 +0800
Message-ID: <be6fef0d1001101757w7f54c9b2ye58c66179137efb1@mail.gmail.com>
References: <ee2a733e1001100312j786108fct1b4c8abd0acc5afc@mail.gmail.com>
	 <alpine.LFD.2.00.1001101501520.10143@xanadu.home>
	 <7v8wc5itlc.fsf@alter.siamese.dyndns.org>
	 <alpine.LFD.2.00.1001101556490.10143@xanadu.home>
	 <ee2a733e1001101736p2f395de6ka05044fe7cca624d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: SLONIK.AZ@gmail.com
X-From: git-owner@vger.kernel.org Mon Jan 11 02:57:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NU9XZ-0006zb-0N
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 02:57:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752043Ab0AKB5w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Jan 2010 20:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751566Ab0AKB5w
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jan 2010 20:57:52 -0500
Received: from mail-iw0-f194.google.com ([209.85.223.194]:37128 "EHLO
	mail-iw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755Ab0AKB5v convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Jan 2010 20:57:51 -0500
Received: by iwn32 with SMTP id 32so4330904iwn.33
        for <git@vger.kernel.org>; Sun, 10 Jan 2010 17:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FB0DBWwaaU2hGqdVNL5bIR7t9pwzOItUyvD/1mFWTvE=;
        b=qeYI3ctQ/mC4V4XmW9cVhYCvUcy/S4nNEb4lEZjJU+U0wJYvUE7PJfEJRuUsrHDUjK
         BGIL14M7Mc+gB0+3QuieI2bAOOmP+StEvJKcr8iUALmwZWuWBAJCR/DfuVgZNzdllVhf
         gMLSccb3J1Xep6+/sUofuObEGgqC5e12piXYE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=NDaR0DKcRZpqQNKVFnqBYFyOscG5/Og8GkJyYr6kfm4KsPGUlCxu+JI0FdMbua6Z5l
         zbAfXaLS1r/1M69WJNYQpJZuotWyHWXjKWnKw/e7irJYN//8opeXgdRsojgp8JAfri4T
         ZpRfSd2kSMuXYFqMSDlRE1ROKfdNLoxU5IOU4=
Received: by 10.231.9.33 with SMTP id j33mr1788574ibj.37.1263175071112; Sun, 
	10 Jan 2010 17:57:51 -0800 (PST)
In-Reply-To: <ee2a733e1001101736p2f395de6ka05044fe7cca624d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136594>

Hi,

On Mon, Jan 11, 2010 at 9:36 AM, Leo Razoumov <slonik.az@gmail.com> wro=
te:
> On 2010-01-10, Nicolas Pitre <nico@fluxnic.net> wrote:
>> On Sun, 10 Jan 2010, Junio C Hamano wrote:
>> =A0>
>> =A0> A feel good factor is in play? =A0IOW, "I am short of time, so =
I won't be
>> =A0> able to really afford to 'git pull' and test the result of re-i=
ntegrating
>> =A0> my changes to what happened on the other end. =A0If I can learn=
 that there
>> =A0> is nothing happening over there, then I won't have to do anythi=
ng and know
>> =A0> that I am up to date."
>>
>>
>> Just do a fetch then. =A0If the fetch progress display looks like if=
 it is
>> =A0going to take a while then just interrupt it and go home. =A0If t=
he fetch
>> =A0looks trivial then just merge it. =A0In any case, the "feel good"=
 factor
>> =A0can't be that great by only knowing if the remote has changed or =
not.
>>
>
> Forced interruption is not such a good idea. I would favor a
> non-destructive way to monitor availability of remote commits.

By default, when you add a remote (with git remote add), git sets up
the fetch refspec in your config that looks like

  [remote "foo"]
    url =3D git://foo.com/git/foo.git
    fetch =3D refs/heads/*:refs/remotes/foo/*

That is to say, branches on the remote repo will be fetched into a
"safe" area, refs/remotes/foo/, away from the branches that you
normally work with in refs/heads/.

However, if you have a different config and you're fetching directly
into refs/heads/, then I can see why you would want to "peek" first
with --dry-run before fetching. Are you doing this?

> BTW, pull and push are in a way symmetric operations. Is there any
> deep reason why push supports --dry-run but pull/fetch does not??

It's more accurate to say that push and fetch are symmetric, because
pull is fetch with merge or rebase tacked on.

Even then, push and fetch are not _that_ symmetric...

--=20
Cheers,
Ray Chuan
