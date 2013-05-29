From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2 4/7] add tests for rebasing root
Date: Wed, 29 May 2013 09:31:27 +0200
Message-ID: <51A5AECF.6070702@viscovery.net>
References: <1347949878-12578-1-git-send-email-martinvonz@gmail.com> <1369809572-24431-1-git-send-email-martinvonz@gmail.com> <1369809572-24431-5-git-send-email-martinvonz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Chris Webb <chris@arachsys.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 09:31:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhar9-0003YY-LQ
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 09:31:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964787Ab3E2Hbb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 03:31:31 -0400
Received: from so.liwest.at ([212.33.55.13]:10820 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935085Ab3E2Hbb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 03:31:31 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Uhar2-0007Sp-Hh; Wed, 29 May 2013 09:31:28 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 4E5B41660F;
	Wed, 29 May 2013 09:31:28 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <1369809572-24431-5-git-send-email-martinvonz@gmail.com>
X-Enigmail-Version: 1.5.1
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225767>

Am 5/29/2013 8:39, schrieb Martin von Zweigbergk:
> +test_run_rebase () {
> +	result=$1
> +	shift
> +	test_expect_$result "rebase $* --onto --root with merge-base does not go to root" "
> +		reset_rebase &&
> +		git rebase $* --onto m --root g &&
> +		test_cmp_rev m HEAD~2 &&
> +		test_linear_range 'c g' m..

Here you check the outcome. There is no explicit check whether the rebase
attempted to replay a and b. But that check is implicit: If a or b were
attempted to replay, the rebase would have been interrupted with "no new
changes". Right?

> +	"
> +}
> +
> +test_run_rebase success ''
> +test_run_rebase success -m
> +test_run_rebase success -i
> +test_run_rebase failure -p

Just curious: Does the last one fail because the result is not correct or
because it does go to the root?

-- Hannes
