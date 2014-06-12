From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH v4 1/4] commit test: Use test_config instead of git-config
Date: Thu, 12 Jun 2014 01:41:52 -0700
Message-ID: <20140612084152.GA6095@hudson.localdomain>
References: <1402511079-17735-1-git-send-email-caleb@calebthompson.io>
 <1402511079-17735-2-git-send-email-caleb@calebthompson.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: caleb@calebthompson.io
X-From: git-owner@vger.kernel.org Thu Jun 12 10:42:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wv0aA-0007i5-JQ
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 10:42:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932814AbaFLIl6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 04:41:58 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:39144 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932501AbaFLIl4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 04:41:56 -0400
Received: by mail-pb0-f48.google.com with SMTP id rr13so770522pbb.21
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 01:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=6Emq+EmYpDHWk1qoE0jyv46Fo6u7lzbnbgVIEuhpf6E=;
        b=x7lJKZNYy72pdFY4LG5Kb/g7lNHJ2jZtSgxs6ht4MJKs5TAgHoJyX1erp0VHpKyPv/
         nnLmwt18ZTM+XbyLzEJx2R1NLgXHheqjGT1VookeFYUELEbwfQgGigzciBugA2pu/gCL
         vQfjQyb+6gbegjTR7xAcibnucEHKPFitP6aPiremDBwP/El11vVtJU1UDxn8o3fNyIfu
         sMkcsrYSJomEP3J73goOIjG+Flk72VAl9INwSNfS2EWiL5Y+GwQXREBpeYVNCT7NXXKR
         DNQfluTr13hedpXcR5kjf/wGlhgDneOsqWAZD9pRKCfQ3UTLL556Fsg5uKDAN4vC4vVh
         b1ag==
X-Received: by 10.66.244.176 with SMTP id xh16mr19434917pac.20.1402562515820;
        Thu, 12 Jun 2014 01:41:55 -0700 (PDT)
Received: from localhost (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id jb5sm37255755pbd.73.2014.06.12.01.41.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jun 2014 01:41:54 -0700 (PDT)
Mail-Followup-To: Jeremiah Mahler <jmmahler@gmail.com>,
	caleb@calebthompson.io, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1402511079-17735-2-git-send-email-caleb@calebthompson.io>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251404>

On Wed, Jun 11, 2014 at 01:24:36PM -0500, caleb@calebthompson.io wrote:
> Some of the tests in t/t7507-commit-verbose.sh were still using
> git-config to set configuration. Change them to use the test_config
> helper.
> 
> Signed-off-by: Caleb Thompson <caleb@calebthompson.io>
> ---
>  t/t7507-commit-verbose.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
> index 2ddf28c..6d778ed 100755
> --- a/t/t7507-commit-verbose.sh
> +++ b/t/t7507-commit-verbose.sh
> @@ -43,7 +43,7 @@ test_expect_success 'verbose diff is stripped out' '
>  '
> 
>  test_expect_success 'verbose diff is stripped out (mnemonicprefix)' '
> -	git config diff.mnemonicprefix true &&
> +	test_config diff.mnemonicprefix true &&
> 	git commit --amend -v &&
> 	check_message message
>  '
> @@ -71,7 +71,7 @@ test_expect_success 'diff in message is retained with -v' '
>  '
> 
>  test_expect_success 'submodule log is stripped out too with -v' '
> -	git config diff.submodule log &&
> +	test_config diff.submodule log &&
> 	git submodule add ./. sub &&
> 	git commit -m "sub added" &&
> 	(
> --
> 2.0.0
> 

It is probably something dumb on my part but for some reason I cannot
apply this patch using 'git am'.  After I save the patch to a Maildir
from Mutt and run git am...

  jeri@hudson:~/git$ ./git-am ct1.patch
  Applying: commit test: Use test_config instead of git-config
  fatal: corrupt patch at line 15
  Patch failed at 0001 commit test: Use test_config instead of git-config
  The copy of the patch that failed is found in:
     /home/jeri/git/.git/rebase-apply/patch
  When you have resolved this problem, run "git am --continue".
  If you prefer to skip this patch, run "git am --skip" instead.
  To restore the original branch and stop patching, run "git am --abort".
  jeri@hudson:~/git$

The second patch in the series applies fine.  And I have applied other
patches this way without issue.  Can anyone confirm this problem?

-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
