From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv4 1/6] environment: static list of repo-local env vars
Date: Wed, 24 Feb 2010 20:20:14 +0100
Message-ID: <cb7bb73a1002241120i4bbbce0bl50460c76db0c6529@mail.gmail.com>
References: <1266996196-25978-1-git-send-email-giuseppe.bilotta@gmail.com> 
	<1266996196-25978-2-git-send-email-giuseppe.bilotta@gmail.com> 
	<7vhbp64odi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Heiko Voigt <hvoigt@hvoigt.net>,
	msysGit Mailinglist <msysgit@googlegroups.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 20:20:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkMmp-0005Yf-1G
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 20:20:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757637Ab0BXTUh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Feb 2010 14:20:37 -0500
Received: from mail-ew0-f212.google.com ([209.85.219.212]:59357 "EHLO
	mail-ew0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757610Ab0BXTUg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Feb 2010 14:20:36 -0500
Received: by ewy4 with SMTP id 4so1212134ewy.28
        for <git@vger.kernel.org>; Wed, 24 Feb 2010 11:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=lxpauZi3tHIMLlj1n0/nIcEiL73czQE3suHIux5s/tE=;
        b=OA7jYRt4wjP1NGBSwoZQu27Swi6Ey/t/Po4Y8df89QKe9BvKJQl7Nhs2k11ZPN/mwt
         vticMt7wQN8Dx23VFvrPCv3JdZ9RVYwRve93fJ44VT4gGh0M5M/nkaUoEn+PPyF7gQer
         q6+U7g1KNI2kbk0ddt0hQUuLdRcBgekkSCB78=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ZD74jb18cwxAPy30jMkRkfIZa2wWqRIzv1Yrc3iWj7PsXQUSLnrj4FopvV85/7iM4b
         BqCxS0wAYQBYpPr1B4yyFnE+UR8+P1aM/qhiBKmWdVg8y6dKVU2sijZzEA3LVD0RY/2J
         pmWIXF++Avfyuh8Nx/SDNv0aGjo5Um6h1Tufg=
Received: by 10.213.100.160 with SMTP id y32mr631120ebn.49.1267039234205; Wed, 
	24 Feb 2010 11:20:34 -0800 (PST)
In-Reply-To: <7vhbp64odi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140973>

On Wed, Feb 24, 2010 at 4:58 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>
>> +/* Repository-local GIT_* environment variables */
>> +const char *const local_repo_env[] =3D {
>> + =A0 =A0 ALTERNATE_DB_ENVIRONMENT,
>> + =A0 =A0 CONFIG_ENVIRONMENT,
>> + =A0 =A0 DB_ENVIRONMENT,
>> + =A0 =A0 GIT_DIR_ENVIRONMENT,
>> + =A0 =A0 GIT_WORK_TREE_ENVIRONMENT,
>> + =A0 =A0 GRAFT_ENVIRONMENT,
>> + =A0 =A0 INDEX_ENVIRONMENT,
>> + =A0 =A0 NO_REPLACE_OBJECTS_ENVIRONMENT,
>> + =A0 =A0 NULL
>> +};
>> +
>> +const unsigned int local_repo_env_size =3D ARRAY_SIZE(local_repo_en=
v);
>
> This does not look very useful for two reasons.
>
> =A0- It counts the NULL at the tail, so the number is one-off; you ca=
nnot
> =A0 say
>
> =A0 =A0 =A0 =A0for (i =3D 0; i < local_repo_env_size; i++)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0do_something_to(local_repo_env[i]);

This is obviously very easy to fix by decrementing the size by 1 in
the definition.

> =A0- local_repo_env_size is not a compile time constant, so you canno=
t do:
>
> =A0 =A0 =A0 =A0const char *env[local_repo_env_size + 20];
> =A0 =A0 =A0 =A0memcpy(env, local_repo_env, sizeof(env[0]) * local_rep=
o_env_size);
> =A0 =A0 =A0 =A0for (i =3D local_repo_env_size; i < ARRAY_SIZE(env); i=
++)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0add_more_to(env + i, ...);

Indeed, I was just discussing this on the other thread. I personally
have no objection to using this C99 feature.

I guess #defining local_repo_env_size in cache.h, and keeping it
up-to-date when local_repo_env is updated is the best alternative.
This can be done in such a way that if it the array needs expansion,
forgetting to update its size is catched at compile time, but not for
contraction. Of course we don't expect that it will contract. The
disadvantage of this is that a change in cache.h requires an almost
complete recompile because almost everything depends on it. It's a
minor disadvantage, when compared to other approaches (double-walking
the list or other stuff).

(Of course, I still wonder what's wrong with C99 VLAs, but anyway).

--=20
Giuseppe "Oblomov" Bilotta
