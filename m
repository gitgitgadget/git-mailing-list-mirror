From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: erratic behavior commit --allow-empty
Date: Thu, 4 Oct 2012 23:42:49 +0100
Organization: OPDS
Message-ID: <74938A94D25C4F1887F30C281A02B35F@PhilipOakley>
References: <CAB9Jk9BynCunFHRFhGKoyDA-qof1iu6w952sAgSs2_JWb8+U3A@mail.gmail.com><506AA51E.9010209@viscovery.net><7vzk449449.fsf@alter.siamese.dyndns.org><CAB9Jk9CSW0ObJtgsfSwjf+k438=V8i7dP0p+YUehqdh2Z0k6tA@mail.gmail.com><7vhaqc7in6.fsf@alter.siamese.dyndns.org><CAB9Jk9D-eJ8goYx7LWqGcWcLgRDS8+qLZVUsvvJ+QOtryP9-zg@mail.gmail.com><90464C79DA97415C9D66846A77ECAA4A@PhilipOakley><CAB9Jk9ARWnE-cWVjqMUFiua21QjqGEX3VhYjKQMBSotVYXXK1Q@mail.gmail.com><vpq626s6kwu.fsf@grenoble-inp.fr><CAB9Jk9DFb2s4s00yCNUytxFdrOQKPEKZGsXpKzwZDo5WAOdXaQ@mail.gmail.com><vpqvcer4xvo.fsf@grenoble-inp.fr><CAB9Jk9BTCaV7RDx6_K+MKOeJTdOQPOwvnGM0UNxg9S8KMo4D4Q@mail.gmail.com><A75F75C4DE3C47C7AF43D39355C873F7@PhilipOakley><CAB9Jk9C4Y2LSzZW5Nkz=4f===8_gk4uAG4EKDxT17kUHu4VX1A@mail.gmail.com><20C3105FC8D94F749FAEB7444325B34A@Phil
 ipOakley> <CAB9Jk9CiDNNBM9V-VvwCK6q-N0JNwEbf4vJj0ffT82iLnrUwog@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Sixt" <j.sixt@viscovery.net>,
	"git" <git@vger.kernel.org>,
	"Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>
To: "Angelo Borsotti" <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 01:16:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJu7u-0000BA-Ov
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:42:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755215Ab2JDWmc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 18:42:32 -0400
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:57680 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755203Ab2JDWmc (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Oct 2012 18:42:32 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AhIKAOkBblBcGnKf/2dsb2JhbABFi06yPAOBCIEJghsFAQEFCAEBLh4BASELAgMFAgEDFQELJRQBBAgSBgcXBhMIAgECAwEKh1gDE65RDYlUilpkbAKET2ADiCOFRoYrjHaFC4Ju
X-IronPort-AV: E=Sophos;i="4.80,537,1344207600"; 
   d="scan'208";a="405707357"
Received: from host-92-26-114-159.as13285.net (HELO PhilipOakley) ([92.26.114.159])
  by out1.ip01ir2.opaltelecom.net with SMTP; 04 Oct 2012 23:42:30 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207052>

From: "Angelo Borsotti" <angelo.borsotti@gmail.com>
Sent: Thursday, October 04, 2012 11:09 PM

>>
>> A reasonable solution. You can also create a sentinel (--root) commit
>> for
>> any time that you need to create the source branch, just so it (the
>> real
>> source code commit) has a different parent when on source branch to
>> that on
>> the binaries branch.
>
> Do you mean I could create an empty root commit to be used as parent
> for the
> real source commit? Or that there is some --root option to be used?

I was using "--root" in a colloquial way. It is used in some other
commands when the very first commit is to be included in its operation.

At the point where you do the 'git checkout --orphan  <new_branch>
<start_point>' you could have separate start points ready for the source
branch and the binaries branch, and immediately do a 'git commit' to
create the unique sentinel commit before you re-checkout the developers
latest and greatest (with --force), and then do your commits on the 
source branch as before.

Another technique could be to simply switch to the sources branch, and 
then use a 'git clean -x' with an updated .gitignore ('reset' the file 
from the source branch)[or use the exclude file] to remove those now 
ignored binaries, before doing the commit.

Philip
