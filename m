From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: Re: [PATCH] bash completion: Support "unpushed commits" warnings
 in __git_ps1
Date: Sun, 06 Jun 2010 23:19:11 +0100
Message-ID: <4C0C1EDF.6050404@pileofstuff.org>
References: <4C0AE640.3040503@pileofstuff.org>	<201006062014.59386.trast@student.ethz.ch>	<4C0C09BF.4070503@pileofstuff.org> <m3r5kjq3ac.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 07 00:19:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLOBh-0004W6-C3
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 00:19:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754525Ab0FFWTV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jun 2010 18:19:21 -0400
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:44161 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753728Ab0FFWTU (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Jun 2010 18:19:20 -0400
Received: from aamtaout02-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout03-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20100606221913.DJW3075.mtaout03-winn.ispmail.ntl.com@aamtaout02-winn.ispmail.ntl.com>;
          Sun, 6 Jun 2010 23:19:13 +0100
Received: from [192.168.1.5] (really [80.6.134.127])
          by aamtaout02-winn.ispmail.ntl.com
          (InterMail vG.2.02.00.01 201-2161-120-102-20060912) with ESMTP
          id <20100606221913.WXQH1586.aamtaout02-winn.ispmail.ntl.com@[192.168.1.5]>;
          Sun, 6 Jun 2010 23:19:13 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100423 Thunderbird/3.0.4
In-Reply-To: <m3r5kjq3ac.fsf@localhost.localdomain>
X-Cloudmark-Analysis: v=1.1 cv=ZtHxNT4mZm3rCuM0SmWmgWxeBwJsziC8EqOrwwVkrhA= c=1 sm=0 a=jbOMyiAj6TwA:10 a=yQWWgrYGNuUA:10 a=8nJEP1OIZ-IA:10 a=4vNVaFtVqrTh0YDBwO8A:9 a=BHYQSzPYhD-YoVuyCUsxJjaqojcA:4 a=wPNLvfGTeEIA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148555>

On 06/06/10 22:07, Jakub Narebski wrote:
> 
> What disallowed ${} constructs?

My mistake, I misread that part of CodingGuidelines.  The following
bash-specific implementation takes about 0.013 seconds:

BRANCH=( $( git log --first-parent -1 \
		--grep="^git-svn-id: $remote_branch" ) )
BRANCH=${BRANCH[ ${#BRANCH[@]} - 2 ]}
BRANCH=${BRANCH%@*}
BRANCH=${BRANCH#*$remote_branch/}

Using an array here saves about 0.001 of a second.

	- Andrew
