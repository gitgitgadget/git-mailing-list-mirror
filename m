From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: [Q] `git fetch tag NAME' into mirror repo does not update HEAD,
 what to do?
Date: Thu, 12 Aug 2010 10:33:13 +0200
Message-ID: <4C63B1C9.6050801@dbservice.com>
References: <201008120954.27648.brian.foster@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Brian Foster <brian.foster@innova-card.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 10:33:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjTE5-0002jU-8R
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 10:33:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752879Ab0HLIdU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Aug 2010 04:33:20 -0400
Received: from office.neopsis.com ([78.46.209.98]:58758 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752457Ab0HLIdT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 04:33:19 -0400
X-Spam-Status: No, hits=0.0 required=5.0
	tests=AWL: 0.037,BAYES_00: -1.665,TOTAL_SCORE: -1.628,autolearn=ham
X-Spam-Level: 
Received: from calvin.caurea.org ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits));
	Thu, 12 Aug 2010 10:33:15 +0200
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
In-Reply-To: <201008120954.27648.brian.foster@innova-card.com>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153355>

On 8/12/10 9:54 AM, Brian Foster wrote:
> 
>  Bare repository ORIG's master looks like this:
> 
>    o--o--o--o--v1--o--v2--o--o--o HEAD
> 
>  where v1 and v2 are (annotated) tagged commits.
> 
>  Repository SLAVE is a mirror clone of ORIG which
>  (very deliberately!) lags behind (i.e., its HEAD
>  is one of the earlier (and usually tagged) commits
>  on ORIG).  SLAVE's master was like this:
> 
>    o--o--o--o--v1 HEAD
> 
>  We wanted to update its HEAD to v2, so did:
> 
>    git fetch ORIG tag v2
> 
>  This gave us:
> 
>    o--o--o--o--v1 HEAD
>                  \ 
>                   o--v2
> 
>  It did not update SLAVE's HEAD to v2, which we wanted.
>  This was worked-around by editing refs/heads/master(?)
>  but we don't want to do that again (esp. since we got
>  it wrong the first time (Thank you back-ups!)).

Fetch only fetches commits. It doesn't update any local refs (other than
FETCH_HEAD). If you want to switch HEAD to that new tag, use checkout.

>  Whilst we want to switch to a push from ORIG to SLAVE
>  model, until that happens (there are some IT issues),
>  we are still fetching on SLAVE from ORIG.  Hence, how
>  can we avoid the above issue; that is, what should we
>  have done?  Searching various docs has failed to find
>  any clew or answer.

Is SLAVE a bare repo? If not, please see
https://git.wiki.kernel.org/index.php/GitFaq#non-bare.

tom
