From: demerphq <demerphq@gmail.com>
Subject: Re: General support for ! in git-config values
Date: Thu, 2 Feb 2012 11:21:54 +0100
Message-ID: <CANgJU+XoZd6x6jdSHszigZaPgi+6H3Nbf4OG7p0y1_=7m+qntA@mail.gmail.com>
References: <20120201184020.GA29374@sigill.intra.peff.net>
	<CACBZZX5mX55Rh8b2GYv7wKbCCypCkrn5AiM9BpXydgcYxHWdQA@mail.gmail.com>
	<7v62fq2o03.fsf@alter.siamese.dyndns.org>
	<CANgJU+X+UZmycwE6xkJ-zHfT7ai6nV9zbeR4WYnAXczL5JtqjA@mail.gmail.com>
	<7vliom13lm.fsf@alter.siamese.dyndns.org>
	<CANgJU+XQWdFmfmBJ4KX4GBz1a=TrVbp9BphGmhEb5Gphmzogjw@mail.gmail.com>
	<7v7h06109t.fsf@alter.siamese.dyndns.org>
	<CANgJU+WCdsF+igCWoueYcChYBvNyj5je_kvWorCBOgh5D7Bb9g@mail.gmail.com>
	<20120202023857.GA11745@sigill.intra.peff.net>
	<CANgJU+X2dRP__PFAywGEisDS3xyF7fSszSQG6BO61j2TMKL3Qg@mail.gmail.com>
	<20120202095432.GA19356@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 02 11:22:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rstnl-0006gU-9l
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 11:22:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754811Ab2BBKV4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 05:21:56 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:53452 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754650Ab2BBKVz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 05:21:55 -0500
Received: by ggnh1 with SMTP id h1so1080399ggn.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 02:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=d9zcA9TNjSBmPeFBWm0RoMLI2FEXyTdNSscUhH+BVxg=;
        b=Qpk9gOxKE8JezBofg4HUcki3vPpZhk42juMSaV78H+KdqIv7ucme+AsYxVEzIayiL/
         sfYCS97/5qliBfzL7mRF05XKpWVoT9VEy0vIiAxVgiChGE8PbIxw3vlMHLX/JI58YTzy
         Lxt8R7w9q/p++8i76RRjHP6gFxXKJu+VQQvzg=
Received: by 10.101.51.12 with SMTP id d12mr835863ank.69.1328178114724; Thu,
 02 Feb 2012 02:21:54 -0800 (PST)
Received: by 10.236.63.2 with HTTP; Thu, 2 Feb 2012 02:21:54 -0800 (PST)
In-Reply-To: <20120202095432.GA19356@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189616>

On 2 February 2012 10:54, Jeff King <peff@peff.net> wrote:
> On Thu, Feb 02, 2012 at 10:44:05AM +0100, demerphq wrote:
>
>> The general design of git seems to me to be based around providing
>> building blocks that people can use to build new and interesting tools
>> on top of, and so it seems counter to that philosophy to reject an
>> feature based on speculative security issues that really can't be
>> decided in advance but must instead be decided on a case by case
>> basis.
>
> I can't speak for Junio, but I am certainly not rejecting it. Only
> saying that it needs to be thought through, and the utility weighed
> against the costs.

Of course. I totally understand. I have written mails saying stuff
like this myself. :-)

> So far I haven't seen an actual patch to comment on
> (or even a proposed syntax beyond starting a string with "!", which I
> think is a non-starter due to conflicting with existing uses),

I understand. I think we will probably use backtick quoting in git-deploy. So

deploy.prefix=`cat /etc/SERVER_ROLE`

will execute cat /etc/SERVER_ROLE and use the results as the value of
the config option.

> nor have
> I seen a concrete use case (you mentioned pulling the name/email from
> ldap, but you also mentioned that there are lots of other ways of
> solving that particular problem, so it's not especially compelling).

One place that it would be useful for us in git-deploy would be to
detect the tag prefix for the rollout we are doing. Every staging
server already has a file that contains this value. We would like to
make it easy for people to configure the tool to either use the value
provided, or to use something like  `cat /etc/SERVER_ROLE` instead.
Anyway, from that POV I could totally understand "so do that in
git-deploy". Since the tool is written in perl we have to wrap
git-config anyway, so it easy to add a special case for ourselves.

But I still think the general idea is pretty useful, the ldap example
is IMO a cleaner solution than the alternatives, and a variant that I
think is much harder to do currently come to mind right away: setting
the user.email automatically depending on where in your tree a git
repo was located, so that when I work on repo underneath  /CPAN/ it
uses my CPAN address, and when I work in my /work/ tree it uses my
$work address, etc, without me having to configure it repo by repo.
(This has bitten more than once in the past)

> I'd be happy to hear a more concrete proposal.

I will be mostly afk the next week so I will leave that to Avar if he
wants to pursue it.

cheers,
Yves


-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
