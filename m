From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Change "refs/" references to symbolic constants
Date: Tue, 20 Feb 2007 13:26:44 +0000
Message-ID: <200702201326.46015.andyparkins@gmail.com>
References: <200702191839.05784.andyparkins@gmail.com> <200702201057.21398.andyparkins@gmail.com> <Pine.LNX.4.63.0702201235350.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 20 14:27:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJV1G-0000mq-KQ
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 14:26:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964871AbXBTN0z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Feb 2007 08:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964879AbXBTN0z
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 08:26:55 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:45848 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964871AbXBTN0y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 08:26:54 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2738010nfa
        for <git@vger.kernel.org>; Tue, 20 Feb 2007 05:26:53 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=H6LrbV/aonlOX1uGl6kT/D3I++vP3eoI/COqNtFgu7Hc/cxLpG4nY8ZzGLkml+G2XKO3H0d58/Hes/qoS+ZUfvL1lcCYtO9N/8Dexr7A9m6ZfCKjkn7c70+u7XkFLFHJxMx8IQByEjdESuNkKztod3H/NHL+ur+EieNegkYEPI8=
Received: by 10.82.114.3 with SMTP id m3mr13116894buc.1171978013176;
        Tue, 20 Feb 2007 05:26:53 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id m16sm30714470nfc.2007.02.20.05.26.50;
        Tue, 20 Feb 2007 05:26:51 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.63.0702201235350.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40238>

On Tuesday 2007 February 20 11:37, Johannes Schindelin wrote:

> Actually, it's not even ternary, but to the return value should only be
> handled in terms of >0, ==0, <0.

Apologies, I'm not using ternary in the sense of the number 0, 1 and 2; I'm 
using it in the sense of there being three possible outcomes - which there 
are.  This is similar to how operators are categorised into unary, binary and 
ternary categories.  I use ternary to mean "having three states or elements", 
rather than "having the value 0, 1 or 2".

> Ah, and if "!" implies a boolean, then why is "!!" a common construct?
> Because "!" really does not imply a boolean.

Boolean expressions are those that have two possible states - "true" 
or "false".  There are no real booleans in C, so they are faked.  The two 
boolean states in C are represented by

 False = Equal to zero
 True = Not equal to zero

Now, the !! construction you suggest is perfectly in keeping with this 
definition.  Ironically, the only reason you need the !! construction is 
because of this integer-as-boolean trait of C.

So, to get a boolean in C you use a standard integer (say).  My contention is 
that to improve clarity you should not mix integer-as-boolean and 
integer-as-integer, even though C will accept it when you do.

 i = 10;
 while( i )
   i--;

This is bad, it abuses the fact that C will let you treat an integer as a 
boolean.  while() takes a boolean expression as it's argument, so I think 
that you should always hand it something that would be a boolean output (even 
though C doesn't care if you don't).

 i = 10;
 while( i > 0 )
  i--;

This makes it clear to the reader that i is not boolean.  Obviously this is a 
trivial example; no one would have any trouble understanding either of the 
two examples.  When things start to get bigger and more complicated though, 
more clarity is always better than less clarity.  The principle I try to 
follow is that code is write-once-read-many.  If you save yourself two 
keystrokes at the expense of the clarity you gain for the 100 times you read 
that code, then you have made a false economy.

In the end - I don't care - I was only countering Junio's "I prefer !strcmp", 
with my reasons why I don't like it.  I do not expect git to change to my 
preferred coding style, and I do try to keep to the coding style that the git 
project uses.  To my mind, inconsistency is a worse offence than anything 
else in a project, so it's always better to go with what is established.



Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
