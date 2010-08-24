From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 1/3] clone: warn users --depth is ignored in local
 clones
Date: Tue, 24 Aug 2010 00:28:46 -0500
Message-ID: <20100824052846.GE20037@burratino>
References: <1282565304-3122-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 24 07:30:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Onm5l-00069T-70
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 07:30:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752138Ab0HXFa3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 01:30:29 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:42424 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751357Ab0HXFa1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Aug 2010 01:30:27 -0400
Received: by gyd8 with SMTP id 8so2419760gyd.19
        for <git@vger.kernel.org>; Mon, 23 Aug 2010 22:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=jvlV1If3M1uQ6y+8SMJ9Bjdokk5IiySCZDJmazoOUFw=;
        b=VK4y2jE4oQOhkhuGdU2RXmHsdXgWElkRJ8eCKUSwyXA18XDScnwJNl0+mKIz02Kn7w
         U73KXBMyzbN9k4cC1iRyhkZ2xPUyNhTmtbcChviQKv9VF5iD/AESn9E4xW2rbn2cqpDG
         f5fzxFMWoRPNTbuwNG4ontDvAne/egWbfGe9w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=uw4v4Qh3EuNuj8E3f8xqmMMO/jP4MxKVHwW1JJA+nztiBdJFP3XUOUThtmFTOmlvhS
         a04WT7gznKF/lPkBWFkD55ylO8eJYzIWsCZMWnFf3zDjmXwTp8o/JEuJTQETrLCmMBQJ
         0xoaO3HsM3VtjR71Cq+OSiTUHK9sJms/IBv2Y=
Received: by 10.100.169.2 with SMTP id r2mr6530844ane.268.1282627826995;
        Mon, 23 Aug 2010 22:30:26 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id 14sm12205417ant.1.2010.08.23.22.30.25
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 23 Aug 2010 22:30:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1282565304-3122-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154292>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> +++ b/builtin/clone.c
> @@ -361,7 +361,7 @@ static void write_remote_refs(const struct ref *l=
ocal_refs)
> =20
>  int cmd_clone(int argc, const char **argv, const char *prefix)
>  {
> -	int is_bundle =3D 0;
> +	int is_bundle =3D 0, is_local;
>  	struct stat buf;
>  	const char *repo_name, *repo, *work_tree, *git_dir;
>  	char *path, *dir;
> @@ -414,6 +414,9 @@ int cmd_clone(int argc, const char **argv, const =
char *prefix)
>  		repo =3D xstrdup(make_absolute_path(repo_name));
>  	else
>  		repo =3D repo_name;
> +	is_local =3D path && !is_bundle;
> +	if (is_local && option_depth)
> +		warning("--depth is ignored in local clones, use file:// instead."=
);

Micronit: this comma should be a semicolon or period.

As for the patch itself: I like it.  I could have used this advice
about a year ago.
