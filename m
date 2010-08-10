From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Black smoke from git rebase -i exec
Date: Tue, 10 Aug 2010 14:16:38 +0000
Message-ID: <AANLkTikVB6VoSy3=XVHqGsA7xH39MgDwh2hDnX89enfM@mail.gmail.com>
References: <AANLkTikCgSNRipTbjiL+uPOqCL3WXwn08_QV=UJ7EwvT@mail.gmail.com>
	<vpqlj8ezizq.fsf@bauges.imag.fr>
	<AANLkTimgRu=nRFpO+QW758SWbQ+Vs+8gtpAc4N-cNWr6@mail.gmail.com>
	<4C615E5E.3090301@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	gitster@pobox.com
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Aug 10 16:16:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OipdE-0006Vu-Sl
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 16:16:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095Ab0HJOQk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Aug 2010 10:16:40 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47260 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757606Ab0HJOQj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Aug 2010 10:16:39 -0400
Received: by iwn33 with SMTP id 33so4433065iwn.19
        for <git@vger.kernel.org>; Tue, 10 Aug 2010 07:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=hwOgaBPUUmlmesbusAPdqAySxkBXk5G8B30Pk2EliS8=;
        b=HaER2E/mZu29+DgkgoeaDY0aPJvDWiki9nsUV6Edi9qoL6rWemjFA3N1jWsQQY52HG
         geMbCwT1BHbola4c18SeDj1QqhI4lEwsXTOZHAxQJmSpFN+jesjFx3lnQk0xPRKU+eE4
         3kjUfGHh+GCKjgBa9d+e4OWPyZI+A6Z1j1KeA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=axdqJfYN4Vv4kJefMQIG9R/L5IbWWJPKM2J4MIrH/tIDAHdTF2/07Omjr5mGxEUnvY
         zkExyDDPojjNJZz11Yo7QQgOXvffOE/bApBSAo7v/6lPpaOg6b8Xsa6uPWVjuR7bA392
         O3Aig3mxUoJgmqDaWl2QY89PrYizihTvoGcpQ=
Received: by 10.231.130.99 with SMTP id r35mr14965042ibs.171.1281449798339; 
	Tue, 10 Aug 2010 07:16:38 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Tue, 10 Aug 2010 07:16:38 -0700 (PDT)
In-Reply-To: <4C615E5E.3090301@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153110>

On Tue, Aug 10, 2010 at 14:12, Johannes Sixt <j.sixt@viscovery.net> wro=
te:
> You cannot apply single-command-export if the command is a shell func=
tion.
> You must rewrite this as:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0(
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0export FAKE_LI=
NES=3D"..." &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_must_fail=
 git rebase ....
> =C2=A0 =C2=A0 =C2=A0 =C2=A0) &&

Except that's not portable either, it should be:

    FAKE_LINES=3D"..." &&
    export FAKE_LINES &&
	test_must_fail git rebase ...

See the other examples in t3404-rebase-interactive.sh
