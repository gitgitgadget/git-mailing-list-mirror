From: Michael Schubert <mschub@elegosoft.com>
Subject: Re: git alias fails if non-accessible directory is in PATH
Date: Sun, 08 May 2011 18:15:25 +0200
Message-ID: <4DC6C19D.4060704@elegosoft.com>
References: <iq5p6k$73f$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 08 18:15:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ6e8-0007x9-Os
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 18:15:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754956Ab1EHQPf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2011 12:15:35 -0400
Received: from mx0.elegosoft.com ([78.47.87.163]:43994 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754800Ab1EHQPe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 12:15:34 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 19C73DE0D4;
	Sun,  8 May 2011 18:15:31 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oSDzjfj6cmEs; Sun,  8 May 2011 18:15:26 +0200 (CEST)
Received: from [192.168.1.103] (g231229230.adsl.alicedsl.de [92.231.229.230])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 6F0F9DE0C0;
	Sun,  8 May 2011 18:15:26 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110503 Thunderbird/3.1.10
In-Reply-To: <iq5p6k$73f$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173159>


> Is this by design, or a bug? I currently do not see a reason for git stop executing an alias just because it cannot access a directory in PATH. Strangely, I also haven't found any discussion about this on the mailing list yet.

If you look at start_command(), `git br` ends up as execvp call
returning EACCESS in the given case whereas only ENOENT was "expected".
This happens before git tries to resolve the alias.

Could it be a legit assumption that PATH holds only accessible paths?
(POSIX?) Otherwise it's a bug.
