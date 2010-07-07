From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 02/13] Add skeleton SVN client and Makefile
Date: Wed, 7 Jul 2010 14:30:17 -0500
Message-ID: <20100707193017.GA2911@burratino>
References: <1278461693-3828-1-git-send-email-artagnon@gmail.com>
 <1278461693-3828-3-git-send-email-artagnon@gmail.com>
 <20100707162516.GA1529@burratino>
 <20100707170926.GC18806@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Bert Huijben <rhuijben@collab.net>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>, dev@subversion.apache.org,
	Stefan Sperling <stsp@elego.de>,
	Julian Foad <julian.foad@wandisco.com>,
	Will Palmer <wmpalmer@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 07 21:31:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWaKu-0001hd-Uf
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 21:31:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754579Ab0GGTbE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Jul 2010 15:31:04 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:55072 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756606Ab0GGTbB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 15:31:01 -0400
Received: by eya25 with SMTP id 25so485eya.19
        for <git@vger.kernel.org>; Wed, 07 Jul 2010 12:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=EcDY5Ui+u8cvcdJwpBaA2rxMSN8uMtB/mKMTebdwYws=;
        b=aOZlnQji51nelHebd2S+PwHcCmVu2fYmYKrf/zmW69tRGb7Xff3hRIYBsf/heOi5Mx
         qNpCSdFWL299TcJU1C9fO9bxLstAtsn4NkPuSh+Rm93i02FYL2pN4Q0fOkFZA1QGtQhr
         InE8cmicwgsT6CnY72lnrd1iIsAuOhsjmij6E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=sankoCl/88faIvLaPRL870O4oSeHrkn/dzc7MsTgxH4JaE5SUOKgKVi6YZStRsaeSG
         33yLlduHokoOS94KsFOU6skwwCFC3m313yaPHCE4LoR6c0aaGer/C2wDIMCMdUI0DJFs
         bpUYfR7AL65QHmHbdYAiMn06m3gfN4UaYfzDU=
Received: by 10.213.8.134 with SMTP id h6mr5985949ebh.95.1278531059557;
        Wed, 07 Jul 2010 12:30:59 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id n20sm21074753ibe.5.2010.07.07.12.30.58
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 07 Jul 2010 12:30:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100707170926.GC18806@debian>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150495>

Ramkumar Ramachandra wrote:

> Here's a diff of the modifications I made after your review:

That=E2=80=99s quite helpful.

> +++ b/svndumpr.c
> @@ -76,31 +76,19 @@ static svn_error_t *replay_revend(svn_revnum_t re=
vision,
[...]
> +	/* Populte ctx->auth_baton with the auth baton
> +	   non-interactively. Arguments 3, 4 and 5 are for username,
> +	   password and config_dir which is NULL in this case. Set
> +	   no_auth_cache and trust_serv_cert to FALSE, don't provide a
> +	   config, and omit cancel_func/ cancel_baton */
>  	SVN_ERR(svn_cmdline_create_auth_baton(&(ctx->auth_baton), TRUE,
>  					      NULL, NULL, NULL, FALSE,
>  					      FALSE, NULL, NULL, NULL,

I think you took my suggestion too seriously here.  Such a comment
probably will not help people much; instead, maybe a more focused
comment can help the curious avoid looking up
svn_cmdline_create_auth_baton:

	/* Default authentication providers for noninteractive
	   use. */
	SVN_ERR(svn_cmdline_create_auth_baton(...

Looking this up, I notice that function was added in svn 1.6.
Hopefully that is okay, since this code is destined for svn trunk.

Except as noted above,

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
