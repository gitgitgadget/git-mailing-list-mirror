From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Proposal for git stash : add --staged option
Date: Wed, 22 Apr 2015 11:25:41 +0200
Organization: gmx
Message-ID: <0082a449b4d1723cb557ac353a04c3af@www.dscho.org>
References: <96c00a316c79d9e5a85e199ba7d6f317@netapsys.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: edgar.hipp@netapsys.fr
X-From: git-owner@vger.kernel.org Wed Apr 22 11:26:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ykqup-0003cF-M3
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 11:25:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbbDVJZs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 05:25:48 -0400
Received: from mout.gmx.net ([212.227.15.19]:53082 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964793AbbDVJZp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2015 05:25:45 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LnOve-1ZGLyS0naY-00hghB; Wed, 22 Apr 2015 11:25:42
 +0200
In-Reply-To: <96c00a316c79d9e5a85e199ba7d6f317@netapsys.fr>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:UB8by8p5Jkh2Xeegg6vrsqftz8EgLS3lYLXCuhHO0OYGf/YhNk8
 Of0J34BBqJiD3redMf0TWtyoURa8DwEKksNs4oTPHawzZKezKcZjVY+Tps8or6zZA43KSu7
 ZcVjklLxFVr2vcz3Ei1NVXzyNZVErRVqPlfDjVV1aQhLGan1CYOowSO3JAXqgI/yxIrG9hw
 7SGeeBXzawhJ0zPf/C7uQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267583>

Hi Edgar,

On 2015-04-22 10:30, edgar.hipp@netapsys.fr wrote:

> When you have a lot of unstaged files, and would like to test what
> happens if you undo some of the changes that you think are unecessary,
> you would rather keep a copy of those changes somewhere.
> 
> For example
> 
> Changed but not updated:
>     M config_test.xml
>     M config_real.xml
> 
> I have changed both config_test.xml and config_real.xml, but I think
> the changes made in config_test.xml are unnecessary. However, I would
> still like to keep them somewhere in case it breaks something.
> 
> In this case for example, I would like to be able to stash only the
> file config_test.xml
> 
> Eg:
> 
> git add config_test.xml
> git stash --staged
> 
> So that after this, my git looks like this:
> 
> Changed but not updated:
>     M config_real.xml
> 
> and my stash contains only the changes introduced in config_test.xml
> 
> `git stash --keep-index` doesn't give the necessary control, because
> it will still stash everything (and create unnecessary merge
> complications if I change the files and apply the stash)

I often have the same problem. How about doing this:

```sh
git add config_real.xml
git stash -k
git reset
```

The difference between our approaches is that I keep thinking of the staging area as the place to put changes I want to *keep*, not that I want to forget for a moment.

Having said that, I am sympathetic to your cause, although I would rather have `git stash [--patch] -- [<file>...]` that would be used like `git add -p` except that the selected changes are *not* staged, but stashed instead.

Ciao,
Johannes
