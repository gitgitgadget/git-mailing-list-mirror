From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Minimum Perl version?
Date: Fri, 24 Sep 2010 22:39:32 +0000
Message-ID: <AANLkTinQQxsbUHiKLaCJ0b5-dcvdE4JhLMVWOV5P2bkh@mail.gmail.com>
References: <20100924100019.GT23563@ece.pdx.edu>
	<AANLkTin_wrCnpz-fz=FuJ96j+xBHM1-5HTGG0vP7bmDY@mail.gmail.com>
	<20100924204032.GU23563@ece.pdx.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Tait <git.git@t41t.com>
X-From: git-owner@vger.kernel.org Sat Sep 25 00:39:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzGvc-00060X-Ba
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 00:39:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758303Ab0IXWjf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 18:39:35 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45780 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755460Ab0IXWje (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 18:39:34 -0400
Received: by iwn5 with SMTP id 5so2731423iwn.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 15:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=/2V5By8WhLr2OhTLz4KseQ+WrMivaSytdRnvkXIa1Lk=;
        b=Lvi3HexDoB/WCeHofCsc+iRk9jlYpC4zkOEAUHMuIIjpspO0i53q94Fms5Bj56shzV
         z8SOOz7Fk+1xB5YzVuvVezLZk9VARkxKaWvVbm95jX2gx+3Zpswisca4pP/f667qNLn7
         fwQdnFSyb5gWh84Hdg5SnobiqP3tCWe02ehZc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=lylnHXm+m3hCo6Sp3umHsUCsC0F1MsS3IBhtpgp8roOiitWFaMyyFj8sqK5i/vWNgx
         4VKikF0J/06sZRmxJWPv8/0xiDjTvAp6OBpeWulxaAHFujvYZLfEe+h+RN6mprSmZ5pf
         6ArdmtRMqurZ+S1eNH3/6iXBbiNBD8cY9iy1g=
Received: by 10.231.191.136 with SMTP id dm8mr4451042ibb.75.1285367972297;
 Fri, 24 Sep 2010 15:39:32 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Fri, 24 Sep 2010 15:39:32 -0700 (PDT)
In-Reply-To: <20100924204032.GU23563@ece.pdx.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157092>

On Fri, Sep 24, 2010 at 20:40, Tait <git.git@t41t.com> wrote:
>> > What is the minimum Perl version git expects to support?
>> >
>> > I ask, because f922df8... seems to have introduced a open() syntax that
>> > is not compatible with some older Perl versions.
>>
>> We generally support 5.6 or above, but 5.8 or above for some other
>> programs.
>
> I am having to use a system with 5.6.1 to do cvsimport and cvsexportcommit,
> and interactive add. I haven't tried sendmail or other functions, yet. This
> system was previously using git 1.6.5.something, and did not have these
> problems as of that release, but now that I'm building git 1.7.3, they
> have appeared.

Maybe marking everything as needing 5.8 or later isn't the right thing
to do. E.g. the git-*cvs*.perl code mostly isn't touched, but
cvsexportcommit does use Git.pm, so that would also need to be pinned
at 5.6 if cvsexportcommit was.

> Perl 5.6.1 doesn't support the list open syntax, so one must replace
> open(my $fh, '-|', @list) with open(my $fh, '-|'), and then exec(@list).
> I'm working up a patch set to fill my own needs on this system, but based
> on the subsequent discussion about setting 5.8 as the minimum, it sounds
> like it's not worth submitting.

The issue isn't that we don't have a workaround for individual bits
like open(my $fh, '-|', @list), but rather that keeping all of the
code 5.6 compatible is a burden on ongoing maintenance for a very
marginal benefit.
