From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/4] is_directory(): a generic helper function
Date: Tue, 09 Sep 2008 12:31:39 +0200
Message-ID: <48C6508B.1080600@viscovery.net>
References: <1220948830-3275-1-git-send-email-gitster@pobox.com> <1220948830-3275-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 09 12:32:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kd0Wh-0003c1-NV
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 12:32:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751746AbYIIKbp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 06:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbYIIKbo
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 06:31:44 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:48218 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237AbYIIKbo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 06:31:44 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Kd0VX-0004dl-If; Tue, 09 Sep 2008 12:31:39 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 5357E69F; Tue,  9 Sep 2008 12:31:39 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <1220948830-3275-2-git-send-email-gitster@pobox.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95371>

Junio C Hamano schrieb:
> +/*
> + * Do not use this for inspecting *tracked* content.  When path is a
> + * symlink to a directory, we do not want to say it is a directory.

I though stat(2) checks the thing that a symlink points to. Then either
this comment is not correct or you want to use lstat(2), no?

> + * Worth yet, leading components in path could contain symbolic links.
> + */
> +int is_directory(const char *path)
> +{
> +	struct stat st;
> +	return (!stat(path, &st) && S_ISDIR(st.st_mode));
> +}

-- Hannes
