From: John Tapsell <johnflux@gmail.com>
Subject: Re: git checkout -b origin/mybranch origin/mybranch
Date: Thu, 12 Mar 2009 16:58:22 +0000
Message-ID: <43d8ce650903120958n18baf6c0w9d083976b52d6e40@mail.gmail.com>
References: <alpine.DEB.1.00.0903121240400.10279@pacific.mpi-cbg.de>
	 <alpine.DEB.1.00.0903121357320.6335@intel-tinevez-2-302>
	 <43d8ce650903120618h79686207vaa478c54f34e26f8@mail.gmail.com>
	 <fabb9a1e0903120643r3cfefdfej560ff7edda2be6f5@mail.gmail.com>
	 <B9479687-D936-4EE1-A5A4-663968B76EBF@ai.rug.nl>
	 <20090312153738.GA24690@coredump.intra.peff.net>
	 <43d8ce650903120916yb91113fy5485813c512c8108@mail.gmail.com>
	 <20090312163533.GA28205@coredump.intra.peff.net>
	 <EAF5D3F1-32F2-4BF3-9B10-F91C17D06A6A@ai.rug.nl>
	 <20090312165153.GA28401@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pieter de Bie <pdebie@ai.rug.nl>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 12 18:07:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhoGE-0006lU-1S
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 17:59:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755423AbZCLQ61 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Mar 2009 12:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755132AbZCLQ60
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 12:58:26 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:3564 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754145AbZCLQ60 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Mar 2009 12:58:26 -0400
Received: by qw-out-2122.google.com with SMTP id 5so915533qwi.37
        for <git@vger.kernel.org>; Thu, 12 Mar 2009 09:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=yxhEjg2wpTQQS7v0MonORbvPOYcdB1GGULmi4+ET+Go=;
        b=SCiy5KA23mnIekfi9elzHSsHl67uZ5pQCnC0nZU/KF7A1E5a15ZkQVn6h/CVuPZSxC
         FBQ11kD0qoEVjsEjw+a8RbioA6nYerEIQeGeVf8rLnItSoQyk0b6EHdycoAnP3MBSSlc
         phOeYbHLwsOjf0/DI+x9EkCHJC9lH0EjWsmtM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Am0K+YKZxUvC2elpnaDkuso3uf3G3WyZ0ELn8h5w0+iAM5x+WN0QQD2SPMupdGc/PB
         +wJomlF6GRo2GEN9xrlkGSDyJ07LCRj/oYhQt/7DNlRSyAU9zpgN0jGR1t/s7Bd3x7+w
         pJwwCbPC7cfD86eC/hTxyV60L/8N8Gdm26UqA=
Received: by 10.142.52.7 with SMTP id z7mr66924wfz.260.1236877103158; Thu, 12 
	Mar 2009 09:58:23 -0700 (PDT)
In-Reply-To: <20090312165153.GA28401@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113091>

2009/3/12 Jeff King <peff@peff.net>:
> On Thu, Mar 12, 2009 at 04:40:10PM +0000, Pieter de Bie wrote:
>
>>> I think the future-proofing is probably not worth the effort.
>>> Catching things that are ambiguous _now_ will cover the "oops, I
>>> typed the wrong thing" case, which I think is really the issue.
>>
>> Exactly, that's the common case where things go wrong. I guess using
>> dwim_ref should be DWIM enough? :)
>
> Hmm. Yeah, I mispoke before: I should have said dwim_ref instead of
> resolve_ref (which doesn't dwym :) ).
>
> Here's a sloppy patch that I think does what you want; but it might m=
ake
> more sense to just iterate over ref_rev_parse_rules ourselves, as
> dwim_ref does more than we care about (and we should probably
> differentiate between "a branch already exists" and "this would make =
an
> ambiguous ref").
>
> ---
> diff --git a/branch.c b/branch.c
> index d20fb04..409f445 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -122,6 +122,7 @@ void create_branch(const char *head,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned char sha1[20];
> =C2=A0 =C2=A0 =C2=A0 =C2=A0char *real_ref, msg[PATH_MAX + 20];
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct strbuf ref =3D STRBUF_INIT;
> + =C2=A0 =C2=A0 =C2=A0 char *junk;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int forcing =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int len;
>
> @@ -135,7 +136,8 @@ void create_branch(const char *head,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (check_ref_format(ref.buf))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0die("'%s' is n=
ot a valid branch name.", name);
>
> - =C2=A0 =C2=A0 =C2=A0 if (resolve_ref(ref.buf, sha1, 1, NULL)) {
> + =C2=A0 =C2=A0 =C2=A0 if (dwim_ref(name, strlen(name), sha1, &junk))=
 {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 free(junk);

Presumably 'junk' is the resolved name?  I wonder if it's worth
putting this info in the error message?

> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!force)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0die("A branch named '%s' already exists.", name);

>                        die("A branch named '%s' already exists (%s)."=
, name, junk);

That would give  "A branched named 'origin/master' already exists
(refs/remotes/origin/master)"  right?

Dunno if it's worth it, just wondering.
