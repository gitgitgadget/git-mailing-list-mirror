From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 6/7] completion: get rid of __gitcomp_1
Date: Wed, 10 Apr 2013 06:13:06 -0400
Message-ID: <CAPig+cR4_ZB=s8JVT2LRJGcNhM9ZaESWZQ5v6Wa20=bWGoMydg@mail.gmail.com>
References: <1365577077-12648-1-git-send-email-felipe.contreras@gmail.com>
	<1365577077-12648-7-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 10 12:13:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPs1i-0004k8-KO
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 12:13:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751926Ab3DJKNJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 06:13:09 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:59113 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751515Ab3DJKNI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 06:13:08 -0400
Received: by mail-lb0-f169.google.com with SMTP id p11so343124lbi.28
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 03:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=tCTNnRNpUdHTL8OplTlyCSQwyJnRXkHQORc8/ZDg6mw=;
        b=Eq3CISc64uKVnwRBoCpyF5n87g6VG2pdwuyQliRYlp6FNbP0vZNKGaOKimllqjmzOB
         Mqg0vZAT5eU1pO97PgtDqLP4f77U7w2X2h5pQ06qyatznOKJ3aIoV2OUWvqxHVhmHpHf
         h7v671f2hlmRDZmgxvUn6TleG+g94HkklQ3tabAM+FR4UnNJkLFilnFT8jPPvBFaG4Lr
         Gd3AqaThXNpRq7J7CiB3moUBivLcm32nHlHpQ+5hniVbCVKSROtw1C+AwU+VDd7M9/H7
         NiqtUxdChjfGT3RRStHmoCsD3TUy4avEU1tT0V2/UCa3LmzUKZmssYShMhw9EX/utRdQ
         zQ0Q==
X-Received: by 10.112.6.234 with SMTP id e10mr897072lba.46.1365588786930; Wed,
 10 Apr 2013 03:13:06 -0700 (PDT)
Received: by 10.114.174.104 with HTTP; Wed, 10 Apr 2013 03:13:06 -0700 (PDT)
In-Reply-To: <1365577077-12648-7-git-send-email-felipe.contreras@gmail.com>
X-Google-Sender-Auth: 0A0yi3rCEVnB6T1Br__oxTUrXCk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220677>

On Wed, Apr 10, 2013 at 2:57 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> There's no point in calling a separate function that is only used in one
> place. Specially considering that there's no need to call compgen, and

s/Specially/Especially/

> we traverse the words ourselves both in __gitcompadd, and __gitcomp_1.

s/ourselves/ourself/

> So lets squash the functions together, and traverse only once.

s/lets/let's/

> This improves performance. For N number of words:
>
>   == 1 ==
>   original: 0.002s
>   new: 0.000s
>   == 10 ==
>   original: 0.005s
>   new: 0.001s
>   == 100 ==
>   original: 0.009s
>   new: 0.006s
>   == 1000 ==
>   original: 0.027s
>   new: 0.019s
>   == 10000 ==
>   original: 0.163s
>   new: 0.151s
>   == 100000 ==
>   original: 1.555s
>   new: 1.497s
>
> No functional changes.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
