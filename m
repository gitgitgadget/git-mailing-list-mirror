From: =?UTF-8?Q?Felipe_Gon=C3=A7alves_Assis?= <felipeg.assis@gmail.com>
Subject: Re: Custom merge driver with no rename detection
Date: Mon, 15 Feb 2016 23:04:40 -0200
Message-ID: <CALMa68o3EsnLaKUmQstkF5KOtiqVkLF4_-Q1eWPyAQQF_adS+Q@mail.gmail.com>
References: <CALMa68ovz=VZYkCcUDvEn1d7=xJDx__71caqsPXUFASZ1phfdw@mail.gmail.com>
	<alpine.DEB.2.20.1602150858340.2964@virtualbox>
	<CALMa68p9jdO63k2NLTUJXyms=Fc+woXx00UXCxzJ5_zV8jO8Rw@mail.gmail.com>
	<xmqqd1ryqlpr.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 02:04:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVU4L-0000Qa-TB
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 02:04:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbcBPBEm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Feb 2016 20:04:42 -0500
Received: from mail-io0-f171.google.com ([209.85.223.171]:35991 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751390AbcBPBEl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Feb 2016 20:04:41 -0500
Received: by mail-io0-f171.google.com with SMTP id l127so174968368iof.3
        for <git@vger.kernel.org>; Mon, 15 Feb 2016 17:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=XcL9m21FC3awaWA6+Nrk9hETs0Tj3Q6IpzRe1k9TXh4=;
        b=c9DrM0HDe/lNDTm5KyppG5NCC/xm68FGSLMweGifBPU3U2dOoGT9n99JY3ibbqrEdT
         5FjsmVfrY+ak8R0A6IS8C1KwmapyOaEKB615gG7gKMrKCOs0Y051E+dnroBGLi7sqWWy
         F/Qfd1M2Ay+kCy8tplNk327qH4WqFK6ykfL2NPw3XOBKgcsB3WHazhygUuZunitnclpU
         xH5T2LqAFDSh7SyMH6LwdzT2cRgGli4clvdr8DFQ6tKSVjHblsGDSRncW3fMRe0Pny8Z
         BcJimI5vAoLU6tEPpLl4O94CO/dnhyd7SD4OgLF9Vl46fY+Wfn6+iqB1C7Pc7e1WoheV
         i7MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=XcL9m21FC3awaWA6+Nrk9hETs0Tj3Q6IpzRe1k9TXh4=;
        b=d9dNro/7NVZ+A4TiDb33W6erdqK0klKW/EiUtRH42nUK+jJ0E0TcZBuya7OhIi4UNm
         dutAzqSj6rQk5xsIJ3b8az5IBBw4t+V24mxymmdJMi40Ai8kEAAXrNfRFfKqc4cIEtsc
         dMKF0MDkG/UPJG4u/MKt0SKJT3mARUfD4MjrBjvFucccpCWDktbSmfqwzj0VQXYQyn2z
         dPCYElkmkyp8xXur2FnKS4Lq+XFxy5nuCjPYw9koG0tunxrsFqWc25xnGLrGlfuN3TFd
         Q9TIO32LjY4IF1ecVxEuuJWju9UnYpycyxDzCNhut17IiQtKxF/40UzY4UGNgXOWQvRc
         vG8Q==
X-Gm-Message-State: AG10YOS56ApaKgnBtDP91lY/guGhfzNzaS0nfd8C3+OBGiGrYhGUShORVIHnwWbdvS+s5SoHh3w/rfNE7/YYBQ==
X-Received: by 10.107.157.18 with SMTP id g18mr19888159ioe.151.1455584680899;
 Mon, 15 Feb 2016 17:04:40 -0800 (PST)
Received: by 10.107.3.94 with HTTP; Mon, 15 Feb 2016 17:04:40 -0800 (PST)
In-Reply-To: <xmqqd1ryqlpr.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286297>

On 15 February 2016 at 09:03, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Gon=C3=A7alves Assis <felipeg.assis@gmail.com> writes:
>
>> However, if you do find this approach acceptable/desirable
>> (rename-threshold > 100%), I can work on the issues pointed out and
>> propose a proper patch.
>
> The caller asks diffcore-rename to detect rename, and the algorithm
> compares things to come up with a similarity score and match things
> up.  And you add an option to the rename detection logic to forbid
> finding any?
>
> To be bluntly honest, the approach sounds like a crazy talk.
>
> If your goal is not to allow rename detection at all, why not teach
> the caller of the diff machinery not to even ask for rename
> detection at all?  merge-recursive.c has a helper function called
> get_renames(), and it calls into the diff machinery passing
> DIFF_DETECT_RENAME option.  As a dirty hack, I think you would
> achieve your desired result if you stop passing that option there.
>
> I called that a "dirty hack", because for the purpose of not
> allowing rename detection inside merge-recursive, I think an even
> better thing to do is to teach the get_renames() helper to report to
> its caller, under your new option, "I found no renames at all"
> without doing anything.
>
> It might be just a simple matter of teaching its callers (there
> probably are two of them, one between the common ancestor and our
> branch and the other between the common ancestor and their branch)
> not call the get_renames() helper at all under your new option, but
> I didn't check these callers closely.

Thanks for all the ideas. In order to have something concrete to
discuss, I submitted the patch "merge-recursive: option to disable
renames".

Is that what you had in mind? I would be happy to receive comments and
either improve it or try something else.

=46elipe
