From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 2/5] index-helper: new daemon for caching index and
 related stuff
Date: Tue, 10 Jun 2014 14:44:19 -0400
Organization: Twitter
Message-ID: <1402425859.18134.207.camel@stross>
References: <1402406665-27988-1-git-send-email-pclouds@gmail.com>
	 <1402406665-27988-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 20:44:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuR22-0001zp-B2
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 20:44:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751835AbaFJSoW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jun 2014 14:44:22 -0400
Received: from mail-qa0-f45.google.com ([209.85.216.45]:40282 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbaFJSoW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 14:44:22 -0400
Received: by mail-qa0-f45.google.com with SMTP id hw13so9672306qab.18
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 11:44:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=3qVLfD+xKRrbamRWDEgZwhTRZ4EMz5tOrtwPfcdaxbg=;
        b=BRbFn4GQacY47SlNpd/3c0wFbu1eud3vN5jcHdR4u9jSYLdHg7hCmJeNIdd1PPpHQO
         U84ilcvAlBQdgOKZho99tQilaH5u1Kn1wWrLjwQmrtVs8U7u/kudDqoJmjTK9uJq9/kR
         lvp5sj4XLgVIgVkt7dS3wr0FPA+rnX9CxBPMGJWGD/pToYGREz6rDcTW8nq26XiqTZhQ
         NyOLw6JFgYLbbCJR+v0CL5CJnkYncQtQAOAc7B7VwaX+AHjbxFrxw/0Jd58zIJPCHROs
         gia6BKKHV37SDDaswQ7cahggTn7ft+LsQNRxqCv5yR3MNQrIfnbvdhxEOxZWm+YyX5Ns
         o1Sw==
X-Gm-Message-State: ALoCoQmhKuJUUudMYKdEsG1GybEmMGR2cbsq0O9Lh0fmR2LbfRWtmsGzYEUZsGR/32D463UOlZIq
X-Received: by 10.224.72.13 with SMTP id k13mr19513788qaj.54.1402425860967;
        Tue, 10 Jun 2014 11:44:20 -0700 (PDT)
Received: from [172.17.3.188] ([38.104.173.198])
        by mx.google.com with ESMTPSA id j4sm10580737qaf.31.2014.06.10.11.44.19
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Tue, 10 Jun 2014 11:44:20 -0700 (PDT)
In-Reply-To: <1402406665-27988-3-git-send-email-pclouds@gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251211>

On Tue, 2014-06-10 at 20:24 +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy wrote:

> +	loop(sb.buf, 600);
=2E..
> +	if (st->st_mtime + 600 < time(NULL))

s/600/INDEX_HELPER_TIMEOUT/ or something.

> +		return;	  /* don't try to read from stale .pid file */
> +
> +	fd =3D open(git_path("read-cache--daemon.pid"), O_RDONLY);

should be index-helper.pid (actually, there are a few other instances o=
f
this as well); maybe make it a constant.
