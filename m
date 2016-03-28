From: =?UTF-8?B?5oOg6L22576k?= <huiyiqun@gmail.com>
Subject: Re: [PATCH v3/GSoC 2/5] path.c: implement xdg_runtime_dir()
Date: Mon, 28 Mar 2016 22:12:09 +0800
Message-ID: <CAKqreuzNeY7HryZvMgLKpPAbXOQ_qLfX63YOj57Wo+KrHJbtMA@mail.gmail.com>
References: <1458728005-22555-1-git-send-email-huiyiqun@gmail.com>
	<1458728005-22555-2-git-send-email-huiyiqun@gmail.com>
	<20160325095923.GB8880@sigill.intra.peff.net>
	<CAKqreux8FHdJoKDishjQkbi9g1oUc265EUK4nOJ_sgeFivGSNA@mail.gmail.com>
	<20160325175947.GC10563@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Your friend <pickfire@riseup.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 28 16:18:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akXtv-0000li-P6
	for gcvg-git-2@plane.gmane.org; Mon, 28 Mar 2016 16:12:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753444AbcC1OMM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Mar 2016 10:12:12 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34060 "EHLO
	mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752468AbcC1OMK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Mar 2016 10:12:10 -0400
Received: by mail-oi0-f67.google.com with SMTP id q133so7409304oib.1
        for <git@vger.kernel.org>; Mon, 28 Mar 2016 07:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=WbP/TFkZtkEdM7JugxsW/aI8WlLwSgNLMeU6k7y/MLc=;
        b=KmBtt28PbVXvZwmWhEOQgoXXK95JG91U1nErKJw8EB4oe4hSVCeqaj2EnKnhLmTwWP
         r48PzfWwTmSyAUkGjljnIVYZW9Tg7teNJiu34wlWJFWtYAG0cVyuSNa/qgV9caJoGXRs
         zsGFIhGCkClulPCKbNI8mF62plK++jQ2Y8i5YjIEYwSQuFI4dIm+LXsnqi09zJZyKvvR
         a4liET4wED6/3EcvP8c+UybYcdgvi4sfMDkpd08IZ/jOU4fPO6RRhOLKn5FDFKnuw1NF
         rzEILEaEDelIULAL2LZJ4C2hDaSO/V2HqvbKzbzcQHmmgtf+x4Q34+zSWahXR2vu4BEi
         effQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=WbP/TFkZtkEdM7JugxsW/aI8WlLwSgNLMeU6k7y/MLc=;
        b=GGqutwEe9+4LnVZ5bV3xF4kyiLVNpy/rhNGso5wGf9lMQ/j2DBarFb8B8IzHJNSKLt
         PwLOO50r8t79xIxPQmViAO9pU3C8hsWtTuHH3Fd+gcIXJj5rb9Sl1QU6AzQqP54K3ARw
         RRGxOWq/0eppdes9SDdm2a4j7QDRwXM/b5X+Xstsx4+60ZUnv6B5Pj2O81A4zrQglJFE
         Q1sOnjNGnes9sA0QdlYTGye2ZTCpJ+N9gPt/0A5Z1dtuNlRHpsGDh4jpdzx8iV9DewfN
         7uvsKzrktXLdGRAJ7RrW+zos8eSi7PkARsOe7BSXGNCudD+78J775RokzN1i+Zjc2jdh
         nJAw==
X-Gm-Message-State: AD7BkJLI91nf5kWz0pFdTrLdEAFe7a/4AEnXHNZqtQmdbAX5f8Yj+/afjVXbZlb02uu8fxDU8KelmHLw5uu/Dg==
X-Received: by 10.157.17.72 with SMTP id p8mr13564302otp.162.1459174329625;
 Mon, 28 Mar 2016 07:12:09 -0700 (PDT)
Received: by 10.157.12.170 with HTTP; Mon, 28 Mar 2016 07:12:09 -0700 (PDT)
In-Reply-To: <20160325175947.GC10563@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290035>

2016-03-26 1:59 GMT+08:00 Jeff King <peff@peff.net>:
> On Fri, Mar 25, 2016 at 10:21:48PM +0800, =E6=83=A0=E8=BD=B6=E7=BE=A4=
 wrote:
>
>> > There are some minor English problems here (and elsewhere). E.g., =
you
>> > probably want "So we just issue a warning and leave it to the user=
 to
>> > solve.".
>>
>> Sorry for my English.
>
> Thanks. And sorry if that sounded too harsh. I know that working in a
> non-native language is tough. Usually in a review I'll try to provide
> specific English fixes, but in this case, I think a lot of these
> messages are still in flux, so I I didn't want to waste either of our
> time going over specifics if the content is just going to change late=
r.
>
>> > These ones leak, too.
>>
>> I will deal with it.
>>
>> I find there are some similar leakage in this file. I'll fix them in
>> another patch.
>
> Great, thanks.

After read the source code of strbuf more carefully, I get the conclusi=
on
that if a strbuf is initialized with STRBUF_INIT but is not used, there=
 is
no need to release it. Is it true?

> -Peff
