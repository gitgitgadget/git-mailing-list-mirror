From: Sylvain Joyeux <sylvain.joyeux@dfki.de>
Subject: Re: [PATCH] fix "git-submodule add a/b/c/repository"
Date: Mon, 7 Jul 2008 08:34:25 +0200
Message-ID: <20080707063424.GB5506@jhaampe.org>
References: <20080701150025.GD5852@joyeux> <7vd4lro7ct.fsf@gitster.siamese.dyndns.org> <20080706161101.GB23385@jhaampe.org> <48711782.6090609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
	Ping Yin <pkufranky@gmail.com>, git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 08:35:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFkJq-0003DE-8w
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 08:35:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751640AbYGGGe2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 02:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751530AbYGGGe2
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 02:34:28 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:32802 "EHLO
	mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779AbYGGGe2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 02:34:28 -0400
Received: from jhaampe.org (p5B3CCD36.dip.t-dialin.net [91.60.205.54])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by ssl.polytechnique.org (Postfix) with ESMTP id 7953933170;
	Mon,  7 Jul 2008 08:34:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48711782.6090609@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-AV-Checked: ClamAV using ClamSMTP at djali.polytechnique.org (Mon Jul  7 08:34:26 2008 +0200 (CEST))
X-Spam-Flag: No, tests=bogofilter, spamicity=0.009054, queueID=5D8DE33171
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87586>

On Sun, Jul 06, 2008 at 03:05:38PM -0400, Mark Levedahl wrote:
> Sylvain Joyeux wrote:
>>  	git submodule add init dir0/dir1/init
>>     Would clone dir0/dir1/init at ./init and add ./init as a submodule. 
>> This is
>> actually what the current git-submodule (wrongly) does.
>>
>> Sylvain
>>   
> ...after some prep work...
>
> >git submodule add init dir0/dir1/init
> Adding existing repo at 'dir0/dir1/init' to the index
>
> So, what's the problem?

Redo the prep work, the clone and now

git submodule add dir0/dir1/init

(i.e. don't expect dir0/dir1/init to be the clone of ./init, that was just a
shortcut for the test. Expect it to be a clone of "something, somewhere")

[~/tmp/test]% git-submodule add dir0/dir1/init
Initialize init/.git
Initialized empty Git repository in /home/doudou/tmp/test/init/.git/

[~/tmp/test]% git status
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       modified:   .gitmodules
#       new file:   init
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       dir0/

What it is supposed to do (according to the documentation) is register
dir0/dir1/init as the submodule, not clone it and register init/.

Sylvain
