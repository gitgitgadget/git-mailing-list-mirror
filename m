From: Henry Qin <root@hq6.me>
Subject: Re: Is it possible to build `git` such that the install directory and
 the deployment prefix is not the same?
Date: Fri, 27 Nov 2015 23:58:02 -0800
Message-ID: <CAO8bsPB98QRDRRftHNvLYafB-_EA_sbLMmB5SxxEjY+uRhKKCg@mail.gmail.com>
References: <CAO8bsPDQ2BX1U0D9=pa99_nkEeRWzuN6QzsMw+2u0GPqO6M9kw@mail.gmail.com>
 <xmqqmvty8soc.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, dennis@kaarsemaker.net
X-From: git-owner@vger.kernel.org Sat Nov 28 08:58:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a2aOv-0005ew-Fq
	for gcvg-git-2@plane.gmane.org; Sat, 28 Nov 2015 08:58:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbbK1H6e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Nov 2015 02:58:34 -0500
Received: from hq6.me ([104.236.142.227]:42295 "EHLO mail.hq6.me"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750847AbbK1H6d (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Nov 2015 02:58:33 -0500
Received: from mail-oi0-f49.google.com (mail-oi0-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.hq6.me (Postfix) with ESMTPSA id 884A51201E0
	for <git@vger.kernel.org>; Fri, 27 Nov 2015 23:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hq6.me; s=mail;
	t=1448697513; bh=sn3OSpg8b1zJ7Dyb1OfcZFiukvu5a7u6SFXLiaCGoKY=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
	b=cFLOPSJRQPm8ZBm90fH7AEpTKY+KzeujNtClfx7oV7GEFVSwyuepXRh0371Q+CPRx
	 5BJDnt192vIfzm02yGvG1u90QWww4kwhLYjdKdGPSOLKkUua2rjuQ+z2x2JoZRMBnj
	 10FY09KqNgBnuJAG9JmRxFUcPQ+SuQcMo8jlaYEE=
Received: by oiww189 with SMTP id w189so71470879oiw.3
        for <git@vger.kernel.org>; Fri, 27 Nov 2015 23:58:32 -0800 (PST)
X-Received: by 10.202.65.11 with SMTP id o11mr35034929oia.39.1448697511995;
 Fri, 27 Nov 2015 23:58:31 -0800 (PST)
Received: by 10.60.80.169 with HTTP; Fri, 27 Nov 2015 23:58:02 -0800 (PST)
In-Reply-To: <xmqqmvty8soc.fsf@gitster.mtv.corp.google.com>
X-Gmail-Original-Message-ID: <CAO8bsPB98QRDRRftHNvLYafB-_EA_sbLMmB5SxxEjY+uRhKKCg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281784>

Thanks a lot, Junio and Dennis!

~Henry

On Fri, Nov 27, 2015 at 11:47 PM, Dennis Kaarsemaker
<dennis@kaarsemaker.net> wrote:
> On vr, 2015-11-27 at 23:19 -0800, Henry Qin wrote:
>
>> Is there a way to specify during either configure or make that I want
>> a different path for actual deployment, such as /usr/bin/local, but
>
> There is, using the DESTDIR variable:
>
> make PREFIX=/usr/local
> DESTDIR=$(PWD)/dist make install
> --
> Dennis Kaarsemaker
> www.kaarsemaker.net
>
>


On Fri, Nov 27, 2015 at 11:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Henry Qin <root@hq6.me> writes:
>
>> Here is the question, copied below for your convenience:
>>
>> """
>> I am attempting to build git from source, and I would like make
>> install to put the binaries into a directory called dist in my source
>> directory, so I use the following configure line.
>>
>> ./configure --prefix=`pwd`/dist
>
> You probably want to use DESTDIR instead, e.g.
>
>     $ make prefix=/usr/local DESTDIR=/var/tmp/dest
>
> The standard way to phrase your question is "how do I 'make install'
> to install to a fake location so that I can tar up the result into a
> tarball?" (the key part being "so that..."), I think.
>
