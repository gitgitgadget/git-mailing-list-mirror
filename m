From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [RFC/PATCH] rebase: use reflog to find common base with upstream
Date: Sun, 8 Dec 2013 15:34:58 -0800
Message-ID: <CANiSa6hnHdC5Rk9gBZd=9Hr74wjnnjrsoagwsv=HLQb5CM0AEg@mail.gmail.com>
References: <9e5fa57b027e1a5cd11a456c14f43b64f8f5386c.1386531376.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Dec 09 00:35:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VpnsP-0001tp-NH
	for gcvg-git-2@plane.gmane.org; Mon, 09 Dec 2013 00:35:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760031Ab3LHXfB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Dec 2013 18:35:01 -0500
Received: from mail-wi0-f175.google.com ([209.85.212.175]:34199 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755574Ab3LHXfA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Dec 2013 18:35:00 -0500
Received: by mail-wi0-f175.google.com with SMTP id hi5so3026796wib.2
        for <git@vger.kernel.org>; Sun, 08 Dec 2013 15:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=k68UpVvL+C23YWOz6a6SPj0MAdUAHbzOYCublAJAh04=;
        b=NVM40BTekmljcAeqTY07MEzZAJyxiMltuzWxTbFqQOZcmybHmTeGNlyr1GcMq2L2th
         RsxG7dU1y9LBMY475eAgg071b7RRFTGrP6SJELAt7+IVBJwwZfUg/xw8AVlEp0AHsrwk
         7Z3fKO8OnAnonmFoAH2BPw23bXFaF6BO6NMp2HNDzonfOGk2DgCC10G8zohftW22te6E
         JdOsauCvqmpFrAu22/o40pTo8cXjD6/HBYugEXohn+bDNwVFWCYX3pXKSXjnYV9UCthB
         +JjEAmgiVcXEKhmEqBFwxKdxgwtRUyXGUTkZa07cK3uW2x5aCbTdkzPqKZX1flv75lg5
         XlCg==
X-Received: by 10.194.23.201 with SMTP id o9mr3312462wjf.67.1386545698867;
 Sun, 08 Dec 2013 15:34:58 -0800 (PST)
Received: by 10.180.5.66 with HTTP; Sun, 8 Dec 2013 15:34:58 -0800 (PST)
In-Reply-To: <9e5fa57b027e1a5cd11a456c14f43b64f8f5386c.1386531376.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239056>

On Sun, Dec 8, 2013 at 12:06 PM, John Keeping <john@keeping.me.uk> wrote:
> Commit 15a147e (rebase: use @{upstream} if no upstream specified,
> 2011-02-09) says:
>
>         Make it default to 'git rebase @{upstream}'. That is also what
>         'git pull [--rebase]' defaults to, so it only makes sense that
>         'git rebase' defaults to the same thing.
>
> but that isn't actually the case.  Since commit d44e712 (pull: support
> rebased upstream + fetch + pull --rebase, 2009-07-19), pull has actually
> chosen the most recent reflog entry which is an ancestor of the current
> branch if it can find one.

In my mind, 'git pull --rebase' does default to @{u}, it just started
interpreting it differently in d44e712, but maybe I'm just being
defensive :-).

In a similar way, I think your patch is about interpreting the
upstream argument differently, not about changing the default upstream
argument. This is why I think "git rebase" and "git rebase
origin/master" should be the same (when origin/master is the
configured upstream).
