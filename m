From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [ITCH] Specify refspec without remote
Date: Thu, 11 Apr 2013 02:11:01 +0530
Message-ID: <CALkWK0nfJezWbd3+VfA+DMqUNbekSJJJ539AmhQT37kkap_qeg@mail.gmail.com>
References: <20130409231332.GZ30308@google.com> <7vobdnnpx6.fsf@alter.siamese.dyndns.org>
 <20130410041343.GB795@sigill.intra.peff.net> <7v4nfenxzm.fsf@alter.siamese.dyndns.org>
 <20130410172748.GA16908@sigill.intra.peff.net> <7vhajemd1x.fsf@alter.siamese.dyndns.org>
 <20130410185958.GA22394@sigill.intra.peff.net> <CALkWK0nKvTiGsjO4zF81nsSuUM=MmmbpdzHWB=4hFR2PiB+LWg@mail.gmail.com>
 <20130410195256.GA24177@sigill.intra.peff.net> <CALkWK0nAMVKuDg4wmwujkpNxAF9zxQEdsZXyUzr+w4zVpWDCzA@mail.gmail.com>
 <20130410202105.GE24177@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	=?UTF-8?B?RHV5IE5ndXnhu4Vu?= <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 10 22:41:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ1pz-0004tp-Sr
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 22:41:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935771Ab3DJUlm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 16:41:42 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:42509 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935648Ab3DJUll (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 16:41:41 -0400
Received: by mail-ie0-f172.google.com with SMTP id c10so1132614ieb.17
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 13:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=BjqMMEt3Ll59ixO5etp5x/6zn9RdZ9EyDzeGXKQIeYg=;
        b=v3xbqYCgjr3S33MW7vlhRChipyd3zJiR2CO9H6mY9pOVn5wBdWSKtQxlEx9q68zO5o
         IETdI1s0qHzJ1ApIDMMArPCEffC9GyGowZxxxTQ+jKvPxHSdbJGBtjzGB6Ru2YJZcFis
         Pqk7xbkDo0b52Z0lWD4aNvrDOYMIqu/mAL/vgIFPMsxvhPk0nzISRfygloDWmuL3FJjA
         lkhO0ZhVgbYOheZu4VHZ0fcocAkgCOhSmB42cL0Wtic2t8urFnjVRPfVCZoesLrajTHM
         S/Td3qy5JSjop9vKXNbDD5MSBzdH1m3tsv0IVW3jyKa80qWmpPtg3CvjYYOxlOnCbbez
         E4EA==
X-Received: by 10.50.17.166 with SMTP id p6mr14313096igd.12.1365626501543;
 Wed, 10 Apr 2013 13:41:41 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Wed, 10 Apr 2013 13:41:01 -0700 (PDT)
In-Reply-To: <20130410202105.GE24177@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220757>

Jeff King wrote:
> On Thu, Apr 11, 2013 at 01:35:34AM +0530, Ramkumar Ramachandra wrote:
>
>> Jeff King wrote:
>> > Maybe. But no more so than the current:
>> >
>> >   git push
>> >
>> > which may also push master and next to the same remote.
>>
>> I would argue that this was not really a problem in practice, until I
>> introduced branch.<name>.pushremote.
>>
>> Let us imagine that I was working on artagnon/git.git (remote: ram), a
>> fork of git/git.git (remote: origin) earlier.  My fork contains the
>> link and implicit-push branches in addition to the master, next and pu
>> branches, which are present on both.  When I push from my
>> implicit-push branch with push.default = matching, I'm updating all
>> the matching refs on the remote ram (since branch.implicit-push.remote
>> is set to ram), which is fine.  Now, I git push while on branch
>> master.  My push is simply rejected, as I don't have write access to
>> the remote origin.
>>
>> This is designed exactly for the read-only upstream, read-write fork
>> scenario.  If I had write access to upstream (where we're essentially
>> regression to a centralized model), we'd have some major confusion.
>
> I don't see how pushremote changes that. It was already a problem with
> branch.*.remote, no?

Technically, it changes nothing.  pushremote is only an enabler for
more complex scenarios where git push; breaking user expectations is
magnified.

According to me, what branch.<name>.pushremote suddenly starts
supporting (apart from the use I intended for it) is each branch
having different read/ write access.  So, we're back to git.git where
Junio has graciously given me write support to pu, but not next or
master.  So I set up branch.master.pushremote and
branch.next.pushremote to ram and run git push; from pu.  Disaster:
the pu ref went through fine, but master and next failed to get pushed
despite me specifying a proper pushremote for them.

> I have a similar remote setup in my git.git repository. But all of my
> branch.*.remote variables point to origin, because my branches are based
> off of Junio's master. A matching push goes to the wrong place (and I
> have screwed it up many times; it is nice that I do not have write
> access to Junio's repository). The is broken without having pushremote
> at all (and the proper fix is your remote.pushdefault).

Yeah, I can't believe I lived without remote.pushdefault for this long.

> If we are not going to break the existing behavior, I think it can be
> argued that consistency and simplicity of the rules is important, so the
> user can predict what will happen. But the more we discuss, the more I
> think we should simply change the current behavior (to stop respecting
> branch.* config with "matching"), which just seems wrong to me. Then we
> can be simple and consistent, and do what the user probably intended.

So there are some push.default options that respect branch.* config
(ie. "current"), and others that don't (ie. "matching").  I would
argue that push.default is badly designed to begin with, so the
solution makes sense to me even if the patch is a bit of hack; we
never guaranteed that the various push.default options respect the
same configuration variables.
