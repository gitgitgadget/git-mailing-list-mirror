From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH] format-patch: introduce branch.*.forkedFrom
Date: Wed, 8 Jan 2014 03:05:48 +0530
Message-ID: <CALkWK0=UkWEGhU6D8CQctdgTvZUUj276LSuNhSmRUMZ5mwZTeA@mail.gmail.com>
References: <1389126588-3663-1-git-send-email-artagnon@gmail.com>
 <CALkWK0=g5-9r05vTkys8Tk7iv7PqPZJvMvkYsAOnN_F90Mtgxg@mail.gmail.com>
 <20140107204035.GA27932@sigill.intra.peff.net> <CALkWK0mGPhU-8vVg+xY-MGWNstxoXSU9MGQiNzyFN+-Q6Bw28A@mail.gmail.com>
 <20140107211645.GC28102@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 07 22:36:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0eK9-0001bO-1v
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 22:36:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753687AbaAGVga (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 16:36:30 -0500
Received: from mail-ie0-f182.google.com ([209.85.223.182]:54447 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752691AbaAGVg2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 16:36:28 -0500
Received: by mail-ie0-f182.google.com with SMTP id as1so1110833iec.27
        for <git@vger.kernel.org>; Tue, 07 Jan 2014 13:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=m3fWBMvAC0nCOVfubuXPHmqfmT53IWYb+gaccjpqa9U=;
        b=uotCUOIYWrnupmk/bxqKsaYFr9YyV4qXxt7WBH+qRu80W2IVubjVcdkH1UkXC5KbgO
         JfdOgIkcXSTQX5bFF089kGUndtBnc9Cy4A6PrXoYSzkF7AiM0NyOPFp5nefirKKpQ9Bg
         np/+JjiYFpAfoxTtQDpiRT7TEd99ApVquiOz4qCvDsr2mhyJYeKNOqAhOC/FPIUGvx9H
         YKQVPQb6sIamJCyCfNvF16Iw6DhuutqiZjxs7o/OTc79brtg/0ZvCy+pICaLLzzxxAGc
         GszqrzPaZOGV4xYVE/4JNBbULOPdb0bXdfsOlqtt8lmNP8J4+tOkxX7HAkjsd1kYDW/u
         xdsQ==
X-Received: by 10.50.36.67 with SMTP id o3mr27800843igj.47.1389130588237; Tue,
 07 Jan 2014 13:36:28 -0800 (PST)
Received: by 10.64.17.10 with HTTP; Tue, 7 Jan 2014 13:35:48 -0800 (PST)
In-Reply-To: <20140107211645.GC28102@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240163>

Jeff King wrote:
> I definitely respect the desire to reuse the existing tooling we have
> for @{u}. At the same time, I think you are warping the meaning of
> @{u} somewhat. It is _not_ your upstream here, but rather another
> version of the branch that has useful changes in it. That might be
> splitting hairs a bit, but I think you will find that the differences
> leak through in inconvenient spots (like format-patch, where you really
> _do_ want to default to the true upstream).

Thanks for the clear reasoning.

> If we add "@{publish}" (and "@{pu}"), then it becomes very convenient to
> refer to the ram/ version of your branch. That seems like an obvious
> first step to me. We don't have to add new config, because
> "branch.*.pushremote" already handles this.

Agreed. I'll start working on @{publish}. It's going to take quite a
bit of effort, because I won't actually start using it until my prompt
is @{publish}-aware.

> Now you can do "git rebase @{pu}" which is nice, but not _quite_ as nice
> as "git rebase", which defaults to "@{u}". That first step might be
> enough, and I'd hold off there and try it out for a few days or weeks
> first. But if you find in your workflow that you are having to specify
> "@{pu}" a lot, then maybe it is worth adding an option to default rebase
> to "@{pu}" instead of "@{u}".

Actually, I'm not sure I'd use "git rebase @{pu}"; for me @{pu} is
mainly a source of information for taking apart to build a new series.
