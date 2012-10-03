From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: erratic behavior commit --allow-empty
Date: Wed, 3 Oct 2012 23:32:49 +0100
Organization: OPDS
Message-ID: <A75F75C4DE3C47C7AF43D39355C873F7@PhilipOakley>
References: <CAB9Jk9BynCunFHRFhGKoyDA-qof1iu6w952sAgSs2_JWb8+U3A@mail.gmail.com><506AA51E.9010209@viscovery.net><7vzk449449.fsf@alter.siamese.dyndns.org><CAB9Jk9CSW0ObJtgsfSwjf+k438=V8i7dP0p+YUehqdh2Z0k6tA@mail.gmail.com><7vhaqc7in6.fsf@alter.siamese.dyndns.org><CAB9Jk9D-eJ8goYx7LWqGcWcLgRDS8+qLZVUsvvJ+QOtryP9-zg@mail.gmail.com><90464C79DA97415C9D66846A77ECAA4A@PhilipOakley><CAB9Jk9ARWnE-cWVjqMUFiua21QjqGEX3VhYjKQMBSotVYXXK1Q@mail.gmail.com><vpq626s6kwu.fsf@grenoble-inp.fr><CAB9Jk9DFb2s4s00yCNUytxFdrOQKPEKZGsXpKzwZDo5WAOdXaQ@mail.gmail.com><vpqvcer4xvo.fsf@grenoble-inp.fr> <CAB9Jk9BTCaV7RDx6_K+MKOeJTdOQPOwvnGM0UNxg9S8KMo4D4Q@mail.gmail.com>
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
X-From: git-owner@vger.kernel.org Fri Oct 05 00:01:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtLA-0001DP-IH
	for gcvg-git-2@plane.gmane.org; Thu, 04 Oct 2012 23:52:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756650Ab2JCWct (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 18:32:49 -0400
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:31164 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754475Ab2JCWct (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Oct 2012 18:32:49 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AuAKAHu7bFBcGnKf/2dsb2JhbABFi06yHQEDgQ6BCYIbBQEBBAEIAQEuHgEBIQUGAgMFAgEDFQELJRQBBAgSBgcXBhMIAgECAwGHYgMJCqQ+igQNiVSKP2Q4MgMkhElgA4gjgxuCK4YriCWEUIULgm4
X-IronPort-AV: E=Sophos;i="4.80,529,1344207600"; 
   d="scan'208";a="400488258"
Received: from host-92-26-114-159.as13285.net (HELO PhilipOakley) ([92.26.114.159])
  by out1.ip03ir2.opaltelecom.net with SMTP; 03 Oct 2012 23:32:46 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206949>

From: "Angelo Borsotti" <angelo.borsotti@gmail.com>
Sent: Wednesday, October 03, 2012 12:52 PM
> Hi
>
>>>> You still didn't tell us where the problem was.
>

I've split up the explanation of your problem you have seen, to see if I 
can understand where the 'missing' aspect is within the extended 
dicussions.

> I thought I did, but here it is:

> I have private and a public
> repositories. In the private ones the developers keep both the sources
> and the binaries. In the public ones they keep only the sources. They
> do not want the binaries there because binaries are very large and
> requite much time to be pushed. Besides that, they are not even needed
> because they must be rebuilt anyway.

> To push the sources only, they keep in the private repositories an
> orphan branch in which commits are done taking the relevant commits in
> the (say) master branch and removing the binaries from the index.

> Pushing directly the master branch would push also the binaries even
> if they were removed from its index (the  history gets pushed): thence
> the need for an orphan branch.

> Scripts have been provided to do this
> easily and safely. Now, it could happen that a developer does not have
> (yet) binaries, but want to push all the same.

> The script has to take
> care for this special case, in which no binaries are removed, but a
> commit on the orphan branch is done all the same.

>And here is the
> problem since git commit does not produce a brand new, different &
> unique commit all the times, making then the orphan branch point to
> the master one, i.e. becoming a non-orphan one.

What isn't clear is how the master branch is created and maintained at 
this point.

Does the script create it afresh each time, so that it is also, 
implicitly, an --orphan branch?

>
>> I ended up with a branch "master" and a branch "new-branch", both
>> pointing to the same commit. The new branch _is_ created.
>>
In such a case (a new master being created every time the script runs), 
then you can suffer the situation you describe where you have a common 
sentinel commit being used for both branches, even though you thought 
they were orphaned from each other. - a very special case.

However one has to ask how the rest of the script would work in such 
situations with such a truncated master branch.

If the master branch has a true history, then you would get different 
commits being created on the two branches because the parents would be 
different.

Or finally, you have a truly special test (initialisation) case when you 
are starting master (which will later grow) and comparing it to the very 
first test case of the --orphan branch and in that special case you 
could get a common commit. But that is a one off special case, and would 
not recur in practice.

Can you say more about the script?

> Exactly, it is created, but it is not an orphan ... or more precisely,
> it is sometimes, depending on how fast you are to enter the second
> commit command. This time-dependent behaviour is what I am talking
> about.
>
> -Angelo
> --
