From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [RFC 2/2] Git-over-TLS (gits://) client side support (part 2 of 
	2)
Date: Wed, 13 Jan 2010 14:25:29 +0100
Message-ID: <81b0412b1001130525j63f5879bx657436b418b128df@mail.gmail.com>
References: <1263388786-6880-1-git-send-email-ilari.liusvaara@elisanet.fi>
	 <1263388786-6880-3-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Wed Jan 13 14:25:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV3E9-0000wR-39
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 14:25:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754268Ab0AMNZc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jan 2010 08:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753911Ab0AMNZc
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 08:25:32 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:51569 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753600Ab0AMNZc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jan 2010 08:25:32 -0500
Received: by bwz27 with SMTP id 27so1907704bwz.21
        for <git@vger.kernel.org>; Wed, 13 Jan 2010 05:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=OYS5q63abmgdP8EaWSmsjh7TzBaUuW0g3jM1dkNb11U=;
        b=xcPcn7WAIJ8mUxFKVLG2i95aHf4JRWYwLqu4/OM0pJtfP8YbTr0OKSDqNHEkAOEuOX
         R5zHJ86YkHL7rXcP2HOFjtDCIVmla1Gu8cnweDMRTtDOoWzljFsPgKNMKFC6EdOB6gVb
         I8OX4sEZLffF4z4dj0zBvlCLeRTiPPhEWpvjc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oRNEb3QqTYnxDBqtZEly8Wess7bD61aMddknFgCci9kJ+MjzTgVbld61ldT/IKbn4B
         D1rxFs4c/tuWUnAVy8/vD3iZsgXt8MARZ6GoK/3s0IYNweNfSvfRKoMVlsX6rW4sFyyT
         Nf+9aCHBfquRBILGKRXBodDhE8G1Ehhx5N6EI=
Received: by 10.204.32.19 with SMTP id a19mr5501053bkd.90.1263389129304; Wed, 
	13 Jan 2010 05:25:29 -0800 (PST)
In-Reply-To: <1263388786-6880-3-git-send-email-ilari.liusvaara@elisanet.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136819>

On Wed, Jan 13, 2010 at 14:19, Ilari Liusvaara
<ilari.liusvaara@elisanet.fi> wrote:
> +char *copy_alloc(const char *str, size_t len)
> +{
> + =C2=A0 =C2=A0 =C2=A0 char *copy;
> +
> + =C2=A0 =C2=A0 =C2=A0 copy =3D xmalloc(len + 1);
> + =C2=A0 =C2=A0 =C2=A0 copy[len] =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 strncpy(copy, str, len);
> + =C2=A0 =C2=A0 =C2=A0 return copy;
> +}

Some know this code as strndup(3):

  http://linux.die.net/man/3/strndup
