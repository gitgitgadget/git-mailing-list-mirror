From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: build deps
Date: Tue, 16 Oct 2012 09:37:41 +0200
Message-ID: <507D0EC5.4030206@drmicha.warpmail.net>
References: <CACnwZYe_vhH9Ui8W9D=M_8avgEugR+UvM1E+jH7fxr+8yk2UtQ@mail.gmail.com> <5072FAD1.1000807@gmail.com> <CACnwZYeJ-FKXterxd697iu+U4HobqEaP0zx_p8CZDsPZx4hbHQ@mail.gmail.com> <50735939.10604@gmail.com> <CACnwZYf56XkqW085HoWhAN2EnjCJd=VYHGAD8fZCCe6_FNhO2A@mail.gmail.com> <50776D0D.9090306@gmail.com> <CACnwZYfmz1BTo6okzFh8jXbw+0MAV0sEanYXNzAnV7L4p7nY_g@mail.gmail.com> <507C2F6E.9060100@drmicha.warpmail.net> <7vd30jwj7v.fsf@alter.siamese.dyndns.org> <CAJDDKr5QaByGg0wW_fwFErRyMA6hbg2kHskxOqY4Z_rLoo1maQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Thiago Farina <tfransosi@gmail.com>,
	Andrew Wong <andrew.kw.w.lists@gmail.com>,
	Andrew Wong <andrew.kw.w@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Scott Chacon <schacon@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 16 09:38:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TO1iv-00056D-62
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 09:37:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754867Ab2JPHhq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 03:37:46 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:38578 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754233Ab2JPHhp (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Oct 2012 03:37:45 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id B46CF2075D;
	Tue, 16 Oct 2012 03:37:44 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 16 Oct 2012 03:37:44 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=eMyH9fn1LDa16D332Zc2sI
	16EhQ=; b=jVrn1Os/uBgZ+hTqk6lfYJgt52LmajBl4Klb9s/d2v4Iwkm5P9fUA+
	cETqQDHW1Mw/hPkPDgRP0WxT9/bgfbeEUd1kdoiZJDg81oQmj6N4kwzmA8KVsSxO
	CFgdtn5gnYeFwTAylbwgTFfwlCXqRg88yWSYVwH1nedBM7cWUtrTw=
X-Sasl-enc: D5VpYNKjqAWuVJM+q84tQ0xL3ENqazD4+CpZ2YyBoA8v 1350373064
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 99DA74827B0;
	Tue, 16 Oct 2012 03:37:43 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121011 Thunderbird/16.0.1
In-Reply-To: <CAJDDKr5QaByGg0wW_fwFErRyMA6hbg2kHskxOqY4Z_rLoo1maQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207808>

David Aguilar venit, vidit, dixit 16.10.2012 03:39:
> On Mon, Oct 15, 2012 at 1:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>>
>>>> grep.c:451:16: warning: comparison of unsigned enum expression < 0 is
>>>> always false [-Wtautological-compare]
>>>>                 if (p->field < 0 || GREP_HEADER_FIELD_MAX <= p->field)
>>>>                     ~~~~~~~~ ^ ~
>>>> 1 warning generated.
>>>
>>> Right, that enum type starts at 0. Junio, you last touched this area.
>>> Can we just dump the first comparison or did you have something else in
>>> mind?
>>
>> I think it was a leftover from the very first implementation that
>> defensively said "this has to be one of these known ones", and tried
>> to bound it from both sides of the range, regaredless of the actual
>> type of the field (these GREP_HEADER_WHAT things may have been
>> simple integers with #define'd values).  Dropping the "negative"
>> comparison is perfectly fine.
> 
> This snippet of code came up before:
> 
> http://thread.gmane.org/gmane.comp.version-control.git/184908/focus=185014
> 
> There seemed to be good reasons to keep the check at the time.
> 
> Was this same snippet not also touched when Nguyen Thai Ngoc Duy
> worked on the "even if I'm drunk" patch?:
> 
> http://thread.gmane.org/gmane.comp.version-control.git/206413/focus=206539
> 
> With the "drunk" patch then we wouldn't need the check at all,
> which is really nice.
> 
> I hope that helps jog folks' memories.
> I'm not sure if the above discussions are relevant anymore,
> but I figured it'd be good to provide some more context.
> 
> cheers,

The drunk patch, cheers ;)

That's very valuable context that you are giving. So it's either
avoiding the warning and relying and enum unsignedness (or human/static
analysis) or playing it safe and keeping the warning. How is

if (/* p->field < 0 || */ GREP_HEADER_FIELD_MAX <= p->field)

to remind any reader that the first condition should be granted? One
could take this further and use a macro but that seems overkill.

Michael
