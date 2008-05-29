From: Paolo Bonzini <paolo.bonzini@gmail.com>
Subject: Re: [PATCH] make commit --interactive lock index
Date: Thu, 29 May 2008 15:12:56 +0200
Message-ID: <483EABD8.3050600@gnu.org>
References: <E1K1eXH-00063c-Bt@fencepost.gnu.org> <alpine.DEB.1.00.0805291343120.13507@racer.site.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git mailing list <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 29 15:14:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1hxA-0000AH-UL
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 15:14:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752408AbYE2NNJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 09:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752001AbYE2NNH
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 09:13:07 -0400
Received: from mu-out-0910.google.com ([209.85.134.187]:50607 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751781AbYE2NNG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 09:13:06 -0400
Received: by mu-out-0910.google.com with SMTP id w8so2631104mue.1
        for <git@vger.kernel.org>; Thu, 29 May 2008 06:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:from;
        bh=5z1JlI8u5hP6VvlczQ1IBVcR8pNRpzB5QMp7sdET87w=;
        b=tglewvoYfoHn4KoiyiZi3J5+mBDYXC22949mnusp8J9Xtkzap6WTmJvMMqx6gCUWw6SDVXG3Q8tY+2ZV4ZFy0EheLSakY0MkyYXVLUPIOnUxoAYEY8BjEkt0UPuDq6/2JAVjQAMXDlHeEBj8Kkn1eQL+H0JuSpaDG89rO249y0o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:from;
        b=WPujUri6gnHF48h0N5LRh/gLJdiJrxEdWOt8JRU8lQgY7NVKauMR8oSJeLjVIN5+5oln6GO+Gi515VWake+jtPQ9nWe4x/0DA0sIpAET1jjb9szz0bbT34vRiwocGCJ//RD7k8GxTsmpC3luzRZCAEHqKc3CWWV0mGy0Fa0nmck=
Received: by 10.103.227.10 with SMTP id e10mr2685832mur.38.1212066782346;
        Thu, 29 May 2008 06:13:02 -0700 (PDT)
Received: from scientist-2.local ( [195.176.178.209])
        by mx.google.com with ESMTPS id n10sm1042100mue.14.2008.05.29.06.12.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 29 May 2008 06:13:01 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Macintosh/20080421)
In-Reply-To: <alpine.DEB.1.00.0805291343120.13507@racer.site.net>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83196>

Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 29 May 2008, Paolo Bonzini wrote:
> 
>> @@ -233,6 +228,8 @@ static char *prepare_index(int argc, const char **argv, const char *prefix)
>>  	if (*argv)
>>  		pathspec = get_pathspec(prefix, argv);
>>  
>> +	assert (!(interactive && pathspec && *pathspec));
> 
> As pathspec is specified indirectly by the user, I think an assert() here 
> is actively wrong.

But the program may still guarantee a condition by checking it 
elsewhere.  I don't need to teach you about that, do I?  In particular, 
the assert checks that this:

if (interactive && argc > 0)
         die("Paths with --interactive does not make sense.");

... is equivalent to !pathspec || !*pathspec.

Paolo
