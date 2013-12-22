From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: Rationale behind 'extern' on protypes in .h files
Date: Sun, 22 Dec 2013 18:11:00 +0100
Message-ID: <52B71D24.4000207@googlemail.com>
References: <CAKTJ_1zecXP03k_2YRnm_26n=anxkG6=k+isZxnnjWgfec70LA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Ravi Shekhar Jethani <rsjethani@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 22 18:11:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VumYZ-0003dS-FR
	for gcvg-git-2@plane.gmane.org; Sun, 22 Dec 2013 18:11:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754521Ab3LVRLG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Dec 2013 12:11:06 -0500
Received: from mail-ea0-f176.google.com ([209.85.215.176]:41887 "EHLO
	mail-ea0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754018Ab3LVRLF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Dec 2013 12:11:05 -0500
Received: by mail-ea0-f176.google.com with SMTP id h14so1921793eaj.21
        for <git@vger.kernel.org>; Sun, 22 Dec 2013 09:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=Uz/Q3OW5ZmSbi/AHeRSC7YJanJbfWk2WYJF9UHSIOAg=;
        b=J07or/KrdwJBV4+WjK78nry1jil7dPQpA9XEZbviLCqdVtXU0hCvpD/aZ0ywONnIDl
         6Ab4XNx7wqOhtkCizkRvL2mYSFlmTEuoOj9VF0i/0YZzD4yp0y8V5PiPc83Ggfo2m8UU
         C7cSGnWQwOdEOnPHVF77TrRKV9kVmljTcUNqnn8ViEbXG6BzoxNQ4p66WYiker3AaEHS
         eKBG3xROnpyWPaJ+F6bGKASlpHL55x8o6d6KDAkdTEKsI+QPgt2ecKk2dxXHxZSIDWy5
         DAtfm/BBYlvrLZ01TYNTU4hyQQ9Afg9KR25+HKJvg2k5sJPFQf/N3PxswPd7ro/m822c
         oiQw==
X-Received: by 10.14.203.6 with SMTP id e6mr15834404eeo.33.1387732262928;
        Sun, 22 Dec 2013 09:11:02 -0800 (PST)
Received: from [192.168.1.7] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id v7sm38002665eel.2.2013.12.22.09.11.01
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 22 Dec 2013 09:11:01 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <CAKTJ_1zecXP03k_2YRnm_26n=anxkG6=k+isZxnnjWgfec70LA@mail.gmail.com>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239645>

On 22.12.2013 16:51, Ravi Shekhar Jethani wrote:

> 
> Now, my real question :
> 1) I cannot understand the reason behind making function prototypes as
> extern. What purpose does this serve? AFAIK we put definition in a .c
> file and the prototype in a .h thats it.
> 
> 2) Why are some  prototypes in some of the .h file are extern and
> others are not?
> 
> Thank you guys for reading through. Any suggestions are humbly welcome.
> Ravi S. Jethani
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

That's an interesting question. From my understanding there is no
difference for functions declarations being set to extern or not,
because extern is the default on functions. It is however important
for variables to mark them extern if they're in a header file.

After a quick research on the web, it may be there for historical
reasons. Back then, when there were one pass compilers,
the compiler needed to know where the function is to be found.
(extern was not default at these times?)

Another reason I could make up, would be to indicate,
whether the function is in the c file having the
same name as the header file.
For example in builtin.h there are all the functions declared
extern, as the implementation of the functions are found in
builtin/*.c
In another header cache-tree.h there are function declarations
without explicit extern keyword, and the implementation
is found in the cache-tree.c file (${SAME-NAME-AS-HEADER}.C)
This is however not always the case as found in archive.{c,h}

I'd be also interested in knowing the real reason for this rationale.

Thanks,
Stefan
