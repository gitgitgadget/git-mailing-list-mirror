From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: Re: git-cherry-pick and git-commit --amend in version 1.7.6.4
Date: Thu, 06 Oct 2011 09:53:12 +0200
Organization: 6WIND
Message-ID: <4E8D5E68.8050403@6wind.com>
References: <4E8C6F2F.1070306@6wind.com> <CAG+J_DynqAK8uXDPtHwWpGhfA5qFZifucs91qL79Pu_DmCxG3g@mail.gmail.com> <4E8D5AD0.2040509@6wind.com>
Reply-To: nicolas.dichtel@6wind.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 06 09:53:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBilc-0004ib-Lb
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 09:53:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934981Ab1JFHxQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Oct 2011 03:53:16 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42287 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932374Ab1JFHxP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 03:53:15 -0400
Received: by wyg34 with SMTP id 34so2511613wyg.19
        for <git@vger.kernel.org>; Thu, 06 Oct 2011 00:53:14 -0700 (PDT)
Received: by 10.216.82.14 with SMTP id n14mr592786wee.10.1317887594448;
        Thu, 06 Oct 2011 00:53:14 -0700 (PDT)
Received: from [192.168.1.4] (schneckos.n1c0.com. [88.182.61.195])
        by mx.google.com with ESMTPS id h39sm8782253wbo.0.2011.10.06.00.53.12
        (version=SSLv3 cipher=OTHER);
        Thu, 06 Oct 2011 00:53:13 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.23) Gecko/20110921 Thunderbird/3.1.15
In-Reply-To: <4E8D5AD0.2040509@6wind.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182934>

Le 06/10/2011 09:37, Nicolas Dichtel a =C3=A9crit :
> Le 05/10/2011 18:50, Jay Soffian a =C3=A9crit :
>> On Wed, Oct 5, 2011 at 10:52 AM, Nicolas Dichtel
>> <nicolas.dichtel@6wind.com> wrote:
>>> Hi,
>>>
>>> still with version 1.7.6.4, when I do a cherry-pick, that succeeded=
, I
>>> cannot do a commit --amend after:
>>>
>>> # git cherry-pick 3f78d1f210ff89af77f042ab7f4a8fee39feb1c9
>>> [dev 1a04a23] drivers/net/usb/asix.c: Fix unaligned accesses
>>> 1 files changed, 33 insertions(+), 1 deletions(-)
>>> # echo $?
>>> 0
>>> # git commit --amend
>>> fatal: You are in the middle of a cherry-pick -- cannot amend.
>>> #
>>>
>>> The same operations (with the same patch), with version 1.7.3.4 is =
ok.
>>
>> Please do the following with 1.7.6.4:
>>
>> # ls .git
>> # git cherry-pick 3f78d1f210ff89af77f042ab7f4a8fee39feb1c9
>> # ls .git
>> # git cat-file -p 3f78d1f210ff89af77f042ab7f4a8fee39feb1c9
>> # git cat-file -p HEAD
>>
>> And send the transcript.
> Here is:
>
> # ls .git
> branches COMMIT_EDITMSG config description FETCH_HEAD HEAD hooks inde=
x info logs
> objects ORIG_HEAD packed-refs refs
> # git cherry-pick 3f78d1f210ff89af77f042ab7f4a8fee39feb1c9
> [dev 4cca2c2] drivers/net/usb/asix.c: Fix unaligned accesses
> 1 files changed, 33 insertions(+), 1 deletions(-)
> # ls .git
> branches CHERRY_PICK_HEAD COMMIT_EDITMSG config description FETCH_HEA=
D HEAD
> hooks index info logs objects ORIG_HEAD packed-refs refs
> # git cat-file -p 3f78d1f210ff89af77f042ab7f4a8fee39feb1c9
> tree f29742a1a73c27a88c7ac701a7a06ac1c2f7973a
> parent e7a3af5d8cd782b84e6ca4e4dcc8613be1a809f0
> author Neil Jones <NeilJay@gmail.com> 1274141908 -0700
> committer David S. Miller <davem@davemloft.net> 1274141908 -0700
>
> drivers/net/usb/asix.c: Fix unaligned accesses
>
> Using this driver can cause unaligned accesses in the IP layer
> This has been fixed by aligning the skb data correctly using the
> spare room left over by the 4 byte header inserted between packets
> by the device.
>
> Signed-off-by: Neil Jones <NeilJay@gmail.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> # git cat-file -p HEAD
> tree 282b6492d9d5bcf1c3718420c6f31ca2033ca5cb
> parent c8054f854773e65d8592f2ef35939ec2ae8b01df
> author Nicolas Dichtel <nicolas.dichtel@6wind.com> 1317886553 +0200
> committer Nicolas Dichtel <nicolas.dichtel@6wind.com> 1317886553 +020=
0
>
> drivers/net/usb/asix.c: Fix unaligned accesses
>
> Using this driver can cause unaligned accesses in the IP layer
> This has been fixed by aligning the skb data correctly using the
> spare room left over by the 4 byte header inserted between packets
> by the device.
>
> Signed-off-by: Neil Jones <NeilJay@gmail.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> #
>
There is another symptom, describe in this thread:
http://comments.gmane.org/gmane.comp.version-control.git/182852

Maybe the two problems are related.


Regards,
Nicolas
