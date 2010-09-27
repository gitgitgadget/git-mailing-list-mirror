From: Grant Erickson <gerickson@nuovations.com>
Subject: Re: GIT and Cloning Remote Repositories into "Local Remote"
 Repositories
Date: Sun, 26 Sep 2010 18:17:45 -0700
Organization: Nuovation System Designs, LLC
Message-ID: <C8C53EC9.1E621%gerickson@nuovations.com>
References: <20100921013700.GC8380@foucault.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Casey Dahlin <cdahlin@redhat.com>
X-From: git-owner@vger.kernel.org Mon Sep 27 03:18:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P02Mn-00051Q-7h
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 03:18:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757593Ab0I0BSA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Sep 2010 21:18:00 -0400
Received: from relay01.pair.com ([209.68.5.15]:2168 "HELO relay01.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753486Ab0I0BR7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 21:17:59 -0400
Received: (qmail 37437 invoked by uid 0); 27 Sep 2010 01:17:57 -0000
Received: from 71.142.81.237 (HELO ?192.168.1.2?) (71.142.81.237)
  by relay01.pair.com with SMTP; 27 Sep 2010 01:17:57 -0000
X-pair-Authenticated: 71.142.81.237
User-Agent: Microsoft-Entourage/12.26.0.100708
Thread-Topic: GIT and Cloning Remote Repositories into "Local Remote"
 Repositories
Thread-Index: Actd4cobEwJPtKexyEWnVfwE6tZaIQ==
In-Reply-To: <20100921013700.GC8380@foucault.redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157285>

On 9/20/10 6:37 PM, Casey Dahlin wrote:
> On Mon, Sep 20, 2010 at 06:22:09PM -0700, Grant Erickson wrote:
>> Perhaps 'submodules' are what I am looking for?
>> 
> 
> Yup, exactly :) the manpage git submodule should get you going.

Casey:

Thanks for the prompt reply.

I spent some time over the weekend playing with the various submodule
tutorials and I wasn't left feeling convinced that it's the right solution,
particularly with the added complexity around commits and pushes (trailing
slashes, etc.) that I am sure my users are going to get wrong more often
than right.

In further explorations, it occurred to me that the "subtree" merge strategy
might be another, perhaps, better alternative. However, when I tried it
based on the example at
http://www.kernel.org/pub/software/scm/git/docs/howto/using-merge-subtree.ht
ml, I got some results that were unexpected, such as files showing up where
I didn't want them to: top-of-tree rather than the intended subdirectory.

Basically, I am starting out a project with x-loader, u-boot and linux based
on the Arago project GIT at tag OMAPPSP_03.00.01.06, from which TI's
somewhat-dated PSP is based:

    git://arago-project.org/git/projects/x-load-omap3.git
    git://arago-project.org/git/projects/u-boot-omap3.git
    git://arago-project.org/git/projects/linux-omap3.git

At some point, once my system is stable, I'd like to merge both u-boot and
linux up to mainline revisions/tags with my local changes included from:

    git://git.denx.de/u-boot.git
    git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

My tree is organized roughly as:

    root/
        .git/
        fw/
            u-boot/
                Makefile
                u-boot/
                    <Actual contents of GIT tree here>
            x-loader/
                Makefile
                x-loader/
                    <Actual contents of GIT tree here>
        sw/
            tps/
                linux/
                    Makefile
                    linux/
                        <Actual contents of GIT tree here>

My ideal workflow would be:

    1) Merge Arago GIT git://arago-project.org/git/projects/u-boot-omap3.git
to root/fw/u-boot/u-boot/.
    2) Make local changes.
    3) % git commit ...
       % git push <to GitHub repo master>
    4) Make more local changes.
    5) % git commit ...
       % git push <to GitHub repo master>
    6) Ad infinitum until local changes are stable
    7) Merge Denx GIT git://git.denx.de/u-boot.git @ v2010.09-rc2 to
root/fw/u-boot/u-boot/.
       % git <something> ...
    8) Resolve conflicts, commit and push to GitHub repo master.

And so on for the linux subtree as well. Any further tips or course
corrections you can offer, particularly relative to subtree merges?

Best,

Grant
