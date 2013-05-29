From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: 1.8.3 - gitignore not being parsed correctly on OS X; regex
 support is broken?
Date: Wed, 29 May 2013 11:19:43 +0700
Message-ID: <CACsJy8DD=LxAKh_fUELJ5Mj0xS_gZE88N_rJFkKGer=YAOqsMg@mail.gmail.com>
References: <CAGLuM14_MQffwQWrB2YCQXzhkGaxdaYBuY74y7=pfb-hB6LskA@mail.gmail.com>
 <CACsJy8BqCUKhc8vhjhNz0OedBngk7zcSOk70ekRm3EiruHfNxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Misty De Meo <misty@brew.sh>,
	=?UTF-8?Q?=C3=98ystein_Walle?= <oystwa@gmail.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 06:20:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhXs5-0003fv-BA
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 06:20:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752563Ab3E2EUO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 May 2013 00:20:14 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:50625 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258Ab3E2EUN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 May 2013 00:20:13 -0400
Received: by mail-oa0-f48.google.com with SMTP id i4so10993631oah.35
        for <git@vger.kernel.org>; Tue, 28 May 2013 21:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=tfbsjpGDtut3wuuLmtFQ852psf7h1yIlY2GHn0aV0Ts=;
        b=C+GlxiS2pfxqYfDo/110KyyAevjBec6x8peRtoUqaJa8AxOkjsPfmWf4m63UY4Qj/F
         MEe1gWu7ZyZWG+M8pIvUb/jj5Rr15ptkfslzqqly/IbtlOcK7HU7xGPgC2Y6z1VJBCqx
         s3EuXgLzAJvp6iPxQ4WFKKX/LkOFZZ1wbkd7NmCck7/YynqsAhF0GAKsmdJ3QGBC38Vi
         2tB+aJnTYGxzU/4JFjdEW0+TyBxgASmBovOfo3NsA1O6fviWozjpnOl4ScD+6o0AiKqD
         M2rolQUAwLV/a8mMEX5cNdmDZBkCRbVhL1BqvtG9LDIAzUaLbkzlkP3tAunWtQTxPone
         +h0Q==
X-Received: by 10.60.134.236 with SMTP id pn12mr602306oeb.4.1369801213330;
 Tue, 28 May 2013 21:20:13 -0700 (PDT)
Received: by 10.76.171.199 with HTTP; Tue, 28 May 2013 21:19:43 -0700 (PDT)
In-Reply-To: <CACsJy8BqCUKhc8vhjhNz0OedBngk7zcSOk70ekRm3EiruHfNxA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225732>

On Wed, May 29, 2013 at 10:41 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> The changes in this area since 1.8.2.3 seem to be Karsten's (I'm not
> blaming, just wanted to narrow down the problem). The patterns of
> interest seem to be
>
> !/bin
> /bin/*
> !/bin/brew
>
> Without "!/bin" v1.8.3 seems to behave the same as v1.8.2.3.

Karsten, the block "/* Abort if the directory is excluded */" in
prep_exclude() seems to cause this. I think it goes through the
exclude patterns, hits "!/bin", believes the patterns do not make
sense in this context and throws all away. I think =C3=98ystein's case
falls into the same path. Commenting out the block seems to gain the
old behavior back (and probably breaks other stuff). Contrary to what
Junio said, I'm clueless about this. I wanted to read your series
through and eventually gave up. I think I now have the motivation to
look at it again this weekend.
--
Duy
