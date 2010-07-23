From: Chris Packham <judge.packham@gmail.com>
Subject: Re: question (possibly) on git subtree/submodules
Date: Fri, 23 Jul 2010 09:56:38 -0700
Message-ID: <4C49C9C6.3080409@gmail.com>
References: <xotjlj92i9gr.fsf@leonardo.pit.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Maurizio Vitale <mav@leonardo.pit.corp.google.com>,
	git@vger.kernel.org
To: maurizio.vitale@polymath-solutions.com
X-From: git-owner@vger.kernel.org Fri Jul 23 18:56:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcLYK-0002P0-V0
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 18:56:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756675Ab0GWQ4r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jul 2010 12:56:47 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:38036 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753932Ab0GWQ4q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 12:56:46 -0400
Received: by pxi14 with SMTP id 14so3712936pxi.19
        for <git@vger.kernel.org>; Fri, 23 Jul 2010 09:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=eXTvv7p6MnjcMEprCnmywAONzQEwj5afrpaDjUKkU30=;
        b=dvAyspQ//TKCJO5hgsBeDCcexBgzAiOfqOZxoJbVRQUNLSCuFJcO/cQO8vvgjswBVa
         1HrokRIiDxO3N9igxW/JNj7r8p7Yw6PBBEz8jktna/M3CpqiLFybUR/QtXdmTL9oZyJg
         4wXFdeEy3/bMr71zWJaW30PqP5rc5esqkjvN0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=D4Piij0ZgucIqHE9Jfgl2c3v8nYdoDQQTLFxFvbyDYEnqYukzhvyZx8oSui9RSI3Cq
         V+qb2k4LM/wAudWlA+2JvlVG19g0J0W2pCRV3b8j7VEjaz5E+E8LK6XmmUqeZc7+4Qvp
         As3Rf94aRJeVWfwlRFPsf8/S/9K7NpBAqxvLs=
Received: by 10.114.120.9 with SMTP id s9mr2560717wac.100.1279904206064;
        Fri, 23 Jul 2010 09:56:46 -0700 (PDT)
Received: from asus-laptop.site (209-234-175-66.static.twtelecom.net [209.234.175.66])
        by mx.google.com with ESMTPS id k23sm703903waf.17.2010.07.23.09.56.44
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 23 Jul 2010 09:56:44 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.1.10) Gecko/20100520 SUSE/3.0.5 Thunderbird/3.0.5
In-Reply-To: <xotjlj92i9gr.fsf@leonardo.pit.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151548>

Hi,

On 23/07/10 07:00, Maurizio Vitale wrote:
> 
> I'm new to git and have read the recent thread on subtree support.
> I'm not sure they (or git submodules) offer what I'm looking for.
> Here's the scenario:
>        - I have a large monolithic code base, all in my repository (e.g.
>          I don't need to link in external repositories, which is what I
>          understand submodules offer
>        - I'd like to be able to clone only a small fraction of the
>          repository (say an arbitrary directory or even a single file)
>          in order to make small changes
>        - these directories are not known when the full repository is set
>          up.
>        - commits to the part I've checked out should show in the history
>          of any clone that includes the part, up to the full repository
>        - ideally, I should be able to incrementally clone portions (e.g.
>          I've checked out path/dir_A and realize I need to modify
>          path/dir_B as well).
>          these additional clones should be in whatever branch I switched
>          to after the initial checkouts.
> 
> Assuming the above makes any sense (in general or in git), is there
> anything in git that would help me doing what I'm looking for?
> Thanks,
> 
>         Maurizio 

The short answer is no. Nothing git has currently will let you clone a
subset of files. Shallow clones exist if you want all the code and the
last X changes. The reason for this is git, like other DVCSes, tracks
_changes_ rather than _files_ this is something that took me a while to
get my head around when I was learning git.

The best advice I've seen is to actually take your repository and use
git filter-branch to create several smaller repositories (or depending
on your desire for retention of history just create new repos). You can
then use submodules or subtrees to stitch these back together into a
super project to which you can add the smaller repositories as needed
(note: I have never used subtrees so I'm not 100% sure if what I'm
saying applies to them) .

We use this model with submodules at $dayjob and it works quite well for us.
