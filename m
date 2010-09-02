From: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Thu, 2 Sep 2010 14:37:30 +0100
Message-ID: <AANLkTimpE6rf0azHtrz6BFK5d7YojF+G1YuSA1gusSC=@mail.gmail.com>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com>
	<AANLkTinu=RoGfq93d+yjHiQwCt0HXx4YtqfvhXyZdO=F@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 02 15:37:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Or9z0-0004LG-JA
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 15:37:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754627Ab0IBNhc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 09:37:32 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:38208 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752864Ab0IBNhb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Sep 2010 09:37:31 -0400
Received: by pxi10 with SMTP id 10so102106pxi.19
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 06:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=2FHcznd8tYsA+v2innVEgki3L4sBCMwgfJ/5sQOvwRw=;
        b=fTc3wCA1w4nrTwB3XkvFWKDfXVhMMX4VGwc8vzotZnHHG3ijrtytT0rnizBCoIm3kg
         c0zuOA2UBaG4qMezklBmJ19UiTFD1nsdzO9n6SUEKQFBNMeWM31M87jksVlcqR/Rl2vJ
         lCVGXdryBys/oDSEpjyPm4LK0mOB+tJoV/Feg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=apuA8Ph7ZvgtcUPaVr0YnQn9A9rRw40QqTWxKl9aHqkXbBUuPXgvhHISNd3Wootmot
         1Ak3fAamRVIAxIBRz0fKOluKfMz844EpNwAgLDs8aUHc50SQvq4E/KmMLiI54s/M7yLT
         mAxFiAAdJv10mKnSAhRHQ8rvxWEJsaBVkw3+A=
Received: by 10.114.61.1 with SMTP id j1mr3796339waa.76.1283434650859; Thu, 02
 Sep 2010 06:37:30 -0700 (PDT)
Received: by 10.220.98.8 with HTTP; Thu, 2 Sep 2010 06:37:30 -0700 (PDT)
In-Reply-To: <AANLkTinu=RoGfq93d+yjHiQwCt0HXx4YtqfvhXyZdO=F@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155127>

On Wed, Sep 1, 2010 at 11:04 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.co=
m> wrote:
> On Thu, Sep 2, 2010 at 12:36 AM, Luke Kenneth Casson Leighton
> <luke.leighton@gmail.com> wrote:
>> http://gitorious.org/python-libbittorrent/pybtlib
>>
>> hurrah - success! =C2=A0git fsck shows a "dangling commit"!
>>
>> so, as a proof-of-concept, 400 lines of python code plus a bittorren=
t
>> library shows that it's possible to create a peer-to-peer distribute=
d
>> version of "git fetch", by treating the pack objects as "files to be
>> shared".
>
> You should have a look at gittorrent [1] (and finish it too if you ar=
e
> interested).

 it's in perl, and has been shelved afaik.  sam (hi sam, you still
here? :) abandoned bittorrent as the underlying mechanism, and i
disagree with that decision, hence why i created what i have, to prove
that it's viable.

 so a) i don't do perl so would need to re-create what's been done
(which i don't understand, and, because it's incomplete, i can't do a
perl-to-python translation and "have something working") b) i don't
believe in reinventing the wheel ESPECIALLY on something as complex as
peer-to-peer file distribution.

 cameron dale created apt-p2p which is a recreation of a peer-to-peer
file distribution mechanism, and, not surprisingly, it's slow and
problematic.

> There were discussions whether a pack is stable enough to
> be shared like this,

 it seems to be.  as long as each version of git produces the exact
same pack object, off of the command "git pack-objects --all --stdout
--thin {ref} < {objref}"

 is that what you're referring to?

 because if it isn't, then yes, the sharing of files (named by a
virtual filename of packs/{ref}/{objref} of course) which _might_ have
differences, yeah, it becomes a bit of a fuck-up.

> one of the reason "commit reel" was introduced.

 ah _ha_.  i need to look that up.  will get back to you.

 l.
