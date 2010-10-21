From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v4 15/15] daemon: opt-out on features that require posix
Date: Thu, 21 Oct 2010 22:37:44 +0200
Message-ID: <AANLkTikJXaqDH6vJzPna7txssMO67SxmVy_Nvu2SW46W@mail.gmail.com>
References: <1286833829-5116-1-git-send-email-kusmabite@gmail.com> <1286833829-5116-16-git-send-email-kusmabite@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: msysgit@googlegroups.com, j6t@kdbg.org, avarab@gmail.com,
	sunshine@sunshineco.com, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, matled@gmx.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 21 22:38:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P91tr-0005i9-Tc
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 22:38:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756263Ab0JUUiG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Oct 2010 16:38:06 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:54142 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752474Ab0JUUiF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Oct 2010 16:38:05 -0400
Received: by fxm16 with SMTP id 16so32096fxm.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 13:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=h4eO4BaTtvUdcTKK9u22ejjG83zWcXyQ9Jja2gkJAAA=;
        b=eXLvm5v2Yyy07KmBevZL5GDJDiwsLI6PYcQcSOaF7nd3AYHaeLeItHE/4TADmTv4Fg
         mbh1i9I0QHEuBDWONRDtfSSCzQyLFOlKWzbaOaizx9cXMDxyT5mzTsfkNgDPf5+hXAmI
         3lzwuNEfn0YEAAJndlq7ggEa8l0O94z3pxQEE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=i6lsitsoHuUkvhdUH1PlznbGjNhepVVC65g45ROpD5j2k4l+/h/du2upWvSArMg+WO
         9hiMU0hQdblox3/VG/nIgI+gt2I7apkJyXE7UDmhB3mXlWAE5ncFVbvdKPsgMtDDgFYi
         D4qU118g1pdZG4rSOCjc6fs3p23rknnnjrD4w=
Received: by 10.223.72.198 with SMTP id n6mr34376faj.122.1287693484372; Thu,
 21 Oct 2010 13:38:04 -0700 (PDT)
Received: by 10.223.112.146 with HTTP; Thu, 21 Oct 2010 13:37:44 -0700 (PDT)
In-Reply-To: <1286833829-5116-16-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159562>

On Mon, Oct 11, 2010 at 11:50 PM, Erik Faye-Lund <kusmabite@gmail.com> =
wrote:
> @@ -1168,11 +1185,13 @@ int main(int argc, char **argv)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return execute();
> =A0 =A0 =A0 =A0}
>
> +#ifndef NO_POSIX_GOODIES
> =A0 =A0 =A0 =A0if (detach) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0daemonize();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0loginfo("Ready to rumble");
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0else
> +#endif
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sanitize_stdfds();
>

Does anyone know what the call to sanitize_stdfds() is good for? I
tried searching the mailing list, but the discussion on the patch that
introduced it seems to only discuss how to implement
sanitize_stdfds(), not why...

I understand that it might be beneficial in the --detach code-path,
but how can stdint, stdout or stderr be closed in this code-path?

(CC'ed Matthias, who wrote the code)
