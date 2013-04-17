From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Splitting a commit with rebase -i and keeping a commit message
Date: Wed, 17 Apr 2013 07:55:41 +0200
Message-ID: <516E395D.3050307@viscovery.net>
References: <20130416203825.3701d98b@bigbox.christie.dr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tim Chase <git@tim.thechases.com>
X-From: git-owner@vger.kernel.org Wed Apr 17 07:55:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USLLU-0003Fs-44
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 07:55:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757778Ab3DQFzs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 01:55:48 -0400
Received: from so.liwest.at ([212.33.55.14]:26860 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754259Ab3DQFzr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 01:55:47 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1USLLK-00015d-Mq; Wed, 17 Apr 2013 07:55:42 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 5A7F41660F;
	Wed, 17 Apr 2013 07:55:42 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <20130416203825.3701d98b@bigbox.christie.dr>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221511>

Am 4/17/2013 3:38, schrieb Tim Chase:
> I asked this on IRC and played with some of their ideas, but struck
> out with anything satisfying.  I walked through [1] with the
> following setup:
> 
>   git init foo
>   cd foo
>   touch a.txt b.txt
>   git add a.txt b.txt
>   git commit -m "Initial checkin"
>   echo "Modify A" >> a.txt
>   git commit -am "Modified A"
>   echo "Modify B" >> b.txt
>   git commit -am "Modified B"
>   echo "Modify A2" >> a.txt
>   echo "Modify B2" >> b.txt
>   git commit -am "Modified B"
>   git commit -am "Long-bodied commit comment about b.txt changes"
>   # whoops, just wanted B
>   git rebase -i HEAD^^
>   # change the "Added b.txt..." commit to "edit"

    # and duplicate the instruction line
    git checkout HEAD^ b.txt # undo b.txt
    git commit --amend -m "Tweaked a.txt"
    git rebase --continue
    # in real world cases, you are likely to see conflicts here
    # when the commit is applied a second time,
    # but not in this toy example
    git rebase --continue

-- Hannes
