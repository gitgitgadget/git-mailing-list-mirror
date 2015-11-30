From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC/PATCH] config: add core.trustmtime
Date: Mon, 30 Nov 2015 20:12:14 +0100
Message-ID: <CACsJy8BZo4hFz+mQKNxrmPQaGforvguFmjL90g=Hf698okFs2A@mail.gmail.com>
References: <1448433323-21037-1-git-send-email-chriscool@tuxfamily.org>
 <CACBZZX4YSvfA=BRayk8CC8ipk_nDdvJfznxjyb-upwP9PKRBSA@mail.gmail.com>
 <CACsJy8DhAfu7J=WpPAp8HYGLuFQC5+DZyZj6Hs6vruEJEeVKig@mail.gmail.com>
 <CAP8UFD2V3nbY2-abW6cGDtB2PR9Q+sN+d0RgTVJORCPg6TPMcQ@mail.gmail.com>
 <CACsJy8CNRbvsDY+ucFZGcO4+tE9Ud_QNr1k4D=+utawSCrc+Sg@mail.gmail.com>
 <CACBZZX4jJ_b-5sbor6YibXGASeOa0gx8nEBiv8=54yoHfWL8Fw@mail.gmail.com> <xmqq610j8fzt.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	David Turner <dturner@twopensource.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 30 20:12:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3TsY-0007j3-RG
	for gcvg-git-2@plane.gmane.org; Mon, 30 Nov 2015 20:12:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751755AbbK3TMq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Nov 2015 14:12:46 -0500
Received: from mail-lf0-f43.google.com ([209.85.215.43]:35021 "EHLO
	mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237AbbK3TMq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Nov 2015 14:12:46 -0500
Received: by lfdl133 with SMTP id l133so209583846lfd.2
        for <git@vger.kernel.org>; Mon, 30 Nov 2015 11:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=KCxpPB4APDjLmiPMXWOQfsmJ4MgJtc9O+AI5wek352U=;
        b=0x00oyZe5+PUPsTwQhoy6p18KuOJBLjZgZ4QoRuazHhO8jx3C5UHPUVFEESJuYu0Bp
         pkyK31aPiDatpDyuKa0p7Omdqv8r0HBd07xlK61hicOCfbzJw+0hfomCCoAZFc1Qc1QQ
         Ai0aH9Cy4yDA//uDKo1Qn6116Yk5H9vOd5M9KYVrsNhG9NdLM7SN0IgMZuyK1rv7ff0I
         WnPZO2Ng1hWCHGL2A2MYUxXmjwxxdxiKGsiQ/gqGeyXsanmu+m5PJSMHH+J8R80MWMYF
         JkKGSCzZjO+IqFGFSBLVeWh0ttmhbyD/GLRU8kJR1y9lh4vkt0YkJs2LRVIhy5zCouN7
         792g==
X-Received: by 10.112.202.168 with SMTP id kj8mr25674880lbc.12.1448910764597;
 Mon, 30 Nov 2015 11:12:44 -0800 (PST)
Received: by 10.112.199.5 with HTTP; Mon, 30 Nov 2015 11:12:14 -0800 (PST)
In-Reply-To: <xmqq610j8fzt.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281813>

On Mon, Nov 30, 2015 at 8:05 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> Maybe I'm missing some really common breakage with st_mtime on some
>> system, but having a feature the user explicitly enables turn itself
>> off and doing FS-testing that takes 10 seconds when it's enabled see=
ms
>> like the wrong default to me.
>>
>> We don't do it with core.fileMode, core.ignorecase or core.trustctim=
e
>> or core.symlinks. Do we really need to be treating this differently?
>
> I share the exact thought.  I was looking the other way when
> untracked-cache was done originally ;-), and I would also want to
> know the answers to the above questions.

OK I was just paranoid (and having to look at filesystem source code
to determine if it supported this didn't help either). So I guess that
means we can make the test a separate option, only invoked by the
user, then.
--=20
Duy
