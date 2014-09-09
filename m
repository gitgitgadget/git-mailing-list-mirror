From: Harry Jeffery <harry@exec64.co.uk>
Subject: Re: [PATCH] pretty-format: add append line-feed format specifier
Date: Tue, 09 Sep 2014 23:17:20 +0100
Message-ID: <540F7C70.4010909@exec64.co.uk>
References: <540F426E.6080908@exec64.co.uk> <xmqqmwa8k3lg.fsf@gitster.dls.corp.google.com> <540F554C.5010301@exec64.co.uk> <xmqqegvkk2k3.fsf@gitster.dls.corp.google.com> <20140909214520.GA13603@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 10 00:17:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRTin-0003Ac-IA
	for gcvg-git-2@plane.gmane.org; Wed, 10 Sep 2014 00:17:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752756AbaIIWRF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2014 18:17:05 -0400
Received: from mail-we0-f172.google.com ([74.125.82.172]:53765 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752171AbaIIWRE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2014 18:17:04 -0400
Received: by mail-we0-f172.google.com with SMTP id k48so2156699wev.3
        for <git@vger.kernel.org>; Tue, 09 Sep 2014 15:17:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=aZif0Mr5QxWhtktQFvmcOP/DMjCfUnrkfXUyNIUQ42E=;
        b=hiRzGc1wCM1N8utmC0UKIh7V/dTWvcIenSI3kQ2soNz3GevnZASkSqTz/pVuqIy5Tc
         9FWgfWei/J8N97WWBFSYq2oxUnwZRGm5Scnq8t/FJPHcZrL9Y1lbZv3v3OWntI5L5Dhn
         8ptInP6ewZjoFe5A2QpG142fgzTUJ32Q+y0u/XTXWQEatJqujtoJ1faxgmnI2XM8OcZU
         ioFRxJ7KosJ1DqN0PPSLmyZSFr36Z32aZ4zPJbJcUjk3TKJ7KPoMdPJ31qnf/7YVrQ8i
         3UQ8eQX8aKV8MXUeK6WAVzU96QImmtAWWYCQiY9AeZgshH5R6kzza9p4RO2bMtTLtuLd
         9/ow==
X-Gm-Message-State: ALoCoQmk8GFOla6HzT1Yfjq9bWldKCOE323I2rola5I3I9dYe69Sf/LWSfn9pttOZ0Nxg9eFNRVx
X-Received: by 10.194.78.100 with SMTP id a4mr7429093wjx.106.1410301021931;
        Tue, 09 Sep 2014 15:17:01 -0700 (PDT)
Received: from [192.168.0.14] (cpc69047-oxfd25-2-0-cust267.4-3.cable.virginm.net. [81.109.93.12])
        by mx.google.com with ESMTPSA id hy9sm16367984wjb.27.2014.09.09.15.17.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Sep 2014 15:17:01 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <20140909214520.GA13603@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256715>

On 09/09/14 22:45, Jeff King wrote:
> Yeah, that was my thought on reading the initial patch, too. Why limit
> ourselves to newlines and spaces. I'd much rather have full conditional
> expansion, like "${foo:+prefix $foo suffix}" in the shell.
>
> Something like the patch below might work, but I didn't test it very
> thoroughly (and note the comments, which might need dealing with). Maybe
> it would make a sensible base for Harry to build on if he wants to
> pursue this.

I definitely prefer your more general solution to my 
bare-minimum-to-scratch-itch patch. I'd certainly be willing to take 
your patch and expand upon it (pun unintended) once Junio has weighed in 
on your suggestions.

> You could also make "%d" more flexible with it. We unconditionally
> include the " (...)" wrapper when expanding it. But assuming we
> introduced a "%D" that is _just_ the decoration names, you could do:
>
>    %if(%D, (%D))
>
> to get the same effect with much more flexibility.

Regardless of what happens with the conditional expansion I think it 
would definitely be a useful addition to be able to print the decorators 
without the " (...)" wrapper. I think it's general enough that it'd 
warrant its own separate patch rather than being part of a patch series 
for the conditional expansion.
