From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 3/4] reset: add option "--merge-safe" to "git reset"
Date: Thu, 17 Sep 2009 15:25:23 +0200
Message-ID: <c07716ae0909170625s7d7e93a5n500db9e4d341335f@mail.gmail.com>
References: <20090917040835.4048.51057.chriscool@tuxfamily.org>
	 <20090917041440.4048.16353.chriscool@tuxfamily.org>
	 <7vk4zykv7o.fsf@alter.siamese.dyndns.org>
	 <4AB1D957.20902@viscovery.net>
	 <7vr5u6jbgk.fsf@alter.siamese.dyndns.org>
	 <4AB1E41F.6050304@viscovery.net>
	 <c07716ae0909170512k3c2ec7m21e69e9acfdfd81f@mail.gmail.com>
	 <4AB23410.6080508@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Sep 17 15:25:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoGzN-0001jL-Ii
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 15:25:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752750AbZIQNZW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Sep 2009 09:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752152AbZIQNZW
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 09:25:22 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:57668 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751678AbZIQNZV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Sep 2009 09:25:21 -0400
Received: by fxm17 with SMTP id 17so17863fxm.37
        for <git@vger.kernel.org>; Thu, 17 Sep 2009 06:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=sPLC2iplY5h+O4Xx5Bu/3so2rhuGQfXd18pRgxST1o4=;
        b=Skxyc8g+70n2hm53wlJ02F+bQ47D/P78FbYgaI56fvhBz64r9V95snPTY/zCrDvMzL
         Kfxd/gG/gt4/lcsYHOWX1XmVGQKOwoRE+nBoyHMxoUpWaPdRLNXbQfF/BW0F+Z5Uda7i
         l7/bs9fAvHrlP4xfMePGhST3IFHEXTGTRvY3A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fRBYorskr9AdNX1IEb+nxj8H7dC4sPeCEdh6p3VqOmq05XlrjqAgtUuh60oxq7/D03
         zpyVdKYLsl8BH5kT65bs5octrvP9hMSqP+ghoABQEWF+ni4d+wweA2x0QT+pYlbiUUnf
         ycLK9+suEVrgy8OLNxhI8rq64sRjIHbUV6uBM=
Received: by 10.204.15.6 with SMTP id i6mr407447bka.59.1253193924024; Thu, 17 
	Sep 2009 06:25:24 -0700 (PDT)
In-Reply-To: <4AB23410.6080508@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128754>

On Thu, Sep 17, 2009 at 3:05 PM, Johannes Sixt <j.sixt@viscovery.net> w=
rote:
> Christian Couder schrieb:
>> On Thu, Sep 17, 2009 at 9:24 AM, Johannes Sixt <j.sixt@viscovery.net=
> wrote:
>>> Junio C Hamano schrieb:
>>>> Johannes Sixt <j.sixt@viscovery.net> writes:
>>> =A0$ git stash
>>> =A0$ git reset --hard $target
>>> =A0$ git stash pop
>>>
>>>> I have _no_ idea what the intended use-case of --merge-safe is, an=
d that
>>>> was why I asked Christian for clarification in the previous round.=
 =A0The
>>>> answer was still not clear enough so I pointed out --merge-safe co=
uld be
>>>> still doing a wrong thing even in _his_ use-case.
>>> Reading Christian in 200909170554.49416.chriscool@tuxfamily.org, I =
think
>>> this *is* his use-case? Christian?
>>
>> Yes, I agree, it can be used instead of git stash.
>
> It "can"? Do you say that you intend --merge-safe for something else =
in
> addition to the above stash + reset --hard + stash pop sequence? What=
?

As I said to Junio, another "use case" is to enable more commands (like
an improved cherry-pick) to be used with a dirty work tree or index.

>> By the way Linus, in his
>> patch that added the --merge option, said that --merge could be used=
 like
>> that.
>
> But that use-case has one important difference: You can't use stash r=
ight
> before the reset:
>
> =A0 # work tree is dirty
> =A0 $ git pull $there $topic =A0# assume we have conflicts
>
> =A0 # investigate result ...
> =A0 # oh no, that's crap, scratch it
>
> =A0 $ git stash what? conflicted changes?
> =A0 $ git reset what? --hard would remove my dirty state, too
>
> You are screwed. 'git reset --merge' comes to rescue.
>
> I'm pretty sure you don't mean --merge-safe to provide extra safety i=
n
> *this* use-case,

You are right, I don't think it is usefull in this use case.

> but that you have a very different use-case in mind.

I don't have other use cases I didn't already talked about in mind.

Best regards,
Christian.
