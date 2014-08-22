From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 18/18] signed push: final protocol update
Date: Thu, 21 Aug 2014 21:20:49 -0700
Message-ID: <CAPc5daVnhEDykmM6CmZa5q4FWfxuKfqwm0U9vsr7xd3sDJSboQ@mail.gmail.com>
References: <1408485987-3590-1-git-send-email-gitster@pobox.com>
 <1408485987-3590-19-git-send-email-gitster@pobox.com> <CAJo=hJuToRQDTkccV9BfVbs1YnjCrr2iPrG-HmTbJ=ds4r6MzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Aug 22 06:21:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKgLj-0004vb-W0
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 06:21:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbaHVEVM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2014 00:21:12 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:56353 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330AbaHVEVL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2014 00:21:11 -0400
Received: by mail-la0-f45.google.com with SMTP id ty20so9527229lab.18
        for <git@vger.kernel.org>; Thu, 21 Aug 2014 21:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=W7D9BJHf3ESZdORLqZXIrqn6yEnnnf4qW5akuK+o+hs=;
        b=sYTgzRnCntcWDgb6VlIUIK9+BeZN5C4/rt5pBv6naHVG4mfMDLLOvW08i+1AFlJJqq
         T1p3uIN2KIXvv7LDIL6JeRvjXx4u0MyIJa/xRJk0FMaUIAmPVt8DwRL5ou6GbhmIYoA6
         QBIz1bz0SWEX6hM5MCabWFIXYArmAXcfrhaitbbpk3owqyn8bJk0LPZVgR07IyWIOojG
         jLKvAYKsMUUQHoHae1au69gFwT+Tnrzf9AEVWklirLv5k5erAr62To8duuDner1Ia8ql
         eKPeUyAo2s0JyQYMXOwPylYwHQi218B3615EwH2pbe3Aq73DNJ0Vie9lleBqAE5BY/eh
         5ZRg==
X-Received: by 10.112.163.103 with SMTP id yh7mr2167666lbb.73.1408681269602;
 Thu, 21 Aug 2014 21:21:09 -0700 (PDT)
Received: by 10.112.97.177 with HTTP; Thu, 21 Aug 2014 21:20:49 -0700 (PDT)
In-Reply-To: <CAJo=hJuToRQDTkccV9BfVbs1YnjCrr2iPrG-HmTbJ=ds4r6MzA@mail.gmail.com>
X-Google-Sender-Auth: R7BZyoOC3K_VkTzxUL5I4St5DL0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255657>

On Thu, Aug 21, 2014 at 12:28 PM, Shawn Pearce <spearce@spearce.org> wrote:
> On Tue, Aug 19, 2014 at 3:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> +  push-cert         = PKT-LINE("push-cert" NUL capability-list LF)
>
> Haha. NUL.  I love our wire protocol.

It is a direct and natural consequence of [PATCH 02/18].

We could use SP here, if we really wanted to, but that would make the
push-cert packet a special kind that is different from others, which we
would want to avoid. "shallow" is already special in that it cannot even
carry the feature request, and it is not worth introducing and advertising
a new capability to fix it, but at least we can avoid making the same
mistake here.
