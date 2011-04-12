From: Jacek Masiulaniec <jacek.masiulaniec@gmail.com>
Subject: Re: git archive: tar.umask ignored
Date: Tue, 12 Apr 2011 21:39:48 +0100
Message-ID: <BANLkTinEFPZoaUAc+8F1sPGE636u1vDOZw@mail.gmail.com>
References: <BANLkTimTs+Qh9fNs6pLcZidYy-YjXNR2iw@mail.gmail.com>
	<4DA497B7.706@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Apr 12 22:40:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9kNT-00034m-Hs
	for gcvg-git-2@lo.gmane.org; Tue, 12 Apr 2011 22:39:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757346Ab1DLUjv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Apr 2011 16:39:51 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:65403 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757341Ab1DLUjt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Apr 2011 16:39:49 -0400
Received: by iwn34 with SMTP id 34so6990862iwn.19
        for <git@vger.kernel.org>; Tue, 12 Apr 2011 13:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FZe+A75waDMybFlPbUXTrVQJSv9ECTAu4xO7JMsfm8k=;
        b=JX6Dun1GPmSwPsMKKnmVN7s0y8mJofplHC4/EavXjQL021O6FNl23EqgdA0idmZzTJ
         nWG0/Eieds2z1xFzrp2Vqugfk85Z4zgyBcfwe/Q1OrkBaK7q5OQPVUit/u1gdQQWBpTq
         vAXua/qBHw1hRyFoAGf6k7UkFVpuS051Ig6KA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=g0QD9rw5YkCOEHkbF0sj3w81JZ8l6tEFu9scPlIt+xG+xbHLHvZNI+yda8yHypQEVo
         CelfQBFCwu9/YJR6ipoid+Uaq/AGwbmkqS81GGH8rQQ+lFig0UiPnN9o56MZuQpAVeQH
         Aznct+uByZatDMS9enUKPhcUGJYupf0/eJo/o=
Received: by 10.231.4.139 with SMTP id 11mr7299341ibr.65.1302640788906; Tue,
 12 Apr 2011 13:39:48 -0700 (PDT)
Received: by 10.231.17.71 with HTTP; Tue, 12 Apr 2011 13:39:48 -0700 (PDT)
In-Reply-To: <4DA497B7.706@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171417>

On 12 April 2011 19:19, Ren=E9 Scharfe <rene.scharfe@lsrfire.ath.cx> wr=
ote:
> The local setting of tar.umask does not affect the archive created at=
 the
> remote end. =A0If your "remote" repository is in fact located on the =
same
> machine and accessed with the same user then of course settings in
> ~/.gitconfig will take effect.

I've eventually realised this by reading the source code.  The command
I actually needed was:

  cd /repo/website.git && git -c tar.umask=3D0022 archive HEAD

Can't comment on the proposed diff without getting better handle on
the whole system, but my knee-jerk reaction would be to resist the
urge to add more switches.  Maybe the existing -c switch could be made
to cooperate with --remote, or maybe the documentation could be edited
to make it clearer that -c and --remote are not related in the way I
had originally assumed.

Jacek
