From: Ben Armstrong <BArmstrong@dymaxion.ca>
Subject: Re: jgit standalone client on OpenVMS works (somewhat)
Date: Mon, 4 May 2009 09:42:55 -0300
Message-ID: <3f1ae6620905040542t4713777ay3ab00499906df112@mail.gmail.com>
References: <3f1ae6620904300839n48e88143y2ae1694472f712a4@mail.gmail.com>
	 <200905031715.22085.robin.rosenberg.lists@dewire.com>
	 <49FEE276.8010508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 04 14:43:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0xVo-00049j-Dv
	for gcvg-git-2@gmane.org; Mon, 04 May 2009 14:43:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755073AbZEDMm7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2009 08:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754165AbZEDMm7
	(ORCPT <rfc822;git-outgoing>); Mon, 4 May 2009 08:42:59 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:52752 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753954AbZEDMm6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2009 08:42:58 -0400
Received: by fxm2 with SMTP id 2so3710984fxm.37
        for <git@vger.kernel.org>; Mon, 04 May 2009 05:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=IHqQCTrchdwAMBunk+waD0FizGiK/1ks40hvKWJB0Wc=;
        b=IPhaKJgT3JnUgQ3P/27mY6dWR8gmzTI+CN7USa2vDE6eQ4GLKUvVtrv23/tDKvqK9G
         pc0tfzQVRdZJiuAacwYL5Fh3rybxGzw794Avh1P+WZNhPtMhPiEbLOQJnMUouAzLStxT
         otBPOygJcfVnyKlv7lBpV88vKU/yWlyGygRnE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=LtdW9tx5RY1rYU4NIhj1Jge2iIXx4s5A8Ab0zV3IEdTc0DknMROooY+fhfWkeiKKWW
         Gz1vxhR19ppHA2MhRnNFq3d/NK3BaAUAyxl/dNNyInDeKEOP0pG+NW679qwH0atGjn7T
         vZNJu/MmotRD0S+e0K4J+ZmnxN7+cG7xsxxR4=
Received: by 10.204.118.12 with SMTP id t12mr5679407bkq.158.1241440975896; 
	Mon, 04 May 2009 05:42:55 -0700 (PDT)
In-Reply-To: <49FEE276.8010508@gmail.com>
X-Google-Sender-Auth: d48d6285a073b610
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118228>

Robin Rosenberg wrote:
> Not sure what to say here.. cool. I never even thought of VMS as a Java platform.
>

Apparently HP is working on (or has already produced -- I haven't yet
checked) Java 6 for VMS/Itanium, but since we're still on VMS/Alpha,
we have to make do with Java 5.  I don't think they have any plans for
Java 6 for this platform.

> After googling a little, I think you got JAVA$FILENAME_CONTROLS wrong.
> 8 is for basic unix filenames. But you also need %x00200000 (or possibly
> %x00100000) as well. See
> http://h18012.www1.hp.com/java/documentation/1.5.0/ivms/docs/user_guide.html#unix_style
>
> That's my guess....  I wouldn't dare to tell you how to get the exact syntax right, My VMS skillz are not what they once were.
>

Great tip.  Yes, using -1 fixes the tag problem:

A:BG.WORK> dir [.egit._git.refs.tags]

Directory DSA0:[BG.WORK.egit._git.refs.tags]

v0.2;1              v0_1.1;1            v0_2.1;1            v0_2.2;1
       v0_2_99.200709172321;1                  v0_3.0;1
v0_3.1;1          v0_4.0;1
This has also turned dots in filenames into underscores.  Hmm.  I'll
file this away for whenever I return to this project.  It's certainly
easier on the eyes than "^.", but I don't know if it has negative
repercussions for other applications.  I'll have to review the doc and
choose carefully the options that we want to use.

> Come to think of it, the first VMS machine I used was named "Linus", named
> after a widely known character (in a comic strip called Snoopy). </anecdotes>
>

:)

Thanks,
Ben
