From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 0/5] Large file support for git-archive
Date: Mon, 30 Apr 2012 23:07:57 +0200
Message-ID: <4F9EFF2D.8080505@lsrfire.ath.cx>
References: <1335761837-12482-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 30 23:08:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOxpI-0001Kd-IP
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 23:08:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757204Ab2D3VIA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Apr 2012 17:08:00 -0400
Received: from india601.server4you.de ([85.25.151.105]:57782 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756581Ab2D3VH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 17:07:59 -0400
Received: from [192.168.2.105] (p4FFDA315.dip.t-dialin.net [79.253.163.21])
	by india601.server4you.de (Postfix) with ESMTPSA id 670482F805D;
	Mon, 30 Apr 2012 23:07:57 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120420 Thunderbird/12.0
In-Reply-To: <1335761837-12482-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196609>

Am 30.04.2012 06:57, schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy:
> This is a spin-off from the large file support series I posted some
> time ago [1]. Both tar and zip format now support streaming large
> blobs. Although zip will store uncompressed large blobs.
>
> [1] http://thread.gmane.org/gmane.comp.version-control.git/191605
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (5):
>    archive-tar: turn write_tar_entry into blob-writing only
>    archive-tar: unindent write_tar_entry by one level
>    archive: delegate blob reading to backend
>    archive-tar: stream large blobs to tar file
>    archive-zip: stream large blobs into zip file
>
>   Documentation/git-archive.txt |    3 +
>   archive-tar.c                 |  184 ++++++++++++++++++++++++++++--=
-----------
>   archive-zip.c                 |   56 ++++++++++++-
>   archive.c                     |   28 +++----
>   archive.h                     |   10 ++-
>   t/t1050-large.sh              |    8 ++
>   6 files changed, 209 insertions(+), 80 deletions(-)

I like the cleanups in the first two patches.

I'm neutral to positive on the third one; it certainly simplifies the=20
interface to the backends with only little code duplication.

The ZIP format supports streaming natively (look for "Data descriptor"=20
in http://www.pkware.com/documents/casestudies/APPNOTE.TXT).=20
Incidentally, I had been working on supporting that, but without any=20
presentable results.  So far.  I've adapted the pieces I had to your=20
series now; will send shortly.

Ren=C3=A9
