From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC/PATCH] Add multiple workdir support to branch/checkout
Date: Thu, 6 Oct 2011 10:11:26 +1100
Message-ID: <CACsJy8D5FGr3R0tLYOND0kKNct4e_KgYfLUK8xL2Q4uNzWczgQ@mail.gmail.com>
References: <1317786204-57335-1-git-send-email-jaysoffian@gmail.com>
 <CACsJy8AqYq+YF+rvUp=BBeFUAtUz783iF2jbUp3fO58yLp9ptQ@mail.gmail.com>
 <CAG+J_DygQTD5ibco=-NOiKg0BLgBGFJnvV8zPyhngC2iZv_H8g@mail.gmail.com>
 <7vpqib8jzk.fsf@alter.siamese.dyndns.org> <CAG+J_Dz-GXvRbYUXSoyfyHfOO-_BszcOza9x=ysHhmL5YBW-Jw@mail.gmail.com>
 <7vzkhf713u.fsf@alter.siamese.dyndns.org> <CACsJy8BHeZZqsOP_+OSPfrPdkYgKQe3LgaGfo3bERD+hWT7U0g@mail.gmail.com>
 <7vaa9f59p5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 01:12:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBad8-00025l-Cr
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 01:12:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935522Ab1JEXL6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Oct 2011 19:11:58 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:45928 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935480Ab1JEXL5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Oct 2011 19:11:57 -0400
Received: by eya28 with SMTP id 28so2118943eya.19
        for <git@vger.kernel.org>; Wed, 05 Oct 2011 16:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=u/suQy3z43L/KEOq+nKPMdtbMG86AvbjFsCoLGHqK38=;
        b=s4r6u5us9su4orIUYtH/HZxJ6RMqQ549IcuzSpcaUju7C17qGo+uNBMb7KQKy0E8/m
         8Jm+89buTp5HNK0be0W+mMN4doCKzzcWqvGndEFEgsGjQQS9SVxqIupFouw2/X5yLcsg
         KosgU1d/f2fAncqI0sjgXi8MEmBf8NG9DOaMk=
Received: by 10.204.141.134 with SMTP id m6mr32033bku.199.1317856316139; Wed,
 05 Oct 2011 16:11:56 -0700 (PDT)
Received: by 10.204.120.75 with HTTP; Wed, 5 Oct 2011 16:11:26 -0700 (PDT)
In-Reply-To: <7vaa9f59p5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182902>

On Thu, Oct 6, 2011 at 9:56 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> On Thu, Oct 6, 2011 at 5:19 AM, Junio C Hamano <gitster@pobox.com> w=
rote:
>>> I do not necessarily think that it is a good approach to forbid the=
 same
>>> branch to be checked out in two different places, by the way. One r=
eason
>>> people would want to keep multiple workdirs is so that while they a=
re
>>> still working on a branch and are not yet at a good "stop point" to=
 even
>>> make a temporary commit to get interrupted, they find it sometimes
>>> necessary to be able to build the tip of that same branch and even =
make a
>>> small in-working-tree fixes (which later will be carried back to th=
e
>>> primary branch). The problem arises only when one of the repositori=
es try
>>> to update or delete the branch while it is checked out in another w=
orking
>>> tree.
>>
>> I think of two options:
>>
>> =C2=A0- detach from the already locked branch (pretty much like what=
 we do
>> with tags now)
>>
>> =C2=A0- refuse normally but let "checkout -f" do it anyway. However =
the
>> checkout lock will remain at the original worktree. If you want to
>> update branch from the second checkout, do "commit -f" and take
>> responsibility for your action.
>
> Sorry, what problem are you trying to solve? Does that "checkout -f" =
meant
> to nuke the local changes that are not yet at a good "stop point"?

I meant "git checkout" on the already locked branch is refused, but
"git checkout -f" in that case will act just like "git checkout"
ignoring all locks. But I forgot that "git checkout -f" also discards
worktree changes. Maybe "git checkout --ignore-locks" instead of "git
checkout -f".
--=20
Duy
