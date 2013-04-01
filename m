From: Edward Thomson <ethomson@microsoft.com>
Subject: RE: Rename conflicts in the index
Date: Mon, 1 Apr 2013 16:14:52 +0000
Message-ID: <A54CE3E330039942B33B670D971F857403A0E20C@TK5EX14MBXC253.redmond.corp.microsoft.com>
References: <A54CE3E330039942B33B670D971F857403995D93@TK5EX14MBXC252.redmond.corp.microsoft.com>
 <7va9q72n1u.fsf@alter.siamese.dyndns.org>
 <A54CE3E330039942B33B670D971F857403A0AA7A@TK5EX14MBXC253.redmond.corp.microsoft.com>
 <7vboa6t14w.fsf@alter.siamese.dyndns.org>
 <A54CE3E330039942B33B670D971F857403A0BA54@TK5EX14MBXC253.redmond.corp.microsoft.com>
 <7vk3osn3vs.fsf@alter.siamese.dyndns.org>
 <A54CE3E330039942B33B670D971F857403A0BB93@TK5EX14MBXC253.redmond.corp.microsoft.com>
 <7v38vgmxty.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 01 18:15:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMhOJ-0000vU-Ri
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 18:15:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759031Ab3DAQO6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Apr 2013 12:14:58 -0400
Received: from mail-by2lp0243.outbound.protection.outlook.com ([207.46.163.243]:28003
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758981Ab3DAQO5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Apr 2013 12:14:57 -0400
Received: from BY2FFO11FD023.protection.gbl (10.1.15.204) by
 BY2FFO11HUB027.protection.gbl (10.1.14.113) with Microsoft SMTP Server (TLS)
 id 15.0.651.3; Mon, 1 Apr 2013 16:14:52 +0000
Received: from TK5EX14HUBC102.redmond.corp.microsoft.com (131.107.125.37) by
 BY2FFO11FD023.mail.protection.outlook.com (10.1.15.212) with Microsoft SMTP
 Server (TLS) id 15.0.651.3 via Frontend Transport; Mon, 1 Apr 2013 16:14:51
 +0000
Received: from TK5EX14MBXC253.redmond.corp.microsoft.com ([169.254.3.151]) by
 TK5EX14HUBC102.redmond.corp.microsoft.com ([157.54.7.154]) with mapi id
 14.02.0318.003; Mon, 1 Apr 2013 16:14:53 +0000
Thread-Topic: Rename conflicts in the index
Thread-Index: Ac4f8fcF2rzNm40zS7GBMxbrAtW2UQAI1oifAoxQUOAABEG55gAtP7SQAAEvx18AAmt9kAACJe2MAPKwK3A=
In-Reply-To: <7v38vgmxty.fsf@alter.siamese.dyndns.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [157.54.51.32]
X-Forefront-Antispam-Report: CIP:131.107.125.37;CTRY:US;IPV:CAL;IPV:NLI;EFV:NLI;SFV:NSPM;SFS:(24454001)(51444002)(51704002)(189002)(199002)(56776001)(79102001)(46406002)(80022001)(69226001)(54356001)(74502001)(76482001)(66066001)(65816001)(53806001)(33656001)(49866001)(77982001)(4396001)(47776003)(55846006)(63696002)(23726001)(54316002)(74662001)(20776003)(44976002)(31966008)(59766001)(50986001)(81342001)(16406001)(47446002)(47976001)(47736001)(51856001)(50466001)(56816002)(46102001);DIR:OUT;SFP:;SCL:1;SRVR:BY2FFO11HUB027;H:TK5EX14HUBC102.redmond.corp.microsoft.com;RD:InfoDomainNonexistent;MX:1;A:1;LANG:en;
X-OriginatorOrg: microsoft.onmicrosoft.com
X-Forefront-PRVS: 0803A0241F
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219691>

Junio C Hamano [mailto:gister@pobox.com] wrote:
> As long as
> the format will be backward compatible to allow existing users use existing tools
> to deal with cases the existing tools can handle, then that is OK.  I didn't get that
> impression which is where my "non starter" came from.

I see now.  Thank you for the clarification.  I apologize if I was not clear
about this; indeed, the duplication of data in my proposed extension was
specifically to avoid any compatibility problems amongst clients.

In particular, when we have a rename in ours, edit in theirs conflict, we
store the conflict at the new (ours) path.  If, for example, I rename a->b
in my branch and merge a branch that edits a:

mode hash 1 b
mode hash 2 b
mode hash 3 b

This prohibits us from storing anything else in the theirs side at that
path, so if I were to have added b in their branch in addition to modifying
b, I cannot record it.

I was assuming that any change to this behavior would be a breaking one,
which is where the new section came from.

>  * Path A may have only stage #1, while path B and C has only stage
>    #2 and stage #3 (the user would have to notice these three
>    correspond to each other, and resolve manually).
> 
>    You would want to annotate "B at stage #2 seems to have been at A
>    in the original" (similarly for C#3) if you choose to do so.

If we're going to make changes to the way conflicts are recorded in the
main index, then I would prefer this approach.  It is unambiguous and all
data about all sides are recorded, including the names that items had in
their respective branches.

I would think that this might be a burden on current tools, however.
Now if I rename a->b my just my branch, my conflict will be recorded as:

mode hash 1 a
mode hash 2 b
mode hash 3 a

And current git-status will not look at any rename annotations to know
how to report this.

However, maybe this is not as big a problem as I'm concerned it would be.

>  * You can choose to favor "our" choice, and have path B with three
>    stages (if we guessed wrong and the user wants to move it to C,
>    the user can resolve and then "git mv" the path).

I think this approach suffers from the drawback that the current approach
has, wherein this conflicts when they had path B, also, as noted above.

I think that if you were to put both B and C with all three stages, this
would be problematic for the same reason.

> *1* Instead of a three-way merge that inspects only the endpoints,
>     you might get a better rename trail if you looked at the
>     histories of both branches.  It would be a lot more expensive
>     than the simple three-way, but burning CPU cycles is better than
>     burning human neurons.

For the record, I like this approach very much.  It's not something that
libgit2 will be able to tackle in the near future; we're in a sort of
walk-before-you-can-run situation with merge at the moment, as you can
probably see.  But any improvement that avoids burning neurons is a
valuable one.

Thanks-

-ed
