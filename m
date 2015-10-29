From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv2 0/8] Expose the submodule parallelism to the user
Date: Thu, 29 Oct 2015 08:51:27 -0700
Message-ID: <CAGZ79kYXrOFDqs5c-OYG2vRO9GY_aoD_GU1=TkRtOMaGC_GowA@mail.gmail.com>
References: <xmqqfv0wp1l1.fsf@gitster.mtv.corp.google.com>
	<1446074504-6014-1-git-send-email-sbeller@google.com>
	<56321CF4.60807@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Eric Sunshine <ericsunshine@gmail.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Thu Oct 29 16:51:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrpUC-0002g1-SK
	for gcvg-git-2@plane.gmane.org; Thu, 29 Oct 2015 16:51:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753068AbbJ2Pv2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2015 11:51:28 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:32929 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258AbbJ2Pv1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2015 11:51:27 -0400
Received: by ykft191 with SMTP id t191so46735503ykf.0
        for <git@vger.kernel.org>; Thu, 29 Oct 2015 08:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=29IxkZB9PF4L6WnTHb/9P997BCZG53ShJjYbwZbZ3wo=;
        b=paH/EYwGaaEsAlXsLJdI+Tkpc+iQ1KRfOqU7z8ZcQGkwW8EACThQ56uCHFcbGrVIDy
         igDJ/SNV/3947GSW6bdMp+dOi3SqquIIpnkuQkZ/fgm03AiUWrppN3BswkEZeUx8lqAi
         v+E2RBhoB2GZxrK+k448UVQfcExKnY1w+AlU+0PrCnyD/mpu+SHtwH5f8YjKvyjpSiun
         c6tkY7Nwz8LwPFEVfbGybD6aQfSt3ahiDGBZXqgOAcxRY9JLgHP0IjL+4xIKB4GZ6tn4
         tLRyqHxpTsh/4uNDoTQlE3kdpgyYZ9lO9Cb4p7Bnq8KReezVRIzSZKJeK+CZsnvSmwRH
         ENrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=29IxkZB9PF4L6WnTHb/9P997BCZG53ShJjYbwZbZ3wo=;
        b=f//vBk6XxI4Rl6I3GPAjspUUOc+JphkRahBSqqnZfr9Y1n55aREOchjniCInI14d+O
         zinyxpdVTGRKj0V0SBjuavfEKdn+KsgUoy9zfybfpxyZdC9Q/w32cB0ARyBen7JhurWL
         /Ph+v0VFBplggDQEzxaJ4jS25fHDnlGPs0jj2PXRjpvrsDs5EdfvM61WcqFQPPYO1RKM
         xC69DlSI8hQpA+VAyrdmUgVDjrB4OsGwVC8x/YX77N8NBD2MKNMoqQRZNMmpyHVc0CdY
         LTaHOxy+LYGPYnTP6NYCyzYWBujftZdUIaCRk30+5lVnA1qcGtAJ7qjbXUkpSNIwYu6W
         ZXNw==
X-Gm-Message-State: ALoCoQlFzu+x2tCn5/Ph68Uju3RKXeE9wY8InITRCTGOqNryq1OypnPbPbnREKI3zsOC3+Mxqhif
X-Received: by 10.129.75.208 with SMTP id y199mr2163616ywa.48.1446133887217;
 Thu, 29 Oct 2015 08:51:27 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Thu, 29 Oct 2015 08:51:27 -0700 (PDT)
In-Reply-To: <56321CF4.60807@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280443>

On Thu, Oct 29, 2015 at 6:19 AM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:

> Hmm, is there a way to _not_ fetch in parallel (override the
> config) from the command line for a given command?
>
> ATB,
> Ramsay Jones

git config submodule.jobs 42
git <foo> --jobs 1 # should run just one task, despite having 42 configured

It does use the parallel processing machinery though, but with a maximum of
one subcommand being spawned. Is that what you're asking?

Thanks,
Stefan
