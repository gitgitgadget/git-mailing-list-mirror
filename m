From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Tip: avoiding net overhead using git over sshfs
Date: Thu, 23 Oct 2008 14:54:16 +0200
Message-ID: <490073F8.6080509@viscovery.net>
References: <a2075f4c0810221826w511a3b87r6fea4fb0dee24e1f@mail.gmail.com>	 <490036A2.20608@drmicha.warpmail.net> <a2075f4c0810230451lefff6ffnc283f4078eff9f9c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Felipe Carvalho Oliveira <felipekde@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 23 14:55:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ksziv-00085M-0X
	for gcvg-git-2@gmane.org; Thu, 23 Oct 2008 14:55:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756277AbYJWMyW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2008 08:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756266AbYJWMyW
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Oct 2008 08:54:22 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:3836 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756237AbYJWMyV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2008 08:54:21 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Kt1Zj-0005NU-T1; Thu, 23 Oct 2008 16:54:12 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id CFAE9AFCC; Thu, 23 Oct 2008 14:54:16 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <a2075f4c0810230451lefff6ffnc283f4078eff9f9c@mail.gmail.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98958>

Felipe Carvalho Oliveira schrieb:
> On Thu, Oct 23, 2008 at 7:00 AM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
>> I think you'd better work locally, and push to the sshfs directory
>> from time to time. Then, you'd both have working tree and .git locally
>> and fast, while keeping the safety of replicating to your ssh server.
> 
> I can't use git-push as I explained before.
> I use git as a deployment tool in this case.
> I work locallly and use git-pull to sync my local repo and the
> "production"(server).
> Git works better than a manual (S)FTP sync.

Then how about this: You keep your repository local, and you also hack
locally. When it's time to push your changes to the production server, you
do this:

  $ GIT_INDEX_FILE=.git/index.published \
    GIT_WORK_TREE=/sshfs-mount/on/production/server \
    git reset --hard

This will update only files that changed since you did this the last time.

Disclaimer: I didn't try this myself.

-- Hannes
