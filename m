From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 1/2] sh-setup: Write a new require_clean_work_tree
 function
Date: Fri, 1 Oct 2010 12:51:51 +0530
Message-ID: <20101001072149.GA24171@kytes>
References: <1285877017-8060-1-git-send-email-artagnon@gmail.com>
 <1285877017-8060-2-git-send-email-artagnon@gmail.com>
 <7v4od7hsqt.fsf@alter.siamese.dyndns.org>
 <20101001045713.GE20098@kytes>
 <20101001053721.GB6184@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 01 09:23:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1ZxR-00079J-N2
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 09:23:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751672Ab0JAHW7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Oct 2010 03:22:59 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:59202 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248Ab0JAHW6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Oct 2010 03:22:58 -0400
Received: by pzk34 with SMTP id 34so694465pzk.19
        for <git@vger.kernel.org>; Fri, 01 Oct 2010 00:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ZUy6JTIySj/gweFJyZCuQTcGrBswn9mCFfn8dcVpxpE=;
        b=VYfhnrELHjtpy1QynHr73Y32MS9mQ6069LSFWbNiQVgRMyv4l3F+wJhk0oGfjaiIG3
         YAVi1KOipcF3YPLUJDX3dLR94OF+MdpY0EPHcVSnCduM+3j7Uwuo3N7yk4AmiYgzd0IE
         2ekK4Zsza++v3JQ3jv3uz5QjTd4q10vc1bNzI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=yFsR6X8cgYmwhpsOLoh+Hpm5tb2joucSf014RLtAJAODkUuZ7EWm3b+M8emVrlvtEU
         G8BUHyU0AUucY3EBkmFMd4/ci9QVxpB+AALQ7w7kkez8u8uksskRCPyO/927kmiLstiX
         889g1QFnA0vgXbbHRqYw5NIdStansVR3r+9Zw=
Received: by 10.142.207.7 with SMTP id e7mr4376817wfg.112.1285917778186;
        Fri, 01 Oct 2010 00:22:58 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id 9sm892105wfd.12.2010.10.01.00.22.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 01 Oct 2010 00:22:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101001053721.GB6184@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157735>

Hi Jonathan,

Jonathan Nieder writes:
> Some noise about Cc and Reviewed-by tags:
> 
>  - I have been using Cc lines in patches to say "I consider this
>    person something of a maintainer of the subsystem in question
>    and would be particularly interested in his or her opinion."
>    The idea is that if the patch does not get acked and a Cc line
>    remains, people can tell that from the log.  The benefits:
> 
>     1) I remember to cc them
>     2) later it is easy to find who looks like a maintainer
>     3) the lack of ack is more obvious
> 
>    Checking Linux's Documentation/SubmittingPatches, I find that
>    that is a misuse on my part (sorry).  A person passing on a patch
>    to Linus is rather supposed to _add_ a Cc line in the rare event
>    that they want to explain that a certain person had an opportunity
>    to comment but did not comment (so Linus can know about their
>    indifference to the patch, I guess).
> 
>    Neither use is as important for git, where many people read the
>    list so it is not as important to cc people to get proper review.
> 
>  - I also used to abuse Cc lines to fit in contact information for a
>    person who helped me, until I learned to use Helped-by and similar
>    neologisms for that.  Sorry.
> 
>  - Again from Documentation/SubmittingPatches, I learned a while ago
>    that Reviewed-by, unlike Acked-by, can only be offered by the
>    reviewer and means that she is satisfied that the patch is ready
>    for application.
> 
> If you just want to credit Matthieu, I suppose it would make sense to
> say "Thanks to Matthieu Moy for such-and-such" somewhere.

Thanks for the lengthy explanation. Perhaps we can document this in
Git's SubmittingPatches?

Are all these tags useful? Should I include more such as "Mentored-by"
or explicity mention that the contributor is free to come up with
other freeform tags as she deems appropriate?

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
-- 8< --
diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index ece3c77..84c9eaa 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -264,12 +264,25 @@ the change to its true author (see (2) above).
 Also notice that a real name is used in the Signed-off-by: line. Please
 don't hide your real name.
 
-Some people also put extra tags at the end.
-
-"Acked-by:" says that the patch was reviewed by the person who
-is more familiar with the issues and the area the patch attempts
-to modify.  "Tested-by:" says the patch was tested by the person
-and found to have the desired effect.
+Some extra tags you can use in the end along with their meanings are:
+
+1. "Reported-by:" is used to to credit someone who found the bug that
+   the patch attempts to fix.
+2. "Acked-by:" says that the patch was acknowledged by the person who
+   is more familiar with the issues and the area the patch attempts to
+   modify.
+3. "Reviewed-by:", unlike the other tags, can only be offered by the
+   reviewer and means that she is completely satisfied that the patch
+   is ready for application.  It is usually offered only after a
+   detailed review.
+4. "Tested-by:" is used to indicate that the person applied the patch
+   and found it to have the desired effect.
+5. "Thanks-to:" is a more broad term used to credit someone who helped
+   with the patch in some way. The person perhaps gave an idea or
+   reviewed some part of the patch without awarding a "Reviewed-by".
+6. "Based-on-patch-by:" is used to credit the person whose patch yours
+   is based on. The original patch was probably not considered for
+   inclusion due to several reasons.
 
 ------------------------------------------------
 An ideal patch flow
