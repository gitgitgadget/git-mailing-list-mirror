From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH 1/9] Makefile: Do not install a copy of 'git' in $(gitexecdir)
Date: Sun, 27 Jul 2008 20:18:23 -0400
Message-ID: <488D104F.8080005@gmail.com>
References: <1216667998-8879-1-git-send-email-johannes.sixt@telecom.at> <1216667998-8879-2-git-send-email-johannes.sixt@telecom.at>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Mon Jul 28 02:19:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNGSj-0002uu-3m
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 02:19:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757341AbYG1ASd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 20:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757374AbYG1ASd
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 20:18:33 -0400
Received: from an-out-0708.google.com ([209.85.132.251]:45085 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755333AbYG1ASb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 20:18:31 -0400
Received: by an-out-0708.google.com with SMTP id d40so865222and.103
        for <git@vger.kernel.org>; Sun, 27 Jul 2008 17:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=LU4+syr8u38lvkiN690k52lYggeeQPJtWy9VjK4di2I=;
        b=cB25sR3xCf+tJmkJqAOXXzaadl79Zh2HKcThp/Wu4QfI/w/WHjm2fU+YAHpC6KIAsx
         ga9A67x3kkwTWY+a7vC7Asmjh7hgIAYzMGpU7mr7OoWQWYlWHp3Psr9TyQxpY+g2Zgn7
         TRJkFsstYlVTLTehMyDWn3gtupZSvfwLnvbOk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=g/BhDL98InXS7Bq3k5Zz87xTnBOU/O/FVHJGS7bycqy/ekxdtnmz97iXCOVp1U3iYr
         RVxMdFchYFq1CGLsYQLc8gL8f4OUEZzEHGoEcnvtWkir1woTgmJZnXjn6We7AZ1C2xkj
         kb7ko9j8nLYzp5E5VnfLozr1pZ9IawVpchUP4=
Received: by 10.100.3.4 with SMTP id 4mr2232867anc.4.1217204310807;
        Sun, 27 Jul 2008 17:18:30 -0700 (PDT)
Received: from ?10.0.0.6? ( [66.177.19.100])
        by mx.google.com with ESMTPS id 4sm12766217yxd.2.2008.07.27.17.18.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 27 Jul 2008 17:18:29 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <1216667998-8879-2-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90379>

Johannes Sixt wrote:
[...]
> 
> diff --git a/Makefile b/Makefile
> index 551bde9..cbab4f9 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1335,6 +1335,7 @@ endif
>  			'$(DESTDIR_SQ)$(gitexecdir_SQ)/git$X'; \
>  	fi
>  	$(foreach p,$(BUILT_INS), $(RM) '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' && ln '$(DESTDIR_SQ)$(gitexecdir_SQ)/git$X' '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' ;)
> +	$(RM) '$(DESTDIR_SQ)$(gitexecdir_SQ)/git$X'
>  ifneq (,$X)
>  	$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_PROGRAMS) $(BUILT_INS) git$X)), $(RM) '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p';)
>  endif

This new action needs to be in a conditional to keep it from removing 
the ONLY git executable when bindir and execdir are the same dir.
