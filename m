From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH/RFC v3 2/8] Makefile & configure: add a NO_FNMATCH_CASEFOLD flag
Date: Sun, 3 Oct 2010 19:58:59 +0200
Message-ID: <201010031958.59482.j6t@kdbg.org>
References: <4CA847D5.4000903@workspacewhiz.com> <1286099806-25774-3-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Brandon Casey <drafnel@gmail.com>
To: =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 03 19:59:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2SqI-0003Vd-FR
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 19:59:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754368Ab0JCR7F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Oct 2010 13:59:05 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:20673 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754353Ab0JCR7C (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 13:59:02 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 0D2CD10014;
	Sun,  3 Oct 2010 19:59:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id B6B3619F609;
	Sun,  3 Oct 2010 19:58:59 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <1286099806-25774-3-git-send-email-avarab@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157887>

On Sonntag, 3. Oktober 2010, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wro=
te:
> @@ -1350,6 +1354,11 @@ ifdef NO_FNMATCH
>  	COMPAT_CFLAGS +=3D -DNO_FNMATCH
>  	COMPAT_OBJS +=3D compat/fnmatch/fnmatch.o
>  endif
> +ifdef NO_FNMATCH_CASEFOLD
> +	COMPAT_CFLAGS +=3D -Icompat/fnmatch
> +	COMPAT_CFLAGS +=3D -DNO_FNMATCH_CASEFOLD
> +	COMPAT_OBJS +=3D compat/fnmatch/fnmatch.o
> +endif

I think you should protect against defining both NO_FNMATCH and=20
NO_FNMATCH_CASEFOLD (your version would link compat/fnmatch/fnmatch.o t=
wice=20
in this case):

ifdef NO_FNMATCH
=2E..
else
ifdef NO_FNMATCH_CASEFOLD
=2E..
endif
endif

Otherwise, the patch looks fine.

-- Hannes
