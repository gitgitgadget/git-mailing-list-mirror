From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Make $prevent_xss protection for 'blob_plain' more usable
Date: Tue, 14 Jun 2011 03:33:57 +0200
Message-ID: <201106140333.58351.jnareb@gmail.com>
References: <1307177015-880-1-git-send-email-jnareb@gmail.com> <201106132350.00161.jnareb@gmail.com> <7vy615mily.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Matt McCutchen <matt@mattmccutchen.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 03:34:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWIWF-00024t-61
	for gcvg-git-2@lo.gmane.org; Tue, 14 Jun 2011 03:34:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755626Ab1FNBeK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2011 21:34:10 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:43362 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752848Ab1FNBeI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2011 21:34:08 -0400
Received: by fxm6 with SMTP id 6so4801485fxm.11
        for <git@vger.kernel.org>; Mon, 13 Jun 2011 18:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=ApsJECfe/39Ls6IdgT9TEbsk9yNnE9HW7bZWTlmGy6Q=;
        b=jog97XoKACL75sDZZuLK1r40qjsn4i8DWTOVe5TEIBlI1Htr30Xt+0CZRmem9tWCZV
         TSoNcFLRw9vAyPdXdNagGRvn29j78zGOHMh+nAFIst5K+xcgi/7Iak4MOdQ1mlHb0Vay
         zC/Y5N42AV+CKqiJFhL+160Vb5OdMB+oI13wg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=QXJy99ZcyL4Zu7+oh6bP7mQ6gWn/7mCZdRPFlZKPaRcBzer+tLaGvflyJVxwvSghvw
         JzNQ9BQftq8NPQ2eq1ngyQ+seYYS3u3/w5Nouz9hfgsZwI1WcQk4w/ATLND4BtY5So0i
         b7wfVa7TQ2hlPVTdI1WAi4uYVIAVxumDZWHFc=
Received: by 10.223.62.194 with SMTP id y2mr803681fah.123.1308015247162;
        Mon, 13 Jun 2011 18:34:07 -0700 (PDT)
Received: from [192.168.1.15] (abwt98.neoplus.adsl.tpnet.pl [83.8.243.98])
        by mx.google.com with ESMTPS id h9sm2306801fai.6.2011.06.13.18.34.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 13 Jun 2011 18:34:06 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vy615mily.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175740>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>>> Hmph, wouldn't it be more straightforward if you dropped the statement
>>> modifier?  I.e.
>>> 
>>> 	my ($subtype, $rest) = ($1, $2);
>>> 	$rest = '' unless defined $rest;
>>> 	$type = "text/plain$rest";
>>
>> Yes, of course.
>>
>> I don't know why I decided that avoiding rewriting 'text/plain; 
>> charset=utf-8' case was important.
> 
> Just to make sure I understand what you are saying...
> 
>     my $type = 'text/plain; charset=utf-8';
>     if ($type =~ m|^text/([a-z]+)\b(.*)$|) {
>  	my ($subtype, $rest) = ($1, $2);
>  	$rest = '' unless defined $rest;
>  	$type = "text/plain$rest";
>         print "Type is now <$type>\n";
>     }
> 
> 
> does yield "text/plain; charset=utf-8". It does rewrite but rewrite to
> exactly the same thing, so...

Yes, it does rewrite to the same thing.  And the code is simpler,
therefore better. 

-- 
Jakub Narebski
Poland
