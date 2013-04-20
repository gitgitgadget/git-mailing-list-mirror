From: Pete Wyckoff <pw@padd.com>
Subject: Re: is git-p4 compatible with p4/linux?
Date: Sat, 20 Apr 2013 09:22:33 -0400
Message-ID: <20130420132233.GA2094@padd.com>
References: <7BF81DF9-941D-400B-8304-6DA5F5C82D4F@aivor.com>
 <20130419000947.GB9048@padd.com>
 <CAJDDKr4gLWev=N-yMw3j0norzVxBp99ie_EYAbNcUvWcL-_70w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexander Tomlinson <alex@aivor.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 20 15:22:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTXkX-0003sK-TI
	for gcvg-git-2@plane.gmane.org; Sat, 20 Apr 2013 15:22:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755233Ab3DTNWh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Apr 2013 09:22:37 -0400
Received: from honk.padd.com ([74.3.171.149]:50103 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755015Ab3DTNWh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Apr 2013 09:22:37 -0400
Received: from arf.padd.com (unknown [50.55.134.154])
	by honk.padd.com (Postfix) with ESMTPSA id 81B1431E7;
	Sat, 20 Apr 2013 06:22:36 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id C6DE92D192; Sat, 20 Apr 2013 09:22:33 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CAJDDKr4gLWev=N-yMw3j0norzVxBp99ie_EYAbNcUvWcL-_70w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221852>

davvid@gmail.com wrote on Sat, 20 Apr 2013 03:50 -0700:
> On Thu, Apr 18, 2013 at 5:09 PM, Pete Wyckoff <pw@padd.com> wrote:
> >> First issue
> >> -----------
> >>
> >> git-p4 assumes the output of 'p4 print' adds a newline to the
> >> target.  To work around this, git-p4.py strips the last char from
> >> symlinks as shown in the following snippet:
> >>
> >>     if type_base == "symlink":
> >>         git_mode = "120000"
> >>         # p4 print on a symlink contains "target\n"; remove the newline
> >>         data = ''.join(contents)
> >>         contents = [data[:-1]]
> 
> This line could be made more robust by changing it to:
> 
>     contents = [data.rstrip('\n')]
> 
> That way it only strips off newlines if they exist, which essentially
> papers over these rogue depot files.
> Alternatively, it could use rstrip() with no arguments to cast a wider
> net and catch all whitespace.

I was tempted to do that, but it is possible to put \n and other
space characters in the target of symlinks.  It's unfortunate
that p4 always appears to tack on a newline itself.

We'll see if Alex comes up with a pattern that shows how he ended
up with the odd symlinks.

		-- Pete
