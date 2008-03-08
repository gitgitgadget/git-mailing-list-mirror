From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add test for filter-branch on a subdirectory that's been
 added and deleted and re-added
Date: Sat, 08 Mar 2008 10:41:24 -0800
Message-ID: <7vzlt9t5wr.fsf@gitster.siamese.dyndns.org>
References: <1204977007-7267-3-git-send-email-kevin@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Sat Mar 08 19:42:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JY3zu-0005hM-Fv
	for gcvg-git-2@gmane.org; Sat, 08 Mar 2008 19:42:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754416AbYCHSld (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 13:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754935AbYCHSld
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 13:41:33 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45831 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754416AbYCHSlc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 13:41:32 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 783541603;
	Sat,  8 Mar 2008 13:41:30 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id A96541602; Sat,  8 Mar 2008 13:41:27 -0500 (EST)
In-Reply-To: <1204977007-7267-3-git-send-email-kevin@sb.org> (Kevin Ballard's
 message of "Sat, 8 Mar 2008 06:50:07 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76572>

Kevin Ballard <kevin@sb.org> writes:

> Add a currently-failing test for the case when git-filter-branch
> is run with the --subdirectory-filter referencing a folder that
> has been added, deleted, and re-added. Such an action should work,
> but as this test shows it ends up blowing up.

Such a test is a very good incentive to the people involved in the failing
part of the system to fix, and is greatly appreciated.  However,

 * please mark "currently-failing" test with "test_expect_failure";

 * please hint (after --- lines) if you will shortly be following up with
   a fix patch yourself, or if you are only reporting a bug.

I can fix-up and forge your Sign-off.

> diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
> index 868babc..933157b 100755
> --- a/t/t7003-filter-branch.sh
> +++ b/t/t7003-filter-branch.sh
> @@ -179,4 +179,17 @@ test_expect_success 'Name needing quotes' '
>  
>  '
>  
> +test_expect_success 'Subdirectory filter on folder with non-contiguous history' '
> +	mkdir foo &&
> +	touch foo/bar &&
> +	git add foo &&
> +	git commit -m "Adding foo" &&
> +	git rm -r foo &&
> +	git commit -m "Removing foo" &&
> +	mkdir foo &&
> +	touch foo/bar &&
> +	git commit -m "Re-adding foo" &&
> +	git filter-branch --subdirectory-filter foo
> +'
> +
>  test_done
> -- 
> 1.5.4.3.487.g5a92
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
