From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH v5 01/28] path.c: make get_pathname() return strbuf instead
 of static buffer
Date: Sat, 08 Mar 2014 07:11:07 +0100
Message-ID: <531AB47B.7070506@web.de>
References: <1393675983-3232-1-git-send-email-pclouds@gmail.com> <1394246900-31535-1-git-send-email-pclouds@gmail.com> <1394246900-31535-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 08 07:11:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMAUE-0004vI-6k
	for gcvg-git-2@plane.gmane.org; Sat, 08 Mar 2014 07:11:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbaCHGLY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Mar 2014 01:11:24 -0500
Received: from mout.web.de ([212.227.15.4]:54652 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751103AbaCHGLX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2014 01:11:23 -0500
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MZUWH-1Wd14f1wIH-00LHVm; Sat, 08 Mar 2014 07:11:12
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <1394246900-31535-2-git-send-email-pclouds@gmail.com>
X-Provags-ID: V03:K0:PKyZ/Vj4XNlGrzBx/4kZOZPMNoQAslyt0IukyVA8ONw2wMPKEzy
 4eOyMI6t2b8NBbf5uywhBSleS+Tb0v/NNBYM4EcwFNJ1TXtBMvoKH5WADJ1iJojZVoKb+qI
 ORvnnp5mbCUeYifnlxdbhArIHPFsYsRSn8ZraBbH9jWMY0RFMssIWzDKk7sjNeLhCYFGL+x
 nZ/0swoWT+0XewGzwQ8ew==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243671>

On 2014-03-08 03.47, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> We've been avoiding PATH_MAX whenever possible. This patch makes
> get_pathname() return a strbuf and updates the callers to take
> advantage of this. The code is simplified as we no longer need to
> worry about buffer overflow.
>=20
> vsnpath() behavior is changed slightly: previously it always clears
Minor question:
Is the function name vsnpath() appropriate any more ?
How about renaming the function into strbuf_vaddpath() ?

> the buffer before writing, now it just appends. Fortunately this is a
> static function and all of its callers prepare the buffer properly:
> git_path() gets the buffer from get_pathname() which resets the
> buffer, the remaining call sites start with STRBUF_INIT'd buffer.
>=20
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
