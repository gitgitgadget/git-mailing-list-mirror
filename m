From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] bash-completion: fix getting strategy list
Date: Tue, 19 Aug 2008 16:50:35 +0200
Message-ID: <48AADDBB.1080203@viscovery.net>
References: <fcaeb9bf0808190527q60869fd0uccbfd165431a752d@mail.gmail.com> <20080819132803.GA26201@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 16:51:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVSYh-0000SO-2Y
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 16:51:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753129AbYHSOuj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 10:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753053AbYHSOui
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 10:50:38 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:12232 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752700AbYHSOui (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 10:50:38 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KVSXc-0004wA-3r; Tue, 19 Aug 2008 16:50:36 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id DCDA24FB; Tue, 19 Aug 2008 16:50:35 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080819132803.GA26201@laptop>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92869>

Nguyen Thai Ngoc Duy schrieb:
> +--show-strategies::
> +	Show all available strategies. For internal use only.
> +

IMO, you don't need to declare this option as internal; offering it for
the public is fine...

> +	/* needed for git bash completion and similar tools */

... which would make this comment slightly odd.

> +	if (argc == 2 && !strcmp(argv[1], "--show-strategies")) {
> +		for (i = 0; i < ARRAY_SIZE(all_strategy); i++)
> +			printf("%s\n", all_strategy[i].name);
> +		return 0;

Improved error checking, but quick and dirty:

+	if (!strcmp(argv[1], "--show-strategies")) {
+		for (i = 0; i < ARRAY_SIZE(all_strategy); i++)
+			printf("%s\n", all_strategy[i].name);
+		return argc == 2 ? 0 :
+			 error("--show-strategies does not take "
+				"any arguments");

> +	$(git --exec-path)/git-merge --show-strategies

+	git merge --show-strategies

-- Hannes
