From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] Created git-basis and modified git-bundle to accept --stdin.
Date: Tue, 24 Jun 2008 01:09:10 -0700 (PDT)
Message-ID: <m3iqvzl091.fsf@localhost.localdomain>
References: <1214273297-8257-1-git-send-email-adambrewster@gmail.com>
	<1214273297-8257-2-git-send-email-adambrewster@gmail.com>
	<c376da900806231921y2d822been9cd573d509fbf78a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Adam Brewster" <adam@adambrewster.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 10:10:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB3bQ-0001sL-HO
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 10:10:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758122AbYFXIJS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 04:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758195AbYFXIJS
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 04:09:18 -0400
Received: from ik-out-1112.google.com ([66.249.90.176]:34003 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758122AbYFXIJN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 04:09:13 -0400
Received: by ik-out-1112.google.com with SMTP id c28so1460098ika.5
        for <git@vger.kernel.org>; Tue, 24 Jun 2008 01:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=zRyobtRTtQIh/rrwhKm7FWdA2zA5Z8SBMYxhyKTrlY4=;
        b=Z2TpFEPCWU8LAR3mooCl8/OrOA8OS8+xPRHoOARpuVDoR+1bYgfU2Gbpi7QiZVLXXI
         EhvAcRPhWatpak0/2+ZMvBmxEB87MYX9JffnZC95P0Lm10Sgtl4B0flOmfZADbZTT86l
         juH1hNw00vYOWgtP4+H4nAEEmY/VSfbzOPMUI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=kxAmdlI2rq/HEQqD82dnjJF1PUOrF+ICZGQEeTZ0o5fHUl/8cIeEipZx7VT93e9AGb
         IDyj8zE5MeB+lfaBlaOmBcTg9CPKiIlFLZLrNbEsOSN/GlgKJo9x0bb6vZSyg0NQf4d+
         cr84MY9NlC1ZF+EOkCL6hDBF8gEQiU89jawzU=
Received: by 10.210.72.19 with SMTP id u19mr70965eba.71.1214294951896;
        Tue, 24 Jun 2008 01:09:11 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.195.249])
        by mx.google.com with ESMTPS id y37sm9879033iky.8.2008.06.24.01.09.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Jun 2008 01:09:10 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5O8Ch8Y005603;
	Tue, 24 Jun 2008 10:12:43 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5O8Chlc005600;
	Tue, 24 Jun 2008 10:12:43 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <c376da900806231921y2d822been9cd573d509fbf78a@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86009>

"Adam Brewster" <adam@adambrewster.com> writes:

> Git-basis is a perl script that remembers bases for use by git-bundle.
> Code from rev-parse was borrowed to allow git-bundle to handle --stdin.

I'd rather you follow git-pack-objects, and use `--revs` for the name
of this option (or even '--not --revs').  The name `--stdin` might
imply that you are providing objects names on stdin of git-bundle.

But perhaps I am worrying over nothing.
 
[...]
> Then you can add the objects in the bundle to the basis, so they won't
> get included in the next pack like this:
> 
>  $ git-basis --update my-basis < my-bundle

Why not use "$(git ls-remote my-bundle)" somewhere in the invocation
creating new bundle instead?
 
> I'm sure that my implementation is crap, but I think this is a useful
> idea.  Anybody agree?  Disagree?

Documentation, please?  Especially that it looks like '--stdin' option
is a bit tricky...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
