From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 2/3] branch: give a more helpful message on redundant
 arguments
Date: Sun, 27 Jan 2013 03:58:31 -0800
Message-ID: <20130127115831.GE4228@elie.Belkin>
References: <1359102416-1240-1-git-send-email-pclouds@gmail.com>
 <1359118225-14356-1-git-send-email-pclouds@gmail.com>
 <1359118225-14356-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 27 12:59:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzQtY-0005qY-Hd
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 12:59:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756638Ab3A0L6i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Jan 2013 06:58:38 -0500
Received: from mail-pb0-f51.google.com ([209.85.160.51]:56947 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756598Ab3A0L6g convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Jan 2013 06:58:36 -0500
Received: by mail-pb0-f51.google.com with SMTP id ro12so963883pbb.38
        for <git@vger.kernel.org>; Sun, 27 Jan 2013 03:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=TMJrK2s5t3NiHPrYkRjNcelAkWILcQME4CIDPbKD6nY=;
        b=XUlm9fbayiLgoWw9D70fnUP6+xZ/kULiiT7qBwwZZaycgPz4MSRwhNirCuvt09c7pv
         RCF542pGX7zW0I39C+fShUiqCTtn0QHfsrfTVPvnyyP5Qj8ZwHriLorcWt4kgEUtFJEB
         e8mL72b/4kf9mB51MCSf06WuxER7UIlxXCVr7OHpLAWkKOrHGABAHp/kRvrj29sX7TG1
         QXyZu3nXPUfNJZUCTiTjmoL9p9cGqFP404JGCyeBczHoqUgaabMuHFBJeSuUrvonMkvS
         ICbAzU1Zhy+L9kvPW8g5vkIbdju2m3UOCwrJ8qpPi7yno6eDEJ/YkglaWRNAsvod+q1k
         fsQA==
X-Received: by 10.68.233.99 with SMTP id tv3mr29051775pbc.64.1359287916297;
        Sun, 27 Jan 2013 03:58:36 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id sy1sm4266270pbc.66.2013.01.27.03.58.34
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 27 Jan 2013 03:58:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1359118225-14356-2-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214692>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -852,14 +852,14 @@ int cmd_branch(int argc, const char **argv, con=
st char *prefix)
>  		const char *branch_name;
>  		struct strbuf branch_ref =3D STRBUF_INIT;
> =20
> -		if (detached)
> -			die("Cannot give description to detached HEAD");
> -		if (!argc)
> +		if (!argc) {
> +			if (detached)
> +				die("Cannot give description to detached HEAD");

Good catch.  Shouldn't this bugfix be a separate patch, so it can also
be included in maint?
