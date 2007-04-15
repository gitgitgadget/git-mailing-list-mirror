From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH 01/02] ident.c: Use const qualifier when possible
Date: Sun, 15 Apr 2007 21:06:49 +0100
Message-ID: <200704152106.51082.andyparkins@gmail.com>
References: <20070415155110.365070d8@gnut>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: 7bit
Cc: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 15 22:07:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdB0W-00077k-9Q
	for gcvg-git@gmane.org; Sun, 15 Apr 2007 22:07:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753589AbXDOUHH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 16:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753586AbXDOUHH
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 16:07:07 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:39911 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753589AbXDOUHG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 16:07:06 -0400
Received: by ug-out-1314.google.com with SMTP id 44so951924uga
        for <git@vger.kernel.org>; Sun, 15 Apr 2007 13:07:04 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Jo+VT3qNsIBU5b9Xzz/AtmqbLq3qk0M/Ue0EbK0QSf8I2duu4k6Ps4t41tTyx+KZ5Fu7Rwgj3UE3uG0xMJeUwYNILzFJ01UpL3xuiVrq3KfCGmRqFM+ifEkT7tTAm363+M+eQDkLkncCvFucZUh3YQnGYsrnQaCLX9ph0ZTaTvU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Q7igM4FdHLfyvEX9aIw6S09Nhkx8zSEC5eNwvP9dfp0wA+dUjBYxOGsvGvXWTzDzEvd3X+a4gBNubcBBufLzMK82tMEqtLo3u6Io/8KxEZGz6VjIXwTNhSyBmJkrE1f9m+/hFbcvOHijU4rhWzCtjCV7SK7KqDTaZtQQcslWHcQ=
Received: by 10.67.90.1 with SMTP id s1mr3771652ugl.1176667623915;
        Sun, 15 Apr 2007 13:07:03 -0700 (PDT)
Received: from grissom.local ( [82.0.29.64])
        by mx.google.com with ESMTP id y37sm10690127iky.2007.04.15.13.07.02;
        Sun, 15 Apr 2007 13:07:03 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <20070415155110.365070d8@gnut>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44511>

On Sunday 2007, April 15, Luiz Fernando N. Capitulino wrote:

> -static const char *env_hint =
> +static const char const *env_hint =

 char c;              // c is a char
 char *p;             // p is a pointer, *p is a char
 const char c;        // c is a const char  [1]
 char const c;        // c is a const char  [1]
 const char *p;       // p is a pointer, *p is a const char [2]
 char const *p;       // p is a pointer, *p is a const char [2]
 char *const p;       // p is a const-pointer, *p is a char
 const char *const p; // p is a const-pointer, *p is a const-char

[1] Semantically identical
[2] Semantically identical

You can see then that

 const char const *env_hint

is redundant, it's simply saying twice that (*env_hint) is const.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
