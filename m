From: Shawn Pearce <spearce@spearce.org>
Subject: Re: PROPFIND 405 with git-http-backend and Smart HTTP
Date: Mon, 30 Jul 2012 09:37:46 -0700
Message-ID: <CAJo=hJtynNo3SPmM4vmmsS3b7PTUwOcQpHPYh0_sPWFWL-4HMA@mail.gmail.com>
References: <1343587966493-7564017.post@n2.nabble.com> <CAJo=hJtB6OQ8+8Q_JgPoAntOdQ=Z0tOERYRD7wJ0LRLgacYA8A@mail.gmail.com>
 <1343637600904-7564056.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Bo98 <BoEllisAnderson@aol.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 18:38:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Svsyz-0006D2-RZ
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 18:38:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754197Ab2G3QiI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 12:38:08 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:64354 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754130Ab2G3QiH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 12:38:07 -0400
Received: by ghrr11 with SMTP id r11so5033063ghr.19
        for <git@vger.kernel.org>; Mon, 30 Jul 2012 09:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=w/HmAmwsSShchESv4mlQAqMOdNxM787I5A2mLkPyCEg=;
        b=MnDIqqKPBj+Tq/YsSe4pj41f8ppFdRZJ/MioZY1uhFA7e2kdhvdRHRS6Vt3TmTzaLz
         fFe8e2mb5KLWWa7V5cxI4eZHh/Cl4/czIKyGaiI58dy63zbF8CuJ5hHFRSGYiIEUiYKJ
         oBAIPd6lEAqzPIbUR6bc+0lHw+fwhSVven8C4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=w/HmAmwsSShchESv4mlQAqMOdNxM787I5A2mLkPyCEg=;
        b=diHz8jgETDKLMGzpJIeXVcVfHmCqwleFcVvIGrH2oz3+3uHZa/JiMy0se8EalVK7Lz
         STFqxSdKGWfIALDpV+0NJV6LSaxJkmR/1Rsdg75Xi3ga/yEr6jMgmWtIK2n5WbSnNS/a
         IEDN5tt5ozU8K4uM6K7pcr2a2ajm2AlcRMxO+8NaL2M+kG5BVVqx1YxAAYL7nnc2LuHj
         S27Ju7UUVlggFt3I9bWKQAEYY6PtkJ8QLsWCozfPYgceFv6KyufH4BMmWFIOpxgho/Xk
         kyqWBAHgup+83CqocYHW8KER23Q1l0aUk2EQB52GXcbQBpLageJyH4elPtjyaIcMCebL
         P2qg==
Received: by 10.50.149.199 with SMTP id uc7mr8703301igb.12.1343666286265; Mon,
 30 Jul 2012 09:38:06 -0700 (PDT)
Received: by 10.64.14.177 with HTTP; Mon, 30 Jul 2012 09:37:46 -0700 (PDT)
In-Reply-To: <1343637600904-7564056.post@n2.nabble.com>
X-Gm-Message-State: ALoCoQmgoulm0XaYohV0qZIA5ElIusd5qNurbyAmZLZ4kQ+Hwx81iPFiVMNJyf24xuVwVvziuDSH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202575>

On Mon, Jul 30, 2012 at 1:40 AM, Bo98 <BoEllisAnderson@aol.com> wrote:
>
> Shawn Pearce wrote
>>
>>> And here's a snip from my access_log:
>>>
>>>     ::1 - - [29/Jul/2012:18:34:34 +0100] "GET
>>> /repo/myproject.git/info/refs?service=git-receive-pack HTTP/1.1" 200 117
>>
>> Was this request actually served using the smart http-backend? Try the
>> request yourself on the command line with curl, making sure to pass
>> the ?service=git-receive-pack query parameter. A smart HTTP response
>> will include a service=git-receive-pack line as the first line of the
>> response body. I don't think Apache called the http-backend CGI, and
>> so the client thought the server was not smart HTTP capable.
>>
>
> This is what curl returned:
>
> 2ddf56592a0f55456b8c42dc9f2cb9289f083f53        refs/heads/1.0.x
> 55079bb13d9af8a9164ad0d24b654cbfe119bc7e        refs/heads/master
>
> Looks okay. Those are the 2 branches I've got.

No, a smart HTTP response looks more like this:

1e# service=git-receive-pack
000000a5e7a3bcbbb8083e812ce07a5459f0e6d30edfb9fe HEAD include-tag
multi_ack_detailed multi_ack ofs-delta side-band side-band-64k
thin-pack no-progress shallow no-done

Looks like Apache isn't calling the smart-http CGI.
