From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] doc git: multivar configuration parameters append to existing values
Date: Tue, 17 Jun 2014 23:03:14 +0100
Organization: OPDS
Message-ID: <E9A1113CB95B406FA3C16ED2AA5B111D@PhilipOakley>
References: <1402922952-172-1-git-send-email-philipoakley@iee.org><xmqqd2e8r8yz.fsf@gitster.dls.corp.google.com><708AD97F308249A1B61D9348AFE59182@PhilipOakley> <xmqqfvj4pnl1.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "GitList" <git@vger.kernel.org>, "Jeff King" <peff@peff.net>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	"Robert Clausecker" <fuz@fuz.su>,
	"Alex Riesen" <raa.lkml@gmail.com>,
	"Tanay Abhra" <tanayabh@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 00:03:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wx1Ta-0001CR-Oc
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 00:03:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966458AbaFQWDa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 18:03:30 -0400
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:47027 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S966399AbaFQWD1 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jun 2014 18:03:27 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ah0kAKe6oFMCYJLo/2dsb2JhbABagw1miG27CAUBAgEBDIEDF3WDfgUBAQQBCAEBLh4BASEFBgIDBQIBAxUMJRQBBBoGBxcGEwgCAQIDAYgpDLJQmCQXiUOFMzWCf4EWBIoFhlqdPINBPIExJA
X-IPAS-Result: Ah0kAKe6oFMCYJLo/2dsb2JhbABagw1miG27CAUBAgEBDIEDF3WDfgUBAQQBCAEBLh4BASEFBgIDBQIBAxUMJRQBBBoGBxcGEwgCAQIDAYgpDLJQmCQXiUOFMzWCf4EWBIoFhlqdPINBPIExJA
X-IronPort-AV: E=Sophos;i="5.01,497,1400022000"; 
   d="scan'208";a="498984234"
Received: from host-2-96-146-232.as13285.net (HELO PhilipOakley) ([2.96.146.232])
  by out1.ip03ir2.opaltelecom.net with SMTP; 17 Jun 2014 23:03:09 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251959>

From: "Junio C Hamano" <gitster@pobox.com>
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>>>                                                                   ---once
>>> the reader
>>>   understands that Git reads all configuration varilables of the
>>>   same name and the code paths that *use* one of them pick the one
>>>   defined the last,
>> It's this step that's a concern. We shouldn't be forcing the reader
>> to
>> implicitly grok that, especially as we don't actually say it
>> elsewhere
>> (in the regular documentation).
>
> I think that is what I was driving at.  If we do not tell the reader
> that, perhaps we should and everything else will fall as natural
> consequence of that understanding.
>
>>> * The last sentence added, i.e. "insteadof"-style, will not be
>>>   understood by any reader other than those who tried to use "-c"
>>>   on remote.*.url variables and does not belong here.  A better
>>>   way/place to give that information is needed.
>>
>> I just wanted to indicate that some multivars do have get-out
>> [override]
>> config parameters, though we aren't consistent about their names yet,
>> while giving a clue as to a typical name style.
>
> I think those who tried "-c remote.*.url" would be helped better by
> having a see-also in the documentation on "remote.*.url" that refers
> them to "insteadOf" noting that "remote.*.url" is a multi-value
> variable and appending different definition will not make "the last
> one wins".  After all "-c" is merely *one* way to append.
>
> The next person who gets confused may say "I added remote.origin.url
> at the end of my $repo/.git/config expecting that the value to be
> used"; the answer would be the same "the variable is multi-valued;
> adding a new value is not the right way to futz with it.  You either
> need to replace, or if you do not want to replace, use insteadOf".
>
> That is the second reason why the mention of insteadOf does not
> belong to the description of "-c var=value".
>
> Perhaps something like this as a starting point?
>

Yes, that's a good start, but we still need the correction to the git(1)
'-c' option text.

It'll be a few days before I can get back to this.

> Documentation/config.txt | 11 +++++++++++
> 1 file changed, 11 insertions(+)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 1d718bd..357cc02 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2108,6 +2108,13 @@ remote.pushdefault::
> remote.<name>.url::
>  The URL of a remote repository.  See linkgit:git-fetch[1] or
>  linkgit:git-push[1].
> ++
> +Note that this variable is multi-valued (e.g. "git push there" with
> +multiple `remote.there.url` will push to all the named repositories),
> +and does not follow the "last-one-survives" rule.  When you want to
> +temporarily redirect a push to somewhere else, see
> `url.<base>.insteadOf`;
> +you cannot use "git -c remote.<name>.url=<temporary URL> push",
> because
> +you will be pushing to both the configured place and the temporary
> place.
>
> remote.<name>.pushurl::
>  The push URL of a remote repository.  See linkgit:git-push[1].
> @@ -2419,6 +2426,10 @@ url.<base>.insteadOf::
>  the best alternative for the particular user, even for a
>  never-before-seen repository on the site.  When more than one
>  insteadOf strings match a given URL, the longest match is used.
> ++
> +When you want to redirect a push to `$URL` (e.g. `site.xz:myrepo`)
> +temporarily to somewhere else (e.g. `othersite.xz:myrepo`), you can
> +use "git -c url.othersite.xz:myrepo.insteadOf=site.xz:myrepo push
> ..."
>
> url.<base>.pushInsteadOf::
>  Any URL that starts with this value will not be pushed to;
>
>
--
Philip
