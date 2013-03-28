From: Stephen Smith <ishchis2@gmail.com>
Subject: Re: git subtree oddity
Date: Thu, 28 Mar 2013 06:34:01 -0700
Message-ID: <A344B55C-0796-4739-8F44-F7BA26EA4B32@gmail.com>
References: <CAH0ocawbOX8C7_EaNFc2PiFT8cnpSJyPD+-8RLDL1S0SX-jQvw@mail.gmail.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git <git@vger.kernel.org>
To: Thomas Taranowski <tom@baringforge.com>
X-From: git-owner@vger.kernel.org Thu Mar 28 14:32:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULCwa-0006JR-FX
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 14:32:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756138Ab3C1NcM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 09:32:12 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:55160 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755922Ab3C1NcL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Mar 2013 09:32:11 -0400
Received: by mail-pa0-f54.google.com with SMTP id fa10so2676317pad.41
        for <git@vger.kernel.org>; Thu, 28 Mar 2013 06:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:references:mime-version:in-reply-to:content-type
         :content-transfer-encoding:message-id:cc:x-mailer:from:subject:date
         :to;
        bh=qWtTbulVqq4ajzbXpv8E8AYPECSdxumz+z2Bx3462sY=;
        b=zn9wWwJUpbUVYGwqKrvbvQulrY5NetQXUPZcCwH7jROypjExET2XoL05T754yaQpmA
         XP0czD9cd6oA5zxu/4Mc/YQp3u1zAyuMCQYUiMJYzDYi9uz7fevfGtkcR882Cs+ep0gy
         so6uD6TSnMVjSi+3POx560Psmj2d2L9StHZhUf2G2Ac2QRCraLD2LGMhlNgPAj7jmkID
         JZMAE0qw+HmUpZlqLgMJ9/bky/JNjy1P6Za3itlhy0rilcLKHO/enOPQfo38fIugr4My
         XL/o6LRey7pX0I8IZ3HxfAyfpbPl/wG+aB8mDCkcHITM0JqOReaA/PMT63oXCmpf4xrc
         Tkzg==
X-Received: by 10.68.50.161 with SMTP id d1mr35168929pbo.30.1364477530336;
        Thu, 28 Mar 2013 06:32:10 -0700 (PDT)
Received: from [10.164.252.79] (mobile-166-137-218-050.mycingular.net. [166.137.218.50])
        by mx.google.com with ESMTPS id qs10sm7042775pbb.28.2013.03.28.06.32.07
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 28 Mar 2013 06:32:08 -0700 (PDT)
In-Reply-To: <CAH0ocawbOX8C7_EaNFc2PiFT8cnpSJyPD+-8RLDL1S0SX-jQvw@mail.gmail.com>
X-Mailer: iPhone Mail (10B329)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219394>

I built v1.8.2 last evening and found that the subtree command isn't supported.  What version of git are you using? And where did you get it?

SPS
Sent from my iPhone

On Mar 27, 2013, at 8:12 PM, Thomas Taranowski <tom@baringforge.com> wrote:

> I'd like to have the following configuration:
> 
> /myproject.git
> |__/upstream_dependency -- Points to a remote library git repo
> |__/project_source -- local project source
> 
> 
> I issue the following commands to pull in the upstream dependency as a
> subtree of the myproject.git repo:
> 
> git remote add upstream git://gnuradio.org/gnuradio
> git fetch upstream
> git checkout master
> git subtree add -P upstream upstream/master
> 
> Now, my expectation is that I would have the following:
> 
> /myproject.git
> |__/upstream_dependency -- Points to a remote library git repo
> |____< all the upstream files are present here, as expected >
> |__/project_source < this is still intact, as expected >
> |__< all the upstream files are present here. wtf?>
> 
> My question is, why does "subtree add" pull in all the subtree files
> into the root of the repo, and not just into the specified subtree
> prefix?
> 
> #
> # Here's an excerpt of what I see:
> #
> $:~/scratch/myproject.git$ ls
> AUTHORS         gr-comedi               gr-utils
> cmake           gr-digital              gr-video-sdl
> CMakeLists.txt  gr-fcd                  gr-vocoder
> config.h.in     gr-fft                  gr-wavelet
> COPYING         gr-filter               gr-wxgui
> docs            gr-howto-write-a-block  README
> dtools          gr-noaa                 README.building-boost
> gnuradio-core   gr-pager                README.hacking
> gr-analog       gr-qtgui                README-win32-mingw-short.txt
> gr-atsc         gr-shd                  upstream <---- the subtree directory
> gr-audio        gr-trellis              volk
> gr-blocks       gruel
> grc             gr-uh
> 
> #
> # Also, those same files are in the upstream subtree directory as well
> (as expected)
> #
> $:~/scratch/myproject.git$ ls upstream
> AUTHORS         grc                     gruel
> cmake           gr-comedi               gr-uhd
> CMakeLists.txt  gr-digital              gr-utils
> config.h.in     gr-fcd                  gr-video-sdl
> COPYING         gr-fft                  gr-vocoder
> docs            gr-filter               gr-wavelet
> dtools          gr-howto-write-a-block  gr-wxgui
> gnuradio-core   gr-noaa                 README
> gr-analog       gr-pager                README.building-boost
> gr-atsc         gr-qtgui                README.hacking
> gr-audio        gr-shd                  README-win32-mingw-short.txt
> gr-blocks       gr-trellis              volk
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
