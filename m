From: Adam Dinwoodie <adam@dinwoodie.org>
Subject: Re: Bug: t5813 failing on Cygwin
Date: Sat, 7 Nov 2015 19:20:29 +0000
Message-ID: <20151107192029.GW14466@dinwoodie.org>
References: <563DEA71.1080808@dinwoodie.org>
 <20151107184527.GA4483@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 07 20:20:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zv92W-0007BA-Pi
	for gcvg-git-2@plane.gmane.org; Sat, 07 Nov 2015 20:20:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754017AbbKGTUg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Nov 2015 14:20:36 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:38416 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753938AbbKGTUf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Nov 2015 14:20:35 -0500
Received: by wmec201 with SMTP id c201so41493709wme.1
        for <git@vger.kernel.org>; Sat, 07 Nov 2015 11:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=LtC3il3rYCzesjx9FlSvczogxYfM4RmhNBAYwXyLN4g=;
        b=R5JsLROh2/K+S/JAb588ooYPxv9YItpM+0N5d9vNRXK6MKooLrz8t4CDixfs59Mwe9
         UmS6lphpOjgNM8giV01Pf7uEbn8fakflPC1K08i99dwWashpX8kXHTkERKO+uGtvO6XR
         edKryb6lejJpAcFVKeXBEZ+XFyYTDZRiGSKn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=LtC3il3rYCzesjx9FlSvczogxYfM4RmhNBAYwXyLN4g=;
        b=fguOxHdZfNSCBCQxx9voXuJuuQ/ar0JB9tY/AWc48JN7OHfe5zIVKyo1lQvqYihhyh
         Andb8+fotDx1gvTW3FbxJxXx4q+jd60TqMgcTjB5nTHks+q1gYIIV6y5hGX9T+a3ZgeU
         krPH4DpfFnI8u4zXYRMKQYqaYletshJLfcFRNxl3il4zjRU0jWwKjX2F9IEwA9uXtJJU
         c9aUUh0NVAaTr6HjCX36r8rGpoTzfOPrQjxtyoo0FdZgoYUujoUY712YDTVabxI83Ud6
         nXC3Sq3LnrKwDMiCUwB/fJf7JIx3pVxaipEnZj7+nmdcldKoP+Ja+pgW+17ep8KNwoh0
         0RMw==
X-Gm-Message-State: ALoCoQnHZUObU6Tl241fKI1QS0tgUkQCXjdi6XG9Nv4l7ghQoWwBcSBJxCOEkZArVgbMIThOvngQ
X-Received: by 10.28.217.18 with SMTP id q18mr17350262wmg.10.1446924033500;
        Sat, 07 Nov 2015 11:20:33 -0800 (PST)
Received: from dinwoodie.org ([2001:ba8:0:1c0::9:1])
        by smtp.gmail.com with ESMTPSA id l1sm7906334wmb.1.2015.11.07.11.20.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 07 Nov 2015 11:20:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20151107184527.GA4483@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281022>

On Sat, Nov 07, 2015 at 01:45:27PM -0500, Jeff King wrote:
> On Sat, Nov 07, 2015 at 12:11:29PM +0000, Adam Dinwoodie wrote:
> 
> > Specifically, I'm seeing t5813 subtests 9-13 and 15-19 failing. This happens
> > with a clean build straight from the Git source tree (git clean -dfx && make
> > configure && ./configure && make && cd t && ./t5813-proto-disable-ssh.sh) as
> > well as builds using the Cygwin packaging paraphernalia.
> 
> What does the output of "./t5813-proto-disable-ssh.sh -v -i" show?
> 
> It seems strange that it would fail only on Cygwin; this code doesn't
> really use any platform-dependent features. It's also weird that it
> fails _only_ for ssh, and _only_ on the tests that are using "ssh://"
> URLs are not "host:path" syntax.

Ah!  I thought I'd checked that already, but looking at the output now I
can see what's going wrong.  Cutting down to the relevant error:

    ssh: remote git-upload-pack '//home/Adam/vcs/Cygwin-Git/git-2.6.2-1.x86_64/build/t/trash directory.t5813-proto-disable-ssh/remote/repo.git' fatal: '//home/Adam/vcs/Cygwin-Git/git-2.6.2-1.x86_64/build/t/trash directory.t5813-proto-disable-ssh/remote/repo.git' does not appear to be a git repository

Note the '//' at the start of the path -- on most *nix systems '//' is
effectively identical to '/'.  On Cygwin, however, '//' is used to
access Windows UNC paths: what Windows calls "\\server\share", Cygwin
calls "//server/share".  If you replace the '//' with '/' you get the
locatoin of the repository; but here Cygwin is looking for the
repository in a share called "Adam" on a network server called "home"...

I suspect the correct fix here is to fix whatever's causing Git to
generate a path with that '//'.  If nobody else gets to it soon
(probably on the order of a week before I'll get the chance), I'll go
code diving and submit a patch.

> I tried building on Linux with the Cygwin build knobs found in
> config.mak.uname, but I couldn't get it to fail. I also wondered if the
> test was doing something with the shell that might not be portable, but
> I don't see anything interesting.

If I recall correctly, the correct interpretation of '//' isn't defined
in POSIX, so whatever's causing that path to be generated is the bit
that's not fully portable.  It looks as though t5813 throwing this up is
just a coincidence rather than it being particularly related to the
function those tests are actually testing.

Adam
