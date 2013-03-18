From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH/RFC] http_init: only initialize SSL for https
Date: Mon, 18 Mar 2013 13:14:15 +0100
Message-ID: <CABPQNSZVptZ9RMQSe8ypgcBH1hmQ6Edg-27JT7-qp4H-46UfQA@mail.gmail.com>
References: <1363269079-6124-1-git-send-email-kusmabite@gmail.com>
 <alpine.DEB.1.00.1303141621340.3794@s15462909.onlinehome-server.info>
 <CABPQNSZNdGea9Nn91emWhfRGAZjZXm755UKArNr3EUy9CrSKHg@mail.gmail.com>
 <7vmwu6x72q.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.1303142333170.3794@s15462909.onlinehome-server.info>
 <7vk3p9wqh5.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.00.1303151054130.32216@tvnag.unkk.fr>
 <7v4ngcwt4w.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.00.1303151719170.32216@tvnag.unkk.fr>
 <20130316120300.GA2626@sigill.intra.peff.net> <alpine.DEB.2.00.1303162355120.21738@tvnag.unkk.fr>
 <CALWbr2wQNM=7vUcoragNmKGpSeXkOCsmsM5y1AMhj95i15A4bw@mail.gmail.com>
 <alpine.DEB.2.00.1303172305230.21738@tvnag.unkk.fr> <7vli9lpsqe.fsf@alter.siamese.dyndns.org>
 <CABPQNSasFV-vZSMygu16xc-C2d3jTt7mtzFsYQyNUhS5jL-EoQ@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Daniel Stenberg <daniel@haxx.se>,
	Antoine Pelisse <apelisse@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git <git@vger.kernel.org>, msysgit@googlegroups.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 18 13:15:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHYyJ-00028V-PR
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 13:15:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752370Ab3CRMO5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 08:14:57 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:64189 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102Ab3CRMO4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 08:14:56 -0400
Received: by mail-ie0-f175.google.com with SMTP id c12so6872977ieb.34
        for <git@vger.kernel.org>; Mon, 18 Mar 2013 05:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:reply-to:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=RLMjE3L7ALwPo0OTDp/IHRa2cTVkQ6tCFJy69yRYiYs=;
        b=r0D0ROFr4lcCtT8aCoZh2TZj3kNuGmavkXuXY7Gq1u7Bp32KZGLVt+dyB5fFsVxIZH
         3Tcy01MvqBFTRbca4Wc4XzKyXn0NOnVhm208HnZkOhzNyNy+L4eAiqQQWZQufXoDgTLH
         enTNJHeSUdtDSkL/x37nn8FPHtmk75+DhmTNRoW/sv+BvM/BjNJ6+ob0MD26cjdGzl8W
         /qwxgUHTlkZfg9xZGhoUdyFLGz/D9HV+a+b1VX2zTC390dSHLpZBojE8StceAeAbqEgf
         4PrKopgCfcmXpnoivd6SPoVlpEY0iaMleb8ZfiGeYDHgImNv/3ixz8LsMpRyY5dEsbPD
         XJgQ==
X-Received: by 10.50.202.6 with SMTP id ke6mr6122750igc.30.1363608895793; Mon,
 18 Mar 2013 05:14:55 -0700 (PDT)
Received: by 10.64.44.47 with HTTP; Mon, 18 Mar 2013 05:14:15 -0700 (PDT)
In-Reply-To: <CABPQNSasFV-vZSMygu16xc-C2d3jTt7mtzFsYQyNUhS5jL-EoQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218406>

On Mon, Mar 18, 2013 at 11:38 AM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> On Sun, Mar 17, 2013 at 11:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Daniel Stenberg <daniel@haxx.se> writes:
>>
>>> On Sun, 17 Mar 2013, Antoine Pelisse wrote:
>>>
>>>>> With redirects taken into account, I can't think of any really good way
>>>>> around avoiding this init...
>>>>
>>>> Is there any way for curl to initialize SSL on-demand ?
>>>
>>> Yes, but not without drawbacks.
>>>
>>> If you don't call curl_global_init() at all, libcurl will notice that
>>> on first use and then libcurl will call global_init by itself with a
>>> default bitmask.
>>>
>>> That automatic call of course will prevent the application from being
>>> able to set its own bitmask choice, and also the global_init function
>>> is not (necessarily) thread safe while all other libcurl functions are
>>> so the internal call to global_init from an otherwise thread-safe
>>> function is unfortunate.
>>
>> So in short, unless you are writing a custom application to talk to
>> servers that you know will never redirect you to HTTPS, passing
>> custom masks such as ALL&~SSL to global-init is not going to be a
>> valid optimization.
>>
>> I think that is a reasonable API; your custom application may want
>> to go around your intranet servers all of which serve their status
>> over plain HTTP, and it is a valid optimization to initialize the
>> library with ALL&~SSL.  It is just that such an optimization does
>> not apply to us---we let our users go to random hosts we have no
>> control over, and they may redirect us in ways we cannot anticipate.
>>
>
> I wonder. Our libcurl is build with "-winssl" (USE_WINDOWS_SSPI=1), it
> seems. Perhaps switching to openssl (which we already have libraries
> for) would make the init-time better?

It does indeed. So this is probably a better solution, and is
something we're considering doing in Git for Windows anyway (for a
different reason). Thanks for all the feed-back!
