From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [GSOC][HELP] Incremental blame in gitweb.
Date: Fri, 30 Mar 2012 22:33:48 +0100
Message-ID: <201203302333.48770.jnareb@gmail.com>
References: <CAH-tXsDHJ98LLcHVs5U-OYS1maKoM+sDn6hw5HeD6c6wZ8mBHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: jaseem abid <jaseemabid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 30 23:34:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDjSK-0003Py-67
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 23:34:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966378Ab2C3Vdx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 17:33:53 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:45801 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966155Ab2C3Vdt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 17:33:49 -0400
Received: by wibhj6 with SMTP id hj6so969516wib.1
        for <git@vger.kernel.org>; Fri, 30 Mar 2012 14:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=TtMxxBngRlUKS0Zx+Vv9hzPLot/KKhX2ew1pI68/nVY=;
        b=GG7lGHbJoMHwXu/Uwd/4KdQ13oXsVe5pyugSdZYz5ITtJtGOklIFuohwqNKstDz0Eu
         w4mrrSjxr10F4n+g4FdFPTgH3Sd+1YRUR0As/O+c8m3hptXfqJdq64pjSh/SSG2O05tz
         PFL5Jekr2ZgmIh1l6QNC+GOxUYU9S8y5hVjH9c2Ugp0pCpC2W4cfrPNEwFOUCaZi+R9+
         TwotIvezHQ5LVJj05kUewIrGVMW/NKAMt3xh3sFQj4/JpxWqsJ1j8Boh3WYesWPXbfcW
         CSHJfzRXViyox9rNt76kREPtH+dSdkivfmoZTifdAWzgHXmAnsD/eOHHpkcuWHQlpjUY
         mIIQ==
Received: by 10.180.81.166 with SMTP id b6mr813642wiy.0.1333143228141;
        Fri, 30 Mar 2012 14:33:48 -0700 (PDT)
Received: from [192.168.1.13] (addb154.neoplus.adsl.tpnet.pl. [79.184.53.154])
        by mx.google.com with ESMTPS id fz9sm9742587wib.3.2012.03.30.14.33.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 30 Mar 2012 14:33:47 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <CAH-tXsDHJ98LLcHVs5U-OYS1maKoM+sDn6hw5HeD6c6wZ8mBHQ@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194412>

On Fri, 30 Mar 2012, jaseem abid wrote:

> I was learning from the gitweb source code and I am a bit stuck at a
> particular point.
> What does incremental blame do in gitweb? I tried to get some
> information from the documentation.
> I was expecting it to be used for pagination of huge git-blame output
> or something similar. Doc says it can be used for similar purposes
> I notice code written in JavaScript for AJAX calls etc, but i cant
> find a place where it is being used. Can somebody give me a link to
> one in k.org or somewhere for a demo? I tried to find some AJAX calls
> in the web console but cant trace any. I'm a bit confused here.
> 
> Any help will be very much appreciated.

The 'incremental_blame' view should produce the same output as ordinary
'blame' view, but in different way (using JavaScript and Ajax, and
"git blame --incremental").

With the ordinary 'blame' view we have to wait for the blame data to be
generated in full for the whole file (on server) before we get the view.
This can take quite a while (and that is why 'blame' feature is disabled
by default).

The Ajax-y 'incremental_blame' view gets the contents of the file from
"git cat-file blob <blob-id>" and shows it to web browser, then adds
blame view incrementally, from the most recent blame to most ancient,
calling "git blame --incremental" and getting its response via XHR,
and repainting contents of file with blame data.


You can run gitweb by yourself, for example using git-instaweb script
(I think it enables all features by default).

HTH
-- 
Jakub Narebski
Poland
