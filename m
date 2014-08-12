From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Error "fatal: not a git repository" after auto packing
Date: Tue, 12 Aug 2014 22:41:38 +0700
Message-ID: <CACsJy8A576_OxXNKpsar5DiJ3Z=YsG4DURxL_JceknhRxBjB+g@mail.gmail.com>
References: <CACZXET_qPzBtqJLXBbou+iZ_Muj=VqCBe5qMADN72VScsuHRVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Luke Campagnola <luke.campagnola@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 12 17:42:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHEDG-0003zZ-EW
	for gcvg-git-2@plane.gmane.org; Tue, 12 Aug 2014 17:42:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753042AbaHLPmK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2014 11:42:10 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:34068 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752828AbaHLPmJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2014 11:42:09 -0400
Received: by mail-ig0-f169.google.com with SMTP id r2so8348660igi.2
        for <git@vger.kernel.org>; Tue, 12 Aug 2014 08:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=aRrGm0Ck9i/hHiL4w/OoBIsI+LHMPVWKzaOQY1tVO/U=;
        b=oodrBFquUr9aWtfmpkZToWsDOpU08W/iqvRUeTYh0DWG3Cc5gV/3diX69TmV74lcCk
         gzhFTQ2aiKZ4gTWQ3kYhtUxTGNIWs8kuGnHHU6EhLcVbdz8hwzLPEO0/bE6GZgh4N7i3
         NR+si0LrbngoPEeGv0h9L+m9Kxdb5onCplUK8fcALZuD+/eQW8LmX2iZAbqhoaNE1Rc6
         p2eq18ntg+ToXov3PnENBh/u96ivLqnp3zmRn3cEB3JBtI+qE2UoBldxNLAWcR30Dc+x
         LUU6ikUrl/7+qvMrCYN+5M1vM4OVWb0UgkW+djy6yzKyQK7LNgaIx4ehB13eXukALP+R
         wRhw==
X-Received: by 10.42.109.79 with SMTP id k15mr43267955icp.42.1407858128221;
 Tue, 12 Aug 2014 08:42:08 -0700 (PDT)
Received: by 10.107.13.80 with HTTP; Tue, 12 Aug 2014 08:41:38 -0700 (PDT)
In-Reply-To: <CACZXET_qPzBtqJLXBbou+iZ_Muj=VqCBe5qMADN72VScsuHRVQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255151>

On Tue, Aug 12, 2014 at 5:56 AM, Luke Campagnola
<luke.campagnola@gmail.com> wrote:
> Greetings,
>
> I have been working happily with git for a couple of years, and ran
> into a mysterious issue today: after running a git-pull during which I
> saw the message "Auto packing the repository for optimum performance".
> I now receive the error "Fatal: not a git repository" when running any
> git commands, and a little investigation revealed that my .git/refs
> directory has gone missing, presumably because the refs were all
> combined into .git/packed-refs. To restore access to the repository,
> all I needed was to `mkdir .git/refs`. Is this a known bug?

Not to me.

> It seems
> like either git should tolerate the absence of a .git/refs directory,
> or the auto packer should not remove it.

I tried to clone from vispy.git, running 'git gc' manually and
'pack-refs' (which should be in charge of removing empty dirs with
v1.9.1. Things worked fine. Looked at
refs.c:try_remove_empty_parents() as well. Still could not find any
bug there.. So no good news. I don't suppose that if you run "git gc"
again, it would remove $GIT_DIR/refs one more time?
-- 
Duy
