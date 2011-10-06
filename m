From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC/PATCH] Add multiple workdir support to branch/checkout
Date: Thu, 6 Oct 2011 13:06:25 +1100
Message-ID: <CACsJy8DZE5jSnOuraaVaW1+nA-hUiTXsNLJYEG+32qEJ1irGiQ@mail.gmail.com>
References: <1317786204-57335-1-git-send-email-jaysoffian@gmail.com>
 <CACsJy8AqYq+YF+rvUp=BBeFUAtUz783iF2jbUp3fO58yLp9ptQ@mail.gmail.com>
 <CAG+J_DygQTD5ibco=-NOiKg0BLgBGFJnvV8zPyhngC2iZv_H8g@mail.gmail.com>
 <7vpqib8jzk.fsf@alter.siamese.dyndns.org> <CAG+J_Dz-GXvRbYUXSoyfyHfOO-_BszcOza9x=ysHhmL5YBW-Jw@mail.gmail.com>
 <7vzkhf713u.fsf@alter.siamese.dyndns.org> <CACsJy8BHeZZqsOP_+OSPfrPdkYgKQe3LgaGfo3bERD+hWT7U0g@mail.gmail.com>
 <7vaa9f59p5.fsf@alter.siamese.dyndns.org> <CACsJy8D5FGr3R0tLYOND0kKNct4e_KgYfLUK8xL2Q4uNzWczgQ@mail.gmail.com>
 <7vwrcj3sow.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 04:07:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBdMU-0003J9-0Q
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 04:07:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757914Ab1JFCG5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 22:06:57 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56155 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754435Ab1JFCG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 22:06:57 -0400
Received: by bkbzt4 with SMTP id zt4so2829413bkb.19
        for <git@vger.kernel.org>; Wed, 05 Oct 2011 19:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=BM7X5l6pWiWAI2+jn/mjx8l10ob/UidsRaRxp/eLJ7c=;
        b=O2aZliO3VzNK3JKKebEsoFbkA0IFJltjtJVpdJZg/XksmwL3k96SF416QCQyBSuqc6
         h+KCzH/uqaXE6d7oqY7i4z5IMKnV8ppbSoZZVTS+mGJ8KuHkvdac5LhAZ7fe7T2GDcGD
         kUAWyKOLzi5hwvxn5b41PaqLg9VPGIJTMAlhI=
Received: by 10.204.6.210 with SMTP id a18mr132244bka.303.1317866815361; Wed,
 05 Oct 2011 19:06:55 -0700 (PDT)
Received: by 10.204.120.75 with HTTP; Wed, 5 Oct 2011 19:06:25 -0700 (PDT)
In-Reply-To: <7vwrcj3sow.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182918>

On Thu, Oct 6, 2011 at 10:49 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> On Thu, Oct 6, 2011 at 9:56 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>>> I think of two options:
>>>> ...
>>> Sorry, what problem are you trying to solve? Does that "checkout -f" meant
>>> to nuke the local changes that are not yet at a good "stop point"?
>>
>> I meant "git checkout" on the already locked branch is refused, but
>> "git checkout -f" in that case will act just like "git checkout"
>> ignoring all locks. But I forgot that "git checkout -f" also discards
>> worktree changes. Maybe "git checkout --ignore-locks" instead of "git
>> checkout -f".
>
> I see what you mean, but doesn't it feel as if it is working around a
> problem that is introduced only because of a wrong policy (i.e. "you
> cannot check out the same branch at two places", as opposed to "viewing
> them in multiple places is perfectly fine, but no touching")?

Well, we could do change the default so "git checkout" == "git
checkout --ignore-locks".

"git commit --ignore-locks" would commit without checking locks. "git
commit" could either:

 - reject because it does not hold the lock (to hostile?)

 - detach automatically then commit

The latter has a benefit that we can now checkout tags without
detaching from the beginning. "git branch" would show tag name until
you commit.
-- 
Duy
