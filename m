From: Elijah Newren <newren@gmail.com>
Subject: Re: [RFD PATCH 00/32] subtree clone v2
Date: Tue, 24 Aug 2010 22:37:07 -0600
Message-ID: <AANLkTinsNvVup43B6nQtU6dvJy789n8kQm6N6na0J9oa@mail.gmail.com>
References: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
	<20100824223741.GB2376@burratino>
	<AANLkTikipryFVf_XvvbHopWSo5Ey_mvgTevY2NAvhygQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 06:37:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo7jf-0007Ve-4S
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 06:37:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844Ab0HYEhK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Aug 2010 00:37:10 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41243 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751510Ab0HYEhI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Aug 2010 00:37:08 -0400
Received: by fxm13 with SMTP id 13so84074fxm.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 21:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=rGM4PWYyB8eH4UU1sEmWHMyXnLXp8kYO20HcALlb6b4=;
        b=LNL2Pi1nn6oNhT+iU38BLRYF3HqOQaoj1ZK0SC7p4kkgj8SXGDuGE/+gwFFrqKyfR+
         D59Id88XwCk3NgdrBTL0LflngqEWHL1CgqUPXA2PZn/bpmExfvA04ngK1/qQCmwnIkuu
         +oG+9WG8QixqZ0TG1SoVRXZdEXUHKSVJu2nl8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=H4J074CtVIpJEDIJWeCeJ0H2z8HzHPpqczAoHfwI+JWwJN/vV9ePt9zYWh3Xf9/QwD
         X5F209Xrm0hme6BNGKcEdN+OOXKhZle1tjE1w54K7dxBr8iLrvm4uoUwHXrS04DniZU8
         W41aw66Vax2U92dbPVB+vXsFiN7nFNVzAoPvg=
Received: by 10.223.119.203 with SMTP id a11mr6922624far.42.1282711027400;
 Tue, 24 Aug 2010 21:37:07 -0700 (PDT)
Received: by 10.223.50.154 with HTTP; Tue, 24 Aug 2010 21:37:07 -0700 (PDT)
In-Reply-To: <AANLkTikipryFVf_XvvbHopWSo5Ey_mvgTevY2NAvhygQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154414>

On Tue, Aug 24, 2010 at 4:47 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.co=
m> wrote:
> On Wed, Aug 25, 2010 at 8:37 AM, Jonathan Nieder <jrnieder@gmail.com>=
 wrote:
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>>
>>> Patches 26..30
>>> =C2=A0 Add upload-narrow-base command
>>> =C2=A0 rev-list: traverse some more trees to make upload-narrow-bas=
e happy
>>> =C2=A0 narrow-tree: add oldest_narrow_base()
>>> =C2=A0 Add command fetch-narrow-base
>>> =C2=A0 merge: support merging when narrow bases are different
>>>
>>> Remote merge part.
>>>
>>> Split a merge operation into two parts, the real merge will be done
>>> within narrow tree. Conflicts can happen and be resolved in the nar=
row
>>> index, locally.
>>>
>>> Everything outside narrow tree will be merged (trivially) by
>>> server. Then server sends the base tree back, so join_narrow_tree()=
 in
>>> patch 20 can be used to create proper commit.
>>>
>>> Server can disable this remote merge feature, which means users are
>>> forced to do rebase/fast-forward. Not too bad.
>>
>> Yikes. =C2=A0Na=C3=AFve question (please forgive my laziness): is it=
 possible to
>> merge without remote contact in the boring case, when no changes hav=
e
>> occured outside the narrow tree?
>
> That's possible (and is implemented in my series). But I guess as soo=
n
> as you do "git pull", the boring case is likely not applicable
> anymore.

I'm not sure I follow.  Are you allowing changes outside the narrow
tree to occur?  If you're not, I would have assumed that repeated
pulls just work, without any need to talk to the server, using a
resolve-like strategy (with no special rename detection).

Here's my understanding, though it might have holes:

If you have a narrow/subtree clone, it means that you only have the
data for a certain paths.  I'm assuming that also meant you would only
allow modifying those paths.  In other words, you have no changes
outside the narrow tree.  Because of that, I think you can handle
paths outside the narrow region using trivial-merge logic:  From
Documentation/technical/trivial-merge.txt, I think the relevant cases
are 2, 3, 8, 10, 13, or 14.  13 & 14 already have a specified
resolution.  There's already a comment in the file that cases 8 & 10
could validly be resolved as (empty), it just hasn't been done in the
code as it tends to happen with the follow-up automatic merge anyway.
That only leaves cases 2 & 3 as being slightly tricky -- if a path on
one side of the merge started empty and ended empty, it would seem to
make sense that the non-empty path on the other side would be the
resolution.  We can't do that in the non-narrow clone case because the
non-empty path may have been created due to a rename and we'd like to
have changes follow the rename appropriately.  However, in the narrow
clone case, one can't rename from a path you don't have to a path you
do, so this possibility is eliminated.


So, if my understanding is correct, then if you have no changes from
upstream outside the sparse/narrow/whatever paths (where "paths"
currently means a single tree in your current patches), I think you
should be able to do a merge locally in that sparse clone.  The end
result will also have no changes from upstream outside those paths.
Thus, you should be able to merge again.


Does that seem reasonable?  Am I missing anything?
