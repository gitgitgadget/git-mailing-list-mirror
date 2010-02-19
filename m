From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: Is git over http (git-http-push) ready for production ?
Date: Fri, 19 Feb 2010 19:14:41 +0800
Message-ID: <be6fef0d1002190314n4300aed3uc58d812b83342db2@mail.gmail.com>
References: <hllp07$o78$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Fabien <fabien.ubuntu@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 12:14:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiQop-0005fi-Lx
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 12:14:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751689Ab0BSLOm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Feb 2010 06:14:42 -0500
Received: from mail-iw0-f196.google.com ([209.85.223.196]:61215 "EHLO
	mail-iw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902Ab0BSLOl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Feb 2010 06:14:41 -0500
Received: by iwn34 with SMTP id 34so592572iwn.15
        for <git@vger.kernel.org>; Fri, 19 Feb 2010 03:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=t5+lV7pvyynQrr9h/VjEdfIKBjYP3U6N8JpLjza04WI=;
        b=NoOuzWShSKFCiwUMUrTCk3FCGMhVbIiuUVvDcLrpblfGg+2x/pbLFUUa20cjBjqWxj
         HAm9sjq4OJkc9FsvhixZ36dNbR1iGUF7fEgS/0U7TQbFiNmdjWdPBF3Wl3G17vt6zZDQ
         j52pqQqhckcFtui3Ki8KDWybeObuJ0R6a5+vc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DVjgDaYddE0AurwtkI9lJsqCz/hesBmBCHpwaWU1IDDFbQhHHVaK2/eGdmmSzEdbOa
         Ah0VkPipA7hxik5m7ROIRGyjV/yq67ntEOGOvGJqo7EkYf2JAhi28lgB6Ae3jFvv1q8y
         U6CdiH4CfcnLZIeSGOW8onRacvH9TyA0PORn8=
Received: by 10.231.173.129 with SMTP id p1mr1554062ibz.85.1266578081143; Fri, 
	19 Feb 2010 03:14:41 -0800 (PST)
In-Reply-To: <hllp07$o78$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140443>

Hi,

On Fri, Feb 19, 2010 at 6:26 PM, Fabien <fabien.ubuntu@gmail.com> wrote=
:
> I had to delete the davlock file and restart apache to solve the issu=
e.

I guess this is a regression. Before remote helpers were introduced,
the dumb http-push program was able to release locks on the remote
side on such signals.

> So, this operation doesn't seem really atomic ?

Overall, git-push over dav isn't atomic. At most, it is atomic at the
individual object level - for example, you won't get a blob with SHA-1
"abc123" but hashes to a different SHA-1 value.

> Another problem I see is the password in clear text in ~/.netrc to av=
oid
> =A0to type passwords all the time.

Might sound pathetic, but you could chmod it to make it readable only
to yourself.

> Is there any plan to address this problem ? There used to be the same
> case in subversion (yep, sorry for the comparison), and they finally
> addressed that by supporting GNOME Keyring and KWallet.
> For what I saw, http support is provided thru libcurl, so it may not =
be
> that easy.

You said it yourself. :)

If you really think .netrc isn't your cup of tea, you could tunnel thro=
ugh ssh.

--=20
Cheers,
Ray Chuan
