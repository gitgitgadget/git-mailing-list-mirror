From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: automatic submodule deinit (platform specific blacklist)
Date: Thu, 17 Apr 2014 17:45:40 +0200
Message-ID: <534FF724.9060707@web.de>
References: <2348605.ZgCffZToXK@ws-gergap>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Gerhard Gappmeier <gerhard.gappmeier@ascolab.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 17 17:46:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaoVh-0002To-QF
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 17:45:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbaDQPpx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2014 11:45:53 -0400
Received: from mout.web.de ([212.227.17.11]:62967 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751102AbaDQPps (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2014 11:45:48 -0400
Received: from [192.168.178.41] ([79.193.68.183]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0Lz3BE-1X5M2y3Fz6-014E2J; Thu, 17 Apr 2014 17:45:44
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <2348605.ZgCffZToXK@ws-gergap>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:2059VzcYvXD8IGeozaafIjg6cfvFO+ne+OawEvQi/jK7mwoMGBK
 213nUcxOuUptwmgUcsO4sft2zr/h8DMqgABZGWpKZ89oGEfCq+HBf8gxPEPrqMxS1ruLdVb
 iCC4Ln3CMsCEIwqXOxyHjyElVYarcZ3fUvtTqUhGHgFrNDq/YKXg3rfs6J4M1/MAtG3iceS
 B5StryVQkKpl6+PM+Vb0g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246419>

Am 17.04.2014 10:02, schrieb Gerhard Gappmeier:
> Hi all
> 
> in our cross-platform projects we always have a certain Windows-only 
> submodule, which contains all the compatibility stuff and missing libraries for 
> Windows.
> 
> When cloning such a repository on a Linux machine the typical procedure is:
> git clone git@server:project.git
> cd project
> git submodule init
> git submodule deinit path/to/windows-stuff
> git submodule update
> 
> This way you avoid wasting time and disk space to clone stuff that you don't 
> need on Linux (or on whatever non-windows machine your are actually working).
> 
> It would be really cool to add a kind of platform specific submodule blacklist,
> either in .gitconfig or maybe even better in .gitattributes so that we can add 
> this configuration to the repository.
> 
> Example .gitattributes how this could look like:
>   # common stuff
>   *.sh eol=lf
>   *.conf eol=lf
> 
>   # submodule config
>   [src/windows-compat]
>   platforms = win32
> 
> By default the platforms could have the value "all". But one can change it to 
> a list of platform names e.g. "platforms = linux, macosx" or "win32" like in 
> the example above.
> 
> Such a feature would also make it possible to simply use "git clone --
> recursive git@server:project.git" avoiding the single stops as shown above.
> 
> What do your think? Is something like this possible?
> Or is it even possible already somehow?
> 
> Today I'm using a shell script to automate this steps, but this is just a 
> workaround. It would be cool if git itself could do this for us.

What about setting "submodule.<name>.update" to "none" in the config of
your non-Windows machines? Then they would be initialized (= the URL
setting gets copied to .git/config) but never checked out.
