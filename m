From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Mon, 11 Feb 2008 02:42:26 +0100
Message-ID: <200802110242.27324.jnareb@gmail.com>
References: <200802081828.43849.kendy@suse.cz> <alpine.LFD.1.00.0802100017380.2732@xanadu.home> <BAYC1-PASMTP059B375F7660D93F93647DAE290@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@cam.org>, Jan Holesovsky <kendy@suse.cz>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Mon Feb 11 02:43:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JONhd-0003ks-2k
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 02:43:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbYBKBml convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Feb 2008 20:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751022AbYBKBml
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 20:42:41 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:49022 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904AbYBKBmk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 20:42:40 -0500
Received: by fg-out-1718.google.com with SMTP id e21so3632126fga.17
        for <git@vger.kernel.org>; Sun, 10 Feb 2008 17:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=Ka43nHqbheY+fZuvtNlhmJcWMf3V+8gph0oIaGLou7M=;
        b=qcWUhaziZeJ5/qCW7PF43Zd5+ibWz7l0m/y9ry5Xc2uKoVMi5p37hiL2l7FHk4XI8WVIuVNFYQ9c7OYVe/7XqXBbXtIwSZ8len/ehQuXCodvcwHLjx4V2p7NDMjJh+vm2jHbzMpC7fLNWaI8xokRbcNotP1GAJk5eDNAWir5VdA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=KmyHV1DWlHfCcmmsvBhBmR8paOwTODsc31fUfu04qENd6paWNMB1s6XV8q/dTRmYfN0jesqT1+nOGHDTAzURKplfCCeLoMMbKp44FNrOBVPK7iFfkiAQR0RvrWlN0gs2fwmIUQfX9IzLVsBes+cu8u/5rLbBVs3N8gIzez6gl4Y=
Received: by 10.82.145.7 with SMTP id s7mr28473842bud.7.1202694158372;
        Sun, 10 Feb 2008 17:42:38 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.220.19])
        by mx.google.com with ESMTPS id c5sm622442nfi.2.2008.02.10.17.42.35
        (version=SSLv3 cipher=OTHER);
        Sun, 10 Feb 2008 17:42:36 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <BAYC1-PASMTP059B375F7660D93F93647DAE290@CEZ.ICE>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73450>

On Sun, 10 Feb 2008, Sean napisa=B3:
> On Sun, 10 Feb 2008 00:22:09 -0500 (EST)
> Nicolas Pitre <nico@cam.org> wrote:
>
>> Finding out what those huge objects are, and if they actually need t=
o be=20
>> there, would be a good thing to do to reduce any repository size.
>=20
> Okay, i've sent the sha1's of the top 500 to Jan for inspection.  It =
appears
> that many of the largest objects are automatically generated i18n fil=
es that
> could be regenerated from source files when needed rather than being =
checked
> in themselves; but that's for the OO folks to decide.

Good practice is to not add generated files to version control.
But sometimes such files are stored if regenerating them is costly
(./configure file in some cases, 'man' and 'html' branches in git.git).

IIRC Dana How tried also to deal with repository with large binary
files in repo, although in that case those had shallow history. IIRC
the proposed solution was to pack all such large objects undeltified
into separate "large-objects" kept pack.

You can mark large files with (undocumented except for RelNotes)
'delta' gitattribute, but I don't know if it would help in your
case.

--=20
Jakub Narebski
Poland
