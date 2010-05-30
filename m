From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH 2/4] revert: refactor code into a do_pick_commit() 
	function
Date: Sun, 30 May 2010 13:19:39 +0200
Message-ID: <AANLkTik6SBEkOICHdMYprzGitfS2hezDXKQ8Q5R8cAYs@mail.gmail.com>
References: <20100529043738.569.85482.chriscool@tuxfamily.org> 
	<20100529044044.569.69037.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun May 30 13:20:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIgYy-0003Yi-Pp
	for gcvg-git-2@lo.gmane.org; Sun, 30 May 2010 13:20:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751530Ab0E3LUA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 May 2010 07:20:00 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:39917 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445Ab0E3LUA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 May 2010 07:20:00 -0400
Received: by vws11 with SMTP id 11so958332vws.19
        for <git@vger.kernel.org>; Sun, 30 May 2010 04:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=blwf4WIGt6Kqdx5agkpAUW/jyB83Wb8xhYU8K76oZQQ=;
        b=PEL4txegQODxmCuwrdz9O44723IM5O+8ZeTfI1VycYTF24D08jKtHkbyqwnOsT/bcR
         TV7kjQR8Hl+Zjz3/SOjQpzH/shUOVFrGvMYcuMY4cZWFSR/vmu4PbQpVQtMQcmf0zYfx
         BHpXVAbF5zzF1wdN7luZatMXahNx5W7jBuZqs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=baUys1hXHRhMgmIegdGPF7FdfrKv7LqD1rPqA930JrjX1fj0AcLj5Fnr6Wa4PlAIiZ
         3JvEwjhrSqaQoHtiNC+41oA02rml+PgTGMgTIrIinvp1k0KhEQo4AYRieEiCTPvl8iTR
         dUPiQrkN8heNdJdMvDTEUpfv17zU/juXxAZeE=
Received: by 10.224.107.138 with SMTP id b10mr1073174qap.93.1275218399057; 
	Sun, 30 May 2010 04:19:59 -0700 (PDT)
Received: by 10.229.50.3 with HTTP; Sun, 30 May 2010 04:19:39 -0700 (PDT)
In-Reply-To: <20100529044044.569.69037.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148000>

Hi Christian,

Excellent feature to work on- I've wanted to cherry pick a range severa=
l times.

Christian Couder wrote:
> -static int revert_or_cherry_pick(int argc, const char **argv)
> +static int do_pick_commit()
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned char head[20];
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct commit *base, *next, *parent;

Is there a better way to do this instead of allocating memory for each
commit? When you cherry pick a lot of commits, it might make sense to
use a shared memory pool.

> + =C2=A0 =C2=A0 =C2=A0 /* this is copied from the shell script, but i=
t's never triggered... */
> + =C2=A0 =C2=A0 =C2=A0 if (action =3D=3D REVERT && !no_replay)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("revert is inc=
ompatible with replay");

If it's here for historical reasons, why don't you remove it now?

-- Ram
