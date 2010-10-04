From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: branch versioning
Date: Mon, 04 Oct 2010 16:33:38 +0200
Message-ID: <4CA9E5C2.9040406@dbservice.com>
References: <AANLkTimWxPPi_hHuato+hHePaEja=66GzLEpDUVcZV0i@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 16:33:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2m6v-0001bt-1r
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 16:33:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755921Ab0JDOdm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 10:33:42 -0400
Received: from office.neopsis.com ([78.46.209.98]:44778 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752532Ab0JDOdm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 10:33:42 -0400
X-Spam-Status: No, hits=0.0 required=5.0
	tests=AWL: 0.017,BAYES_00: -1.665,TOTAL_SCORE: -1.648,autolearn=ham
X-Spam-Level: 
Received: from calvin.caurea.org ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits));
	Mon, 4 Oct 2010 16:33:39 +0200
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
In-Reply-To: <AANLkTimWxPPi_hHuato+hHePaEja=66GzLEpDUVcZV0i@mail.gmail.com>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158056>

On 10/4/10 3:18 PM, Nguyen Thai Ngoc Duy wrote:
> Hi,
> 
> How do you guys manage versions of a topic branch? I usually end up
> saving format-patch series somewhere or forget all old versions.
> Although I really want to keep old versions around. reflog to me   is
> polluted with every kind of branch updates. And it's local
> information. It can't be transferred to another repo (or can it?)
> 
> On the same subject, I have quite a few old topic branches that I
> rarely touch. I don't want to remove them. I just want to hide them
> away from "git branch". I've been thinking of "attic/" namespace that
> "git branch" by default will not show. Just wondering if other people
> face the same problem..

There was a blog post from someone suggesting how to extend rebase to
track the old and new commits so the old ones don't get lost (sadly I
can't find the blog post anymore). The idea was to add the old commit as
the second parent to the newly rebased commits. This way you can track
the evolution of commits across multiple iterations. You could do the
same with topic branches: after you create the new version of the topic
branch, add the old topic branch as the second parent of the new branch
head (use merge -s ours to discard changes made by the old topic
branch). And to submit the commits in a topic branch for review you'd
use --first-parent.

tom
