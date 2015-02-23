From: "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: =?us-ascii?Q?RE:_Identifying_user_who_ran_=22git_reset=22_command?=
Date: Mon, 23 Feb 2015 13:43:14 -0500
Message-ID: <00e601d04f98$95177470$bf465d50$@nexbridge.com>
References: <1424493989740-7625788.post@n2.nabble.com> <CAPc5daULfa8oASxvWQ7RuV9T4SXoCw_Pi0EfGkk1GGafa1r9Xg@mail.gmail.com> <1424495778228-7625791.post@n2.nabble.com> <20150223164833.GA17528@vps892.directvps.nl>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Kevin Daudt'" <me@ikke.info>,
	"'Technext'" <varuag.chhabra@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 23 19:43:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPxyV-0007DV-0w
	for gcvg-git-2@plane.gmane.org; Mon, 23 Feb 2015 19:43:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753196AbbBWSnT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2015 13:43:19 -0500
Received: from elephants.elehost.com ([216.66.27.132]:10361 "EHLO
	elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752625AbbBWSnS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2015 13:43:18 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE0023eb577e25-CM602ad06c91a7.cpe.net.cable.rogers.com [99.237.128.150])
	(authenticated bits=0)
	by elephants.elehost.com (8.14.9/8.14.9) with ESMTP id t1NIhDFR058541
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 23 Feb 2015 13:43:14 -0500 (EST)
	(envelope-from rsbecker@nexbridge.com)
In-Reply-To: <20150223164833.GA17528@vps892.directvps.nl>
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQFHpfFYPRhN9rWYiHSGmDxyRFXcDwIe5G7nAmo+J1cBQ5yDEZ3heB3A
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264281>

On 23 Feb 2015, Kevin Daudt wrote:
> On Fri, Feb 20, 2015 at 10:16:18PM -0700, Technext wrote:
> > Thanks Junio for the prompt reply! :) Yes, that's exactly how i would
> > like things to be. I'll definitely try to push this thing and see if
> > this flow can be implemented.
> > However, can you please guide me whether there's any way i could have
> > figured out about the git reset command that the developer executed on
> > his local? (my first query)
> 
> git reset . is just a local working tree operation, which does not leave
> something behind, just like when the user would do any other file
operations
> and comitted that. This created a so called evil merge, which are not easy
to
> detect (see [1] for some possible solutions)
> 
> >
> > Also, am i right in thinking that a check cannot be implemented using
> > hooks or any other similar way? (my second query)
> 
> Because an evil merge is hard to detect, it's even harder to do it
automated in a
> script. Human review works much better for this (when merging in the
changes
> from the developer).

The only effective way I have found to deal with this is to have an
implemented policy of making sure that developers only push changes to topic
branches and have an approver handle the merge. This will not eliminate the
evil merge or reset, but at least you get a second set of eyes on it. With
that said, the oops merge or reset is different, which an accidental
operation.

I know it is off-topic, but there is an approach used by other systems (some
code-management, some not) that implement per-command policies. Something
like a client-side hook or config-like access control list may be useful:
like a hooks/pre-execute (invoked possibly as high up as in run_argv() after
handle_options()) that gets passed argv, and is able to accept/decline the
command, might catch accidents. Granted this slows things down a whole lot,
but places that use (I didn't say need) command-level restrictions, often
are willing to accept performance degradation and the resulting grumbling
that comes with it. And you've probably had this discussion before, so I
sincerely apologize in advance for bringing it up.

Cheers,
Randall

-- Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)/NonStop(211288444200000000)
-- In real life, I talk too much.
