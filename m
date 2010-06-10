From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: [PATCH next] test-lib: set $DIFF to diff if it is unset
Date: Thu, 10 Jun 2010 12:23:36 -0500
Message-ID: <I5rdmhJblm27JnzIPi7xP5KmntXzA3-wGL-IGXejOPAurGsMke2J3g@cipher.nrlssc.navy.mil>
References: <06ffbe0ca6aac061336f6f595e89f75c09ab88ac.1276162629.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jun 10 19:41:24 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMlkm-0002US-Kr
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 19:41:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759214Ab0FJRlN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jun 2010 13:41:13 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:40565 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752240Ab0FJRlN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jun 2010 13:41:13 -0400
Received: by mail.nrlssc.navy.mil id o5AHNbSY025407; Thu, 10 Jun 2010 12:23:37 -0500
In-Reply-To: <06ffbe0ca6aac061336f6f595e89f75c09ab88ac.1276162629.git.trast@student.ethz.ch>
X-OriginalArrivalTime: 10 Jun 2010 17:23:37.0370 (UTC) FILETIME=[A96267A0:01CB08C1]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148897>

On 06/10/2010 04:39 AM, Thomas Rast wrote:
> Since 7b3bdbb (fixup: do not unconditionally disable "diff -u",
> 2010-05-31), test-lib.sh depends on having $DIFF set in the
> environment for the construction of $GIT_TEST_CMP.  While this works
> when called from the main Makefile, it fails if the tests are called
> on their own and the user does not have $DIFF set.
> 
> Set it to 'diff' if it is unset, like the Makefile does.
> 
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---
> 
> I have an uneasy feeling that I must be missing something, seeing as
> this went unnoticed for 10 days...
> 
>  t/test-lib.sh |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index b23a61d..4d89049 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -78,6 +78,7 @@ export EDITOR
>  
>  if test -z "$GIT_TEST_CMP"
>  then
> +	DIFF=${DIFF:-diff}
>  	if test -n "$GIT_TEST_CMP_USE_COPIED_CONTEXT"
>  	then
>  		GIT_TEST_CMP="$DIFF -c"

I think what should be done instead, is to move this section
down below the line where GIT-BUILD-OPTIONS is sourced.  That
way, the value of $DIFF can be gotten from that file.

I guess GIT_TEST_CMP and GIT_TEST_CMP_USE_COPIED_CONTEXT
should be written into GIT-BUILD-OPTIONS too.

-brandon
