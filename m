From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 1/2] Add a test to check that git ls-tree sets non-zero
 exit code on error.
Date: Sat, 23 Jul 2011 20:01:44 +0200
Message-ID: <4E2B0C88.1030906@web.de>
References: <1311424051-29644-1-git-send-email-jon.seymour@gmail.com> <1311424051-29644-2-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 23 20:01:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkgWS-00058O-Bl
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jul 2011 20:01:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753252Ab1GWSBv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jul 2011 14:01:51 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:47763 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753136Ab1GWSBu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2011 14:01:50 -0400
Received: from smtp08.web.de  ( [172.20.5.216])
	by fmmailgate01.web.de (Postfix) with ESMTP id 68E3119444882;
	Sat, 23 Jul 2011 20:01:48 +0200 (CEST)
Received: from [93.246.62.195] (helo=[192.168.178.43])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QkgWK-0001ct-00; Sat, 23 Jul 2011 20:01:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:5.0) Gecko/20110624 Thunderbird/5.0
In-Reply-To: <1311424051-29644-2-git-send-email-jon.seymour@gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+KiiVvWG4LIRhiS5Mjjv7tQFc7yrda2gvPIjpA
	B7r15RszVc1GEFx+LLolC6lTMZTHKO8Xx66EyRH08D+mzpgts0
	4l/vrT1MtXAAkvxFAd9Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177698>

Am 23.07.2011 14:27, schrieb Jon Seymour:
> Fails at this commit, fixed by subsequent commit.

Maybe use "test_expect_failure" here and change that to "test_expect_success"
in the next commit?

> Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
> ---
>  t/t3103-ls-tree-missing-tree.sh |   19 +++++++++++++++++++
>  1 files changed, 19 insertions(+), 0 deletions(-)
>  create mode 100755 t/t3103-ls-tree-missing-tree.sh
> 
> diff --git a/t/t3103-ls-tree-missing-tree.sh b/t/t3103-ls-tree-missing-tree.sh
> new file mode 100755
> index 0000000..365ac07
> --- /dev/null
> +++ b/t/t3103-ls-tree-missing-tree.sh
> @@ -0,0 +1,19 @@
> +#!/bin/sh
> +
> +test_description='ls-tree exits with non-zero status if it also reports an error'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +	mkdir a &&
> +	touch a/one &&
> +	git add a/one &&
> +	git commit -m test
> +'
> +
> +test_expect_success 'ls-tree fails with non-zero exit code on broken tree' '
> +	rm -f .git/objects/5f/cffbd6e4c5c5b8d81f5e9314b20e338e3ffff5 &&
> +	test_must_fail git ls-tree -r HEAD
> +'
> +
> +test_done
