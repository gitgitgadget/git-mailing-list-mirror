From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] Do _not_ call unlink on a directory
Date: Mon, 16 Jul 2007 19:18:51 +0200
Message-ID: <vpqd4yss1vo.fsf@bauges.imag.fr>
References: <11846059721204-git-send-email-sithglan@stud.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
X-From: git-owner@vger.kernel.org Mon Jul 16 19:21:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAUGY-0005U7-Hz
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 19:21:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755171AbXGPRVo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 13:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754582AbXGPRVo
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 13:21:44 -0400
Received: from imag.imag.fr ([129.88.30.1]:56356 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752571AbXGPRVn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 13:21:43 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l6GHIpwA009318
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 16 Jul 2007 19:18:51 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IAUDj-00030i-Id; Mon, 16 Jul 2007 19:18:51 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IAUDj-0000TJ-G7; Mon, 16 Jul 2007 19:18:51 +0200
Mail-Followup-To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>, git@vger.kernel.org,  gitster@pobox.com
In-Reply-To: <11846059721204-git-send-email-sithglan@stud.uni-erlangen.de> (Thomas Glanzmann's message of "Mon\, 16 Jul 2007 19\:12\:52 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 16 Jul 2007 19:18:52 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52693>

Thomas Glanzmann <sithglan@stud.uni-erlangen.de> writes:

I believe you still have a race condition if ...

> -				if (len > state->base_dir_len && state->force && !unlink(buf) && !mkdir(buf, 0777))
> -					continue;

... buf exists here as a file ...

>  				if (!stat(buf, &st) && S_ISDIR(st.st_mode))
>  					continue; /* ok */

... and became a directory here.

> +				if (len > state->base_dir_len && state->force && !unlink(buf) && !mkdir(buf, 0777))
> +					continue;

But that's quite unlikely to happen. And I have no fix to propose.

-- 
Matthieu
