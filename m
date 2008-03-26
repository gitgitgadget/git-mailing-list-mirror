From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] mktag.c: improve verification of tagger field and tests
Date: Wed, 26 Mar 2008 11:26:15 -0500
Message-ID: <47EA7927.9060201@nrlssc.navy.mil>
References: <1206490795-13247-1-git-send-email-casey@nrlssc.navy.mil>	 <47E99B98.1060506@nrlssc.navy.mil> <1b46aba20803260421t4db4987gc6fc8b2e556032e0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Carlos Rica <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 26 17:29:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeYTu-0003BP-Uq
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 17:28:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758148AbYCZQ0U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2008 12:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754960AbYCZQ0T
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 12:26:19 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:47992 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752834AbYCZQ0S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2008 12:26:18 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m2QGQGfi004777;
	Wed, 26 Mar 2008 11:26:16 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 26 Mar 2008 11:26:15 -0500
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <1b46aba20803260421t4db4987gc6fc8b2e556032e0@mail.gmail.com>
X-OriginalArrivalTime: 26 Mar 2008 16:26:15.0898 (UTC) FILETIME=[1D28F3A0:01C88F5E]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15806001
X-TM-AS-Result: : Yes--20.854600-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTgzMDk0MC03MDAw?=
	=?us-ascii?B?NzUtMTM5MDEwLTcwMDE2MC03MDE2MDQtNzA1MTc4LTcwMTIwMi03?=
	=?us-ascii?B?MDY4OTEtNzAzMTU3LTcwNjE1OS03MDI3OTEtNzAwNjMwLTcwODI1?=
	=?us-ascii?B?Ny03MDA5NzEtNzAzNzgyLTcwMTIzNi03MDE0NTAtNzAwODM5LTcw?=
	=?us-ascii?B?MDA3NC03MTEyMTMtNzAwNjE4LTcwNDI1Ny03MDEyOTgtNzAyMDUw?=
	=?us-ascii?B?LTcwMDgxMC03MDk1ODQtMTA1MjUwLTcwMjM1OC03MDE0NTUtNzAy?=
	=?us-ascii?B?MDM5LTEzNjA3MC0xODgwMTktNzEwMjA3LTcwMjM3My0xNDgwMzkt?=
	=?us-ascii?B?MTQ4MDUxLTIwMDQy?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78289>

Carlos Rica wrote:
> On Wed, Mar 26, 2008 at 1:40 AM, Brandon Casey <casey@nrlssc.navy.mil> wrote:
>>  Well, since I looked at this code and used it in filter-branch, I figured I
>>  should fix the verification code for the tagger field (even though it's
>>  probably dieing soon).
>>
>>  I'm thinking this utility should be fairly strict about the format it accepts.
> 
> Why not using git-tag to make tags in filter-branch?

How?

With cat-file and mktag I don't have to parse the tag, I can ignore
nearly the entire thing and only change the parts I'm interested in.

With git-tag, wouldn't I have to parse the tag, splitting the header
from the body and redirect the body to a tmpfile, parse the tagger field,
and set GIT_COMMITTER_NAME, GIT_COMMITTER_EMAIL, GIT_COMMITTER_DATE
environment variables?

> git-mktag was used in git-tag.sh before convert it into
> builtin-tag.c, and I didn't know that anyone was using it.

I don't think anything other than filter-branch is (and the usage
there is only tentative).

> I agree that, if this program exists and it is used,
> we should double-check the accepted format and data,
> so this patch is a good addition.
> 
> However, I think that we should progressively deprecate its
> use to avoid mantaining two different ways for creating tags,
> so you must have a very good reason to keep using
> this tool in a script...

Eventually filter-branch along with the rest of git will be rewritten
in c and the need for many low-level git tools will vanish.

-brandon
