From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t9301-fast-export.sh: don't unset config variable while
 we're skipping test 4
Date: Mon, 18 Aug 2008 17:32:45 -0700
Message-ID: <7vtzdhkfo2.fsf@gitster.siamese.dyndns.org>
References: <giNXZFTxzY3B65dQob7CwvwwfSKlZpw_60oz81RxU5UN3PsTT_3dMQ@cipher.nrlssc.navy.mil> <kbCw6MBjduXNz0eWrsdfGIVr60qjr7cf1eJqhd4l-UzDfHEk1LrlkA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Aug 19 02:34:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVFAg-0000ux-LH
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 02:34:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752933AbYHSAcw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 20:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754500AbYHSAcw
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 20:32:52 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34690 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752933AbYHSAcv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 20:32:51 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AF06C53CCE;
	Mon, 18 Aug 2008 20:32:49 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2099253CCD; Mon, 18 Aug 2008 20:32:46 -0400 (EDT)
In-Reply-To: <kbCw6MBjduXNz0eWrsdfGIVr60qjr7cf1eJqhd4l-UzDfHEk1LrlkA@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Mon, 18 Aug 2008 18:20:12 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5A2ED1AA-6D86-11DD-B679-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92795>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> ---
>
>
> This is necessary if t9301.4 is included in the GIT_SKIP_TESTS
> environment variable.

If it is not skipped what happens?  Does your change break this test?

How about attempting to unset always (because the test does not want to
have the configuration) but ignore the result from the command (because
the config may not have had anything to unset to begin with depending on
what happened in the previous tests)?

>  t/t9301-fast-export.sh |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/t/t9301-fast-export.sh b/t/t9301-fast-export.sh
> index c19b4a2..475aadd 100755
> --- a/t/t9301-fast-export.sh
> +++ b/t/t9301-fast-export.sh
> @@ -190,7 +190,6 @@ export GIT_COMMITTER_NAME='C O Mitter'
>  
>  test_expect_success 'setup copies' '
>  
> -	git config --unset i18n.commitencoding &&
>  	git checkout -b copy rein &&
>  	git mv file file3 &&
>  	git commit -m move1 &&
> -- 
> 1.6.0.13.ge1c8
