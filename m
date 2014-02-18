From: Zachary Turner <zturner@chromium.org>
Subject: Re: Make the git codebase thread-safe
Date: Tue, 18 Feb 2014 10:14:27 -0800
Message-ID: <CAAErz9iApJ=og65zoctJLfR8PqO2g3PZVJZ76m=ZGzt3TeMHbw@mail.gmail.com>
References: <CA+TurHgyUK5sfCKrK+3xY8AeOg0t66vEvFxX=JiA9wXww7eZXQ@mail.gmail.com>
	<CABPQNSZ_LLg5i+mpwUj7pzXVQMY1tcXz2gJ+PWG-mP1iyjxoaw@mail.gmail.com>
	<CAHOQ7J8QxfvtrS2KdgzUPvkDzJ1Od0CMvdWxrF_bNacVRYOa5Q@mail.gmail.com>
	<CABPQNSZtQd51gQY7oK8B-BbpNEhxR-onQtiXSfW9sv1t2YW_nw@mail.gmail.com>
	<CAHOQ7J_Jrj1NJ_tZaCioskQU_xGR2FQPt8=JrWpR6rfs=c847w@mail.gmail.com>
	<CABPQNSYVGc9m0_xfAWe=3b7CXyGZ-2FfTMRbTJ=UECeZUtdgmg@mail.gmail.com>
	<52FBC9E5.6010609@gmail.com>
	<loom.20140213T193220-631@post.gmane.org>
	<52FD4C84.7060209@gmail.com>
	<CAHOQ7J8syoQLGwwkwPEX3wZir8sWDQ+k8sgHAKn=n_-Q_S8ipA@mail.gmail.com>
	<CAAErz9hzeiJ9f9tJ+Z-kOHvrPqgcZrpvrpBpa_tMjnKm4YWSXA@mail.gmail.com>
	<52FE68C9.3060403@gmail.com>
	<CAAErz9g7ND1htfk=yxRJJLbSEgBi4EV_AHC9uDRptugGWFWcXw@mail.gmail.com>
	<CAAErz9j=_FpWLSyUk43pp8A6e7Ej0crT8ghW5-yxBEbGkd6O+A@mail.gmail.com>
	<CACsJy8Dzj5iyaUseNyU76ojG1C0VYR=v7xsc=6TSGxTh=Xh3Ag@mail.gmail.com>
	<CAHOQ7J-gGbnADQ+3TGy6b6LJSLH8jvAbdTrc20Ybh=p0D2FmsQ@mail.gmail.com>
	<CACsJy8AQNmmW40R-H7kz1dmwiaSKVgu+GP=Jt1qTKgfbZoMkMA@mail.gmail.com>
	<CAAErz9gO3NrAF5Zhu277NLqBv-4otQVWGBP6fX00x2OJ3v0_fg@mail.gmail.com>
	<CACsJy8BdRd8yLjtYqGqQd2b1f550GLq6duZCD3JNiTO+K3GK6w@mail.gmail.com>
	<xmqqlhx8fgqs.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>, Stefan Zager <szager@google.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 18 19:14:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFpBg-0001N3-V6
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 19:14:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbaBRSO3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 13:14:29 -0500
Received: from mail-ie0-f172.google.com ([209.85.223.172]:47729 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800AbaBRSO2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 13:14:28 -0500
Received: by mail-ie0-f172.google.com with SMTP id rd18so3883442iec.17
        for <git@vger.kernel.org>; Tue, 18 Feb 2014 10:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=HCQ65oKaHENCXuUsFRABJFT6dt+/v1T+c13mHvZQ/Uk=;
        b=bE9d+D/yO+fbz8wzxDXZ+iQNclAEiLGZjhua33Lifi9myXOxOZMA6+NdgN7HNXos8g
         JztbPuPvLQ3nnYe6tcdDHVkaLq7I1b6lJuswNmT3pnFgiPT2uJDBiP/w50G38IyM0OJa
         l6H5iKI9uKoMEGCCk5NDW3ktpFVuxpogmlD95/EaGh8+KuB/MeFXAYYqijIwVXNqLryo
         xoEWnr3ftBQGqvkIs9v4o/oS1mzXeg/e41K7P41bWdxJofaC32nFb1a3nR5jsMckzBbP
         +A+ZTWz4iLpXEvkDJoJn78VfkYPnQIbeTgzbGXMbHdTeG7ZgGkMEsm5HQp649cYM+HDz
         f4Sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=HCQ65oKaHENCXuUsFRABJFT6dt+/v1T+c13mHvZQ/Uk=;
        b=aE2zVFc6gf4ElHYqbKwtk+Q7SlMTrznt+C1EkqMpRsuVDXJnUkxFk2IbYc179TViD4
         +Zyh/3qRRFzHFVJctSMeQWwA3k34xuS2/z0M7TiKuPln69USqyVqY8EEtmlazRrdRlkw
         IjZa4Rq5m1Bg6SIrFdXK+jQ7n6a8D8aqEZ8pw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=HCQ65oKaHENCXuUsFRABJFT6dt+/v1T+c13mHvZQ/Uk=;
        b=LmNP3MXIwHdBOcKmvNfDkYjfC5xnp9dSRtjzurVOCXnMn3Y+Zj67LIQ8xFyx026tri
         yGE2trqOTk/Z5TaH6dwqlb6S+qwo+ZCcxmMw/Kfsn271nHQXJK4utddpE07cxUC0Xwg5
         leBww6RzaREX1h3F5n+t1jcHg/BIVMk0K9FwVcL/w6dWulWmDMiz1U4dUwKOfau/fEA+
         FrZ9Aldxlz6e14x/1X4oa8UEnkP1miEHLkYCb4WQA1DL8eevT/zZPqOE3aIAe4n/MPJl
         R8dEGI+WSYLdgsn5lYvF+jVapvIri0Doihi6a6oCHvKpmNnSBe3WesNgfOGv+KTz86LS
         LExA==
X-Gm-Message-State: ALoCoQlC8mXp72pnkczMIeOan84NoG48B8UR9L3gKiyTl7tP1Qj+1ni9DnWmyC0blCYNZiArc9C1KTgIUPyye1zP+DfyNe5Y08VGSbmX8RQqIP/rsVC4xBhOHVPnleI1wulhHovTlrdTID/bPauuMFxWgfD6sFuWUfE/jmtSXNhTRC3R/Yzjs58U8+UAMLHpxQa4LYPpPv1l
X-Received: by 10.43.145.137 with SMTP id ju9mr4336621icc.36.1392747267579;
 Tue, 18 Feb 2014 10:14:27 -0800 (PST)
Received: by 10.64.23.9 with HTTP; Tue, 18 Feb 2014 10:14:27 -0800 (PST)
In-Reply-To: <xmqqlhx8fgqs.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: aFSkJXyLDE9yfDE5f8jb877CJUc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242335>

It shouldn't be hard for us to run some tests with this patch applied.
 Will report back in a day or two.

On Tue, Feb 18, 2014 at 9:55 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Sat, Feb 15, 2014 at 8:15 AM, Zachary Turner <zturner@chromium.org> wrote:
>> ...
>>> 2) Use TLS as you suggest and have one fd per pack thread.  Probably
>>> the most complicated code change (at least for me, being a first-time
>>> contributor)
>>
>> It's not so complicated. I suggested a patch [1] before (surprise!).
>> ...
>> [1] http://article.gmane.org/gmane.comp.version-control.git/196042
>
> That message is at the tail end of the discussion. I wonder why
> nothing came out of it back then.
>
> While I do not see anything glaringly wrong with the change from a
> quick glance over it, it would be nice to hear how well it performs
> on their platform from Windows folks.
>
> Thanks.
