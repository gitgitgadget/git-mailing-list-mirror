From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 0/2] Re: packaging vs default pager
Date: Thu, 29 Oct 2009 02:32:24 -0500
Message-ID: <20091029073224.GA15403@progeny.tock>
References: <1256742357-sup-3798@ntdws12.chass.utoronto.ca>
 <7vskd3o11t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ben Walton <bwalton@artsci.utoronto.ca>,
	GIT List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 29 08:22:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3PL8-0007Xx-Qh
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 08:22:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756637AbZJ2HWY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Oct 2009 03:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756624AbZJ2HWY
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 03:22:24 -0400
Received: from mail-yw0-f202.google.com ([209.85.211.202]:49395 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756615AbZJ2HWX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 03:22:23 -0400
Received: by ywh40 with SMTP id 40so1428063ywh.33
        for <git@vger.kernel.org>; Thu, 29 Oct 2009 00:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=kzU16Gjx9y0GnJIJXWq3OMkW0UGqN7GpEpcU5SOzXxQ=;
        b=JL1fWxg+mLT6vRKdr+t5Q7oAwskpWHdH+wSml+ea95Vl9RPAkAEthoR8z3YZ1wqh/Q
         Z4mTZSUvYEDP7HHY3tdgmk85dYUoCVS4mQHpHKlmDJtJYT6Y7voSjT+8DdBjbbsHTEMV
         GbhI1hiFH6jZcxmsUanV8xH/Fh6udfHEaXMAY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=SNmULBs8vg2USPW96dsLoxl8BjY4rz0wqBgTKb+xz1eDvf1wX7HmiFMGGlw4TkAsVy
         dH9DdNtDUavzj/e5BHUglLQo6JWleyjO638LPowLzJ+C18W92G6B2N2tB9VN8I3PSY/U
         MJQmabB2V+YvgCEjZzNq5yDgZbGXapL6sr+hU=
Received: by 10.150.90.20 with SMTP id n20mr7714782ybb.149.1256800947680;
        Thu, 29 Oct 2009 00:22:27 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 14sm823480gxk.10.2009.10.29.00.22.26
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 29 Oct 2009 00:22:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vskd3o11t.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131566>

Junio C Hamano wrote:
> Ben Walton <bwalton@artsci.utoronto.ca> writes:

>> Would it be completely out of line to provide a knob so that the
>> fallback $pager could be set to something more specific/appropriate
>> during the build?
>=20
> I think that is a sensible thing to do.  Something like this?
>=20
>  Makefile |    6 ++++++
>  pager.c  |    6 +++++-
>  2 files changed, 11 insertions(+), 1 deletions(-)

That looks good to me, but it=E2=80=99s missing a corresponding change =
to
git-svn.  I think something like this could be useful for Debian to
avoid patching to comply with the distro policy of falling back to
generic "pager" and "editor" symlinks.  How about the following two
patches?

Jonathan Nieder (1):
  Provide a build time default-editor setting

Junio C Hamano (1):
  Provide a build time default-pager setting

 Makefile                  |   18 ++++++++++++++++++
 editor.c                  |    2 +-
 git-add--interactive.perl |    3 ++-
 git-sh-setup.sh           |    6 ++++--
 git-svn.perl              |    8 +++++---
 pager.c                   |    2 +-
 t/Makefile                |    2 ++
 t/t7005-editor.sh         |   29 ++++++++++++++++++++++-------
 8 files changed, 55 insertions(+), 15 deletions(-)
