From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Fix mishandling of $Id$ expanded in the repository copy in convert.c
Date: Sun, 27 May 2007 11:50:48 +0100
Message-ID: <200705271150.50147.andyparkins@gmail.com>
References: <200705251150.09439.andyparkins@gmail.com> <200705261012.50530.andyparkins@gmail.com> <7vveefiex4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 27 12:51:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsGLR-0005OU-FT
	for gcvg-git@gmane.org; Sun, 27 May 2007 12:51:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbXE0KvX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 06:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751542AbXE0KvX
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 06:51:23 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:59133 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751325AbXE0KvW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 06:51:22 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1427348ugf
        for <git@vger.kernel.org>; Sun, 27 May 2007 03:51:21 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=NRgQNhi7Kyzdhyj3bJ+Tant1s5KmFo1jTG7uF646e7S8OItJ5sgl5oe5a3hnp9cfW9PLs+TKJqb6NupgRbSvZymZP2s/HIvvi6qwVeiWgTvOFQBcGD6WNatdF/EfioKgdKRR2nuZ/o8CEJ49UHf1VaQYl8JKp0nuQRyng6uMuI8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ALhkAStZb3k8nOQEjjHT5Mj1t/l9sfkXWWtftP2TKW/5mBemDehedKre/R/j0Yn7HQvkoUEGBK5jIQ+1poxpnEOqX/dSLst4hr4iekY0JcHInqTcykfO+B1cmwmDenH4N5mfpTK1zmHhGz/PDH1Opa82PBZ6qQEb80IeJ3J37fY=
Received: by 10.67.92.1 with SMTP id u1mr4420694ugl.1180263080783;
        Sun, 27 May 2007 03:51:20 -0700 (PDT)
Received: from grissom.local ( [84.201.153.164])
        by mx.google.com with ESMTP id 54sm11213949ugp.2007.05.27.03.51.19;
        Sun, 27 May 2007 03:51:19 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <7vveefiex4.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48529>

On Saturday 2007, May 26, Junio C Hamano wrote:

> Wouldn't it be sufficient to:
>
>  (1) prepare a file with "$Id$", use ident in .gitattributes,
>      check it in and commit;
>
>  (2) remove it from the working tree, check it out with
>      "checkout -f";
>
>  (3) temorarily move away .gitattributes, modify the file, and
>      check it in;
>
>  (4) move .gitattributes back into its place, and commit.

I'm glad to have you confirm that.  I wasn't sure if git would do 
something clever and reading the .gitattributes from the same commit as 
the file for which is being checked out.

If the above would work, then even simpler:

 (1) Commit a file with $Id: blah blah blah $ in it.
 (2) Add a .gitattributes with ident
 (3) Check out.

Patch to follow.


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
