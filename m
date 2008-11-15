From: "Tuncer Ayaz" <tuncer.ayaz@gmail.com>
Subject: Re: [PATCH] Teach/Fix pull/fetch -q/-v options
Date: Sat, 15 Nov 2008 18:42:18 +0100
Message-ID: <4ac8254d0811150942s7d4f5444xbc2b068beecbb44f@mail.gmail.com>
References: <1226708064-19432-1-git-send-email-tuncer.ayaz@gmail.com>
	 <7v7i7594cx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 15 18:43:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1PBH-0005ys-Vo
	for gcvg-git-2@gmane.org; Sat, 15 Nov 2008 18:43:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751781AbYKORmU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2008 12:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751839AbYKORmU
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 12:42:20 -0500
Received: from yx-out-2324.google.com ([74.125.44.29]:32019 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751736AbYKORmT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2008 12:42:19 -0500
Received: by yx-out-2324.google.com with SMTP id 8so801632yxm.1
        for <git@vger.kernel.org>; Sat, 15 Nov 2008 09:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=YMBKTiMWUEYqQzEwJNyreW5+nxPYcY/fECf8xzzS058=;
        b=QgIyB4XFOvDmDSxi4nVTSDekjNe//UblqntGqDGUfaPzjAnpFTzqGFtfrkcNNBW1Mk
         dUEZPRtasl65BGsetAXE2sCn517jjVvyAudNyy58FrPkuOgMz1mJKtMF6rJRmd4vlW7H
         cKunrkJe18AYSVd5L+bsVGVGZF5tVsmmX/Xv4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=qnhukIUzCJ4xvCve4QFUbKv6a0Otkb4alQBplCsOxst06jkor+794z6UqCXBSDInr5
         wwIFEkFsl1Aj+IEdjFlJAVxgaOVgAntia7SF95u4tKcu9B2lvLbwYJRauJMQIVI7sHjx
         UKaP0z/hbdDYjH7OCeuEjoQwnJAQk+Ag+8CnQ=
Received: by 10.65.232.2 with SMTP id j2mr2189563qbr.19.1226770938131;
        Sat, 15 Nov 2008 09:42:18 -0800 (PST)
Received: by 10.65.231.17 with HTTP; Sat, 15 Nov 2008 09:42:18 -0800 (PST)
In-Reply-To: <7v7i7594cx.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101081>

On Sat, Nov 15, 2008 at 2:15 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> @@ -637,9 +638,9 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>>               remote = remote_get(argv[0]);
>>
>>       transport = transport_get(remote, remote->url[0]);
>> -     if (verbose >= 2)
>> +     if (verbosity == VERBOSE)
>>               transport->verbose = 1;
>> -     if (quiet)
>> +     if (verbosity == QUIET)
>>               transport->verbose = -1;
>>       if (upload_pack)
>>               set_option(TRANS_OPT_UPLOADPACK, upload_pack);
>
> In the original code, the variable verbose can be ">= 2" when "-v -v" is
> given, so transport->verbose is not turned on with a single "-v" alone
> (this correctly mimics the original behaviour in the scripted version).
>

Doesn't this also mean that we need to be able to concatenate
multiple -v options in git-pull.sh similar to what one of the first
versions of my patch did?

<snip>
