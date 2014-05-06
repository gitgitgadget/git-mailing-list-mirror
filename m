From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2014, #09; Tue, 29)
Date: Tue, 06 May 2014 13:54:46 -0500
Message-ID: <53692ff63ae2f_2855e9b3089e@nysa.notmuch>
References: <xmqq7g67iwxc.fsf@gitster.dls.corp.google.com>
 <20140505184546.GB23935@serenity.lan>
 <5367e1ac39571_5977e7531081@nysa.notmuch>
 <20140505195525.GC23935@serenity.lan>
 <xmqqeh06g557.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue May 06 22:16:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhkgK-0002u0-I7
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 21:05:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752910AbaEFTFc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 15:05:32 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:56498 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbaEFTFb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 15:05:31 -0400
Received: by mail-oa0-f45.google.com with SMTP id l6so3326406oag.4
        for <git@vger.kernel.org>; Tue, 06 May 2014 12:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=gmcXvQVqt0ImzOaREQnoe2SHq9zh1phFmakU2oRCkSU=;
        b=TxPTawmaB2m5I0ntBbUw8/9pA6XJB9v46P8fyCIU2PZy4oPzRl12vRTOL1ytn5WoTm
         inDFtBhEQnfeQvWvJl8EHww9TaobmPBzwLoLfuGaiO90j+EupNWAeCij8jSHzKTiT+wk
         RBFGC25m/JYVaUBbXROsOX1VcqqDjAyf7HJOVDCZqYv3WUpM96yTwRrULAKzs/A7vXI3
         fit9x2Q5V3ykdAtBONAY+5Gap7URtDMS94VSUeADX6wh8FAvaFMsXuGRBhXkfYA/aewj
         EX2mW7QojaBDA/gBHVDZZdUaLVAumtEwfoHx1ZtOcBon2xCIzt8zJnnk4PszCgaMYfCX
         3R/g==
X-Received: by 10.60.118.1 with SMTP id ki1mr41226670oeb.10.1399403130991;
        Tue, 06 May 2014 12:05:30 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id ci10sm55734914oec.0.2014.05.06.12.05.28
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 May 2014 12:05:29 -0700 (PDT)
In-Reply-To: <xmqqeh06g557.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248236>

Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > And it is now probably too late for that to make Git 2.0,...
> 
> Anything with end-user visible changes in the core part that is not
> a fix to a regression introduced between v1.9.0..master is too late
> for the upcoming release.  We are way past -rc1.

The patch in question only affects users of hg v3.0 since it's
surrounded by a 'check_version(3, 0)'. Therefore it cannot introduce
regressions, there's no reason not to apply it.

> >> So I think these are the two options:
> >> 
> >>   1) Include git-remote-hg/bzr to the core and distribute them by
> >>      default (as is the current intention)
> >> 
> >>   2) Remove git-remote-hg/bzr entirely from the Git tree. And do the
> >>      same for other tools: git-p4, git-svn, git-cvs*. Given the huge
> >>      amount of people using Subversion, we might want to defer that one
> >>      for later, but eventually do it.
> 
> Isn't there a middle ground?  The option 1.5 may be like this:
> 
>  - Eject tools in contrib/ that would benefit the users better if
>    they were outside my tree.  There are a few points to consider
>    when judging "benefit better if outside":
> 
>    * Their release cycle requirements are better met outside my tree
>      (the "remote-hg depends not just on Git but Hg internal" issue
>      we have discussed).

Shouldn't *I* be the one most qualified to know if the release cycle
requirements are better met outside the git.git tree?

>    * They are actively maintained.  The overall Git maintainer would
>      merely be being a bottleneck than being a helpful editor with
>      respect to these tools if we keep them in my tree, and we
>      expect that the tool maintainer would do a much better job
>      without me.

Perhaps. But only if the patches are reviewed throught the git mailing
list.

And what about the tools that are not actively maintainted? For example
'contrib/hg-to-git'.
 
>  - Keep tools that are not actively maintained but still used by the
>    users widely in my tree, but when their external dependencies
>    become baggage to Git as a whole, demote them to contrib/ and
>    stop installing them by default.

That implies that git-remote-hg would become a baggage to Git as a
whole.

If you are arguing that git-remote-hg should be distributed by default,
and only if the dependencies become a problem, demote to 'contrib/' that
is fine. The same for git-p4 and other tools already out of contrib.

-- 
Felipe Contreras
