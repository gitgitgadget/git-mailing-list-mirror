From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [RFC/PATCH 2/2] doc: command line interface (cli) dot-repository dwimmery
Date: Tue, 21 May 2013 08:47:45 +0100
Organization: OPDS
Message-ID: <08847FEAFB00489695F31AA651F5EA2E@PhilipOakley>
References: <1368964449-2724-1-git-send-email-philipoakley@iee.org><1368964449-2724-3-git-send-email-philipoakley@iee.org><20130519173924.GB3362@elie.Belkin><7v38thwn6l.fsf@alter.siamese.dyndns.org><BDA138F1A58247F4A4940B3436A94485@PhilipOakley> <7v1u91uw95.fsf@alter.siamese.dyndns.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Jonathan Nieder" <jrnieder@gmail.com>,
	"GitList" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 21 09:47:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UehIS-0007lW-Jf
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 09:47:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752213Ab3EUHro (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 03:47:44 -0400
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:30433 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751574Ab3EUHro (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 May 2013 03:47:44 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgYPAH8lm1FOl3mN/2dsb2JhbABZgwgwiHq4TAQBAwGBChd0ghoFAQEEAQgBAS4eAQEhBQYCAwUCAQMVAQIJJRQBBAgSBgcXBhMIAgECAwGHagMJCrMSDYhZjEqBbWqCemEDiGeGAYZqjgOFI4MQOw
X-IronPort-AV: E=Sophos;i="4.87,713,1363132800"; 
   d="scan'208";a="72781535"
Received: from host-78-151-121-141.as13285.net (HELO PhilipOakley) ([78.151.121.141])
  by out1.ip07ir2.opaltelecom.net with SMTP; 21 May 2013 08:47:41 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225021>

From: "Junio C Hamano" <gitster@pobox.com>
Sent: Monday, May 20, 2013 11:22 PM
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> So we can have a branch whose remote is '.'
>> _and_ a remote whose URL is '.'
>
> Yes, and they are two separate concepts.
Thank you of the confirmation.

>
> "git fetch" while on "mywork" branch with this:
>
>    [branch "mywork"]
>        remote = git://git.k.org/pub/scm/git/git.git
>        merge = refs/heads/master
>
> without having any named remote whose remote.$name.url is set to
> that URL may happen to work but it is by accident as far as I know.
Interesting. Any thoughts on which way it should be 
documented/deprecated?

> As you do not copy to any remote tracking branches, @{u} would not
> work, so it is not something useful.  But on the other hand
>
>    [branch "mywork"]
>        remote = .
>        merge = refs/heads/master
>
> works _as if_ you have
Thank you of the confirmation.

>
>    [remote "."]
>        url = "."
> ;; no fetch refspec like +refs/heads/*:refs/heads/*
>        ;; no push refspec like +refs/heads/*:refs/heads/*
>
> so in that sense, you _could_ think of branch.$name.remote as a
> (generic) URL or a name of a (special) remote, but it is easier to
> think about it as the latter.
Yes.

>
> And remote.$name.url = "." for any name, e.g.
>
>    [remote "here"]
>        url = "."
>
> is a special case of local repository that is named with a relative
> filesystem path.
>
>> Can there be a clash with a named remote that is actually '.', where
>> the push/fetch is actually a no-op?
>
> Nobody sane would do it in the first place, so...

Oh I don't know. I don't think 'sanity' comes into it any more than 
'common sense' is common. It's easy to fall into the inverse 
Kruger-Dunning mode where those in the know don't realise how much they 
know, and how 'stupid' those that don't can be (that'd be me;-).

All this 'what's a dot-repo and where can I use it' came about because 
of an answer that give it's use as a 'trick'.

On Sat, May 4, 2013 at 2:51 PM, Jonathan Nieder <jrnieder@gmail.com>
wrote:
> Another trick is to use "git push":
>         git push . $production_sha1:refs/heads/master

and

Filipe gave 'git fetch .' in [PATCH 1/3] fetch: add --allow-local 
option, 16 May 2013

Philip 
