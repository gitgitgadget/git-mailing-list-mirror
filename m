From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Selectively clone Git submodules -- a useful feature?
Date: Fri, 19 Jun 2015 21:08:34 +0200
Message-ID: <558468B2.2010307@web.de>
References: <162A5ADF-1FDD-432B-B5F8-672DF5B50EEC@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 19 21:08:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z61ei-0005V0-2g
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 21:08:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753190AbbFSTIo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 15:08:44 -0400
Received: from mout.web.de ([212.227.15.3]:62939 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752435AbbFSTIm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 15:08:42 -0400
Received: from [192.168.178.41] ([79.211.113.60]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0MZlNu-1ZPChR1WSE-00LSSw; Fri, 19 Jun 2015 21:08:35
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.0.1
In-Reply-To: <162A5ADF-1FDD-432B-B5F8-672DF5B50EEC@gmail.com>
X-Provags-ID: V03:K0:ZjFS39FCl1bK527G2YP4NwMHkuDTvqT40Cm+VwhB5COIqNgKR0W
 PS1Usmd7CvNkXVZiOwcWxFvqENi8xYH6nHOxz/UZiLXZxFgtX+H+MKg/8b2o4HlN36BMGtW
 VZdS32FbMSMQ1Fs/eVhQhQeU68GTEBEJ0PUrcQnDk4Cv+xYrOzB2ezutWtbA3A1OvlafI98
 6eO9Df9AuJZsWSIMz1wUA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272186>

Am 18.06.2015 um 22:55 schrieb Lars Schneider:
> AFAIK Git has two ways to clone a repository with respect to submodules:
>
> (1) Plain clone of just the repository itself:
> git clone git://github.com/foo/bar.git
>
> (2) Recursive clone of the repository including all its submodules:
> git clone --recursive git://github.com/foo/bar.git
>
> I am working on a big cross platform project and on certain platforms I don't
 > need certain submodules. AFAIK there is no way to selectively clone only a
 > subset of the submodules with the standard command line interface. I wonder
> if something like an exclude pattern for submodules would be of general interest.
 > I imagine a call like this after a plain "clone" operation:
>
> git submodule update --init --recursive --exclude 3rdParty/Windows/*

Git already supports that use case: Just set the "submodule.<name>.update"
configuration to "none" for all submodules you aren't interested in and
"git submodule update" will always skip them.

You can also set this config option globally:

git config --global submodule.<name>.update=none

That'll set the default for all repositories of the logged in user on this
computer to not update submodule <name>.

> or even:
>
> git clone --recursive --exclude 3rdParty/Windows/* git://github.com/foo/bar.git

git clone will be influenced by the global setting. If you just want to
skip submodule <name> for a single clone you can do it like this:

   git -c submodule.<name>.update=none clone --recursive git://github.com/foo/bar.git
