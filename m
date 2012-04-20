From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: git clone submodules recursive and reference
Date: Fri, 20 Apr 2012 20:59:54 +0200
Message-ID: <4F91B22A.9000507@web.de>
References: <CAFj+z055ZZc-Am+pEMgjRvHgoxKSRBjnHhABCseC45+8YswKWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Samuel Maftoul <samuel.maftoul@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 20 21:00:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLJ3y-0005bi-VM
	for gcvg-git-2@plane.gmane.org; Fri, 20 Apr 2012 21:00:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757464Ab2DTTAE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Apr 2012 15:00:04 -0400
Received: from fmmailgate06.web.de ([217.72.192.247]:46171 "EHLO
	fmmailgate06.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755073Ab2DTTAD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2012 15:00:03 -0400
Received: from moweb001.kundenserver.de (moweb001.kundenserver.de [172.19.20.114])
	by fmmailgate06.web.de (Postfix) with ESMTP id 6E2A91292BAD
	for <git@vger.kernel.org>; Fri, 20 Apr 2012 20:59:57 +0200 (CEST)
Received: from [192.168.178.48] ([91.3.168.131]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0MSav6-1SmqM445lE-00Rcq2; Fri, 20 Apr 2012 20:59:57
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <CAFj+z055ZZc-Am+pEMgjRvHgoxKSRBjnHhABCseC45+8YswKWg@mail.gmail.com>
X-Provags-ID: V02:K0:cAl92sW6L9WVx+Ujl6MDRYjX9fxrTMMMtghIsHmhEcB
 bpNzAuIfGWBDJq5VlPJoUmTwv3y2ZOIlwcr+CC4mVO5saigNKe
 kLDweQxUxS9jkxtt5hC974zAZmJIcfRQkOTJXcnD9N8S7mar31
 NAY66p43dZzcMdjGYeK5CHt312CAV8uV2xuqiR9UwWXA5sU194
 hw0ODzUARBOjw+qpCXGCg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196011>

Am 20.04.2012 17:12, schrieb Samuel Maftoul:
> Hello,
> 
> I'm using git clone --reference, it works like a charm !
> 
> Now, I have submodules, so I call git clone with both --recursive and
> --reference, works only for the repo itself, submodules are being
> cloned without the "--reference" option.
> 
> With GIT_TRACE=1 I can see this for the initial repo:
> 
> trace: built-in: git 'clone' '--recursive' '--reference' [...]
> 
> And this for the submodules:
> 
> trace: built-in: git 'clone' '-n' [...]
> 
> for every submodules.
> 
> Is this an intended behavior ?

Hmm, to me it looks like passing the --reference option to the clone
run in the submodules doesn't make much sense, as that would make
all submodules and the superproject use the same alternates. And as
far as I know sharing objects between different repositories is not
supported.

> How can I force the clones for submodules to be executed with the
> --reference option ?

You'd have to use "git clone" without the --recursive option and
then do a "git submodule update --init --reference ...".
