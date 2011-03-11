From: Alexander Miseler <alexander@miseler.de>
Subject: Re: Summer of Code project ideas due this Friday
Date: Fri, 11 Mar 2011 15:10:15 +0100
Message-ID: <4D7A2D47.9010101@miseler.de>
References: <AANLkTinpVKBjcqxaCGH0vp82kpKsO2uCBPdMoMKco6Ex@mail.gmail.com> <20110303185918.GA18503@sigill.intra.peff.net> <AANLkTinXZDq5FJxMmxUuWpCGgMYb3HH774eLJCojmnOz@mail.gmail.com> <20110303203323.GA21102@sigill.intra.peff.net> <20110309174956.GA22683@sigill.intra.peff.net> <AANLkTinpAOE06YX-m=ptQM_y-QMGpVmjewDxWopkXJkQ@mail.gmail.com> <20110309215841.GC4400@sigill.intra.peff.net> <4D7A1325.1090003@miseler.de> <20110311125259.GA777@LK-Perkele-VI.localdomain> <AANLkTin30fZURU-PxddSai5Qzfqjtwej=maGssyr2b7W@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>, git <git@vger.kernel.org>,
	Pranav Ravichandran <prp.1111@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 11 15:10:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Py33A-0005DM-4N
	for gcvg-git-2@lo.gmane.org; Fri, 11 Mar 2011 15:10:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753638Ab1CKOKe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2011 09:10:34 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:62004 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496Ab1CKOKd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2011 09:10:33 -0500
Received: from [192.168.0.32] (dslb-188-103-098-160.pools.arcor-ip.net [188.103.98.160])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0MCdZW-1PofOS1gMk-0090xH; Fri, 11 Mar 2011 15:10:27 +0100
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <AANLkTin30fZURU-PxddSai5Qzfqjtwej=maGssyr2b7W@mail.gmail.com>
X-Provags-ID: V02:K0:AqQhzzXU06XPGtWhlmTXuUhkHhimM+ri4hM2+/ltFEy
 0KyVcuPQIpzF5eDIogq6/T9YR6dSFGYRfVLJZMcO4Ockmfei11
 rBMNqFm1cA4yWgTuB6LG11mumb55j/pE049ooL+jlB7jDsR5S+
 OrlDek7fTVPYFZBp7SFRheU8qkujqD6WkFE7hH3LXlvOemJT2M
 Lez2G6OR+IQKWc7Pc4kdw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168900>

On 11.03.2011 14:48, Nguyen Thai Ngoc Duy wrote:
> On Fri, Mar 11, 2011 at 7:52 PM, Ilari Liusvaara
> <ilari.liusvaara@elisanet.fi>  wrote:
>> On Fri, Mar 11, 2011 at 01:18:45PM +0100, Alexander Miseler wrote:
>>> Resumable clone
>>
>> This is very very hard. Not so much to implement but to design the way it
>> can be done without assuming things (like object sort orders) that aren't
>> stable.
>
> Yes it's hard. I have some experimental thing that nearly works [1],
> although whether it is an acceptable approach is to be seen. If
> anyone's interested, I'll post it some time
>
> A simpler way to restartable clone is to facilitate bundles (Nicolas'
> idea). Some glue is needed to teach git-fetch/git-daemon to use the
> bundles, and git-push to automatically create bundles periodically (or
> a new command that can be run from cron). I think this way fit in GSoC
> scope better.
>
> [1] The idea of my work above was mentioned elsewhere, history is cut
> down by path. Each file/dir's history a very long chain of deltas. We
> can stream deltas (in parallel if needed) over the wire, resuming
> where the chain stops last time.
>
> There are many problems. One is that a deep chain can make git run out
> of stack, so chains have to be broken down before storing (not done).
> Another one is that not many deltas can be reused, so it will consume
> more power than normal clone. But once you clone this way, the cloned
> repo have lots of delta suitable for another clone (but probably not
> for anything else).


This may all be aiming to short. IMHO the best solution would be some generic way for the client to specify exactly what 
it wants to get and to get just that. This would lay the groundwork for:
- lazy clones
- sparse clones
- resumable cloning
- resumable fetching
and probably quite a few other nifty tricks.

I guess that would be far beyond the scope of a SoC project though.
