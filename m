From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: windows problems summary
Date: Thu, 2 Mar 2006 15:49:24 +0100
Message-ID: <81b0412b0603020649u99a2035i3b8adde8ddce9410@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Mar 02 15:49:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEp7T-0001XU-JI
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 15:49:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbWCBOt2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 09:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbWCBOt2
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 09:49:28 -0500
Received: from nproxy.gmail.com ([64.233.182.194]:11490 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751294AbWCBOt2 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Mar 2006 09:49:28 -0500
Received: by nproxy.gmail.com with SMTP id x30so293189nfb
        for <git@vger.kernel.org>; Thu, 02 Mar 2006 06:49:24 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=joVZWMp8uWZlUw5HDSv1WeD4ULiwDLA+95IB7kBwFks2bE4bi5CaB13sOHFBjdz8osWjONDbPbQNB4OoSN36HX8LvBznkzylx6qtxjv/S/YpgpnTkYih49qGdaNSvuLnB+O2B99XQsOdpU9nfQ0E2/Ju1Hi9wnWBj5f/eS5ORcI=
Received: by 10.48.225.15 with SMTP id x15mr666637nfg;
        Thu, 02 Mar 2006 06:49:24 -0800 (PST)
Received: by 10.49.88.16 with HTTP; Thu, 2 Mar 2006 06:49:24 -0800 (PST)
To: "Git Mailing List" <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17074>

This is just to summarize all the problems which make porting to that
thing so boring. Maybe if we have them all on one page, it'd be easier
to locate the workarounds (it can be one thread, for example).

1. opened and mmaped files can't be removed or renamed
  (caused workaround with reading index in memory)
2. command can safely contain only one argument
  (breaks and complicates passing things between processes)
3. no fork
  (slows down and complicates passing things between processes)
4. non-unix permissions model
  (breaks x-attr)
5. real slow filesystems and caching
  (makes everything slow. I noticed I'm trying to avoid git status!).
  Caused workaround with manual checkout)
6. real slow program startup
  (makes everything slow, eventually may cause everything being put
  in one super-executable, just to avoid spawning new processes,
  with all associated problems. Makes scripting harder)

I hope this message can be a start of a big porting thread,
even though it is only about windows at the moment.

Alex Riesen
