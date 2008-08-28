From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] dir.c: avoid c99 array initialization
Date: Thu, 28 Aug 2008 23:12:46 +0200
Message-ID: <81b0412b0808281412j2a5643ceu49a49cf62002f0be@mail.gmail.com>
References: <IH0MHSTEimhAN93AedvpRKq4qfzm1QA814ZYyhbSBtSdNbq8vuE6aw@cipher.nrlssc.navy.mil>
	 <G-ipWASixyGW7nvO1KquifehvBB7FNKwjPtIB0ukyEJ1Si1CJWM34w@cipher.nrlssc.navy.mil>
	 <871w09kvew.fsf@lysator.liu.se>
	 <GwKOGVPR0AVw4_Phmw1TSNzzMDtafrawMMahm2DQwh44k6uTOHkjTQ@cipher.nrlssc.navy.mil>
	 <7vhc95dldz.fsf@gitster.siamese.dyndns.org>
	 <ojPuT0s3trguL5yp3hozXVxP1WsidV5hbSISvFZjv5JUCO31lWTzEw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"=?UTF-8?Q?David_K=C3=A5gedal?=" <davidk@lysator.liu.se>,
	git@vger.kernel.org
To: "Brandon Casey" <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Aug 28 23:14:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYooY-0006o7-2G
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 23:13:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755557AbYH1VMt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 17:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754988AbYH1VMs
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 17:12:48 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:25810 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754733AbYH1VMs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 17:12:48 -0400
Received: by py-out-1112.google.com with SMTP id p76so357595pyb.10
        for <git@vger.kernel.org>; Thu, 28 Aug 2008 14:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=4IwdLsZ8jfFmdA2wTBmlQC6Enqx602/Sx+2CoUbi2cI=;
        b=hhcQgQdoHfrzjjPyUF+LQMYrT32+R5nlDaacbq3ZogSQ2JMZRqlRL/xzvGLHkbgwDW
         iuJ0dzACio+jMybjGuEUE4w5w7atQlXT8W1+zCCOSireItF1JQVizUFnTNAh++wuslhD
         gGtrkDABGSVUt8nO/5tN3HiBMx18mGIkDecIg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=wbE9showuO0qBj7lCpc0PVJWrN+GmB7mjfrM0HbXcNv3lv+MritxAbfJ257xi7JFct
         hFO3fzHyBZSe6QFUHmNZ0fAETP/fmmo25/961RlDVCNbx7sA2r9yRMgarH0g7OO3q2HO
         lDU1pnUeBBFXJUYLxlzYCfLwSWPPPsxDxcFBE=
Received: by 10.114.133.1 with SMTP id g1mr2017274wad.123.1219957966966;
        Thu, 28 Aug 2008 14:12:46 -0700 (PDT)
Received: by 10.114.157.9 with HTTP; Thu, 28 Aug 2008 14:12:46 -0700 (PDT)
In-Reply-To: <ojPuT0s3trguL5yp3hozXVxP1WsidV5hbSISvFZjv5JUCO31lWTzEw@cipher.nrlssc.navy.mil>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94161>

2008/8/28 Brandon Casey <casey@nrlssc.navy.mil>:
> diff --git a/builtin-cat-file.c b/builtin-cat-file.c
> index 7441a56..d954c09 100644
> --- a/builtin-cat-file.c
> +++ b/builtin-cat-file.c
> @@ -212,7 +212,7 @@ int cmd_cat_file(int argc, const char **argv, const char *pr
>        int opt = 0, batch = 0;
>        const char *exp_type = NULL, *obj_name = NULL;
>
> -       const struct option options[] = {
> +       struct option options[] = {
>                OPT_GROUP("<type> can be one of: blob, tree, commit, tag"),

#ifdef HAVE_CONST
#define gitconst const
#else
#define gitconst
#endif

-	const struct option options[] = {
+	gitconst struct option options[] = {

?
