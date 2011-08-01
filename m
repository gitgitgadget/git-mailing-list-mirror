From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 11/18] revert: Save command-line options for continuing operation
Date: Mon, 1 Aug 2011 23:25:37 +0530
Message-ID: <CALkWK0nprofui1HyewJeCQiX+uRxABAOeFPMGNqQ+jUHtB13GA@mail.gmail.com>
References: <1311871951-3497-1-git-send-email-artagnon@gmail.com>
 <1311871951-3497-12-git-send-email-artagnon@gmail.com> <201107311342.12547.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Aug 01 19:56:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qnwih-0005rj-Ai
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 19:56:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753571Ab1HARz7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Aug 2011 13:55:59 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:34265 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752876Ab1HARz6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Aug 2011 13:55:58 -0400
Received: by wwe5 with SMTP id 5so5900577wwe.1
        for <git@vger.kernel.org>; Mon, 01 Aug 2011 10:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Fu+UbdDXyvN7Kqh+0ApzNQDYgdePJUWuM7u2wlwNSeU=;
        b=C7kEMH9TkDJdxFrYg7Y7V9LmMu3Rf6avqt0GEd5tTQLX+ZgrKiOjZ1Fr5fa1DeOEwg
         CsFwI+cEXkH+kLMDo6Fk2hGWYs1foffTl5FWnjoIfBhrSBauZSeQjrNd5RSJEZApgDie
         OZdXDl4UluLgtPk6HtlEZg5dU/LAk8n9vksPI=
Received: by 10.216.255.18 with SMTP id i18mr920550wes.64.1312221357111; Mon,
 01 Aug 2011 10:55:57 -0700 (PDT)
Received: by 10.216.137.134 with HTTP; Mon, 1 Aug 2011 10:55:37 -0700 (PDT)
In-Reply-To: <201107311342.12547.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178366>

Hi,

Christian Couder writes:
> On Thursday 28 July 2011 18:52:24 Ramkumar Ramachandra wrote:
>> + =C2=A0 =C2=A0 if (opts->mainline) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strbuf_reset(&buf);
>
> It is not necessary to reset &buf here.
>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strbuf_addf(&buf, "%d", =
opts->mainline);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git_config_set_in_file(o=
pts_file, "options.mainline", buf.buf);
>> + =C2=A0 =C2=A0 }
>
> And perhaps it would be clearer if it was:
>
> + =C2=A0 =C2=A0 =C2=A0 if (opts->mainline) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct strbuf buf =
=3D STRBUF_INIT;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strbuf_addf(&buf, =
"%d", opts->mainline);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git_config_set_in_=
file(opts_file, "options.mainline", buf.buf);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strbuf_release(&bu=
f);
> + =C2=A0 =C2=A0 =C2=A0 }

Much clearer.  Fixed.

>> + =C2=A0 =C2=A0 if (opts->strategy)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git_config_set_in_file(o=
pts_file, "options.strategy", opts->strategy);
>> + =C2=A0 =C2=A0 if (opts->xopts) {
>
> Other nit: maybe you could put "int i" here, instead of at the beginn=
ing of
> the function.

=46ixed.  Thanks.

-- Ram
