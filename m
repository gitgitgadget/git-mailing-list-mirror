From: nathan spindel <nathans@gmail.com>
Subject: Re: [PATCH] instaweb: if no httpd is specified and lighttpd doesn't exist, fall back on apache2.
Date: Sun, 11 May 2008 10:03:34 -0700
Message-ID: <5C50F5DC-CAE4-4BF2-BCAA-8CFC8CC43C59@gmail.com>
References: <1210483565-12415-1-git-send-email-nathans@gmail.com> <ee77f5c20805110458s6f1e4908k38be50753ba38d09@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "David Symonds" <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 11 19:04:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvEyM-0006le-9Y
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 19:04:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753622AbYEKRDk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 13:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753437AbYEKRDk
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 13:03:40 -0400
Received: from wf-out-1314.google.com ([209.85.200.174]:19628 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753421AbYEKRDj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 13:03:39 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1967762wfd.4
        for <git@vger.kernel.org>; Sun, 11 May 2008 10:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to:in-reply-to:content-type:content-transfer-encoding:mime-version:subject:date:references:x-mailer;
        bh=vU5SZ15ojBjnOxg0l0DGxhtPPvKe0ZOND1wOrlBJtYs=;
        b=yHtJVljRAZT4joJIyq3Q6XpMw9ZWEGEawF/mh1v3qveKVQrJ27vLf9PiN3rM3J7361c3XnG/19W9sLTjw9E/wvjGso1kzVDyIG2IGbw62h6kNkiSA9BV7VfzsBbrVGJzuuaTMTHtLh2yPbgJIwkgiIzr8+nsOlJjbKI3TqOkBHk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type:content-transfer-encoding:mime-version:subject:date:references:x-mailer;
        b=FFcQB4oGg5r8nUyXwq4jBQLQWgrN0ihanfR58IZo/m1XCiw8xHBukPXhAOsUXK05Smoxkn2WvhtUKqf9fyqANpZOXQEiY/uJUYvLlQQZktwiinGUWYCqcwbMiOuYHKaDvySPbIEarsirjdWI/cnlYr5a9yrDKzUVW7o83v383bc=
Received: by 10.142.201.3 with SMTP id y3mr2884091wff.120.1210525418934;
        Sun, 11 May 2008 10:03:38 -0700 (PDT)
Received: from ?10.0.1.4? ( [76.14.71.118])
        by mx.google.com with ESMTPS id 20sm5165580wfi.11.2008.05.11.10.03.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 May 2008 10:03:38 -0700 (PDT)
In-Reply-To: <ee77f5c20805110458s6f1e4908k38be50753ba38d09@mail.gmail.com>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81795>

On May 11, 2008, at 4:58 AM, David Symonds wrote:

> On Sun, May 11, 2008 at 3:26 PM, nathan spindel <nathans@gmail.com>  
> wrote:
>
>> -# if installed, it doesn't need further configuration (module_path)
>> -test -z "$httpd" && httpd='lighttpd -f'
>> +# use lighttpd if it exists, otherwise use apache2
>> +if test -z "$httpd"
>> +then
>> +       if type "lighttpd" > /dev/null 2>&1;
>> +       then
>> +               httpd="lighttpd -f"
>> +       else
>> +               httpd="apache2 -f"
>> +       fi
>> +fi
>
> I personally would prefer to use webrick over apache2, since it's much
> more lightweight. That's just my two cents.

I am apathetic about which web servers are preferred, I would just  
like to see git-instaweb work well on Mac OS X.  Kevin Ballard's  
suggestion was to fall back on apache2.

We could also modify the default to use [lighttpd, webrick, apache2]  
in that order (whichever is available). Would the community prefer  
that approach?
