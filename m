From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: Re: [RFC/PATCH 1/4] gitweb: Move subroutines to Gitweb::Config module
Date: Wed, 9 Jun 2010 00:52:11 +0530
Message-ID: <AANLkTiksOpUqxGc7Lo4clrLwOF6GvkT7CZH5CVeirtBr@mail.gmail.com>
References: <1275943844-24991-1-git-send-email-pavan.sss1991@gmail.com>
	<201006081446.22587.jnareb@gmail.com>
	<20100608141321.GP20775@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Jun 08 21:22:21 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OM4NP-00055f-Ab
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 21:22:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755895Ab0FHTWO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jun 2010 15:22:14 -0400
Received: from mail-yw0-f204.google.com ([209.85.211.204]:60477 "EHLO
	mail-yw0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755775Ab0FHTWN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jun 2010 15:22:13 -0400
Received: by ywh42 with SMTP id 42so4493074ywh.15
        for <git@vger.kernel.org>; Tue, 08 Jun 2010 12:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=EMMAQT5lwdvhlhNOCYlBdn0YOh19RXydzL3gV7OMVuw=;
        b=Xr9I7ASXAPbYkDXvO6o51qvIZeZXbcAcLgEo0FM7p9iBDrWZwMWJWnrzUleEiH7oCa
         o8BM3yskaYya0mLOcsuXoYf45FMZYW5r5ofEBH29kAeITzmDHPPLWROJkZiuqyP+ysn7
         Yxh4/yIKb6qKlPsqw+O5dGy2ZCZe/Z5DMhvvk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dV7UpQootWNxcOR9zKisa+EI4RoqFw76KcwLO0qQmTPwwuerO8tBgNwL2VptZ80/O5
         X1QioH8QEpWDtS8gNb2nwvm0cy2m+NeqsiScn7yXp50ynxzNcClQW1rtbYdR2EJXk8Dn
         p1HlaNlk++PKwS16LLJ+D7NUK4HcxmYdstUrI=
Received: by 10.101.106.12 with SMTP id i12mr16962143anm.27.1276024931689; 
	Tue, 08 Jun 2010 12:22:11 -0700 (PDT)
Received: by 10.100.126.20 with HTTP; Tue, 8 Jun 2010 12:22:11 -0700 (PDT)
In-Reply-To: <20100608141321.GP20775@machine.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148703>

On Tue, Jun 8, 2010 at 7:43 PM, Petr Baudis <pasky@suse.cz> wrote:
> =A0Hi!
>
> On Tue, Jun 08, 2010 at 02:46:20PM +0200, Jakub Narebski wrote:
>> Third, and I think most important, is that the whole splitting gitwe=
b into
>> modules series seems to alck direction, some underlying architecture
>> design. =A0For example Gitweb::HTML, Gitweb::HTML::Link, Gitweb::HTM=
L::String
>> seems to me too detailed, too fine-grained modules.
>
> =A0I agree!
>
>> It was not visible at first, because Gitweb::Config, Gitweb::Request=
 and to
>> a bit lesser extent Gitweb::Git fell out naturally. =A0But should th=
ere be
>> for example Gitweb::Escape module, or should its functionality be a =
part of
>> Gitweb::Util? =A0Those issues needs to be addressed. =A0Perhaps they=
 were
>> discussed with this GSoC project mentors (via IRC, private email, IM=
), but
>> we don't know what is the intended architecture design of gitweb.
>
> =A0I would expect Gitweb::Escape functionality to live in Gitweb::HTM=
L
> (HTML escaping) and/or Gitweb::Request (URL escaping).
>
>> Should we try for Model-Viewer-Controller pattern without backing MV=
C
>> (micro)framework? =A0(One of design decisions for gitweb was have it=
 working
>> out of the box if Perl and git are installed, without requiring to i=
nstall
>> extra modules; but now we can install extra Perl modules e.g. from C=
PAN
>> under lib/...). =A0How should we organize gitweb code into packages
>> (modules)?
>
> =A0I thought we already discussed MVC and sort of agreed that it's an
> overkill at this point. At least that is still my opinion on it; I'm =
not
> opposed to MVC per se, but to me, this modularization is a good
> intermediate step even if we go the MVC way later, and doing MVC prop=
erly
> would mean much huger large-scale refactoring than just naming a modu=
le
> Gitweb::View instead of Gitweb::HTML. Let's do it not at all, or
> properly sometime later. I think it's well out-of-scope for GSoC.
>
>> Perhaps having gitweb.perl, Gitweb::Git, Gitweb::Config, Gitweb::Req=
uest,
>> Gitweb::Util and Gitweb would be enough?
>
> =A0I'm not sure what would fall into Gitweb::Util. I think Gitweb::HT=
ML
> makes a lot of sense to have, but I don't see the advantage of finer
> graining than that - I dislike the Gitweb::HTML::* submodules as well=
=2E
>
> =A0Pavan, can you outline your next plan on the other modules you aim=
 to
> create, plus possibly a bit of rationale?

I am graining Gitweb::HTML into Gitweb::HTML::* to reduce circular
dependancies of the modules.

In the following days, I will be creating more modules
  Gitweb::HTML::Navigation
  Gitweb::HTML::Error
  Gitweb::HTML::Page (Containing header and footer subs)
  Gitweb::HTML::Format (format_* subs)
  Gitweb::Parse
  Gitweb::RepoConfig
  Gitweb::Util
  Gitweb::Action::* (All action subs like git_blame, git_log)

This is my architectural design for now. But It may change due to
later circular dependancies.

I will be rebasing the whole series, edit them and send them once
every module has undergone as RFC in the mailing list.

I have been stuck many times trying to workaround the circular module
dependancies and believe me, the patches I am sending and the modules
I am creating involves a lot of effort from my side and as long as you
think there's nothing wrong with the grouping of subroutines in my
modules and their names, you need not worry about the module
structure.

Thanks,
Pavan.
