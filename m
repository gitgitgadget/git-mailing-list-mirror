From: Craig Silverstein <csilvers@khanacademy.org>
Subject: Re: [PATCH] git-new-workdir: support submodules
Date: Sat, 24 Jan 2015 17:47:35 -0800
Message-ID: <CAGXKyzEPWrbRFOhvCBm=2Z50zso85G50z-nLd_wyzyeEADQSmw@mail.gmail.com>
References: <CAGXKyzHoLLgkXk0X4UVtLBEryqsHriKmmO5+2iVWk3mR8y7=Hw@mail.gmail.com>
	<CAGXKyzEwAjCNTxRtjSuFh9b6BzzOYKOQryKtXBGY3_hkkFvyVw@mail.gmail.com>
	<xmqqegqlnelu.fsf@gitster.dls.corp.google.com>
Reply-To: csilvers@khanacademy.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 25 02:54:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YFCPD-000168-TZ
	for gcvg-git-2@plane.gmane.org; Sun, 25 Jan 2015 02:54:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbbAYBri (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2015 20:47:38 -0500
Received: from mail-ig0-f179.google.com ([209.85.213.179]:46161 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906AbbAYBrg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2015 20:47:36 -0500
Received: by mail-ig0-f179.google.com with SMTP id l13so3381958iga.0
        for <git@vger.kernel.org>; Sat, 24 Jan 2015 17:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=khanacademy.org; s=google;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=pLtVAjdgKLiUd0iaRvIAnJ6A9r3eGovfytr57jJkc1Q=;
        b=eYzEWuOrHX79DjV5cFohySAhf/5ntq3xqwVYMZiPgCxmpO1KyHzDf8o6+1/AMCI79c
         9l8e+DvraQLDnnv+pPFAUh3q05rItq/UlAdP9wEVjp8FGV2DyzYtg12hak5C6eCgYQ4p
         VU8nFBBoxu2OYzD7Irc+H/fhfmpqYc4M56Zn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=pLtVAjdgKLiUd0iaRvIAnJ6A9r3eGovfytr57jJkc1Q=;
        b=F0w4VQKnD34zZfNu5bRT5wVcuwkCArdUJ77Jewz1GqTw6+vC99d2oF+uZSVTT6uJYs
         FDryYdzOfs4SwmQzfu8jFYS1iH/mgjyH73q8iOGAZyCEx9uFOLqe9lus9v1QUwJ0V/DF
         2gMQhaw7/Doa6gNkIn3GeV8pPH7akiCKkhX6j1BGwuPyub8XoaeslIX/rAZ/wEarv6Sv
         qt+1TRQ53CIpS0Y9C3DK+6ADNvjI9mVpfjykBJ9cjP57SVn95PDtM6V1x8E5ZEsyhsKa
         yXjDo7QfkSwx6FRNvOVdBS+lksRLozW8u9YxJqyjdflTSxSbqAJf6Qcp5YLI2vQ5t3/f
         S31g==
X-Gm-Message-State: ALoCoQmevhFrsyBsN4td4WbKokIhbDAVDS+DRPwLfZrTn/EbIYXGalZlX/sMJwQAP8Uxx26ffEXw
X-Received: by 10.43.19.134 with SMTP id qk6mr15062648icb.29.1422150456000;
 Sat, 24 Jan 2015 17:47:36 -0800 (PST)
Received: by 10.36.76.76 with HTTP; Sat, 24 Jan 2015 17:47:35 -0800 (PST)
In-Reply-To: <xmqqegqlnelu.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262996>

} Or one new-workdir checkout's branch may check out a top-level
} project from today while the other one may have a top-level project
} from two years ago,

This is also true, but just as much a problem with the 'git
new-workdir' script as it existed before my change.  It already
symlinks the top-level .git/config directory, which lists a remote,
submodules, and many other things.  Does symlinking the config file
for submodules add any new wrinkles, that symlinking the config file
for the top-level repository does not?

craig

On Fri, Jan 23, 2015 at 5:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Craig Silverstein <csilvers@khanacademy.org> writes:
>
>>>> Doesn't a submodule checkout keep some state tied to the working
>>>> tree in its repository configuration file?
>>>
>>> Do you mean, in 'config' itself?  If so, I don't see it.  (Though it's
>>> possible there are ways to use submodules that do keep working-tree
>>> state in the config file, and we just happen not to use those ways.)
>>> Here's what my webapp/.git/modules/khan-exercises/config looks like:
>>> ---
>>> [core]
>>>         repositoryformatversion = 0
>>>         filemode = true
>>>         bare = false
>>>         logallrefupdates = true
>>>         worktree = ../../../khan-exercises
>>> [remote "origin"]
>>>         url = http://github.com/Khan/khan-exercises.git
>>>         fetch = +refs/heads/*:refs/remotes/origin/*
>>> [branch "master"]
>>>         remote = origin
>>>         merge = refs/heads/master
>>>         rebase = true
>>> [submodule "test/qunit"]
>>>         url = https://github.com/jquery/qunit.git
>>> --
>>>
>>> The only thing that seems vaguely working-tree related is the
>>> 'worktree' field, which is the field that motivated me to set up my
>>> patch the way it is.
>
> That is the location of the working tree of the top-level
> superproject.  Tied to the state of the submodule working tree
> appear in [submodule "test/qunit"] part.
>
> In one new-workdir checkout, that submodule may be "submodule
> init"ed, while another one, it may not be.
>
> Or one new-workdir checkout's branch may check out a top-level
> project from today while the other one may have a top-level project
> from two years ago, and between these two checkouts of the top-level
> project, the settings of submodule."test/qunit".* variables may have
> to be different (perhaps even URL may have to point at two different
> repositories, one historical one to grab the state two years ago,
> the other current one).
>
> So sharing config between top-level checkouts may not be enough to
> "support submodules" (the patch title).
