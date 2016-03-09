From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 0/7] replacing strbuf_getline_lf() by strbuf_getline()
Date: Tue, 8 Mar 2016 20:17:08 -0500
Message-ID: <CAPig+cRGH=ae2jm4YbwTUpNPx7ZgiZkMf=xKCPP=Ewsr9xJu+g@mail.gmail.com>
References: <56D28092.9090209@moritzneeb.de>
	<56D401C2.8020100@moritzneeb.de>
	<56DF6D67.9040103@moritzneeb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Moritz Neeb <lists@moritzneeb.de>
X-From: git-owner@vger.kernel.org Wed Mar 09 02:17:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adSkp-0006xj-1J
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 02:17:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752286AbcCIBRQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2016 20:17:16 -0500
Received: from mail-vk0-f67.google.com ([209.85.213.67]:36464 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751391AbcCIBRK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2016 20:17:10 -0500
Received: by mail-vk0-f67.google.com with SMTP id j65so2821242vkg.3
        for <git@vger.kernel.org>; Tue, 08 Mar 2016 17:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=Eyy0p0VsJLej85hNTTdKUVtwWkdEMvMCyT/zxUSRuhE=;
        b=q0wzx0bpXhLnR1w0jXpHYeq/9PKhLDY0Hvodrr4ZDvS87zLlhPbQ8QYbUlHtSKRynI
         OUERpCZav/Y+yRLnF37QNn/GuScoZveyK61sY35PNYg9va9Jfm1Bky/m5OEokl54ynY4
         0yPGfFG0jwRX+tVTiz8NabOc5j+fovXxp2M64mtMIM3lL9pF0x/UpGzMsVETcAIxqzGH
         Vh7hRZN+pV5EU0V4ogv2fGJVRWx4+Z/99PP0jSE7il9BS+vD4+KoSI7Czk0/7Yy0WvRu
         BLS9RHZfGIu9NtogX7lY8qqMZruCBeRH7dRWXRaX3yh0v4QIFyeaV8pAcHocP2IMjQm9
         91oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Eyy0p0VsJLej85hNTTdKUVtwWkdEMvMCyT/zxUSRuhE=;
        b=NytfeTS6NY69RILqnuNUl7kkCVpsnOjX7K4ESS4dzcTiR5k+tYJ3pCHtCBGTGzHQBc
         tKVTcJ2XXHBT347rEexgN1nDWofh6lr6OxSESKEMEvBI6ISwajIOdZlT4yNrtrA59iMt
         N5t6FSTeUJxqMnt6IDzxGGI+6epqaZwfThQmJIHsigj7iGtT3k1Zs1sRenbfTY3EyRsR
         yebzg/mtUvlPpohm8OEQoQS/wFilfP3uQD91SrgsNbIrYzK76Me/kR6emfL1nvFTDCXK
         vYPnYMBERbGlOl9E2FomCPxDE9kMvl811NIjLxYkQVnTshbiZ8YNG71bkJhQeYoTFnCP
         AlQA==
X-Gm-Message-State: AD7BkJLwxhYGacQuMf4Qv2bhqqOFdpNxxLit7o/AqghDthlMv4trgSnc3/lxCwct93mDKKLL9/FXDQHVpACekA==
X-Received: by 10.31.8.142 with SMTP id 136mr30311706vki.14.1457486229062;
 Tue, 08 Mar 2016 17:17:09 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Tue, 8 Mar 2016 17:17:08 -0800 (PST)
In-Reply-To: <56DF6D67.9040103@moritzneeb.de>
X-Google-Sender-Auth: 1WZ2nHD6BjntZAs6KTjPtwmSqRk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288470>

On Tue, Mar 8, 2016 at 7:25 PM, Moritz Neeb <lists@moritzneeb.de> wrote:
> how to deal with patches during the v2.8.0 rc freeze? Will they wait on
> the mailing list until the feature release cycle is finished?
>
> Or if it's me who should act on this series, because it got below the
> radar during the rc freeze?
>
> To my knowledge there's only minor points that have to be discussed:
>
> in patches 4/7 and 5/7: Which commit should remove the trimming of
> "split[0]", cf.:
>
>         http://thread.gmane.org/gmane.comp.version-control.git/285118/focus=287894

The reason I brought the issue up in review is that it wasn't clear if
dropping the rtrims over the course of two patches was intentional or
just an oversight (given that the review recommendation from the
previous round had suggested removing both in the same patch). From
your response, it is clear that it was intentional and, as mentioned
in the cited messages, while I do have an opinion on the matter, it's
such a minor point that it's not worth a lot of back and forth, and
the patch can move forward if you're happy with it the way it is.
