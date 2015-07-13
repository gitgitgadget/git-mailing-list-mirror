From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 01/10] ref-filter: add %(refname:shortalign=X) option
Date: Mon, 13 Jul 2015 17:51:35 +0700
Message-ID: <CACsJy8D6XOJbVb9LiDmmNuH9UWmyj9BRc0V5GYq-0wwi2uvN0w@mail.gmail.com>
References: <CAOLa=ZQyHwza6L9r6iFX1GkVrC+F-XNwegO=bGyxafjY3JoYpw@mail.gmail.com>
 <1436437671-25600-1-git-send-email-karthik.188@gmail.com> <xmqqk2u8kmre.fsf@gitster.dls.corp.google.com>
 <CAOLa=ZTNGV=NAXDPB3HX=fanPMQaQQc4ZpFdDFeg+LJ8SFuVOQ@mail.gmail.com>
 <CACsJy8BsLnkPFX04WujMdnBiRGmXacF1QSQudb3T8nxGrZ_1Fg@mail.gmail.com>
 <CACsJy8BL0ccxNYLE0gqBx5KTpqTOt=Ut6-k3fauxXNt2wpxSEw@mail.gmail.com> <CAOLa=ZThDcmM79hL0TUh6+8=NkQBWOWK=Ti+-v+2PCysquw-1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 13 12:52:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZEbLI-0001La-Mc
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jul 2015 12:52:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbbGMKwH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jul 2015 06:52:07 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:36065 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878AbbGMKwF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jul 2015 06:52:05 -0400
Received: by ieik3 with SMTP id k3so19334401iei.3
        for <git@vger.kernel.org>; Mon, 13 Jul 2015 03:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=oeOzWBx31XnLgMbQwoQ81dIKBEFTLeO4Zx6g8L+nB10=;
        b=b/ZD4B5PIooYKDi3GYBLQ07jyeDuy/NrPpcicvtOUM9Fj32QJfwnN4LLgqMq1Xpiia
         mjqPPWkTSC7fhKZoZVisTL0FbfLiXt9uAz6b4GNFf+lokkcp5vS43Uqu5xKEjn6lYMpw
         M+6wWxJh6c8IZhIVutEkQfxJqeMj0fu58xxQ0gEZvH/FpqMN75DiG/x6QXLRsLXpK95X
         eBCgDp0pbsBOCVZ6hEp4ZOkdy7/KXrJqSbMD//IAdOmTx2mDppZ/106GW3F8KRgwmFeg
         NawkVDLLlzIp+LvuonvM4IbqlY6SNXltyIhLKqd4JsM+CT8+pIpCoybVUrZmsJaj2lwk
         dVMg==
X-Received: by 10.107.168.99 with SMTP id r96mr16038351ioe.141.1436784725133;
 Mon, 13 Jul 2015 03:52:05 -0700 (PDT)
Received: by 10.107.16.15 with HTTP; Mon, 13 Jul 2015 03:51:35 -0700 (PDT)
In-Reply-To: <CAOLa=ZThDcmM79hL0TUh6+8=NkQBWOWK=Ti+-v+2PCysquw-1w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273912>

On Mon, Jul 13, 2015 at 2:56 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> On Sun, Jul 12, 2015 at 7:17 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>>
>> I guess if you can have multiple arguments after ':' in an atom, then
>> you have wiggle room for future. But it looks like you only accept one
>> argument after ':'.. (I only checked the version on 'pu'). Having an
>> "alignment atom" to augment the real one (like %< changes the behavior
>> of the next placeholder), could also work, but it adds dependency
>> between atoms, something I don't think ref-filter.c is ready for.
>>
>
> I was thinking of something on the lines of having a function which right
> before printing checks if any "align" option is given to the end of a given
> item and aligns it accordingly, this ensures that any item which needs to
> have such an option can easily do so.
>
> https://github.com/KarthikNayak/git/commit/0284320483d6442a6425fc665e740f9f975654a1
>
> This is what I came up with, you could have a look and let me know if
> you have any
> suggestions.

Yeah, pretty close to what I described in the other mail. Now if you
make "align" a separate atom, I think it would reduce clutter in
populate_value() (my personal opinion is this function looks too messy
already) and we can easily add more alignment options in future :)
-- 
Duy
