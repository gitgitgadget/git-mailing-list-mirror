From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCHv2 1/2] parse-options: add PARSE_OPT_LITERAL_ARGHELP for
 complicated argh's
Date: Thu, 21 May 2009 14:27:25 -0700
Message-ID: <4A15C73D.3010301@gmail.com>
References: <1242557224-8411-1-git-send-email-bebarino@gmail.com>	 <fbaa26d941f496efefc30e298f5534f8194ee716.1242891030.git.bebarino@gmail.com>	 <7v3aaybewo.fsf@alter.siamese.dyndns.org>	 <4A1586A7.9000909@lsrfire.ath.cx> <780e0a6b0905211203g3223fe3fp5eed27ebf244394a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu May 21 23:32:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7Fnd-0002nI-48
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 23:27:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752749AbZEUV1c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 May 2009 17:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753951AbZEUV1b
	(ORCPT <rfc822;git-outgoing>); Thu, 21 May 2009 17:27:31 -0400
Received: from rv-out-0506.google.com ([209.85.198.237]:9422 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753847AbZEUV1a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2009 17:27:30 -0400
Received: by rv-out-0506.google.com with SMTP id f9so447398rvb.1
        for <git@vger.kernel.org>; Thu, 21 May 2009 14:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=oO1pkxhg9VE99E9hWRXW0cphMkFq0WW71Farx4kQmhQ=;
        b=B7ST9fC0jVvNT96MhwS/pvKJ6ulRnRVv+WrE5ewCx3JUlRbzRYogj4JqE4pBcWEo/e
         u/xuBO4eT4BYk+yrCEMjDtbgdy/mSIMcY1VfzgAZMSdfVe8DiNOMh82YwfA2x/f6Ivdn
         hi5o8xs0PXc/3qMlzSXCjtQtUker42X/pLVLM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=XBu5/9Iwr79COCFyiDDbZjrmB+UXtvxd6wDUFRwgrVRmMr7mZqzl0nXdBQYPClwPcf
         or3uV3v9Aczs8BAPt5lOWDxjU3lkEZkeklVbnFn+3ELpKzAYtuSQbZMrEVbMATEeLbEJ
         vM1SOB7xLkSE9k3HZrpCZdfBSgqwtHs38pkbY=
Received: by 10.141.48.6 with SMTP id a6mr1423072rvk.36.1242941250230;
        Thu, 21 May 2009 14:27:30 -0700 (PDT)
Received: from ?192.168.1.2? ([76.89.212.195])
        by mx.google.com with ESMTPS id k41sm8247386rvb.7.2009.05.21.14.27.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 May 2009 14:27:28 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090429)
In-Reply-To: <780e0a6b0905211203g3223fe3fp5eed27ebf244394a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119707>

Stephen Boyd wrote:
> On Thu, May 21, 2009 at 9:51 AM, Ren=C3=A9 Scharfe
> <rene.scharfe@lsrfire.ath.cx> wrote:
>> Junio C Hamano schrieb:
>>> Hmmm, why does this break t0040 (I am queuing this on top of 5acb3e=
5)?
>> Probably because it changes this:
>>
>> =C2  =C2  =C2  =C2 pos +=3D fprintf(...);
>>
>> into this (simplified, usage_argh() expanded):
>>
>> =C2  =C2  =C2  =C2 pos +=3D pos + fprintf(...);
>>
>> usage_argh() doesn't need the parameter pos.
>>
>> Ren=C3=A9
>>
>
> Woops. I thought I ran the tests but I guess I didn't. This is the
> correct fix, thanks.

And here's the patch you can squash in.

diff --git a/parse-options.c b/parse-options.c
index 2b880b1..e8955be 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -361,7 +361,7 @@ int parse_options(int argc, const char **argv, cons=
t struct option *options,
        return parse_options_end(&ctx);
 }

-static int usage_argh(const struct option *opts, int pos)
+static int usage_argh(const struct option *opts)
 {
        const char *s;
        int literal =3D opts->flags & PARSE_OPT_LITERAL_ARGHELP;
@@ -372,7 +372,7 @@ static int usage_argh(const struct option *opts, in=
t pos)
                        s =3D literal ? "[%s]" : "[<%s>]";
        else
                s =3D literal ? " %s" : " <%s>";
-       return pos + fprintf(stderr, s, opts->argh);
+       return fprintf(stderr, s, opts->argh);
 }

 #define USAGE_OPTS_WIDTH 24
@@ -436,7 +436,7 @@ int usage_with_options_internal(const char * const =
*usagestr,
                        /* FALLTHROUGH */
                case OPTION_STRING:
                        if (opts->argh)
-                               pos +=3D usage_argh(opts, pos);
+                               pos +=3D usage_argh(opts);
                        else {
                                if (opts->flags & PARSE_OPT_OPTARG)
                                        if (opts->long_name)
