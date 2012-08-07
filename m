From: Marco Schulze <marco.c.schulze@gmail.com>
Subject: Issuing cat-blob or ls to fast-import from a remote helper
Date: Tue, 07 Aug 2012 19:41:48 -0300
Message-ID: <502199AC.2070909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 08 01:00:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Syslf-0003oy-6v
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 01:00:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932926Ab2HGXAq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Aug 2012 19:00:46 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:33528 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030802Ab2HGWlv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2012 18:41:51 -0400
Received: by mail-yx0-f174.google.com with SMTP id l2so168849yen.19
        for <git@vger.kernel.org>; Tue, 07 Aug 2012 15:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=FbQeA4sncdcjHIqsUbDsSDMXKczvJd03Cxw2oTZnNhk=;
        b=rXgWRAXUKqLgutEFcCGhPxd+q19X8228jkkv8l8WqqgdEdWRew2FaytwGKW4zW7evi
         FkOyb3zyrAguVItip/5xHKOtUglYxUA0va6+LerU543Hf15EDvVww5NNARC2uTB3JF7C
         v57q6htFmnlH4ozH4OuNNM0nR5qVrMdJ4U8CYrwM7MUInWWN98xPcarhsmktgIBZsTNA
         OLhTdbO0YK6WuuJFyXrvSbhEQCrzfKgDlaVdhWs2AX1QjyMvoi9dk0yWiu+sfQoqmOh9
         tQ3h/gqXQTbXeoUzy8Ui8PhaKYC/5TBhnO+S76psLMZ6euuyYOZqG8uxl5IloU2BcSQz
         MZ1g==
Received: by 10.236.186.73 with SMTP id v49mr14831561yhm.48.1344379311135;
        Tue, 07 Aug 2012 15:41:51 -0700 (PDT)
Received: from [192.168.25.100] ([187.115.183.179])
        by mx.google.com with ESMTPS id e5sm11501226yhi.12.2012.08.07.15.41.49
        (version=SSLv3 cipher=OTHER);
        Tue, 07 Aug 2012 15:41:50 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120717 Thunderbird/14.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203056>

I've been toying with a git-remote-svn which uses fast-import (by 
advertising the 'import' capability) to get data into Git. 
Unfortunately, I can't get the result of any commands issued to 
fast-import, as its stdout is not redirected, and the remote helper API 
offers no alternative.

I tried modifiying transport-helper.c to force redirection 
(fast-import's stdout -> remote helper's stdin), but that breaks test 
t5800 (and possibly others). Is this a bug, or intended behaviour? Am I 
missing something?
