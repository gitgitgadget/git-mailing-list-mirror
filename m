From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/7] Add cpp macro implementation of treaps
Date: Sun, 30 May 2010 11:09:17 +0200
Message-ID: <AANLkTilHgXD1mzrTE0PQKeLWM7uheNmZ62ZJGGxuh-7E@mail.gmail.com>
References: <1274650832-7411-1-git-send-email-artagnon@gmail.com> 
	<1274650832-7411-3-git-send-email-artagnon@gmail.com> <20100529071811.GA6648@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Jason Evans <jasone@canonware.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 30 11:09:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIeWf-0002ZG-B4
	for gcvg-git-2@lo.gmane.org; Sun, 30 May 2010 11:09:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752096Ab0E3JJk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 May 2010 05:09:40 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:55768 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751904Ab0E3JJj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 May 2010 05:09:39 -0400
Received: by vws11 with SMTP id 11so896330vws.19
        for <git@vger.kernel.org>; Sun, 30 May 2010 02:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=NFQDwKNos3pKXfLWZ0C7zey+y1xQPkmjqoP6fRxwpQ4=;
        b=DGXJR4EN6KKNOgCQwxIwIDBs3Hd+ncT2at5GCXIzlkA0Lq7GemPyE3vzhwNpEFQEdF
         cyFqiniK1npzXqYjHpN1osAXjR6UkYZE96zVL700xlZGL4G9fLM0cXMIDuU/W0qBzHLn
         yK/iS1d3th/amLWi42BtuTIot93CetxSDYSa4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=N25FedCklz0nPmk8yMlOMJanLxopUhPzGN1puFyp2VRDAMOaddG70U32NFcLYe5sPG
         9tfnAvQPtcR7M3jQLOSxBYgA27P46w2OIE+i6Fm9VY3ojPHRUjQ8kUmjDXKVs1JIKrFY
         cOkhIsmOedviA72+v/mQHI8nr3Gy8WsyNqgCc=
Received: by 10.224.64.79 with SMTP id d15mr1067907qai.319.1275210577161; Sun, 
	30 May 2010 02:09:37 -0700 (PDT)
Received: by 10.229.50.3 with HTTP; Sun, 30 May 2010 02:09:17 -0700 (PDT)
In-Reply-To: <20100529071811.GA6648@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147991>

Hi Jonathan,

Jonathan Nieder <jrnieder@gmail.com> wrote:
> =C2=A0From: Jason Evans <jasone@canonware.com>
>
> =C2=A0Treaps provide a memory-efficient binary search tree structure.
> =C2=A0Insertion/deletion/search are about as about as fast in the ave=
rage
> =C2=A0case as red-black trees and the chances of worst-case behavior =
are
> =C2=A0vanishingly small, thanks to (pseudo-)randomness. =C2=A0That is=
 a small
> =C2=A0price to pay, given that treaps are much simpler to implement.
>
> =C2=A0[db: Altered to reference nodes by offset from a common base po=
inter]
> =C2=A0[db: Bob Jenkins' hashing implementation dropped for Knuth's]
> =C2=A0[db: Methods unnecessary for search and insert dropped]
>
> =C2=A0Signed-off-by: David Barr <david.barr@cordelta.com>
> =C2=A0Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>

Thanks. This can go into the commit message when I re-send the series.

> I don=E2=80=99t know if style nitpicking is welcome here, given that =
the
> code comes from elsewhere. =C2=A0Should we be trying to keep the code
> close to Jason=E2=80=99s version (and sending patches upstream as nee=
ded),
> or is that not worth the trouble?

In my opinion, style nitpicks are welcome: it should conform to the
git.git style. I'm anyway maintaining a separate branch of master just
for changes specific to the git.git merge- Jason and David are welcome
to pull patches from there.

> #include "../git-compat-util.h" would be more portable.

Right, this should be one major change in all the files in the git-merg=
e branch.

> These are defined in obj_pool.h? =C2=A0Maybe this would be easier to
> understand if the patch to add that file came sooner in the series.

Okay. Note that in the revision history, trp.h was first imported, and
then culled to use obj_pool.h by David.

> Where does this magic number come from? =C2=A0(I assume Knuth, but it
> would be nice to include a reference or explanation.)

Indeed. 2654435761 is the golden ratio number corresponding with 2^32.
See http://bit.ly/cwAfD4

> Neat. =C2=A0Maybe this description should go in a file in
> Documentation/technical, to make trp.h itself a little less daunting.

Okay, I'll put it in a separate file then.

> Also: http://www.canonware.com/trp/ seems to provide a test program;
> do you think it would make sense to include it as well?

Probably in documentation/technical?

> [1] http://t-t-travails.blogspot.com/2008/07/treaps-versus-red-black-=
trees.html

This is a good read, thanks.

-- Ram
