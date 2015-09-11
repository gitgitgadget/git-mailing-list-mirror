From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: git submodule ignores --git-dir
Date: Fri, 11 Sep 2015 17:15:52 +0200
Message-ID: <55F2F028.7070505@web.de>
References: <55F1E2AB.3020507@monetas.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Filip Gospodinov <filip.gospodinov@monetas.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 11 17:16:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZaQ3Z-0004jn-MB
	for gcvg-git-2@plane.gmane.org; Fri, 11 Sep 2015 17:16:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752796AbbIKPQB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2015 11:16:01 -0400
Received: from mout.web.de ([212.227.15.3]:56986 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752073AbbIKPP7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2015 11:15:59 -0400
Received: from [192.168.178.41] ([79.211.114.8]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0McWbQ-1ZIkg90nMe-00HhcX; Fri, 11 Sep 2015 17:15:57
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
In-Reply-To: <55F1E2AB.3020507@monetas.net>
X-Provags-ID: V03:K0:PhH+k0+C0svAEOvZuF8GHaqAivMVD9BY7PJGbi+OPkK/+ZoXs2j
 H2DUMK0pgH3puHv18EQLnJnbDfEX5i+UI8CZkT7jxAcxQ+tAGHvoovp9EkhvrdCUkazp3ob
 rtlpRQ9O3tWZL3KikXx2V7hxQwnLEoT5+jk8seBglNGfemwMwaRieJ4nDBOFV2dGFOyKDLn
 9A8IiqOnzXHkNbW2MhTKw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UwXOTXYIUPg=:0OusChSLUXFRW9RpKn2zA2
 ACtIUi0EqnrBNwstfkFAZkzuXKg4f1L8steLWBJpWBcci6QFyYzn3/ktsHat2rAiVoLz29NKL
 Yri3D1p/46VRfhizsIlnsdG5c2QRCmjHgSEsCxvCLxuRM7XazJha0yFILghu/tWIwkKWdacih
 CLslYGMfpvXuQ8OVjzjo8WxrEr8pvdzrx81Qa4az3MHoycM/d0vUK7CSemPhmHMjvfGvAaXFs
 mb3l/mpCQxDZXPuIVIbV7baAwmhLlRhnF0VA+CJOiFc5zZJaJfDGmr7CQot3O37zsCFbzkZ0e
 lmi150hiwkyd9p35nvILeemlkiUcQZwOfjMJNk2uHRDN+fTADIwTZzFkCKwGBfO16/wNZl/Bp
 dIObgvZgGLZgHKO/IdGmQAS70+6iZ79nPWQ2m34+stRPS8nXAU3LBNWSaNJ0puEy9S19/QKgN
 JSmzaXrsQ6EhVy3ao/7RYaXQApE3ZQ+kuDABA09EUKvyfnlKE9ivWc8EJZE4n9ESsz9zN/svN
 z/wO18MRbDNTlTfrC5DSBT8E6sZEtNGw/8hTZvYSaM3G5j8ZvyxeP9cIdEZr0KmMtEFY+lb3N
 pmMgl1EopUIkIvALYXT6JhnvT3NmO7DhuIBO8tZnK38XQIbwQwEsblLQACXyfpa42xIscQb4D
 /fvtRClo9zif9fVcNEhYI7GjOjAEU/0fs87UpaVq52GjBM1po8mSk5yefXoh2VQRZI3lTu6IY
 caXQ5U9SIQRxUpLI/V+pVDSqefBoQy/DQb4rsA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277668>

Am 10.09.2015 um 22:06 schrieb Filip Gospodinov:
> Hi!
>
> I use the `--git-dir` flag in some scripts such that I don't need to `cd` back
> and forth. Recently, I've discovered that `--git-dir` does not seem to work
> correctly for `git submodule`. Here is a short snippet to reproduce that behavior:
>
> mkdir repo1 subm
> (cd subm; git init; git commit -m 1 --allow-empty)
> (cd repo1; git init; git submodule add ../subm subm; git commit -m "add subm")
> git clone repo1 repo2
> git --git-dir=$PWD/repo2/.git submodule update --init
>
>
> which errors with the following output:
>
> No submodule mapping found in .gitmodules for path 'subm'
>
> But this works:
> cd repo2; git --git-dir=$PWD/.git submodule update --init

Thanks for your report containing a nice recipe to reproduce your issue!

> I know that for this particular use case I can just use `git clone --recursive`
> and that other use cases can be worked around by using `cd`. Still, I wonder if
> the behavior I discovered is a bug or if it's expected.

I don't think this is a bug. The git submodule command needs a work tree
to read the .gitmodules file from, that's while it fails when using
--git-dir from outside the work tree. But I admit that the error message
"No submodule mapping found in .gitmodules for path ..." could be improved
to clearly state that the .gitmodules file wasn't found.

Unfortunately trying to show git the right work tree:

$ git --git-dir=$PWD/repo2/.git --work-tree=$PWD/repo2 submodule update --init

Didn't work as I expected it to either:

fatal: /home/Sledge/libexec/git-core/git-submodule cannot be used without a working tree.

So you'll have to cd into the repo for now.
