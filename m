From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: [PATCH] format-patch: remove existing output-directory
Date: Fri, 14 Jun 2013 15:16:29 +0200
Message-ID: <20130614131629.GA1086@paksenarrion.iveqy.com>
References: <1371213813-7925-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 14 15:13:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnTok-0000VH-TO
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 15:13:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752532Ab3FNNNX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Jun 2013 09:13:23 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:45680 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752163Ab3FNNNW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 09:13:22 -0400
Received: by mail-la0-f52.google.com with SMTP id fo12so520537lab.11
        for <git@vger.kernel.org>; Fri, 14 Jun 2013 06:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=MJPNIN0LFUEbqYo6dewWEbmaiW4SCJ6BmjwMFw7IBBo=;
        b=Cas3qGw9/4PMTgsRDnKFZOYg/WOWz5mmq9HjVk8CxQt9sqAW9LdnfeDr2eKI615Jok
         FC95pX+3I2Ezq9pAIGAnk/gCnYxtdLXaLYHs280KqR6BR+LNR6tx42TvsYlt6a3j0ojm
         alsuTkM9q1N+MwU5ob+CjOGaluboDJYBtzxUj9pykabK3YrbnGLef9pdyQSpEStmaIYq
         CDZhtFtpbSZRSP2UBTii8TH/Fg2LHZs3bQ3dM9/xQrE5Uu/BAd67pUnmgNn/SZHby7yR
         FJjrpky9pLnKb9b/1xdgo4ET9+Uk14U8TUnIxRJJ1l/Qwew6lpjDp8vmkdlkxUgfUD4G
         QH7Q==
X-Received: by 10.152.29.41 with SMTP id g9mr1162241lah.44.1371215600430;
        Fri, 14 Jun 2013 06:13:20 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id m14sm623916lbl.1.2013.06.14.06.13.19
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 14 Jun 2013 06:13:19 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1UnTrh-0000Id-3Z; Fri, 14 Jun 2013 15:16:29 +0200
Content-Disposition: inline
In-Reply-To: <1371213813-7925-1-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227824>

Hi,
just some questions about your patch.

On Fri, Jun 14, 2013 at 06:13:33PM +0530, Ramkumar Ramachandra wrote:
> The following command
>=20
>   $ git format-patch -o outgoing master
>=20
> does not ensure that the output-directory outgoing doesn't already
> exist.  As a result, it's possible for patches from two different ser=
ies
> to get mixed up if the user is not careful.  Fix the problem by
> unconditionally removing the output-directory before writing to it.

I'm not entirely happy about removing untracked stuff without asking
the user. What if the output directory isn't empty? What if a user just
want them in ~?

However I think this patch can improve the workflow for experienced
developers. Can we tweak this in some way to get the best out of both
worlds?

> +		struct strbuf buf =3D STRBUF_INIT;
> +
>  		if (use_stdout)
>  			die(_("standard output, or directory, which one?"));
> +		strbuf_addstr(&buf, output_directory);
> +		remove_dir_recursively(&buf, 0);

Should we have a strbuf_release here?

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
