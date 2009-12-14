From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] help.autocorrect: do not run a command if the command 
	given is junk
Date: Mon, 14 Dec 2009 14:29:21 +0100
Message-ID: <81b0412b0912140529w4a15418ewf304b9d6f4c1f007@mail.gmail.com>
References: <4B263797.5070808@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Dec 14 14:29:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKAzQ-0003ej-OG
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 14:29:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbZLNN3Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Dec 2009 08:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbZLNN3X
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 08:29:23 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:63051 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbZLNN3X convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Dec 2009 08:29:23 -0500
Received: by bwz27 with SMTP id 27so1969530bwz.21
        for <git@vger.kernel.org>; Mon, 14 Dec 2009 05:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=4mZjx8MiS8xDvIghuwBLwcjbZ+KnuAqukVVdYD05e3E=;
        b=dtVzRe3kE5tVYpn33zC9f3k7VPl+7qc3PfUmWrc4MziJN9j0UIOKVcHAKSj19MUIiY
         odtGJ2JoKSVCdtUTUwcURofIe+Oso7N2n6WWAIidfEvkEKzYnifTEAN9j12VFjNYXl/o
         iQ13G7DEJe4pbCJyAAPqJ8vOfdBZP7R/L35GE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oUQOG0Dl5l3MrowdOGStl3Bb9nrViPdt4vKhRUEAluuD4/vULwh4S28ZL9H0FOG4nM
         uuzjCC4J6uAsYP6nbREQO/LyjPFsPOwRCBi0nOpRmVQW4g9uCvtRnk8UvJEz8oJ64bhn
         dNXSPFGTaf//DFpK28Hc8zXYUawJuyANg46ns=
Received: by 10.204.34.5 with SMTP id j5mr2800669bkd.123.1260797361527; Mon, 
	14 Dec 2009 05:29:21 -0800 (PST)
In-Reply-To: <4B263797.5070808@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135211>

On Mon, Dec 14, 2009 at 14:03, Johannes Sixt <j.sixt@viscovery.net> wro=
te:
> From: Johannes Sixt <j6t@kdbg.org>
>
> If a given command is not found, then help.c tries to guess which one=
 the
> user could have meant. If help.autocorrect is 0 or unset, then a list=
 of
> suggestions is given as long as the dissimilarity between the given c=
ommand
> and the candidates is not excessively high. But if help.autocorrect w=
as
> non-zero (i.e., a delay after which the command is run automatically)=
, the
> latter restriction on dissimilarity was not obeyed.
>
> In my case, this happened:
>
> =C2=A0$ git ..daab02
> =C2=A0WARNING: You called a Git command named '..daab02', which does =
not exist.
> =C2=A0Continuing under the assumption that you meant 'read-tree'
> =C2=A0in 4.0 seconds automatically...
>
> The similarity limit that this patch introduces is already used a few=
 lines
> later where the list of suggested commands is printed.

Yes, sure. We probably just missed that (I don't use autocorrect myself
apart from the testing. I assume Johannes doesn't, too)
