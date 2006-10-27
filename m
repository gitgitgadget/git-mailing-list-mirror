X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: Re: gitweb.cgi and git instaweb
Date: Fri, 27 Oct 2006 14:28:56 +0530
Message-ID: <4541CA50.6060901@gmail.com>
References: <ehr00n$vbe$1@sea.gmane.org> <45419F75.6060103@gmail.com> <7v8xj2i6hb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 27 Oct 2006 08:59:46 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=c3gznmm6oEACWqod+TIOH4pGIeC5tS5mj0bvtqlS9CUoNVFJfauAc4Jskguo8OeZT38hOADehFCZMZezr/Wn8kfWwq+qDPUKfjpCIUjeJ8qFYnYHLxM/Bf9AEMQ9ZPjOq2y5Jf4nwhGAc6qcWpgaGAZlccwHHIrt/8XbZleWFDI=
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
In-Reply-To: <7v8xj2i6hb.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30311>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdNYY-0001Io-P3 for gcvg-git@gmane.org; Fri, 27 Oct
 2006 10:59:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965257AbWJ0I7K (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 04:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965261AbWJ0I7K
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 04:59:10 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:31479 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S965257AbWJ0I7I
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 04:59:08 -0400
Received: by nf-out-0910.google.com with SMTP id c2so1226453nfe for
 <git@vger.kernel.org>; Fri, 27 Oct 2006 01:59:07 -0700 (PDT)
Received: by 10.78.127.3 with SMTP id z3mr3467880huc; Fri, 27 Oct 2006
 01:59:06 -0700 (PDT)
Received: from ?217.108.227.183? ( [156.153.255.234]) by mx.google.com with
 ESMTP id 2sm347364huc.2006.10.27.01.59.03; Fri, 27 Oct 2006 01:59:06 -0700
 (PDT)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> "Aneesh Kumar K.V" <aneesh.kumar@gmail.com> writes:
> 
>> Aneesh Kumar K.V wrote:
>>> I am getting errors as below with git instaweb.
>>>
>>>
>>> kvaneesh@satan:/home/opensource/vanilla/linux-2.6-git$ git instaweb
>>> 2006-10-27 00:12:56: (log.c.75) server started
>>> kvaneesh@satan:/home/opensource/vanilla/linux-2.6-git$ [Fri Oct 27
>>> 00:12:57 2006] gitweb.cgi: "our" variable $stylesheet masks earlier
>>> declaration in same scope at
>>>
>> The attached patch should fix it.
>>
>> -aneesh
>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index ba7a42a..1962c76 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -55,8 +55,6 @@ our $stylesheet;
>>  # default is not to define style sheet, but it can be overwritten later
>>  undef $stylesheet;
>>  
>> -# URI of default stylesheet
>> -our $stylesheet = "++GITWEB_CSS++";
>>  # URI of GIT logo (72x27 size)
>>  our $logo = "++GITWEB_LOGO++";
>>  # URI of GIT favicon, assumed to be image/png type
> 
> Removing the extraneous undef would also be a good idea,
> wouldn't it?
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index aceaeb7..7999b1a 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -51,12 +51,10 @@ our $site_footer = "++GITWEB_SITE_FOOTER
>  
>  # URI of stylesheets
>  our @stylesheets = ("++GITWEB_CSS++");
> -our $stylesheet;
> -# default is not to define style sheet, but it can be overwritten later
> -undef $stylesheet;
> -
>  # URI of default stylesheet
> -our $stylesheet = "++GITWEB_CSS++";
> +# default is not to define style sheet, but it can be overwritten later.
> +our $stylesheet = undef;
> +
>  # URI of GIT logo (72x27 size)
>  our $logo = "++GITWEB_LOGO++";
>  # URI of GIT favicon, assumed to be image/png type
> 

ACK

