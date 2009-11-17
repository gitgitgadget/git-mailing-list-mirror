From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/2] replace: use a GIT_NO_REPLACE_OBJECTS env variable
Date: Tue, 17 Nov 2009 08:42:18 +0100
Message-ID: <4B0253DA.1090003@viscovery.net>
References: <20091117051125.3588.91072.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jakub Narebski <jnareb@gmail.com>,
	bill lam <cbill.lam@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Paul Mackerras <paulus@samba.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Nov 17 08:42:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAIhv-0005lU-A5
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 08:42:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755873AbZKQHmT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2009 02:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755420AbZKQHmT
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 02:42:19 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:15693 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755272AbZKQHmS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2009 02:42:18 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NAIhf-00030U-34; Tue, 17 Nov 2009 08:42:19 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id C3F6010541; Tue, 17 Nov 2009 08:42:18 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <20091117051125.3588.91072.chriscool@tuxfamily.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133073>

Christian Couder schrieb:
> diff --git a/git.c b/git.c
> index bd2c5fe..7f7d73d 100644
> --- a/git.c
> +++ b/git.c
> @@ -89,6 +89,9 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
>  				*envchanged = 1;
>  		} else if (!strcmp(cmd, "--no-replace-objects")) {
>  			read_replace_refs = 0;
> +			setenv(NO_REPLACE_OBJECTS_ENVIRONMENT, "", 1);

It is safer to set to a non-empty string, e.g., "1".

I think this variable should be added to the list in connect.c around line
630 so that it does not propagate to the remote end.

-- Hannes
