From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 1/5] archive-tar: turn write_tar_entry into blob-writing
 only
Date: Tue, 01 May 2012 00:11:45 +0200
Message-ID: <4F9F0E21.3080407@lsrfire.ath.cx>
References: <1335761837-12482-1-git-send-email-pclouds@gmail.com> <1335761837-12482-2-git-send-email-pclouds@gmail.com> <7vr4v5f5n2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 01 00:11:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOyoy-00068z-Fo
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 00:11:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756871Ab2D3WLs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Apr 2012 18:11:48 -0400
Received: from india601.server4you.de ([85.25.151.105]:57790 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755329Ab2D3WLr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 18:11:47 -0400
Received: from [192.168.2.105] (p4FFDA315.dip.t-dialin.net [79.253.163.21])
	by india601.server4you.de (Postfix) with ESMTPSA id 584972F805D;
	Tue,  1 May 2012 00:11:45 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120420 Thunderbird/12.0
In-Reply-To: <7vr4v5f5n2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196615>

Am 30.04.2012 20:15, schrieb Junio C Hamano:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy<pclouds@gmail.com>  writes:
>
>> Before this patch write_tar_entry() can:
>>
>>   - write global header
>>     by write_global_extended_header() calling write_tar_entry with
>>     with both sha1 and path =3D=3D NULL
>>
>>   - write extended header for symlinks, by write_tar_entry() calling
>>     itself with sha1 !=3D NULL and path =3D=3D NULL
>>
>>   - write a normal blob. In this case both sha1 and path are valid.
>>
>> After this patch, the first two call sites are modified to write the
>> header without calling write_tar_entry(). The function is now for
>> writing blobs only.
>
> Nice.
>
> I am kind of surprised how hacky the original code that switched on !=
sha1
> and !path was, especially given that it came from Ren=C3=A9 at ae64bb=
c
> (tar-tree: Introduce write_entry(), 2006-03-25) --- it even claims th=
at
> these are "reasonable" magic values ;-).

Yeah, and there are still opportunities for cleanup.  Can't say what I=20
was thinking back then, but a few cleanup attempts since then invariabl=
y=20
made the code even more ugly, so I never sent them.

Ren=C3=A9
