From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: Re: git-cherry-pick and author field in version 1.7.6.4
Date: Thu, 06 Oct 2011 09:51:06 +0200
Organization: 6WIND
Message-ID: <4E8D5DEA.9010500@6wind.com>
References: <4E8C6F0E.7000508@6wind.com> <20111005174138.GA22962@sigill.intra.peff.net>
Reply-To: nicolas.dichtel@6wind.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 06 09:51:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBijh-0004J1-Rk
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 09:51:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934770Ab1JFHvM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Oct 2011 03:51:12 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:53811 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932374Ab1JFHvL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 03:51:11 -0400
Received: by wyg34 with SMTP id 34so2509741wyg.19
        for <git@vger.kernel.org>; Thu, 06 Oct 2011 00:51:09 -0700 (PDT)
Received: by 10.227.203.209 with SMTP id fj17mr586991wbb.89.1317887469185;
        Thu, 06 Oct 2011 00:51:09 -0700 (PDT)
Received: from [192.168.1.4] (schneckos.n1c0.com. [88.182.61.195])
        by mx.google.com with ESMTPS id s30sm8710088wbm.12.2011.10.06.00.51.07
        (version=SSLv3 cipher=OTHER);
        Thu, 06 Oct 2011 00:51:08 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.23) Gecko/20110921 Thunderbird/3.1.15
In-Reply-To: <20111005174138.GA22962@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182933>

Le 05/10/2011 19:41, Jeff King a =C3=A9crit :
> On Wed, Oct 05, 2011 at 04:51:58PM +0200, Nicolas Dichtel wrote:
>
>> in the last stable version (1.7.6.4), when I perform a
>> git-cherry-pick, the initial author of the patch is erased whith my
>> name (it was not the case in version 1.7.3.4 and prior). Is this
>> behavior intended ? Is there an option to keep the initial author of
>> the patch?
>
> I can't reproduce your problem:
>
>    git init repo&&
>    cd repo&&
>    echo content>file&&  git add file&&  git commit -m base&&
>    echo changes>>file&&
>    git commit --author=3D'Other Person<other@example.com>' -a -m othe=
r&&
>    git tag other&&
>    git reset --hard HEAD^&&
>    git cherry-pick other
>
> gives this output for the cherry-pick:
>
>    [master 6eb207f] other
>     Author: Other Person<other@example.com>
>     1 files changed, 1 insertions(+), 0 deletions(-)
>
> and the resulting commit looks good:
>
>    $ git log -1 --format=3D'%an<%ae>'
>    Other Person<other@example.com>
>
> Does the script above work for you? If so, then what is different abo=
ut
> your problematic case?
Here is my sequence. I'm in a linux tree with a remote that point to li=
nus tree=20
and I want to cherry-pick a patch from this remote:

# git cherry-pick 3f78d1f210ff89af77f042ab7f4a8fee39feb1c9
[dev 87ce387] drivers/net/usb/asix.c: Fix unaligned accesses
  1 files changed, 33 insertions(+), 1 deletions(-)
# git log -1 --format=3D'%an<%ae>'
Nicolas Dichtel<nicolas.dichtel@6wind.com>
# git log -1 --format=3D'%an<%ae>' 3f78d1f210ff89af77f042ab7f4a8fee39fe=
b1c9
Neil Jones<NeilJay@gmail.com>
#

Maybe it is related to the problem I've reported in another thread:
http://comments.gmane.org/gmane.comp.version-control.git/182853


Regards,
Nicolas
