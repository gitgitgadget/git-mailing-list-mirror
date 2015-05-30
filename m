From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Diffing submodule does not yield complete logs for merge commits
Date: Sat, 30 May 2015 10:04:31 -0700
Message-ID: <xmqqbnh2ateo.fsf@gitster.dls.corp.google.com>
References: <20150501175757.GA10569@book.hvoigt.net>
	<CAHd499B=EcgYiTMFt9VYhj45bRkP8h9TBk1B0cr8fYFuXNe_mQ@mail.gmail.com>
	<5547C961.7070909@web.de>
	<CAHd499CRge9Y6VzdC_ngXS4WxuQ9HizXQJzLpX3iQStY5Cg=6g@mail.gmail.com>
	<37f399418bbebb3b53a50bf8daffcdc0@www.dscho.org>
	<CAHd499Do2aB5E_=aDzkoDssEbgz181rH36X28Oe7Zcok2f=zBQ@mail.gmail.com>
	<20150518123036.GB16841@book.hvoigt.net>
	<CAHd499CETM2jmZ2iJk=AoXtjLUCQ==u6q9Z5P-3EVGSY48FY_A@mail.gmail.com>
	<20150519104413.GA17458@book.hvoigt.net>
	<CAHd499D9vOtLOBj2s5EOfsojSStZY+HdZR35icZ5cssLNkcD-A@mail.gmail.com>
	<20150521125122.GA22553@book.hvoigt.net> <55691DE3.70200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jens Lehmann <Jens.Lehmann@web.de>, Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 30 19:04:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YykBb-0007yF-Cj
	for gcvg-git-2@plane.gmane.org; Sat, 30 May 2015 19:04:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756630AbbE3REe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 May 2015 13:04:34 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:34151 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755632AbbE3REd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 May 2015 13:04:33 -0400
Received: by igbhj9 with SMTP id hj9so35492865igb.1
        for <git@vger.kernel.org>; Sat, 30 May 2015 10:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=aPwIekBlxEIlqPPzKxu7asEz8ldAWpX5wY0NUqYhe3M=;
        b=VpG+ON9EOmGq4D40KIKqJfRmvY7tUa5cvN8rZ7AHp37kY0zwtLjyFBT0aB+lYTFCD1
         5KYEXDbYAyJ7ODt0BQkABV97njx55ZMcqTN17DOYAEvZYr4IPMqzPeZJ+7aiK4FtCCwJ
         piXcGK2CeO0Wu5sney/XMzuIKkYnTdyUhmHg6SkyYZ3/e9wOavZyNJiAjFb+hDfWZ2Jp
         zHH65xKoS6cO0752p3JFVgt1VGxLBJxbi2cmX3snkvANAQHSMLPVr3Ln2h+lt6EESqgW
         CpipobH0zGte8R4/XnL+dG9UOQzObEAyVFrSjpD7qU/yeiWcIpkN3V41+Y7tQ102EfEM
         F6vQ==
X-Received: by 10.107.6.136 with SMTP id f8mr16514944ioi.61.1433005473312;
        Sat, 30 May 2015 10:04:33 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:d9c8:419b:acd5:cf1d])
        by mx.google.com with ESMTPSA id v14sm4043107igd.12.2015.05.30.10.04.32
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 30 May 2015 10:04:32 -0700 (PDT)
In-Reply-To: <55691DE3.70200@gmail.com> (Robert Dailey's message of "Fri, 29
	May 2015 21:18:11 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270291>

Robert Dailey <rcdailey.lists@gmail.com> writes:

> In the meantime I'd like to ask, do we even need to add an option for
> this? What if we just make `diff.submodule log` not use
> --first-parent? This seems like a backward compatible change in of
> itself.

Why?  People have relied on submodule-log not to include all the
noise coming from individual commits on side branches and instead
appreciated seeing only the overview by merges of side branch topics
being listed---why is regressing the system to inconvenience these
existing users "a backward compatible change"?

> And it's simpler to implement. I can't think of a good
> justification to add more settings to an already hugely complex
> configuration scheme for such a minor difference in behavior.

Careful, as that argument can cut both ways.  If it is so a minor
difference in behaviour, perhaps we can do without not just an
option but a feature to omit --first-parent here.  That would be
even simpler to implement, as you do not have to do anything.

So, if you think the new behaviour can help _some_ users, then you
would need the feature and a knob to enable it, I would think.
