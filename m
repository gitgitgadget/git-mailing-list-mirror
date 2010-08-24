From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Compiling git with makepp patch
Date: Mon, 23 Aug 2010 23:32:20 -0500
Message-ID: <20100824043220.GA20037@burratino>
References: <84FD9808A65CDF4C959FDB41FC3D134CBCF306D6@MSSRVS4.atlas.de>
 <4C71A53F.2020108@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: occitan@esperanto.org
X-From: git-owner@vger.kernel.org Tue Aug 24 06:34:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnlDA-00081c-Py
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 06:34:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751997Ab0HXEeH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 00:34:07 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:65403 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751843Ab0HXEeG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Aug 2010 00:34:06 -0400
Received: by yxg6 with SMTP id 6so2400913yxg.19
        for <git@vger.kernel.org>; Mon, 23 Aug 2010 21:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=yV2DRTAR9vtlr7Ej69KGzOTFtjGGNDlvSPS2PxQB4ME=;
        b=rIR9x7/WcdJ0jXykQxZ9ZBDAOYRzdBsvd36JecWj2qJ19exmj1NL+ju8nn9cr8xZ2y
         bB0XsUxPp9hNEt0uMKrEG/Xjscv7Ly+jJ+nJ7lzBu393nrehFlhQ0uXjWc4ZIpSVtg++
         QxhE9RTc5EQ4E0h4Su/RZKviKYlZtLDz9xODQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=uM1lvxRiWeYVCr9dqI1yo0upT61CjbruYxF5eTbEn4bwBJ97tjX/teu7mvcojuDnj/
         DLli3gTA4bHA6IOkhUZ0pjIw5IFph6sMHqH5CRPBYEyElPOTKKFq+yukwwuNEt75ZDYd
         3kXcvCQyxXHZRjnm2tcKfi6oQoDM8Z2ow/WlQ=
Received: by 10.101.145.40 with SMTP id x40mr6485904ann.261.1282624444985;
        Mon, 23 Aug 2010 21:34:04 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id c19sm12099031ana.22.2010.08.23.21.34.03
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 23 Aug 2010 21:34:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C71A53F.2020108@t-online.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154285>

Hi,

Daniel Pfeiffer wrote:

> .PHONY: FORCE
>=20
> I don't know why you depend on a phony that has no rule =E2=80=94 I a=
lso had
> to make that possible.

Surely the name explains it. :)

> The file needs to be built immediately so
> that it can be included, before reading the rest of the makefile.
> But the dependency is only known to be phony after running the rule.
> Here you have a hen-egg problem, where I have no clue how Gnu make
> can cope (this is the one case where it requires .PHONY).

GNU make, unlike, say, pmake, reads all the rules before it runs
anything iirc.  So you can have

 -include foo

 foo:
	echo bar: >foo
	echo '	echo hi' >>foo

and it will cope okay.

Anyway, the git makefile is very far from topologically sorted; if
you are suggesting we change that, that's fine with me, as long as
the new rule is somehow justified and consistent.

Hope that helps,
Jonathan
