From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Add test that checkout does not overwrite entries in .git/info/exclude
Date: Mon, 21 Nov 2011 15:52:50 +0700
Message-ID: <CACsJy8AgDKYhyJ2CD0Y7trGrT63bUuYAS0DadD9khyqEYpguew@mail.gmail.com>
References: <CAPRVejcpAZrLWCeHTZJr9Uk6_z6hTPQLLd6pCOKteYnRGMQ5ig@mail.gmail.com>
 <7vehx2ijf8.fsf@alter.siamese.dyndns.org> <20111120221930.GF14902@foodlogiq3-xp-d620.thebe.ath.cx>
 <7vzkfqgn91.fsf@alter.siamese.dyndns.org> <4EC9FC81.3080306@viscovery.net> <7vsjlhhq33.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Taylor Hedberg <tmhedberg@gmail.com>,
	Bertrand BENOIT <projettwk@users.sourceforge.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 21 09:53:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSPd1-0005eq-TM
	for gcvg-git-2@lo.gmane.org; Mon, 21 Nov 2011 09:53:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754883Ab1KUIxX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Nov 2011 03:53:23 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:44895 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752876Ab1KUIxX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Nov 2011 03:53:23 -0500
Received: by bke11 with SMTP id 11so6261602bke.19
        for <git@vger.kernel.org>; Mon, 21 Nov 2011 00:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=InMKRqD3mDl7lw89JQvmaJWyp3GYs0NjNoR1cfkExyQ=;
        b=m4xFixwWryTJENgYWGOHjA51cp56qwkN30rASKSZfU2VmcrmxzGkeuznBN0qs1JIYS
         zek3DEjogTyBX5T2GW0tpmSl3JgqQwaI8da81/DZr3c3xSXJ+fUe21jkFwFBDiNHDuef
         leI1uD+XaFoW69ET6oaZ7duZdUJzbs7M6s58g=
Received: by 10.205.142.4 with SMTP id jg4mr6844147bkc.119.1321865601117; Mon,
 21 Nov 2011 00:53:21 -0800 (PST)
Received: by 10.204.23.2 with HTTP; Mon, 21 Nov 2011 00:52:50 -0800 (PST)
In-Reply-To: <7vsjlhhq33.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185738>

On Mon, Nov 21, 2011 at 2:50 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> If this is a feature, we would like a patch to Documentation/gitignor=
e.txt
> as well, I think. =C2=A0Also I have a suspicion that this was an unin=
tended
> "regression"; do you have a bisection?

It dated back to f8a9d42 (read-tree: further loosen "working file will
be lost" check. - 2006-12-04) when you introduced
--exclude-per-directory to read-tree, but not --exclude-from to
explicitly add .git/info/exclude. "read tree --exclude-per-directory"
is used in git-checkout.sh and the same logic is carried over to
builtin-checkout.c until today.

I guess it's time to add "read-tree --exclude-from". Not sure what to
do with git-checkout though. We may add an option to checkout to skip
either .git/info/exclude or .gitignore, or both.
--=20
Duy
