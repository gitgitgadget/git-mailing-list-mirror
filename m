From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH jk/prune-mtime] prune: close directory earlier
 during loose-object directory traversal
Date: Thu, 13 Aug 2015 09:32:14 +0200
Organization: gmx
Message-ID: <557753b4c14eb3f90270007782bc3a73@www.dscho.org>
References: <55CA5EB0.1000308@kdbg.org>
 <b9cf9e2168c3b2476bb5bb134a1528be@www.dscho.org> <55CB85A5.5040802@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, msysGit
 <msysgit@googlegroups.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: msysgit+bncBCZPH74Q5YNRBAEQWGXAKGQELBZSJNI@googlegroups.com Thu Aug 13 09:32:20 2015
Return-path: <msysgit+bncBCZPH74Q5YNRBAEQWGXAKGQELBZSJNI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f185.google.com ([209.85.212.185])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBAEQWGXAKGQELBZSJNI@googlegroups.com>)
	id 1ZPmzp-00014E-GO
	for gcvm-msysgit@m.gmane.org; Thu, 13 Aug 2015 09:32:17 +0200
Received: by wicxr16 with SMTP id xr16sf10128277wic.1
        for <gcvm-msysgit@m.gmane.org>; Thu, 13 Aug 2015 00:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:content-type:date:from:to:cc:subject:organization
         :in-reply-to:references:message-id:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=NL3imdXGuumTOxV9aDbq6gStG9MZ801nmLx3IYL1gkI=;
        b=gSj2NKc6KxUAByXl/lE2ATnq9JKljcEnyaXxxV5RCEsADEbWWaj01/8nclhz4ZYMhZ
         zvWPuNyM5yeBSxr5Vrtn2n48qa6MjvPyEgnLAKY7K9ToTE21NwYU/18eUtZBQQsDK8xh
         mpKBGoT7HP42vqVwUZhhxS5J95kimzS/meJBaBnJfuk0EaGCD+h4e74s3v/mbdd9gW8l
         BQ+K66v36HhfPr7q9TQA/K77IuUPYyV1uTywKrKj62g7cqHwA3l1YtRQ72ieCFVWS5GX
         f9eJ8feSeGUhRIIckmdbW1KQS5zwGU3xc2r+B5vJwQKbtQ9weV3OQ3ui81aggDfZyI+A
         879g==
X-Received: by 10.152.5.226 with SMTP id v2mr5364lav.41.1439451137121;
        Thu, 13 Aug 2015 00:32:17 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.26.65 with SMTP id j1ls134988lag.39.gmail; Thu, 13 Aug
 2015 00:32:16 -0700 (PDT)
X-Received: by 10.112.172.70 with SMTP id ba6mr3601342lbc.1.1439451136033;
        Thu, 13 Aug 2015 00:32:16 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.17.20])
        by gmr-mx.google.com with ESMTPS id c3si43363wiz.2.2015.08.13.00.32.15
        for <msysgit@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Aug 2015 00:32:16 -0700 (PDT)
Received-SPF: pass (google.com: domain of johannes.schindelin@gmx.de designates 212.227.17.20 as permitted sender) client-ip=212.227.17.20;
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MKLeM-1ZPEUr0TVG-001g1f; Thu, 13 Aug 2015 09:32:15
 +0200
In-Reply-To: <55CB85A5.5040802@kdbg.org>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:x2OJdGS1pT/Pa4W72SzNnme5JnP+DImSo2mPaQHf8s5QISyKh+L
 i6jLuJqyPGKhlhswGtwFp7T1vzwQjAREqYpjCUp70fuRulsrFeQQT/Ho6mYbNR2rHDJrScP
 PN0/+tdoU+xfIGDlB01nm7oL7TMYdu1okOTxWFaHZrFWItEzz0CBigZzS6OskL6hwiiN4c0
 KEYW+W9oryyWrbI5Js9yA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7F8MIDenE3k=:n7Hoonex6NHyEsw5U5RRNr
 G2BvN1Br+nU3/9ktFDL/VR39BI6KmqUXvETH/KPxdZxkzPqI6OvdjtlHLPCgjcTnjYdJDH3Yi
 v+4riJJ/9BpcjHbZhmpjRn9TbDbD63uMQF0KWvRujgQdwiSRlDOWjBWhV1g9h6IovUFu6d2t+
 rQowk/2eaMtPOvd7woaGQtAUgIzySG7wB48TuiK56eVps2HmepKEyldZqe8uyRSX0Kzmz2Brd
 tkt6h1aJu0sEdfzWgruYIqfk87k9z9k3V2AUvCrnywcv6yB+uP57kkF+izk1gTLRaIbnXCiEo
 bZRu8vHx7qymIg4CsLL84nAlTlyKVV4SupKj02C9VzGbhnHz3QDGEFZzZPjJ2jfHiYuEIO5W/
 wezXxwByTYyUViNOSkdyhCKOUiZID/63OXayJTyaRLdQNFwX0Az3OM9KpIe6qK6RtzneLeJEf
 g1Z2aaSyEIW9/exOHGsMT0YntwhHi0Gw0pNSMRl/RgXSOxQQNj1ZVUZ2Qkly6Tbyi7lqVeC6t
 lylwC+TMrajeuk4uGye6w3UuJx3Z8fiYw9+P9Fe73AAiAX3cQITDQlLcEBvWQXeqRXR0KwJtW
 gXrrNxvqtqNSTU8nvUtSCZsT5JOq7GLS9kHJFIoow1T2HQ7Oo4rlDkSSQ8Dg7G/Ixms+6kpJz
 8raTqQQZBIM+SxS2Q8DiFZuN59F+JhymoheMjJo7ec8dGUl5lI0VNtsut1rJ2ch1BFbweMZTO
 IKVsbdcj2iDl22Vfi8zdaQD5aUDjXg5x6x4VWg==
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of johannes.schindelin@gmx.de designates 212.227.17.20 as
 permitted sender) smtp.mailfrom=johannes.schindelin@gmx.de
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Spam-Checked-In-Group: msysgit@googlegroups.com
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275834>

Hi,

On 2015-08-12 19:43, Johannes Sixt wrote:
> 27e1e22d (prune: factor out loose-object directory traversal, 2014-10-16)
> introduced a new function for_each_loose_file_in_objdir() with a helper
> for_each_file_in_obj_subdir(). The latter calls callbacks for each file
> found during a directory traversal and finally also a callback for the
> directory itself.
> 
> git-prune uses the function to clean up the object directory. In
> particular, in the directory callback it calls rmdir(). On Windows XP,
> this rmdir call fails, because the directory is still open while the
> callback is called. Close the directory before calling the callback.
> 
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  My Windows 8.1 machine does not require this fix for some unkonwn
>  reason. But we still cater for Windows XP users, where this change
>  is a real improvement.

I believe that we have a concrete bug report for that:

    https://github.com/git-for-windows/git/issues/231

Ciao,
Johannes

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
