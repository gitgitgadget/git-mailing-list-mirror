From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] doc: format-patch: don't use origin as a branch name
Date: Fri, 1 Aug 2014 23:26:02 +0100
Organization: OPDS
Message-ID: <F09DC14751724BEB809135DE720953E6@PhilipOakley>
References: <1406920826-4680-1-git-send-email-philipoakley@iee.org><20140801193614.GR12427@google.com> <xmqq8un8ug5d.fsf@gitster.dls.corp.google.com>
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
X-From: git-owner@vger.kernel.org Sat Aug 02 00:26:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDLH8-0000q1-OF
	for gcvg-git-2@plane.gmane.org; Sat, 02 Aug 2014 00:26:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbaHAW0G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2014 18:26:06 -0400
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:45365 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932091AbaHAW0F (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Aug 2014 18:26:05 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Asc8AI8T3FMCYJjrPGdsb2JhbABbgw1jAUWHL4EEyyYFAQIBAQx/FwUBAQEBODaDfgUBAQQBCAEBLh4BASEFBgIDBQIBAxUDCSUUAQQIEgYHAxQGARIIAgECAwGIHQMJDLgOiUENhyaNH4ItNYMBgRwFik6HBYggkDuJcDwv
X-IPAS-Result: Asc8AI8T3FMCYJjrPGdsb2JhbABbgw1jAUWHL4EEyyYFAQIBAQx/FwUBAQEBODaDfgUBAQQBCAEBLh4BASEFBgIDBQIBAxUDCSUUAQQIEgYHAxQGARIIAgECAwGIHQMJDLgOiUENhyaNH4ItNYMBgRwFik6HBYggkDuJcDwv
X-IronPort-AV: E=Sophos;i="5.01,783,1400022000"; 
   d="scan'208";a="117353842"
Received: from host-2-96-152-235.as13285.net (HELO PhilipOakley) ([2.96.152.235])
  by out1.ip07ir2.opaltelecom.net with SMTP; 01 Aug 2014 23:26:01 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254675>

From: "Junio C Hamano" <gitster@pobox.com>
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Philip Oakley wrote:
>>
>>> Historically (5 Nov 2005 v0.99.9-46-g28ffb89) the git-format-patch 
>>> used
>>> 'origin' as the upstream branch name. This is now used to name the 
>>> remote.
>>> Use the more modern 'master' as the branch name.
>>
>> Would 'origin/master' make sense?
>
> It would make a lot more sense than 'master', I think.
>
> The 'origin' will be DWIMmed to whatever the remote designated as

I'd rather not provide an example that requires extra understanding on 
behalf of the reader on the DWIMing, especially as the example doesn't 
actually match the guidance in gitrevisions(7) [2].

The synopsis says it should either be a single commit <since>, or a 
<revision range>, the latter specified via gitrevisions(7), so theirs 
already an opportunity for confusion, but I take your point.

> its primary branch, i.e. refs/remotes/origin/HEAD, and the
> assumption the examples in question makes is that the user is
> following along the simplest workflow to fork from it and upstream
> her changes.  Between 'origin' and 'origin/master', there isn't much
> difference because of it.  In the same spirit of following the
> simplest workflow, that primary branch is likely to be their
> 'master', so 'origin/master' is OK but longer than 'origin' [*1*].

which suggests that maybe the example text should clarify any assumprion 
like that..
>
> On the other hand, 'master' names the local 'master', which may be
> very stale with respect to 'origin/master', or may have tons of
> unrelated things that are not in origin/master, some of which may
> have come from the branch the user is running format-patch to grab
> patches to upstream.  For this reason, changing 'origin' to 'master'
> is not an improvement at all, I would have to say.

I didn't see it that way, my view (presumption?) of the workflow was 
that the user had a branch 'current' which they had branched from their 
'master', thus the updated command felt natural.
>
> We could further adjust the underlying assumption to more modern
> "checkout -t -b" era, and use "format-patch @{u}", but I suspect
> that the readers of these examples are not yet ready for magic
> before the basics to spell out things more explicitly is covered.

agreed

>
>
> [Footnote]
>
> *1* Also using 'origin' will cover the case when the primary branch
> at the remote were not named 'master', so in that sense it is
> slightly better and more generally applicable.
>
--
Philip
[2] the DWIMs listed in the <refname> example of gitrevisions(7), to the 
niave reader, needs to be ref/ prefixed, which isn't what we'd hope 
(assuming they ever read it ;-). 
