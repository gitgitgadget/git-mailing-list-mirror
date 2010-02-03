From: Frank Li <lznuaa@gmail.com>
Subject: Re: http getpass function in msysgit
Date: Wed, 3 Feb 2010 13:48:26 +0800
Message-ID: <1976ea661002022148s544be10bie912295e04189864@mail.gmail.com>
References: <1976ea661002021918m19d9b37fx1872557d3c810e3a@mail.gmail.com>
	 <7vpr4mrijt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, msysGit <msysgit@googlegroups.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 06:50:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcY8N-0004mG-QE
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 06:50:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752435Ab0BCFs3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Feb 2010 00:48:29 -0500
Received: from mail-gx0-f228.google.com ([209.85.217.228]:64777 "EHLO
	mail-gx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751725Ab0BCFs2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Feb 2010 00:48:28 -0500
Received: by gxk28 with SMTP id 28so934554gxk.9
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 21:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=gsufaGa/dICvbf6LK6SAy8wheVQrtbv3N+3cK4dAZUQ=;
        b=Sy997ICTv1RyGnyAmitEBisQJaGK2w5tphaPbO6U3kXjA1LbJfRi5fAMNbLR5ByEUP
         /ORQNGIGePWSOE6xJoWBTDryFqmVcIrEEhCGNT8TnQsYPxQyywSkOBCUO8tLE8Y3hten
         +WXzOATUGekOJpaea553GKZ3BO/OOYNCeFO/4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Rn5cuub1bc0X3SlegXWl9aHZoE0vku2j+sWDcHaoToSK+h7nkYz3rEYDBm2z0PKrAL
         0MaKY3cBqigNfIxytaqg+fiiFd9bULIueLcDOzFdXgXjXFp4bJ4zvCHznnsmNHfJ30ry
         lmBdC054WPmWvEeo3dTeU9g/j82/cfxe0vd5s=
Received: by 10.150.87.9 with SMTP id k9mr10172169ybb.77.1265176107013; Tue, 
	02 Feb 2010 21:48:27 -0800 (PST)
In-Reply-To: <7vpr4mrijt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138807>

> =A0- If you look at an environment, why check terminal at all? =A0If =
the
> =A0 calling application wants to specify "here is the way to ask the =
user
> =A0 for a password" with it, why not use it unconditionally?

I just worry about user set such environment accident. Learn it from  O=
penSSH.
Unconditional is okay for me.

>
> =A0- Why is it HTTP_ASKPASS? =A0If other codepaths (e.g. "ssh passphr=
ase",
> =A0 "svn password") that do not have anything to do with HTTP transfe=
r also
> =A0 wants that feature,

You can choose environment name you like. I choose HTTP_ASKPASS just
because getpass only used at http.c
ssl_cert_password =3D getpass("Certificate Password: ");

OpenSSH is separated application and use own SSH_ASKPASS to ask passwor=
d ...

May GIT_ASKPASS is optional name.

>  wouldn't it be easier for the users to specify one
> =A0 single "password dialog" helper program, that is launched by vari=
ous
> =A0 parts of git, and ask "I need the HTTP password to access li.org"=
, "I
> =A0 need to unlock the ssh key for fl@li.org", etc?

It is nice to use one dialog for all cases. git-svn also have the same =
problem.
