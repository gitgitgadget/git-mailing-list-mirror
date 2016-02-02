From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: git log -g bizarre behaviour
Date: Tue, 02 Feb 2016 09:28:58 +0100
Message-ID: <1454401738.32711.7.camel@kaarsemaker.net>
References: <1454241144.2822.7.camel@kaarsemaker.net>
	 <xmqqegcwt32j.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 02 09:29:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQWKh-0005hR-TJ
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 09:29:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753673AbcBBI3D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 03:29:03 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38631 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753031AbcBBI3B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2016 03:29:01 -0500
Received: by mail-wm0-f47.google.com with SMTP id p63so10811668wmp.1
        for <git@vger.kernel.org>; Tue, 02 Feb 2016 00:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-type:mime-version:content-transfer-encoding;
        bh=A38z4bqDubVdC+tGux757jsiJoO3qsFtiy2TQ5CYEBc=;
        b=TKwRDiHNQmiwfjMdarzHqz7Sef0aNF74Bdnl3WPuF4KgCHFECfcG80gRnavYQ7MZ+i
         BEYJD5xjQGfpkJNZUtuMdjtnx4hvNiUvLUIA7BWuGK9G00CzOBsFg5qn6BZFqkGhyoBP
         7ue2JCw24o9tSPsQfobL9+aSQnKloe3r8Uwq2BLi4j3HdhEfh2E1JyeFWP5rKFQc2B3x
         wERRKYCf4SEbruyRF/7tyh0iVtO9HsDQSipGuI4vUp5uM+3bz/a0YkDJ40bw7yrS/9Wm
         9qQJ+3vgPPPsz4KWR0cn4/DNyx99yi5pke7yiqk8eebO6JYv3GuFIr+x7vNiA4oYaObM
         4XBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=A38z4bqDubVdC+tGux757jsiJoO3qsFtiy2TQ5CYEBc=;
        b=h0H3+IhnR1YnNXRYc/W79tQxlp6LNcTNom04866xsAq5NrNiOw89eKbq06tRmM8a1H
         dJn+DHrwdcdmrux1vv2YN4ogmE4/H5LFZI9ZBB1FHbp+0p1nUorv2Mp8EwgftJClTnoH
         r7vAIbo2dcWba/ijM1JDdt3WnhiY6s6EFmE2fIAZrKvNk7Ocbv7OI6qXuao1pvQ4WbS2
         NepXghPxVfFBujCcyrzbayWPwS+d8UKaM4EBtORZo3EhWfd/XtJGg93pQ4spP/0luUKq
         gDOfPlIfjweSYa/LGz3LAEY/B38sY2wQ4FeqqqkTiNCCLAHR670uuLORGzGswbpkkcwD
         Hb6Q==
X-Gm-Message-State: AG10YOSn0JLiOVx/4SnWfvhWufJkipOT6YsjDA9Tn22iPbS+B4GhC5rxupxz+BAzAnK0pQ==
X-Received: by 10.28.48.137 with SMTP id w131mr2774246wmw.73.1454401740313;
        Tue, 02 Feb 2016 00:29:00 -0800 (PST)
Received: from seahawk.local (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id lc1sm312388wjc.5.2016.02.02.00.28.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 02 Feb 2016 00:28:59 -0800 (PST)
In-Reply-To: <xmqqegcwt32j.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285244>

On ma, 2016-02-01 at 15:37 -0800, Junio C Hamano wrote:
> Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:
> 
> > I'm attempting to understand the log [-g] / reflog code enough to
> > untangle them and make reflog walking work for more than just
> > commit
> > objects [see gmane 283169]. I found something which I think is
> > wrong,
> > and would break after my changes.
> > 
> > git log -g HEAD^ and git log -g v2.7.0^ give no output. This is
> > expected, as those are not things that have a reflog.
> 
> OK.
> 
> > But git log -g v2.7.0 seems to ignore -g and gives the normal
> > log.
> 
> That sounds clearly broken, and I think I see how that happens from
> the hacky way the "-g" traversal was bolted onto the revision
> traversal machinery.
> 
> I _think_ "git log -g" (and by extension "git reflog" which is just
> a short-hand to giving a few more options to that command) ought to
> 
>  * Iterate over the _objects_ that used to be at the tip of the ref;
>  * Show each of these objects as if they were fed to "git show".

That's what I am trying to achieve. Though not quite like 'git show', I
want to emulate the --oneline putput for non-commit objects too.

> This clearly is not possible without major surgery, including
> ripping out the hacky "-g" traversal from the revision traversal
> machinery and perhaps lifting it up a few levels in the callchain,
> as many functions in that callchain want to work on commits.

Yup. I'm planning to either split cmd_log_walk or make its behaviour
depend on whether we're traversing the reflog (don't call get_revision,
but call a new get_reflog_entry function). And then rip out the reflog
handling from revision.c and redo (parts of) reflog-walk.c to
accomodate the cmd_log_walk (split|replacement) that deals with reflogs
better.

> Contrast these two:
> 
>     $ git log -1 v2.7.0
>     $ git show v2.7.0
> 
> > I'd like to make git log -g / git reflog abort early when trying to
> > display a reflog of a ref that has no reflog. Objections?
> 
> Do you mean
> 
> 	$ git checkout -b testing
>         $ rm -f .git/logs/refs/heads/testing
>         $ git log -g testing
> 
> will be changed from a silent no-op to an abort with error?
> 
> I do not see a need for such a change--does that count as an
> objection?

No, I'd like to change:

$ ls .git/logs/refs/tags/v2.7.0
ls: cannot access .git/logs/refs/tags/v2.7.0: No such file or directory
$ git (log -g|reflog) v2.7.0

>From the bizarre behaviour above to a silent noop. But before I do that
in a rewrite (by simply not implementing it), I'd like to have that
behavior now as well and add tests for it.

-- 
Dennis Kaarsemaker
http://www.kaarsemaker.net
