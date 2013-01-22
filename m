From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2] unpack-trees: do not abort when overwriting an
 existing file with the same content
Date: Tue, 22 Jan 2013 08:55:01 +0700
Message-ID: <CACsJy8CwkKyCLefrghVbq74FmeP7bPZAML-P=9s5PoPuNyT2Yg@mail.gmail.com>
References: <1358594648-26851-1-git-send-email-pclouds@gmail.com>
 <1358768433-26096-1-git-send-email-pclouds@gmail.com> <20130121231515.GD17156@sigill.intra.peff.net>
 <CACsJy8AFKXYkHbUf4aqBpCg+v06oFsvHq_zxQFE4BOCzTDAqtg@mail.gmail.com> <7vwqv6c7oe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 02:55:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxT5d-0006rw-G5
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 02:55:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752228Ab3AVBzc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 20:55:32 -0500
Received: from mail-ob0-f173.google.com ([209.85.214.173]:57324 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751693Ab3AVBzb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 20:55:31 -0500
Received: by mail-ob0-f173.google.com with SMTP id xn12so6424240obc.4
        for <git@vger.kernel.org>; Mon, 21 Jan 2013 17:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=f9NbP8hFmJKQFPttPfFS6hmJ82KmfqJApyF2tKtwgyE=;
        b=VKEEk8pPL0NgVXWKjxhTnFJDeZJTOI2151wigjfRmFJKWZEMZkXnPGue5ApjfiS+/n
         SiQvYcPLRNeaZJNAcLE0TLgGTpeHVUyy+Cvk4DM8RHQWxhLUI0B/P4XOErsSphKiYID2
         /4Q+Wb9ioWyEyBW8MgID8sVWXQKZJzpT16yJ4sPUgdvlJ4poLolv0Lw1i804ry693KFB
         2TM86DivrbM7w9ORbSqfDFGSqLFhD7+FRoaSUqfnYxk3Z2keppvtA0P3AeVBEaGrimk2
         XWDnC5/9EzCvjgZ3gUIFkhqA7umzD2+XclDIqTV6W9+rZswQENqnTdqVoDnk559pItiw
         wUVQ==
X-Received: by 10.60.29.66 with SMTP id i2mr15528477oeh.2.1358819731131; Mon,
 21 Jan 2013 17:55:31 -0800 (PST)
Received: by 10.182.153.69 with HTTP; Mon, 21 Jan 2013 17:55:01 -0800 (PST)
In-Reply-To: <7vwqv6c7oe.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214187>

On Tue, Jan 22, 2013 at 8:45 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Tue, Jan 22, 2013 at 6:15 AM, Jeff King <peff@peff.net> wrote:
>>> Can you elaborate on when this code is triggered?
>>>
>>> In the general case, shouldn't we already know the sha1 of what's on
>>> disk in the index, and be able to just compare the hashes? And if we
>>> don't, because the entry is start-dirty, should we be updating it
>>> (possibly earlier, so we do not even get into the "need to write" code
>>> path) instead of doing this ad-hoc byte comparison?
>
> If the index knows what is in the working tree, I think I agree.
>
>>> Confused...
>>
>> git reset HEAD~10
>> # blah that was a mistake, undo it
>> git checkout HEAD@{1}
>>
>> I hit it a few times, probably not with the exact recipe above though.
>
> I've seen myself doing "git reset HEAD~10" by mistake (I wanted "--hard"),
> but the recovery is to do "git reset --hard @{1}" and then come back
> with "git reset --hard HEAD~10", so it hasn't been a real problem
> for me.

Except when you already make some changes elsewhere and you don't want --hard.
-- 
Duy
