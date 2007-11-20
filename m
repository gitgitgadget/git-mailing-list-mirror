From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH] gitweb: Try to sanitize mimetype for 'blob_plain' view
Date: Tue, 20 Nov 2007 11:58:04 +0100
Message-ID: <200711201158.06029.jnareb@gmail.com>
References: <1195484054-18164-1-git-send-email-jnareb@gmail.com> <7vlk8tl4pv.fsf@gitster.siamese.dyndns.org> <4BAE81C8-EFF3-473D-B243-B7D0F66F131B@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Tue Nov 20 11:58:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuQoO-0008Gn-Rp
	for gcvg-git-2@gmane.org; Tue, 20 Nov 2007 11:58:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755312AbXKTK6S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Nov 2007 05:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754606AbXKTK6S
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Nov 2007 05:58:18 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:42298 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752715AbXKTK6R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2007 05:58:17 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1707783nfb
        for <git@vger.kernel.org>; Tue, 20 Nov 2007 02:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=7SlTfgtyRRKLlkk1385QFnijc7F9jqHRUJAXxZk8+8w=;
        b=fmsLHJxCwnoiTt8FFqTs1/X55Xp7eFMkAEBS3yv9j34gyNE/ZBlGYziYg5KvLAp+N050q7bS97IJMmWufqOO21PQOk3ufGX39R7cgIfWhXDOVf98hLL+1LvobvyQ1ZGxZWFuW8GUfi8fLxYnChmUU/SMV5lD03FddHbfObrpm3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ptjRtyMgVw4T8rVFpbXH2B+c7uej7brMreK75ma1Mt2EFBEs+ePwet62FuHi6ugNCM7rZOHGTEaNT/zQ1q/dBhqBI4TgminelkK38Tq3o/88hGZ5CvFEVrDeYCFiVcwPrir6logKWYREIvmteURbxZ0kxL4tLaYmCUO6pj2lmwM=
Received: by 10.86.73.17 with SMTP id v17mr999231fga.1195556296165;
        Tue, 20 Nov 2007 02:58:16 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.203.224])
        by mx.google.com with ESMTPS id l19sm8182291fgb.2007.11.20.02.58.13
        (version=SSLv3 cipher=OTHER);
        Tue, 20 Nov 2007 02:58:14 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <4BAE81C8-EFF3-473D-B243-B7D0F66F131B@wincent.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65537>

Wincent Colaiuta wrote:

> So yes, this is discarding information -- in a sense it is actually =A0
> removing *correct* configuration from the server side to work around =
=A0
> undesired behaviour on the client side -- but it gave the behaviour I=
 =A0
> wanted. So I think this patch is actually a good idea, because the =A0
> behaviour (the user experience) is more important than adhering to a =
=A0
> standard just because its a standard.

Modifying gitweb to work around not configured web browser and=20
mime.types not written for gitweb like in this RFC patch is one way of=20
solving this. Is it good way? That is why it is an RFC... well that
and details of sanitization.

Another would be to use mime.types crafted specially for gitweb, and us=
e=20
it for $mimetypes_file (gitweb falls back to /etc/mime.types if it is=20
not defined or not present). This might be better solution.


QUESTION: Currently gitweb checks if $mimetypes_file is relative path=20
(using nonportable m!^/! instead of File::Spec::file_name_is_absolute),
and if it is then it is used as relative to project. Does anyone use=20
this feature to provide per-project mimetypes? Would perhaps using=20
relative path as-is (i.e. relative to gitweb script) be better=20
solution, and checking for gitweb.mimetypes repo configuration variable=
=20
for per-repo relative to project if relative?

--=20
Jakub Narebski
Poland
