From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: Parse --o in format-patch
Date: Fri, 28 Jun 2013 18:44:40 +0200
Message-ID: <20130628164440.GA21354@paksenarrion.iveqy.com>
References: <20130628160459.GA16832@paksenarrion.iveqy.com>
 <20130628163153.GA9127@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 28 18:45:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsbnM-0006sm-MD
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 18:45:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543Ab3F1QpG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Jun 2013 12:45:06 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:64203 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754226Ab3F1QpF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jun 2013 12:45:05 -0400
Received: by mail-la0-f48.google.com with SMTP id lx15so2388836lab.35
        for <git@vger.kernel.org>; Fri, 28 Jun 2013 09:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=6qZOWmY8hCD0G5v9HTeHQ2Cs4sMquL8z5n5kFhA2Czw=;
        b=n2Uv6Q9sqx8SIfOhGUm+fuqAmBXVwO43xQVx3rNea7MPZSriRdnlVipj6ZHguOw45X
         c1Q+V5vxlZdTSGAdPqSdgQ5p1cwbzUB/lsB2xjO23ossCD9U1Z1byHeTU6vgQ1SwbdHr
         XvywlX0G5zvahaUl7MOlZTqF6Du3N1ecJ9/+RXEASlWWnmloFSDudjooG/wO87MZezZF
         6JWboUrGVcRUr+6Bm0I60qyq7qahN8BTK/a59XgOy0sAHPPTM5qxPJQ01sL2rdcuSlih
         7N/xJS8NzxdY+x4ltRbgvfIezYim+RVNpBJdJdK29Sdrhp7CN2NIn7sreqDo+SMAeba4
         Jyxg==
X-Received: by 10.152.87.15 with SMTP id t15mr6571809laz.85.1372437903671;
        Fri, 28 Jun 2013 09:45:03 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id b8sm2889615lah.0.2013.06.28.09.45.02
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 28 Jun 2013 09:45:03 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1Usbmq-0005l3-QY; Fri, 28 Jun 2013 18:44:40 +0200
Content-Disposition: inline
In-Reply-To: <20130628163153.GA9127@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229212>

On Fri, Jun 28, 2013 at 12:31:53PM -0400, Jeff King wrote:
> It's possible to have an "optional" argument by using the
> PARSE_OPT_OPTARG flag. However, it is not backwards compatible from t=
he
> user's perspective, as they must use the "sticked" form:
>=20
>   git format-patch -ooutdir ...
>=20
> to specify the argument. Otherwise, it is not clear in:
>=20
>   git format-patch -o outdir HEAD~
>=20
> whether "outdir" is the argument to "-o", or if it is simply the next
> argument.

That would be a possibility but I don't like breaking backwards
compability.

> I'm not clear how that interacts with your example, though. Your exam=
ple
> tries to use "-o" to set output_directory to NULL. But it is already
> NULL if you do not specify any "-o" at all.

my goal is to make:
       git format-patch [-k] [(-o|--output-directory) <dir> | --stdout]=
 [ <since> | <revision range> ]
to be:
       git format-patch [-k] [(-o|--output-directory) [dir] | --stdout]=
 [ <since> | <revision range> ]

that would do:
git format patch -> current dir
git format patch -o -> default dir (for example GIT_DIR/.outgoing/)
git format patch -o <dir> -> user defined <dir>

But I guess I would need a new option instead. Something like
--default-output-dir.

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
