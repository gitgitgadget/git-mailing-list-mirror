From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: git log - crash and core dump
Date: Tue, 16 Apr 2013 19:29:34 +0200
Message-ID: <E09BD6FE-D531-4CB1-B452-F3FF000CD8C3@gmail.com>
References: <CANKwXW1EXLiWgdVM4+k_11wu1Nyixp05PUXmQYP_gUXQKek_OA@mail.gmail.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Ivan Lyapunov <dront78@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 19:29:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1US9hY-0001Ow-Rc
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 19:29:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965087Ab3DPR3s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 13:29:48 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:35654 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965064Ab3DPR3r convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Apr 2013 13:29:47 -0400
Received: by mail-wi0-f172.google.com with SMTP id hq17so2125511wib.5
        for <git@vger.kernel.org>; Tue, 16 Apr 2013 10:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:references:in-reply-to:mime-version
         :content-transfer-encoding:content-type:message-id:cc:x-mailer:from
         :subject:date:to;
        bh=SQ/hQxYdiovoYDo6p7DoqIZrMKCmh9IxF30P60sPKQw=;
        b=A7iSZiX8YbN6momLYSxFunANsakwC+PHVkRk8eSxX6SF0++TrncegkMwiHNKGP6GIF
         d45uDxWL5bAHKRGF0vLjD5JX3EdEeQMRN0TAzbhBf5rpmu+6mdy0KPgi93A8Uk1r5ysx
         18mN5nyybQ5i0Lu+5x0b82DT6m46v1J9W1Mk4RpF6xDdlA3HG2J6eJHZHsd5+tX/p2KE
         XolGRpv8WgIrxYU3VE2WvPCqJjog5AviGuZimnXLFM4FnEjGoumQlLUbaWNY6MIcbDVq
         ZbrwfeqUbOPqcNWZkND60ctz7CmuXH+xNJXFQrt6brLklRA+ebrlZ0yU2LJOpj65yc/g
         QIJg==
X-Received: by 10.194.81.71 with SMTP id y7mr5685010wjx.19.1366133386213;
        Tue, 16 Apr 2013 10:29:46 -0700 (PDT)
Received: from [10.106.223.59] ([37.161.163.98])
        by mx.google.com with ESMTPS id fg6sm4353849wib.10.2013.04.16.10.29.43
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 16 Apr 2013 10:29:45 -0700 (PDT)
In-Reply-To: <CANKwXW1EXLiWgdVM4+k_11wu1Nyixp05PUXmQYP_gUXQKek_OA@mail.gmail.com>
X-Mailer: iPhone Mail (9B206)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221432>

Hey

> #0  0x00007ffff722b3e6 in ____strtoull_l_internal () from /usr/lib/libc.so.6
> #1  0x00000000004b31d4 in pp_user_info (pp=pp@entry=0x7fffffffd310,
> what=what@entry=0x521379 "Author", sb=sb@entry=0x7fffffffd290,
>    line=line@entry=0x7b3a45 "Ivan Lyapunov <ilyapunov@trueconf.ru>-
> <> 1354083115 +0400\ncommitter Ivan Lyapunov <ilyapunov@trueconf.ru>
> 1354083115 +0400\n\n- small merge fixes",
> encoding=encoding@entry=0x505400 "UTF-8") at pretty.c:441

Clearly the author line is messed up after name and email. It means we won't be able to parse the time, and return a null pointer to it (which we run through strtoll after, with a crash). 
I thought that bug was already fixed though and we're now checking for null time also ? I think I can submit a fix for that when I'm back home. 

Thanks for reporting !

Cheers, Antoine 
