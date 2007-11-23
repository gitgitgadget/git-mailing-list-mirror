From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Wishlist for a bundle-only transport mode
Date: Fri, 23 Nov 2007 10:18:48 +0100
Message-ID: <200711231018.49322.jnareb@gmail.com>
References: <8aa486160711210654p357ccd87i4809e0cda9471303@mail.gmail.com> <8aa486160711220142w25e9c9b6vbafa34a287dde7eb@mail.gmail.com> <7v4pfe7g4e.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Santi =?utf-8?q?B=C3=A9jar?= <sbejar@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 23 10:19:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvUgw-0002T3-Qx
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 10:19:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755116AbXKWJS6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Nov 2007 04:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755195AbXKWJS5
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Nov 2007 04:18:57 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:27906 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754810AbXKWJSz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2007 04:18:55 -0500
Received: by nf-out-0910.google.com with SMTP id g13so2710253nfb
        for <git@vger.kernel.org>; Fri, 23 Nov 2007 01:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=qa+vAI3JWIQ9YP3gIxT7U0rBqK/GbaVmKpEMHTA3pSc=;
        b=ovOIHuW8JBGdwTua6tZsaYCH6BigVrXIGaBsbjhuuZZramD6wL9p6GhhU9APQMwQJjnmH35MIUStlfR/hqXjlSI4TCgGSe8gKaq+/uf2SIYsOWH09VdoPNwW0aYeXfJoI+mzO6mfzQpB8Rhcn2zZlIiS4LdG71DgSxZaUNT5iZA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=nwx3ILoFad8yJ8VNvo6NQA7srQoQPPPUq2jEo3aU4FGlmrBcmmPGEtsLcvsQpuLfwgpEMCSUw5nK1p8ZBXdr2TtfuE4nECosP5FkAVDyUsBiAFt24V11/Y/j4uZenuEnSmTNCLMP7kHXbu1/GvaCvjdVTCCyzwxIc+LQfBt68WQ=
Received: by 10.86.58.3 with SMTP id g3mr9341882fga.1195809533415;
        Fri, 23 Nov 2007 01:18:53 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.249.172])
        by mx.google.com with ESMTPS id l12sm1062686fgb.2007.11.23.01.18.51
        (version=SSLv3 cipher=OTHER);
        Fri, 23 Nov 2007 01:18:52 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7v4pfe7g4e.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65880>

On Thu, 22 Nov 2007, Junio C Hamano :
> "Santi B=C3=A9jar" <sbejar@gmail.com> writes:
>=20
>> Sorry but I do not understand this. I think this two lines could be =
equivalent:
>>
>> git push --bundle bundle.bdl "refs/heads/master:refs/remotes/bundle/=
master"
>> git bundle create bundle.bdl refs/heads/master ^refs/remotes/bundle/=
master
>=20
> Interesting.
>=20
> 	$ git push $something ours:theirs
>=20
> has defined semantics for any value of $something.
>=20
>  * give $something objects it lacks, so that the object $ours
>    become complete in there;
>=20
>  * set the ref in $theirs to point at the object $ours.
>=20
> So "git push bundle.bdl refspec" should:
>=20
>  * First read bundle.bdl, to find out what objects it gives to
>    the recipients;
>=20
>  * Add missing objects to it to make it up to date wrt "ours",
>    iow, fetching from the updated bundle would now give "ours";
>=20
>  * Record the object "ours" as "theirs" ref, iow, listing
>    the updated bundle would show "theirs" ref pointing at that
>    object.
>=20
> If bundle.bdl does not exist yet, it is like pushing into a
> freshly initialized empty repository.

But for that I think "git bundle" should learn new subcommand:
"git bundle update", which would use refs existing in given
bundle as prerequisites, and either update bundle (create anew
or just concatenate next pack) or create incremental bundle.

Something similar to incremental mode or update command of
archivers...

--=20
Jakub Narebski
Poland
