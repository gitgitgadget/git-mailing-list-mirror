From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [RFC/PATCH 1/2] config doc: add dot-repository note
Date: Mon, 20 May 2013 22:10:37 +0100
Organization: OPDS
Message-ID: <B010AA3E0D5C4FADBC22D43DA4C255D6@PhilipOakley>
References: <1368964449-2724-1-git-send-email-philipoakley@iee.org><1368964449-2724-2-git-send-email-philipoakley@iee.org><20130519174307.GC3362@elie.Belkin> <7v7gitwneq.fsf@alter.siamese.dyndns.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "GitList" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 20 23:10:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeXLs-0002Ip-Sb
	for gcvg-git-2@plane.gmane.org; Mon, 20 May 2013 23:10:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757185Ab3ETVKh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 17:10:37 -0400
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:45881 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756561Ab3ETVKg (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 May 2013 17:10:36 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ArkNAO+QmlFOl3mN/2dsb2JhbABagwiJKrhEBAEDAYEDF3SCGgUBAQQBCAEBLh4BASELAgMFAgEDFQECCSUUAQQIEgYHFwYBEggCAQIDAYdqAwkKs2ENiFmMSoFtaoJ6YQOIZ4YBhmqOA4UjgxA7
X-IronPort-AV: E=Sophos;i="4.87,709,1363132800"; 
   d="scan'208";a="428806074"
Received: from host-78-151-121-141.as13285.net (HELO PhilipOakley) ([78.151.121.141])
  by out1.ip02ir2.opaltelecom.net with SMTP; 20 May 2013 22:10:34 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224983>

From: "Junio C Hamano" <gitster@pobox.com>
Sent: Monday, May 20, 2013 6:50 PM
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Philip Oakley wrote:
>>
>>> --- a/Documentation/config.txt
>>> +++ b/Documentation/config.txt
>>> @@ -734,6 +734,8 @@ branch.<name>.remote::
>>>  overridden by `branch.<name>.pushremote`.  If no remote is
>>>  configured, or if you are not on any branch, it defaults to
>>>  `origin` for fetching and `remote.pushdefault` for pushing.
>>> + Additionally, a `.` (period) means the current local repository
>>> + (a dot-repository), see `branch.<name>.merge`'s final note below.
>>
>> Does this accept an arbitrary git URL, or only remote names?
>
> The branch.<name>.remote variable refers to remote names, and '.'
> often appears as a special name to refer to the local repository.

Initially I thought that the '.' wasn't going to be acceptable as a URL, 
and that the '.' would only apply to the defined <name> of the remote 
within the branch section.

>
> I think you can define it as URL and your "git fetch" (no args) will
> do the right thing in that it would:
>
> (1) fetch the history leading to the tip branch.<name>.merge branch
>     from there; and
>
> (2) leave the result in FETCH_HEAD, so that "git merge FETCH_HEAD"
>     can conclude the "git pull" you split into two manually by
>     running "git fetch" first,
>
> but I do not think there is a "while we create this branch" side
> effect UI like "--set-upstream-to" for doing so, except for setting
> it to '.' when you set upstream to a branch in the local repository.
> I.e.
>
> git checkout -t -b mywork master
>        git branch --set-upstream-to master mywork
>
> Also I think setting it to arbitrary URL would mean that you would
> not see any remote tracking ref (they are to be defined as a
> property of named remote with remote.<name>.fetch refspecs), so it
> is unclear how @{u} would work.  @{u} works when the variable is set
> to '.', though.
>
> For the above reasons, describing '.' as a special value for the
> variable that the end users are likely to see is a reasonable "white
> lie" for this part of the documentation.
>

OK. 
