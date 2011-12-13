From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v4 2/2] push: teach --recurse-submodules the on-demand
 option
Date: Tue, 13 Dec 2011 09:48:27 +0100
Message-ID: <4EE7115B.8040000@web.de>
References: <1313791728-11328-1-git-send-email-iveqy@iveqy.com> <1313791728-11328-3-git-send-email-iveqy@iveqy.com> <7vmxemls8z.fsf@alter.siamese.dyndns.org> <20111017190749.GA3126@sandbox-rc> <7vr52bjljd.fsf@alter.siamese.dyndns.org> <4E9DE883.9050105@web.de> <CABURp0okOmsk4JV9Ku5pHJb5vT-kr_fmweNNBKZ_OoRyfZan=Q@mail.gmail.com> <4EE6805D.7020708@web.de> <CABURp0qkKXCW-U=78OpnejdtdpphhJtOoDubz77m7Gt3o5sC=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 13 09:48:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaO2S-0006o3-Bm
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 09:48:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753852Ab1LMIsg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 03:48:36 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:34853 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753625Ab1LMIsf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 03:48:35 -0500
Received: from moweb001.kundenserver.de (moweb001.kundenserver.de [172.19.20.114])
	by fmmailgate01.web.de (Postfix) with ESMTP id 017751A44D9B9
	for <git@vger.kernel.org>; Tue, 13 Dec 2011 09:48:34 +0100 (CET)
Received: from [192.168.178.25] ([80.187.110.206]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0MSav6-1R8znN01p6-00SQfI; Tue, 13 Dec 2011 09:48:32
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <CABURp0qkKXCW-U=78OpnejdtdpphhJtOoDubz77m7Gt3o5sC=Q@mail.gmail.com>
X-Provags-ID: V02:K0:+1JJbF6iAK4hFIvR8hZPdFdlN7YSCwKgtMZBtZ4MKRd
 W9ULKcFpRp3VJiKFMCsROFwvh8hOGI3jZlXck/Uk1f9yi1WWKh
 exGYUUjjnueyN+iwX7iTiPp1M9TvDZgvc+8bVfQacS9/W2Hpiz
 RfO6tjfUJNKQbScaAtjtur2QnSs4Ss31FRneJ2u8ybsanBuTOH
 05EWvR3zq+hTUfGpqP1EA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187010>

Am 13.12.2011 00:50, schrieb Phil Hord:
> On Mon, Dec 12, 2011 at 5:29 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>> Am 12.12.2011 22:16, schrieb Phil Hord:
>>>  I thought-experimented with this a bit last year and came to the
>>> conclusion that I should be able to 'float' to tips (developer
>>> convenience) and also to store the SHA-1 of each gitlink through
>>> history (automated maybe; as-needed).
>>
>> Which means that after "git submodule update" floated a submodule branch
>> further, you would have to commit that in the superproject.
> 
> Sadly, yes.  Currently I have my CI-server do this for me after it
> verifies each new submodule commit is able to build successfully.

Which I think is a good thing to do, as you have a good chance of
catching breakage introduced by the submodule updates. "float-only"
submodules won't always be a pleasant experience, as they can (and
sometimes will) get you into trouble when advancing them introduces
bugs (and then you can't even bisect that breakage).

>>> The problem with "float + gitlinks", of course, is that it looks like
>>> "not floating" to the developers (git-status is dirty unless
>>> overridden, etc.)
>>
>> Yeah. But what if each "git submodule update" would update the tip of
>> the submodule branch and add that to the superproject? You could follow
>> a tip but still produce reproducible trees.
> 
> Yes, and that's what I want.
> 
> Not what it sounded like was being suggested before, which (to my
> eyes) implied that the submodule gitlinks were useless noise.

It was suggested in other threads in the past. For a start, you could
write a script doing that and play around with it. And if that works
well for you, we can discuss if implementing that functionality into
"git submodule update" makes sense.
