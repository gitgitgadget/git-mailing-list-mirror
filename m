From: Tuncer Ayaz <tuncer.ayaz@gmail.com>
Subject: Re: [PATCH] bash: offer to show (un)staged changes
Date: Mon, 2 Feb 2009 20:31:49 +0100
Message-ID: <4ac8254d0902021131m24bab3b7md4d981e6ee935686@mail.gmail.com>
References: <1232240184-10906-1-git-send-email-trast@student.ethz.ch>
	 <7vwsct2xd1.fsf@gitster.siamese.dyndns.org>
	 <20090119172939.GA14053@spearce.org>
	 <4ac8254d0902011448t242e7fcek3ae7fda609648ef0@mail.gmail.com>
	 <7vwsc9rae9.fsf@gitster.siamese.dyndns.org>
	 <4ac8254d0902011650g714c5a7cya3c5111a74b8d8ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 02 20:33:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LU4Xm-00089x-Iy
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 20:33:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753206AbZBBTbw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 14:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753189AbZBBTbw
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 14:31:52 -0500
Received: from fk-out-0910.google.com ([209.85.128.189]:57815 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753188AbZBBTbv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 14:31:51 -0500
Received: by fk-out-0910.google.com with SMTP id f33so1353502fkf.5
        for <git@vger.kernel.org>; Mon, 02 Feb 2009 11:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+xRq17moMWbPIBC+L4SIqpcF5/sMLk7fzAlooFT2Ua8=;
        b=hm+pBMBMHfXdxoLOGBQaKFFWkOuVT7RU1gRAf9xaDPOV3oMNwZEzV9ESztMfKGJL7T
         OXc+HA4xLrpiuTY2Eq37rut42oO2F2448659qZ860kewkOgUzw/uWo5EOwdFlXMEcGzV
         5Z28g/RtY9lFx76gI4VwVJ480C3MK3+K3hHSw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wCTxn6dkHmZ+opX1NKKfzs4kMy1UNvoYXvgM5Id3OY2R+MYNcyvYDiACh2PJqUQsKv
         +DzkLUd82TPhKuQYhB/g96wSHjSIQoS/ggLSnN9t09fMYnl6pdFQJZHGjd35Fx1GAc6/
         ItcL8v49W4ARp3ozwOiOg9MJRjw4HIyOKafYE=
Received: by 10.223.122.15 with SMTP id j15mr2487612far.74.1233603109401; Mon, 
	02 Feb 2009 11:31:49 -0800 (PST)
In-Reply-To: <4ac8254d0902011650g714c5a7cya3c5111a74b8d8ea@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108110>

On Mon, Feb 2, 2009 at 1:50 AM, Tuncer Ayaz <tuncer.ayaz@gmail.com> wrote:
> On Mon, Feb 2, 2009 at 12:43 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Tuncer Ayaz <tuncer.ayaz@gmail.com> writes:
>>
>>> On Mon, Jan 19, 2009 at 6:29 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
>>>> Junio C Hamano <gitster@pobox.com> wrote:
>>>>> Thomas Rast <trast@student.ethz.ch> writes:
>>>>>
>>>>> > +           if test ! -z "$GIT_PS1_EXPENSIVE"; then
>>>>> > +                   git update-index --refresh >/dev/null 2>&1 || w="*"
>>>>>
>>>>> This makes the feature unavailable for people who care about the stat
>>>>> dirtiness and explicitly set diff.autorefreshindex to false, doesn't it?
>>>>
>>>> Yup, and I'm one of those people who sets autorefresindex to false
>>>> in my ~/.gitconfig, usually before I even have user.{name,email} set.
>>>>
>>>> I do like the idea of what Thomas is trying to do here, but its
>>>> so bloody expensive to compute dirty state on every prompt in
>>>> some repositories that I'd shoot myself.  E.g. WebKit is huge,
>>>
>>> I've been thinking about this and wondered
>>> whether implementing "status --mini" or
>>> "status --short" which prints "+?*" in wt-status.c
>>> could be made fast enough.
>>>
>>> Should we try to implement and profile this
>>> or do we know it will be slow beforehand?
>>
>> I think I've seen a patch to do something like that, soon after Shawn
>> announced his repo tool.
>
> The best I could find is your patch from October 25th 2008
> which implements:
>       $ ./git-shortstatus
>       M     Makefile
>       R100  COPYING -> RENAMING
>           M builtin-commit.c
>           M builtin-revert.c
>           M builtin.h
>           M git.c
>           M wt-status.c
>           M wt-status.h
>
> Is this what you meant?

I am confident that this is the patch Junio referred to
and as time permits I will give it a try.
