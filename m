From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH 5/6] msvc: opendir: handle paths ending with a slash
Date: Tue, 23 Nov 2010 11:43:51 -0600
Message-ID: <20101123174351.GD12113@burratino>
References: <1290533444-3404-1-git-send-email-kusmabite@gmail.com>
 <1290533444-3404-6-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org,
	gitster@pobox.com
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 23 18:44:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKwuR-0002dE-Hy
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 18:44:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755965Ab0KWRn6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 12:43:58 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46996 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755735Ab0KWRn5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 12:43:57 -0500
Received: by fxm13 with SMTP id 13so4102338fxm.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 09:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=P1CuxJ2tRRKjiqUL750vUPDvWo5mFMXwbYh5bFcuTP8=;
        b=d9rPd36Yi7HNSCfo+BRJGp4iddogGC0gcBe4cqCoKKfq9eoGOF1oyoZKol67xR2V8C
         HsC/CKXilt+geYWntcacOK11JtB0sVtjS4QIPWUw4n+ULTbX7Gicgkv2ZGG9a9IAeip9
         u+nMEsD4IoL6M8LSU/DE1eEcM/HlmyOh6m1C8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=brbPX2otJp/AlaOcggL57CSNT4wTuATYEpyrHykD16YiWIXHccS87kFnRKJnb2uIl+
         7klvcSMOL330vxdFnrpDynbOFkvrF2SZT6L859kviLmnwdbMc61YnSc8rYyiIONRkzLv
         BWMxNtWTVyzIZCB6njiN4JYb+d9m+Z9oobZU0=
Received: by 10.223.122.201 with SMTP id m9mr6013638far.79.1290534236625;
        Tue, 23 Nov 2010 09:43:56 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id z25sm1890416fam.18.2010.11.23.09.43.55
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 23 Nov 2010 09:43:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1290533444-3404-6-git-send-email-kusmabite@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161993>

Erik Faye-Lund wrote:

> --- a/compat/msvc.c
> +++ b/compat/msvc.c
> @@ -23,6 +23,8 @@ DIR *opendir(const char *name)
>  
>  	/* check that the pattern won't be too long for FindFirstFileA */
>  	len = strlen(name);
> +	if (is_dir_sep(name[len - 1]))
> +		len--;

I assume len can't be 0?
