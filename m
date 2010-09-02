From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 24/25] gettextize: git-status basic messages
Date: Thu, 2 Sep 2010 20:41:10 +0000
Message-ID: <AANLkTin1ew1nXLwEoyMqMRkZpr6xq2rebRDmVVgA2BLr@mail.gmail.com>
References: <1283373845-2022-1-git-send-email-avarab@gmail.com>
	<1283456446-22577-25-git-send-email-avarab@gmail.com>
	<20100902202846.GD2531@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 02 22:41:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrGaz-0001Fb-Fm
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 22:41:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756966Ab0IBUlN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 16:41:13 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33927 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753493Ab0IBUlM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Sep 2010 16:41:12 -0400
Received: by fxm13 with SMTP id 13so617147fxm.19
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 13:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=k3emmxvGl9y8tAvDiIaG0/O0PVSov7DNqBuVSORGtpE=;
        b=sCBLCvjL0qBgZcyuqsTEWQ75/6H92ZgLYDt9g9lVUannmaqpMVF7vGKMLSGXoUuj0Y
         lv/JIrYGFsRcx1ECCInfkp4o0+DTbx28KyorI7cz2Wo90RmBsNcoBpBwxE5A6XB1RVrp
         O5hR4d7Pu6ZgVeWWyg0W8l3zFOSBR7xIjsp7w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=JCjLvyn/TqKeb2u68Q1sdRwEoolPSJ3FHJHh2S78myDrtACZIEu/vw9GmFbkvjgZeA
         IzrDJltGuKmbY0851+JvR77h9h6QBd00bczm3DvTxNA7FAJza8C0Q/yI5QwBgYgmRlJ7
         FrfScolCAXFJlIpanMHlqDxaCjn78puwiRsN8=
Received: by 10.223.103.148 with SMTP id k20mr5078306fao.37.1283460070912;
 Thu, 02 Sep 2010 13:41:10 -0700 (PDT)
Received: by 10.223.120.14 with HTTP; Thu, 2 Sep 2010 13:41:10 -0700 (PDT)
In-Reply-To: <20100902202846.GD2531@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155201>

On Thu, Sep 2, 2010 at 20:28, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> The only change is the removal of two messages that didn't really
>> belong: _("#\t") and _("%-20s%s\n").
>
> Hmm, isn't it better to let translators tweak the output format to fi=
t
> their constraints? =C2=A0Especially 20 characters might not be enough=
 to
> hold the "deleted by them" et al messages in some language.

Maybe, but my current mode of operation is "do it really simple and
stupid now, solicit complaints later".

Eventually I'd rather just eliminate the need for tweaking stuff like
that by having some va_args function that spews out "16" for that
given a bunch of arguments, i.e. (pseudocode):

    int width =3D gimme_longest(
        _("both deleted:"),
        _("added by us:"),
        _("deleted by them:"),
        _("added by them:"),
        _("deleted by us:"),
        _("both added:"),
        _("both modified:")
    );

    char *fmt =3D concat("%-", width + 4, "s%s\n");
    printf(fmt, ...)
