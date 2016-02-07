From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 06/12] ref-filter: introduce color_atom_parser()
Date: Sun, 7 Feb 2016 02:53:06 -0500
Message-ID: <CAPig+cRBTA4TCwW60UubjLWzzSdO3WiGG+bNy6Wh2Y5-=hYjJA@mail.gmail.com>
References: <1454262176-6594-1-git-send-email-Karthik.188@gmail.com>
	<1454262176-6594-7-git-send-email-Karthik.188@gmail.com>
	<CAPig+cTemTCwOUoyO9p+d544iDcxeYw0gh9DtEkL9hoHVLmuEQ@mail.gmail.com>
	<CAOLa=ZRPbk+uOVhwKumE2eiKDWdkKqtG_mbrNmr4Rn1POdGNdw@mail.gmail.com>
	<CAP8UFD0BMNYiL-N=eTwXvyMX4_exwURzufesW_xYktZoVPaoGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 07 08:53:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSKAG-0007yy-BX
	for gcvg-git-2@plane.gmane.org; Sun, 07 Feb 2016 08:53:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbcBGHxJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Feb 2016 02:53:09 -0500
Received: from mail-vk0-f68.google.com ([209.85.213.68]:33303 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819AbcBGHxH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Feb 2016 02:53:07 -0500
Received: by mail-vk0-f68.google.com with SMTP id c3so1648980vkb.0
        for <git@vger.kernel.org>; Sat, 06 Feb 2016 23:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=wWk8iaUw4CaBeLlhMGZ+7i50dzQ6ZHGqzgwwf9Gy4YU=;
        b=0N07ZzZRuoYsgM7WNmQYjj1BdAOG6FqtpGPQma6iTaZ1U7+GPoHUuipj9DNumHHGeP
         +6kS/jufJ3TSMYqUR0a3QTmVpn61YeOW9P2wW9zdSBVud6HvQ4o3+GoDFOIClWuMxpV7
         fSVM6p509R4P9xbE+YpBRcJ+szGo4U5JL+fh25098Lv6Mw4Sw9LFSRKiL/7hcI9Mai9b
         X2+AA3Ml0ichbQfkbLQn53eINwsBs1SsAVCmd8Z+9DwdNwYUiFPJYj/s5KMpL9oQ5IW7
         mj2X3ZQa+2kKLmRo+xGh9gVs6yz27miJGzf9R8foybeY+gKl5nBOBdbsmqmToNpp9EEK
         dzxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=wWk8iaUw4CaBeLlhMGZ+7i50dzQ6ZHGqzgwwf9Gy4YU=;
        b=aI3yXRCqxJcAs5s216MGG2UMkZeaUNQTBU/qtnDr7kGpa6TtjOD2CLrAI/RK9PXuWM
         APT2goje7UdLHpuRGX0EPeWWVeYF3ktoeRVQ/FuDOSMF2fT7x5K7Ww8vWzU6tgEDqeYr
         Au5UbwZ4XWfgKEPfKz5nssqLGwfcq+x/1DCN16tVViJ6VovZjJH1ZVLTXq96vTfcOH5s
         o1C698DmpIcRLbFmdn0h2qmYVz/wpDLV0/qyviN6uEkSEyQdtBLnrslXtAzH4howZMCt
         lM9SW+R0BZ84kizxnjEUKrWs6Z27KcFyCdPBz72Bg57FO8ys3L7AgwPZVy3lIX9XBx3V
         +3Bg==
X-Gm-Message-State: AG10YOTyv/AxrDYIOMAb+52M9M4f3dwqmukKLhj52+6JzFR78fGqXoOTMfK0wyNzRzwXt3v5Nx/5MUFf4K4r7Q==
X-Received: by 10.31.47.135 with SMTP id v129mr15585704vkv.115.1454831586435;
 Sat, 06 Feb 2016 23:53:06 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sat, 6 Feb 2016 23:53:06 -0800 (PST)
In-Reply-To: <CAP8UFD0BMNYiL-N=eTwXvyMX4_exwURzufesW_xYktZoVPaoGA@mail.gmail.com>
X-Google-Sender-Auth: usDpf-eM-aDOFHzmm5G4ZB71kHE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285716>

On Sat, Feb 6, 2016 at 10:51 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Sat, Feb 6, 2016 at 4:20 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Also the error is reported already in color_parse(...), so seems duplicated.
>>
>> git for-each-ref  --format="%(color:sfadf)%(align:middle,30)%(refname)%(end)"
>> error: invalid color value: sfadf
>> fatal: invalid color value: sfadf
>>
>> What would be an ideal way around this?
>
> Maybe it has already been discussed a lot and I missed the discussion,
> but if possible the argument, the parameter or the atom itself might
> just be ignored with a warning instead of dying when an atom argument,
> format or parameter is not recognized, because in the next Git
> versions we might want to add new arguments, formats and parameter and
> it would be sad if old versions of Git die when those new things are
> passed to them.

The current behavior of die()ing is inherited from existing code which
Karthik refactored to create ref-filter.c, so it is not a new issue,
and old versions of Git are already afflicted. Whether die()ing is
desirable or not is unrelated to the current series which is primarily
aimed at optimizing and slightly generalizing ref-filter.c.
