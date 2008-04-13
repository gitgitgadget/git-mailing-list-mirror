From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH v3 1/4] config.c: Add git_config_bool_or_int to handle bool/int variable
Date: Sun, 13 Apr 2008 15:30:28 +0800
Message-ID: <46dff0320804130030q19dd9f23j66d9b7adc7d305d3@mail.gmail.com>
References: <1208012733-18211-1-git-send-email-pkufranky@gmail.com>
	 <1208012733-18211-2-git-send-email-pkufranky@gmail.com>
	 <7vmynye0cz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <junio@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 13 09:31:18 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkwgG-0004TP-S5
	for gcvg-git-2@gmane.org; Sun, 13 Apr 2008 09:31:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753113AbYDMHaa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Apr 2008 03:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752984AbYDMHaa
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Apr 2008 03:30:30 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:15151 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752782AbYDMHa3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Apr 2008 03:30:29 -0400
Received: by an-out-0708.google.com with SMTP id d31so285580and.103
        for <git@vger.kernel.org>; Sun, 13 Apr 2008 00:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ofN6LUBj9C3GURvnTeCy7hmxVmwrOOpSa1kvTKoNBJw=;
        b=mOt+kh0u9jd/BRj2b2+QWbYezy5LOLSFx8tPWkHkHJOLCfd5bzQ1mGokQpwJ4z062gatQLz+XPGmswWpAMTCr83n2mMKvhGmWdvdnEO2nJIgwwgi5xrCB/PkWREkic3YqlnmvUME7kpDLrynFr8+irfDLBkO/ROki3ReTqb0fXU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oqHhz96Qo3LcyMhafU7jPWj1oOzOLqfxAuLVUna1ObuJw4l4D/PFNpq/nQ5t1DDHY39hpRgZztNBeUaQxnw814hy6tqSbkckL3qoWuOdKX+KqWparyTDCIRSECwNMmthIPITIZK1p29X9RNmkc7MkUirjvjEhwQDeFSgHwskPCE=
Received: by 10.100.105.15 with SMTP id d15mr9395339anc.53.1208071828704;
        Sun, 13 Apr 2008 00:30:28 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Sun, 13 Apr 2008 00:30:28 -0700 (PDT)
In-Reply-To: <7vmynye0cz.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79396>

On Sun, Apr 13, 2008 at 2:26 PM, Junio C Hamano <junio@pobox.com> wrote:
> Ping Yin <pkufranky@gmail.com> writes:

>  -int git_config_bool(const char *name, const char *value)
>
> +int git_config_bool_or_int(const char *name, const char *value, int *is_bool)
>   {
>  +       *is_bool = 1;
>         if (!value)
>                 return 1;
>         if (!*value)
>  @@ -313,9 +314,16 @@ int git_config_bool(const char *name, const char *value)
>
>                 return 1;
>         if (!strcasecmp(value, "false") || !strcasecmp(value, "no"))
>                 return 0;
>  +       *is_bool = 0;
>
>         return git_config_int(name, value) != 0;
>   }

Should return an interger if *is_bool==0
s/!=0//


>  +int git_config_bool(const char *name, const char *value)
>  +{
>  +       int discard;
>  +       return git_config_bool_or_int(name, value, &discard);
>
>
> +}
>  +
>   int git_config_string(const char **dest, const char *var, const char *value)
>   {
>         if (!value)
>
>



-- 
Ping Yin
