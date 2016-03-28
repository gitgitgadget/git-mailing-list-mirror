From: =?UTF-8?B?5oOg6L22576k?= <huiyiqun@gmail.com>
Subject: Re: [PATCH v3/GSoC 2/5] path.c: implement xdg_runtime_dir()
Date: Mon, 28 Mar 2016 23:00:53 +0800
Message-ID: <CAKqreuxJ7Rz2G_hmnAOH7W4rBBKr=CX3pjbzJkkK1ZhN=3_o-w@mail.gmail.com>
References: <1458728005-22555-1-git-send-email-huiyiqun@gmail.com>
	<1458728005-22555-2-git-send-email-huiyiqun@gmail.com>
	<20160325095923.GB8880@sigill.intra.peff.net>
	<CAKqreux8FHdJoKDishjQkbi9g1oUc265EUK4nOJ_sgeFivGSNA@mail.gmail.com>
	<20160325175947.GC10563@sigill.intra.peff.net>
	<CAKqreuzNeY7HryZvMgLKpPAbXOQ_qLfX63YOj57Wo+KrHJbtMA@mail.gmail.com>
	<xmqq60w61wsp.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Your friend <pickfire@riseup.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 17:01:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akYfA-0007E8-UO
	for gcvg-git-2@plane.gmane.org; Mon, 28 Mar 2016 17:01:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753450AbcC1PBA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Mar 2016 11:01:00 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34845 "EHLO
	mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752386AbcC1PA7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Mar 2016 11:00:59 -0400
Received: by mail-oi0-f67.google.com with SMTP id r187so19273377oih.2
        for <git@vger.kernel.org>; Mon, 28 Mar 2016 08:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=qxhloqLx/hdFvEGNgV61vHzPF98rCh6tkHZksLaF6G8=;
        b=Oha3kQf+wWEIhSfLvfyayN2AN3W6v7V0Ic6acbkgZSr3APQWl1o+awI2QvKJCrG8R8
         YA0A3YcZ/7Q5e2mwoivcv3D89tj7A1JZT3B/DYfr8dixdXnpsZ4A9ykGaGn1H6zzUKr9
         5gJDSN5GKv+XmDBIaYQOJ/bm/RVkSBCQ5xOOvWfsOHri8XEueQlHerMFTxUBaR84DCy2
         ljh1t/8FSmeRZap/ujMGztUTwFNSntHoZmYxMHH76OnR19d1zjL1tCMY9K90lGYASDjn
         ifzcZuOugafXy0qhLZhKl+iGQceWPHf/V2G7GU8r61Ekwq9D1K/kKaC11lfq53btJahb
         xhhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=qxhloqLx/hdFvEGNgV61vHzPF98rCh6tkHZksLaF6G8=;
        b=I8Ta0DiUm+bCRouZYEtzxBS/5GEzzFZi3pP22pl2ohu45b23AepXoCDyeP1hRnIQCv
         3GpuAWIbRousvr8dE2OmPWZHAhqNQaGAuG8+XSsQFWU7bQMxIXhy45+YAdpGMQTWfpYL
         4lHxjgpGQKLu+SK4glBihuCccNp6YvtzIRY9q4BJAV0/I9M3C8/9SfC37P7JCIydW65D
         PELIbaxKB+8ptFg3KhGjTv1CLfsCsJnMj+HZQJqWrv6XL3oZCyhHDvBwq5lrHBEihiOl
         fPgFvtaBbyE//IRPrivPB1aKgaQ/x/6uM/rgPZJEW1eSbFl4YzNwBEcMs49tcWOPpwds
         am7g==
X-Gm-Message-State: AD7BkJJg6CyUWQMydcDxwVtySwHY80JNwe/7Ny/3EAyOaeCfiRVuygKC6hmmHW7jW1eBgPwavdP+TDpQhU3y1w==
X-Received: by 10.157.44.66 with SMTP id f60mr11091032otb.163.1459177253361;
 Mon, 28 Mar 2016 08:00:53 -0700 (PDT)
Received: by 10.157.12.170 with HTTP; Mon, 28 Mar 2016 08:00:53 -0700 (PDT)
In-Reply-To: <xmqq60w61wsp.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290039>

2016-03-28 22:50 GMT+08:00 Junio C Hamano <gitster@pobox.com>:
> =E6=83=A0=E8=BD=B6=E7=BE=A4 <huiyiqun@gmail.com> writes:
>
>> After read the source code of strbuf more carefully, I get the concl=
usion
>> that if a strbuf is initialized with STRBUF_INIT but is not used, th=
ere is
>> no need to release it. Is it true?
>
> If it is initialized with STRBUF_INIT and never used, there is no
> reason for the variable to exist ;-)

I mean, if some developer return before the strbuf is used, there seems
no need to release the strbuf according to the current implementation.

But I'm not sure whether this is suitable for the abstraction of strbuf=
=2E

=46or example:

    const char *enter_repo(const char *path, int strict)
    {
        static struct strbuf validated_path =3D STRBUF_INIT;
        static struct strbuf used_path =3D STRBUF_INIT;

        if (!path)
            return NULL; // no need to release, right?
        ...
    }


> Leaving the variable in the code, and not calling release on it at
> the end, would be OK (i.e. there is no leak) today, but may invite
> future bugs (e.g. people may use the variable to tentatively build
> their string before the function returns to leave the scope of the
> variable without adding _release() themselves).
