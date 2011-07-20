From: "J. Bakshi" <joydeep@infoservices.in>
Subject: Re: pre-commit not working at server side push
Date: Wed, 20 Jul 2011 13:15:33 +0530
Message-ID: <20110720131533.7bbba0c5@shiva.selfip.org>
References: <20110720121356.4dc21f6b@shiva.selfip.org>
	<20110720124538.482628e3@shiva.selfip.org>
	<20110720073017.GA10465@LK-Perkele-VI.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Wed Jul 20 09:46:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjRTn-0002DC-7e
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jul 2011 09:46:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180Ab1GTHp2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jul 2011 03:45:28 -0400
Received: from static.206.87.46.78.clients.your-server.de ([78.46.87.206]:41211
	"EHLO Kolkata.infoservices.in" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751104Ab1GTHp1 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jul 2011 03:45:27 -0400
Received: from shiva.selfip.org (unknown [122.176.30.116])
	by Kolkata.infoservices.in (Postfix) with ESMTPSA id 1DC291808001;
	Wed, 20 Jul 2011 09:45:24 +0200 (CEST)
In-Reply-To: <20110720073017.GA10465@LK-Perkele-VI.localdomain>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.24.4; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177525>

On Wed, 20 Jul 2011 10:30:17 +0300
Ilari Liusvaara <ilari.liusvaara@elisanet.fi> wrote:

> On Wed, Jul 20, 2011 at 12:45:38PM +0530, J. Bakshi wrote:
> > On Wed, 20 Jul 2011 12:13:56 +0530
> > "J. Bakshi" <joydeep@infoservices.in> wrote:
> > 
> > > Hello list,
> > > 
> > > I have this bash script to check php syntax error and prevent the commit if there is any
> > > 
> > > ```````````````````
> > > #!/bin/sh
> > > 
> > > ##php_syntax_check
> > > 
> > >   for i in $(git diff-index --name-only --cached HEAD -- | grep -E '\.(php|engine|theme|install|inc>
> > >         if [ -f $i ]; then
> > >                 output=$(/usr/bin/php5 -l $i)
> > >                 if [ "$output" == "No syntax errors detected in $i" ];
> > >                 then
> > >                         echo "PHP syntax check for $i: OK"
> > >                 else
> > >                         echo "=====================================================================>
> > >                         echo "Pause $i for the commit due to PHP parse errors:"
> > >                         echo "$output"
> > >                         exit 1
> > >                 fi
> > >         fi
> > >     done
> > > 
> > > ```````````````````
> 
> > seems it should be pre-receive hook at the server. So done accordingly but still not working 
> 
> Pre-receive runs after objects have been received but before branches are updated. So
> it can inspect the newly arrived commits but the branches retain their old values.
> 
> - Firstly, the server does not have index, so diff-index does not do anything sane.
> - Secondly, HEAD does not point to anything newly arrived (the hook gets list of update 
> instructions via stdin).
> - Thirdly, this hook must be prepared for multiple commits in multiple branches appearing at
> once.
> 
> I think githooks(5) documents what these hooks receive and what they do.
> 
> -Ilari

Thanks for your clarification. As a newbie I am interested to know any such pre-receive hook which can check php syntax before php.
