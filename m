From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 0/5] Patches to avoid reporting conversion changes.
Date: Fri, 4 Jun 2010 14:42:01 -0500
Message-ID: <20100604194201.GB21492@progeny.tock>
References: <cover.1275309129.git.grubba@grubba.org>
 <7vfx16oxmz.fsf@alter.siamese.dyndns.org>
 <Pine.GSO.4.63.1006031543340.22466@shipon.roxen.com>
 <20100604005603.GA25806@progeny.tock>
 <Pine.GSO.4.63.1006041212200.27465@shipon.roxen.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Henrik =?iso-8859-1?Q?Grubbstr=F6m?= <grubba@roxen.com>
X-From: git-owner@vger.kernel.org Fri Jun 04 21:42:13 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKcmS-0000a3-PQ
	for gcvg-git-2@lo.gmane.org; Fri, 04 Jun 2010 21:42:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752924Ab0FDTmH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Jun 2010 15:42:07 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:64746 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752771Ab0FDTmF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jun 2010 15:42:05 -0400
Received: by pxi8 with SMTP id 8so419792pxi.19
        for <git@vger.kernel.org>; Fri, 04 Jun 2010 12:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=3ztGgq4tB7S8+6k+ebvQFGP+GV0LgDsmbpDacdcfy5g=;
        b=Fud+zYX4KyKHoFxmZnixU7ivP8H6KSXcFYAp6du/6X8QGIalvSpeCYUjH6sLhgGRIp
         MJ+cwMdMyzZxDcNAb9HVg0O5hO5WmCwCWS1SKsKk6rkdAs8nVtXNTsRad3ZBJ6PcmI8h
         XQA4WGEMTrHtvOnYFU5PKt7f/A1SbePMUB/OI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=qnnmDrGXVCyD2JO8bgQfjyqOTiXeaUMxncaSapREfMQSQuXG2FOSZqhBVspK59ZCLS
         DfNxUqQ1IX45EG6Rz/V0B4LEsI4lb0q6vgrbVKKp9Ugt77voYj76k1Vb5Kcb2yjUWYYS
         u18Fb8uLTd+ZQAGdWFVnLi9L9gcNdZRwf0N1k=
Received: by 10.142.9.33 with SMTP id 33mr1675642wfi.0.1275680523984;
        Fri, 04 Jun 2010 12:42:03 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id u18sm957731wfh.19.2010.06.04.12.42.01
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 04 Jun 2010 12:42:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.63.1006041212200.27465@shipon.roxen.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148437>

Henrik Grubbstr=C3=B6m wrote:
> On Thu, 3 Jun 2010, Jonathan Nieder wrote:

>> If you wait for some
>> real change to piggy-back onto, on the other hand, then the per-file
>> normalization patches will make it hard to find what changed.
>
> This seems more like an argument against repositories where
> renormalizations have occurred, than against the feature as such.

No, it is an argument against making the process of renormalization
more painful than it has to be (and against piggy-backing in general).
It is kindest to have a flag day and yank the carriage returns off all
at once like a bandage.

> Well, diff and blame would be confused by a crlf renormalization
> regardless of whether the renormalization was piggy-backed or not.

Only if they cross the revision where renormalization occurred.

> I did do an experiment with a .gitattributes file like:
>=20
>   *.c crlf ident
>   [attr]foreign_ident -ident block_commit=3DRemove-foreign_ident-attr=
ibute-before-commit.
>   # A list of files that haven't been changed since import follows.
>   /foo.c foreign_ident
>   /bar.c foreign_ident
>   # etc

This looks more sane.  Ident strings usually touch only a few lines.

> there were two problems in addition to the long
> list of files in the .gitattributes file:
>=20
>   * The attributes file parsing was broken (recently fixed in the
>     master branch), and the above actually caused foo.c and bar.c
>     to have the ident attribute.

Wouldn=E2=80=99t something like

 /foo.c -ident has_foreign_ident

work?  (Thanks for fixing that attributes macro processing bug, btw.)

>   * Hooks are not copied by git clone. Support for copying of hooks
>     to non-POSIX-like systems is not something I'd like to attempt.

Can=E2=80=99t you include a hooks/pre-commit file and a HACKING file: "=
copy
this file to .git/hooks if you want your patches to be accepted"?

Thanks for your hard work,
Jonathan
