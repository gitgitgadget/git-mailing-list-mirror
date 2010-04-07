From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH] Replace hard-coded path with one from <paths.h>
Date: Wed, 7 Apr 2010 12:57:37 +0200
Message-ID: <n2u40aa078e1004070357m143cfaccvdc754a3bc5fe1ae1@mail.gmail.com>
References: <186fa4afcc08ad6ba10906a231c437536fbdb8e9.1270412075.git.chris@arachsys.com>
	 <7vk4sm7vao.fsf@alter.siamese.dyndns.org>
	 <20100404222801.GB31315@arachsys.com>
	 <20100406163525.GF15306@arachsys.com>
	 <20100406163643.GG15306@arachsys.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Chris Webb <chris@arachsys.com>
X-From: git-owner@vger.kernel.org Wed Apr 07 12:57:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzSxD-00023j-Hn
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 12:57:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119Ab0DGK5k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Apr 2010 06:57:40 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:32785 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751424Ab0DGK5j convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Apr 2010 06:57:39 -0400
Received: by bwz1 with SMTP id 1so686497bwz.21
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 03:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=X3zkFnbM6JA5Ap8iyWolOUWyyarGhbhw/ZqTqpikFyg=;
        b=MDafKsDVJLILVdo8/+XjYP9EpXIGngz/33Zc4g0sRdVklCMKCEhxWrHLFuLr0yAIGB
         8QefzdqiY9Xye0mFnTy23/es8zUx4306itEoXphQYMu5DwFBiD5vJORLU5U519+Qe7W/
         1kZnN9smgw9VEtZcUT20/IXvtjsiTXdnkwVik=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=ekyHfunRbDlBswSn5UjQFEHZtYv7jWjcjG+esPXmeBWPgYEUqmpUH1HL2xWahUKCMY
         nc9wh0NtK2ttbw29ttk7NJ/TZ3RPFXVNTY6T785dbm+CTvz+QEV/MaOYNcX54awRcq1T
         x0aTMmvMxApneo5xPUbuyCo/OvSmBDrPyHTUU=
Received: by 10.204.72.202 with HTTP; Wed, 7 Apr 2010 03:57:37 -0700 (PDT)
In-Reply-To: <20100406163643.GG15306@arachsys.com>
Received: by 10.204.2.210 with SMTP id 18mr954523bkk.15.1270637857166; Wed, 07 
	Apr 2010 03:57:37 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144212>

On Tue, Apr 6, 2010 at 6:36 PM, Chris Webb <chris@arachsys.com> wrote:
> In exec_cmd.c, git hard-codes a default path of /usr/local/bin:/usr/b=
in:/bin.
> Get an appropriate value for the system from <paths.h> if possible in=
stead.
>
> Signed-off-by: Chris Webb <chris@arachsys.com>
> ---
> =A0exec_cmd.c =A0 =A0 =A0 =A0| =A0 =A02 +-
> =A0git-compat-util.h | =A0 =A05 +++++
> =A02 files changed, 6 insertions(+), 1 deletions(-)
>
> diff --git a/exec_cmd.c b/exec_cmd.c
> index b2c07c7..bf22570 100644
> --- a/exec_cmd.c
> +++ b/exec_cmd.c
> @@ -107,7 +107,7 @@ void setup_path(void)
> =A0 =A0 =A0 =A0if (old_path)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0strbuf_addstr(&new_path, old_path);
> =A0 =A0 =A0 =A0else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 strbuf_addstr(&new_path, "/usr/local/bi=
n:/usr/bin:/bin");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 strbuf_addstr(&new_path, _PATH_DEFPATH)=
;
>
> =A0 =A0 =A0 =A0setenv("PATH", new_path.buf, 1);
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 7e62b55..7592be7 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -92,6 +92,7 @@
> =A0#include <assert.h>
> =A0#include <regex.h>
> =A0#include <utime.h>
> +#include <paths.h>

This breaks on Windows due to missing paths.h. I guess you need some
guard to detect if the header is present or not.

--=20
Erik "kusma" Faye-Lund
