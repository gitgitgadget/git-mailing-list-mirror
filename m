From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Fix output of "git log --graph --boundary"
Date: Sun, 25 May 2008 12:20:58 -0700
Message-ID: <7vfxs6i411.fsf@gitster.siamese.dyndns.org>
References: <1211670125-10215-1-git-send-email-adam@adamsimpkins.net>
 <1211670125-10215-2-git-send-email-adam@adamsimpkins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adam Simpkins <adam@adamsimpkins.net>
X-From: git-owner@vger.kernel.org Sun May 25 21:22:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0Ln9-0002ld-AV
	for gcvg-git-2@gmane.org; Sun, 25 May 2008 21:22:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757056AbYEYTVM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 May 2008 15:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756814AbYEYTVM
	(ORCPT <rfc822;git-outgoing>); Sun, 25 May 2008 15:21:12 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48793 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756789AbYEYTVL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 May 2008 15:21:11 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DEC9F4E60;
	Sun, 25 May 2008 15:21:09 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 337AB4E2D; Sun, 25 May 2008 15:21:06 -0400 (EDT)
In-Reply-To: <1211670125-10215-2-git-send-email-adam@adamsimpkins.net> (Adam
 Simpkins's message of "Sat, 24 May 2008 16:02:04 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BB1E50A6-2A8F-11DD-8D93-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82875>

Adam Simpkins <adam@adamsimpkins.net> writes:

> diff --git a/revision.c b/revision.c
> index 1341f3d..181fb0b 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1697,7 +1697,7 @@ static struct commit *get_revision_internal(struct rev_info *revs)
>  		 * switch to boundary commits output mode.
>  		 */
>  		revs->boundary = 2;
> -		return get_revision(revs);
> +		return get_revision_internal(revs);
>  	}
>  
>  	/*

This hunk first got me worried, but this is a simple bugfix to 7fefda5
(log and rev-list: add --graph option, 2008-05-04) and does not break
callers without --graph option.

Looks good, thanks.
