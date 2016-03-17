From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rebase -x: do not die without -i
Date: Thu, 17 Mar 2016 07:48:43 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603170745300.4690@virtualbox>
References: <1458177584-11378-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org,
	Matthieu.Moy@grenoble-inp.fr, j6t@kdbg.org,
	Lucien.Kong@ensimag.imag.fr
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 07:49:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agRjw-0001kA-69
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 07:49:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753004AbcCQGs4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 02:48:56 -0400
Received: from mout.gmx.net ([212.227.15.18]:50223 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752042AbcCQGsz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 02:48:55 -0400
Received: from virtualbox ([37.24.143.87]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LfCX2-1a0oT62vSS-00omDG; Thu, 17 Mar 2016 07:48:44
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <1458177584-11378-1-git-send-email-sbeller@google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:bE/otCyCHflafgZMu4pqC9+b5PSnN505o8etDyuDHm388jm5PUP
 /vvwZ9ion4M+cxlGCUUvWY217Fe03r4SgUSz4mh+5h+gZAlE6eYG0gnq01SKs7ClRZmfnyk
 cMe3ZPJT1xrdHv2OPBI/TQHNl30rU3+I974l8GFXRczYYqpeWGd38A7hary/LR1Ueb5AW3M
 PhjzJTvO8+sjBN21nS6KQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fwrTi/AACMk=:NlUKZydqba+Lqifk24//F4
 /1wlACClq9Pdxwi5QCeZ+kWBTCQIhqDZlinezzG8InonhlTwKKsmB/ZvPCX9+jpqxjmCKTDJc
 eLuMN2gejEfeFev1Ha9r+gw5vWTHlniN5UZtUMs0VCqj9P4BRbcM3baUDi+mh17dJQyLkEcsN
 EZv2el0KDRvUfneqefWdEKG0L/HDFguZqcvzhQH5JsB3aNvxL7GmiinMiGVD7ERFzpWhdBRwJ
 uAq+WwYV+Y1eEB1uQt92tO754KUEocPlBYgzwcv6rTRMYjOzv4speG80eNznf8Y3VmELVX+p4
 GiAgvju2kTDDq0hlFzZk4/E4YRXVtmIYzTfnVpgO7COtqQ4n39ufFe4VDnHolntRWxOZ4ZesV
 7c4umiEildH6DX02grLgjhylBu0o6jU8woMT7zhpDqOb0tDfzI8qiHggKrgQJTelNwvIWziB3
 sSN1uPbsbKfcMNo5UL4IWYxHPX6Xlz3gR879H/L3VkZwPZv+Afr+lgNQH6ZmL7xPNxmXHsLGG
 q2pSXDJJeLfSO84rn0kOF0dfkgV5C5syD9wsFoa3NFlIzSlkJhXtO8p6wdTl+/omHpkEitY7K
 9ZDz1p8cvE4cB8my5qEMS1QP6wpUBXb2Hlicd258W6Yhr4hXnROrM00/JrRDeZa1Ov+L7CNiS
 AXcVR/jVP9zPFxtwaNLvaZiQz1euifmVpi0ifb6qwhLbuzqPVb/HOTF/fTcEf2EzU3ommHyA4
 /7w0Xx3GIcsJsT9Bd/+nhkCUkA+gbCGIHNQz0cPKdbBtvZ4qz7uWGaf+1YIhrV1giwZtS1bd 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289078>

Hi Stefan,

On Wed, 16 Mar 2016, Stefan Beller wrote:

> In the later steps of preparing a patch series I do not want to edit the
> patches any more, but just make sure the test suite passes after each
> patch. Currently I would run
> 
>   EDITOR=true git rebase -i <anchor> -x "make test"
> 
> In an ideal world the command would be simpler and just be
> 
>   git rebase <anchor> -x "make test"
> 
> to run the test for each commit I am about to send out for review.
> This patch enables the short line.

Makes sense.

> While at it, remove the double empty lines in t3404.

Could you split those out? They may interfere with some of my work, and
it's easier to figure things out from a trivial patch than from one
combining unrelated changes.

> -test_expect_success 'rebase --exec without -i shows error message' '
> +test_expect_success 'rebase --exec works without -i ' '
>  	git reset --hard execute &&
> -	set_fake_editor &&
> -	test_must_fail git rebase --exec "git show HEAD" HEAD~2 2>actual &&
> -	echo "The --exec option must be used with the --interactive option" >expected &&
> -	test_i18ncmp expected actual
> +	git rebase --exec true HEAD~2 2>actual2 >actual1 &&

How about '--exec "touch executed"'? You'd want to verify that the command
really was executed...

Ciao,
Dscho
