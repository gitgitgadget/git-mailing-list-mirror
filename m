From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Sat, 7 Sep 2013 23:37:13 -0500
Message-ID: <CAMP44s01LL2JCKzqa0Qc5MfBz9zfMXR4H8jZdauLOi-D0JVHpw@mail.gmail.com>
References: <1377988690-23460-1-git-send-email-felipe.contreras@gmail.com>
	<xmqqd2opu8hr.fsf@gitster.dls.corp.google.com>
	<CAMP44s2NzzS48BBpD_oQ24t2SYETte7_U4+O+32SOo5qhooQew@mail.gmail.com>
	<xmqqfvtlpm2l.fsf@gitster.dls.corp.google.com>
	<20130904081047.GB2582@serenity.lan>
	<20130904092527.GB22348@sigill.intra.peff.net>
	<CAMP44s3Vaqe-POwQb30AGdarf=ObdPUay3QEMqxHV3NKiPAouA@mail.gmail.com>
	<20130908041805.GB14019@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Andreas Krey <a.krey@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 08 06:37:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIWkU-00053l-58
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 06:37:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364Ab3IHEhR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 00:37:17 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:52724 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969Ab3IHEhQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 00:37:16 -0400
Received: by mail-la0-f51.google.com with SMTP id es20so4006624lab.10
        for <git@vger.kernel.org>; Sat, 07 Sep 2013 21:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=7cydvV/PT4dCzRdmsO3pChj7+2TFE74xCHzwND04MDk=;
        b=LKDahqGWTkacLI+JkbXK2tHzPYm63jdXbxPVa7O08YZN1olLZy6VI/du6vM0hZwHUk
         eHS7hnVUrh2CqV7vfCSmq0H59UrSzxJeRtEsDfifY5rlIhCsFWj+/OFRZES6LUweIrCH
         xBY1UExaDh0GZ7GINy6lZVfFj4T1V5O4HMNIC87mxcwlWUCNyVOBuk7sO+uoAzGJZlPt
         PSRLEPmwsMuLGINvafZ3/QJRn3alhhlacw9rGEhGqRcXgBW8TJxWTJLv5zPn4km9x2O4
         zeibQBIqLcypJk23lDmwj38ki5QhiiVdf69P1YQTqNz2VhDbPR4c4PCQZWaIof1Ijtu2
         Ynmg==
X-Received: by 10.152.2.4 with SMTP id 4mr10025541laq.0.1378615033173; Sat, 07
 Sep 2013 21:37:13 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Sat, 7 Sep 2013 21:37:13 -0700 (PDT)
In-Reply-To: <20130908041805.GB14019@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234176>

On Sat, Sep 7, 2013 at 11:18 PM, Jeff King <peff@peff.net> wrote:
> On Sat, Sep 07, 2013 at 09:52:16PM -0500, Felipe Contreras wrote:
>
>> On Wed, Sep 4, 2013 at 4:25 AM, Jeff King <peff@peff.net> wrote:
>>
>> > The patch in jc/pull-training-wheel talks about annoying old timers, but
>> > I think you may also be annoying clueless new users who simply want an
>> > svn-like workflow without thinking too hard about it.
>>
>> How? Subversion would complain if you have local changes when you do
>> 'svn pull', there's no notion of remotes, branches and merges are
>> rare, and forget about rebases.
>
> By "svn-like", I mean the people whose workflow is:
>
>   $ hack hack hack
>   $ git commit
>   $ git push ;# oops, somebody else pushed in the meantime
>   $ git pull
>   $ git push

But that's not svn-like at all.

> without using branches or worrying about the shape of history. I do not
> know what you mean by "svn pull", since that command does not exist
> (unless you are talking about svk?). In subversion, that workflow would
> be:
>
>   $ hack hack hack
>   $ svn commit ;# oops, somebody else committed in the meantime
>   $ svn update
>   $ svn commit
>
> Those people would now have to learn enough to choose between merge and
> rebase when running the "git pull".

But that's only if they don't care about the shape of history. In my
experience the people that cling more to centralized VCS do not like
merges, so they rebase everything to make it a straight line. That is
much more "svn-like".

So chances are they are already doing 'git pull --rebase' (or
similar), so their workflow wouldn't be affected.

> It may be OK to say "we do not care about that case, and it is a good
> thing that they learn enough to make the choice consciously." But I do
> think they exist.

Yeah, I'm sure they exist, but they are a tiny minority compared to
the amount of people who don't actually understand what 'git pull' is
doing and do merges by mistake.

-- 
Felipe Contreras
