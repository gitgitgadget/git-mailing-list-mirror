From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Publishing "filtered branch repositories" - workflow / recommendations?
Date: Fri, 06 Dec 2013 09:48:41 +0100
Message-ID: <52A18F69.70002@web.de>
References: <CACPiFCJPq0fqOQrJD-8CHH405Xw61ZDynqqfN+_aZb3ZBgV2VA@mail.gmail.com> <52A0D199.1010403@web.de> <CACPiFCKHprB_oO_eXMYkey_CGbT7WOn5VDDjBdHbLRzcDpHnZw@mail.gmail.com> <52A0D9F5.3030101@web.de> <CACPiFCJ3mkOj=E+siideBpPfgS1tSicVQ46KqPK+Tha0DbkZHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 06 09:48:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vor5c-0001FM-Fj
	for gcvg-git-2@plane.gmane.org; Fri, 06 Dec 2013 09:48:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754035Ab3LFIsn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Dec 2013 03:48:43 -0500
Received: from mout.web.de ([212.227.15.3]:58266 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751543Ab3LFIsm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Dec 2013 03:48:42 -0500
Received: from [192.168.178.41] ([84.132.154.249]) by smtp.web.de (mrweb004)
 with ESMTPA (Nemesis) id 0LgK3g-1VCGg129Ey-00nhjN for <git@vger.kernel.org>;
 Fri, 06 Dec 2013 09:48:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.1
In-Reply-To: <CACPiFCJ3mkOj=E+siideBpPfgS1tSicVQ46KqPK+Tha0DbkZHw@mail.gmail.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:UQS4V1qfFQR5xwE1gWNJNPHY2riDk07vO/f6yOvlG4hGgoI/RnB
 M55hhJjULcI7f+2A6izE+wQH2szwKVxh2UQUCsLqtoNoqu8v0PSHdJ+5r/dwiafVl+3ZSwt
 pUaUAPnh79RJ4jdbwVyk0SwV9EOlOU+F1RyA8dfOdEiBraKyIv9u0+CouSBlMXPkbiqJ8+K
 uwjS0LevRQX1vCAg/N26Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238930>

Am 05.12.2013 23:06, schrieb Martin Langhoff:
> On Thu, Dec 5, 2013 at 2:54 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>> Am 05.12.2013 20:27, schrieb Martin Langhoff:
>>> On Thu, Dec 5, 2013 at 2:18 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>>>> Without knowing more I can't think of a reason why submodules should
>>>> not suit your use case (but you'd have to script branching and tagging
>>>> yourself until these commands learn to recurse into submodules too).
>>>
>>> The submodules feature is way too fiddly and has abundant gotchas.
>>
>> Care to explain what bothers you the most? Being one of the people
>> improving submodules I'm really interested in hearing more about that.
> 
> Very glad to hear submodules is getting TLC! I have other scenarios at
> $dayjob where I may need submodules, so happy happy.
>
> I may be unaware of recent improvements, here's my (perhaps outdated) list

Thanks a lot for your feedback!

>  - git clone does not clone existing submodules by default. An ideal
> workflow assumes that the user wants a fully usable checkout.

You get that when using "git clone --recurse-submodules", but there
is no configuration option yet to switch that on by default (but we
are planning to add one).

>  - git pull does not fetch&update all submodules (assuming a trivial
> "tracking repos" scenario)

Current pull does fetch them (when changes to them are found in the
fetched commits of the superproject), but it does not yet update
them (there is the "recursive update" work in progress to do that).

>  - git push does not warn if you forgot to push commits in the submodule

We do have a command line option ("--recurse-submodules=check" is
what you want here), but no configuration option yet.

> there's possibly a few others that I've forgotten. The main issue is
> that things that are conceptually simple (clone, git pull with no
> local changes) are very fiddly. Our new developers, testers and
> support folks hurt themselves with it plenty.

Seems like we already solved some of those, and your feedback shows
me that we are moving in the right direction. I keep a list of open
issues we are aware of at:

  https://github.com/jlehmann/git-submod-enhancements/wiki

Feel free to point out missing topics.

> I don't mind complex scenarios being complex to handle. If you hit a
> nasty merge conflict in your submodule, and that's gnarly to resolve,
> that's not a showstopper.

Good to hear that! Solving them automatically is hard, only fast
forwards are currently resolved without user intervention.

> While writing this email, I reviewed Documentation/git-submodule.txt
> in git master, and it does seem to have grown some new options. I
> wonder if there is a tutorial with an example workflow anywhere
> showing the current level of usability. My hope is actually for some
> bits of automagic default behaviors to help things along (rather than
> new options)...

Right you are, we need tutorials for the most prominent use cases.

> Early git was very pedantic, and over time it learned some DWIMery.
> You're giving me hope that similar smarts might have grown in around
> submodule support ...

That's what we are aiming at :-)
