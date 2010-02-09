From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] blame: prevent a segv when -L given start > EOF
Date: Tue, 09 Feb 2010 08:43:43 +0100
Message-ID: <4B71122F.3040809@viscovery.net>
References: <1265687293-11168-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <junio@kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 09 08:43:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeklD-00028f-94
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 08:43:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752544Ab0BIHnq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 02:43:46 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:12335 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241Ab0BIHnq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 02:43:46 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Nekl5-00056U-K9; Tue, 09 Feb 2010 08:43:43 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 585821660F;
	Tue,  9 Feb 2010 08:43:43 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <1265687293-11168-1-git-send-email-jaysoffian@gmail.com>
X-Spam-Score: 1.9 (+)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139380>

Jay Soffian schrieb:
> +test_expect_success 'blame -L with invalid start' '
> +	test_must_fail git blame -L5 tres 2>&1 | grep "has only 2 lines"

Please write this as

	test_must_fail git blame -L5 tres >output 2>&1 &&
	grep "has only 2 lines" output

> +'
> +
> +test_expect_success 'blame -L with invalid end' '
> +	git blame -L1,5 tres 2>&1 | grep "has only 2 lines"

	test_must_fail git blame -L1,5 tres >output 2>&1 &&
	grep "has only 2 lines" output

because shells look only at the exit code of the last command in a pipeline.

-- Hannes
