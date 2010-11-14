From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 003/160] gettext: fix bug in git-sh-i18n's eval_gettext()
 by using envsubst(1)
Date: Sun, 14 Nov 2010 22:25:08 +0100
Message-ID: <AANLkTinh_Nkxvw7Z5HU=TbJHHFRZeWgr0COJ+N96OeTd@mail.gmail.com>
References: <1289747245-23263-1-git-send-email-avarab@gmail.com>
	<1289747245-23263-3-git-send-email-avarab@gmail.com>
	<20101114181605.GI26459@burratino>
	<7vmxpb1ztf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 14 22:25:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHk4b-0006Ti-6P
	for gcvg-git-2@lo.gmane.org; Sun, 14 Nov 2010 22:25:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756469Ab0KNVZL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Nov 2010 16:25:11 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48886 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754527Ab0KNVZK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Nov 2010 16:25:10 -0500
Received: by fxm6 with SMTP id 6so1327000fxm.19
        for <git@vger.kernel.org>; Sun, 14 Nov 2010 13:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=mfVx8KzWgVdjTnBcRt2unCxtmai8fJ4nEOsuxzCWPK4=;
        b=OMn/f2igFEMU9akjWUxjJoVmtiyfJqaCeydfL2Y5cct9yRCtdemUACl47sGCXugd5G
         /hWu447m4vCM9ceNCBcKW3bb1NTAjgQ/rvb4q6zC2N+Qg8tB0+Z8wb2oncZe39RotZYp
         pRhRl7uFCczdfyVoHUNzIRv0MYRbjZXKwGaxI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=T/Z/tw/FZEYo9NFdK8Tc6afspJx+maiqGxlPlkSUefbFYNvWmQGM9Kk1qiXJzhIoZe
         aGUTAgkxzOQ8pKtp5IKeVa2E2+bfpY/v/9RG13pAzNGROkuvnwIPD/ZUPV7yCqz4PsZr
         n3taK9e2PyxJTmo9YSL+U1yUYaVwDoHa2AorU=
Received: by 10.223.83.138 with SMTP id f10mr4080476fal.114.1289769908822;
 Sun, 14 Nov 2010 13:25:08 -0800 (PST)
Received: by 10.223.105.78 with HTTP; Sun, 14 Nov 2010 13:25:08 -0800 (PST)
In-Reply-To: <7vmxpb1ztf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161444>

On Sun, Nov 14, 2010 at 20:15, Junio C Hamano <gitster@pobox.com> wrote=
:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>> Nit: can this be moved to a subdir? =C2=A0Maybe po or i18n, or even
>> envsubst. =C2=A0This could make it clearer that the code has an upst=
ream
>> and should be updated when upstream is.
>
> IOW, just like "xdiff/" is a separate directory. =C2=A0I think that i=
s a sane
> thing to do.

Thanks for the suggestion. I'll put it in envsubst/ then.

Any idea about the issue of it being linked to too many things? I
tried to add another entry to this section:

    git-%$X: %.o $(GITLIBS)
        $(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter
%.o,$^) $(LIBS)

    git-imap-send$X: imap-send.o $(GITLIBS)
        $(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter =
%.o,$^) \
            $(LIBS) $(OPENSSL_LINK) $(OPENSSL_LIBSSL)

But it wasn't actually used. But then again I don't know Makefile
hacking that much.
