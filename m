From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: any way to apply tag across all branches in repository?
Date: Tue, 19 May 2009 18:52:20 +0200
Message-ID: <F3E3C849-76E1-4D5F-8305-276C4C205250@dbservice.com>
References: <4A12DDB9.60608@nortel.com>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Chris Friesen" <cfriesen@nortel.com>
X-From: git-owner@vger.kernel.org Tue May 19 18:53:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6SYk-0008Fx-Fb
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 18:52:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754110AbZESQwt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 12:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754075AbZESQws
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 12:52:48 -0400
Received: from office.neopsis.com ([78.46.209.98]:36300 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753707AbZESQws (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 12:52:48 -0400
Received: from calvin.emmen.dbservice.com ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES128-SHA (128 bits));
	Tue, 19 May 2009 18:52:46 +0200
In-Reply-To: <4A12DDB9.60608@nortel.com>
X-Mailer: Apple Mail (2.935.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119549>


On May 19, 2009, at 6:26 PM, Chris Friesen wrote:

>
> Hi all,
>
> I'm hoping you can help me out...please CC me on replies, I'm not
> subscribed to the list.
>
> We have a piece of software with a "main" branch and multiple
> architecture-specific "target" branches.  At each "official" compile,
> we'd like to tag the commits that went into that compile with an  
> identifier.
>
> Using tags normally requires that the tag be assigned to each branch
> individually--is there any way to apply some sort of designator to the
> head of each branch in the repository all at once rather than doing it
> separately for each branch?

Tags are not specific to any branch in particular. Usually you tag  
commits, and git doesn't care on which branch these commits are. That  
information is not recorded in the tag.

What you can do is create an alias that iterates over all branches and  
tags each one.

git for-each-ref refs/heads/main refs/heads/arch/ | while read sha  
type ref; do
     git tag TAGNAME $sha -m "Tagged $ref"
done

$sha is the sha where the ref points to, $type will be 'commit' and  
$ref is the full ref (refs/heads/arch/xxx for example)

tom
