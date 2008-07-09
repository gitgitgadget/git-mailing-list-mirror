From: "Rob Shearman" <robertshearman@gmail.com>
Subject: Re: [PATCH 2/4] git-imap-send: Add support for SSL.
Date: Wed, 9 Jul 2008 22:24:27 +0100
Message-ID: <1096648c0807091424g1e10d0ccrae0be929ec428b89@mail.gmail.com>
References: <1215555496-21335-2-git-send-email-robertshearman@gmail.com>
	 <1215616484.3053.6.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Josh Triplett" <josht@linux.vnet.ibm.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 23:25:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGhAH-0001Kr-Cs
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 23:25:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756672AbYGIVYb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 17:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755437AbYGIVYb
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 17:24:31 -0400
Received: from wr-out-0506.google.com ([64.233.184.236]:27261 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751851AbYGIVYa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 17:24:30 -0400
Received: by wr-out-0506.google.com with SMTP id 69so2280534wri.5
        for <git@vger.kernel.org>; Wed, 09 Jul 2008 14:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=uY5SHqIJwiOyzN3HHjN4NX5pWkaV5EuToKtYUrt4PsI=;
        b=wzJIAomhh74nuf6PVn23C7yvbpK7vtdVvSMf/jWTEAoY9NAFbcjU9DITZ2YTBpMV54
         nbjndm839GZCf+o3SLQF0ob+ueptPVkSoklySh5sA1Zyk0wXR9bL01ep1szE2dS/NBuN
         in9GLkqndAMbsN01bA+jOddDQwnOfKq4igO94=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=b+WjKsg8U0BOUbsbpIljgRTpWZGmSMw7y1/85tdR5OyYXPsWCv6xAsPb2N+HL23U47
         rctjdLGGArnWRb5sBXqus359FDMkFXxNfM2PJdHjwixA1M5I6rCXThjaEx+YiUZXj7X3
         oo48YGca+gCMdhbxf3pS1Y31ZagQHDr5bSDzs=
Received: by 10.90.55.20 with SMTP id d20mr9132323aga.29.1215638667421;
        Wed, 09 Jul 2008 14:24:27 -0700 (PDT)
Received: by 10.90.93.17 with HTTP; Wed, 9 Jul 2008 14:24:27 -0700 (PDT)
In-Reply-To: <1215616484.3053.6.camel@josh-work.beaverton.ibm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87915>

2008/7/9 Josh Triplett <josht@linux.vnet.ibm.com>:
> On Tue, 2008-07-08 at 23:18 +0100, Robert Shearman wrote:
>> --- a/Documentation/git-imap-send.txt
>> +++ b/Documentation/git-imap-send.txt
>> @@ -37,10 +37,11 @@ configuration file (shown with examples):
>>      Tunnel = "ssh -q user@server.com /usr/bin/imapd ./Maildir 2> /dev/null"
>>
>>  [imap]
>> -    Host = imap.server.com
>> +    Host = imaps://imap.example.com
>>      User = bob
>>      Pass = pwd
>> -    Port = 143
>> +    Port = 993
>> +    sslverify = false
> [...]
>> @@ -1280,6 +1411,8 @@ git_imap_config(const char *key, const char *val, void *cb)
>>               server.port = git_config_int( key, val );
>>       else if (!strcmp( "tunnel", key ))
>>               server.tunnel = xstrdup( val );
>> +     else if (!strcmp( "ssl_verify", key ))
>> +             server.ssl_verify = git_config_bool( key, val );
>
> The example and the code disagree on the name of the
> sslverify/ssl_verify option.

I wouldn't exactly call it "disagree". The config variable is limited
by not allowing underscores, whereas the C language does allow them.

> Also, ssl_verify needs explanation.

See patch 4/4.

-- 
Rob Shearman
