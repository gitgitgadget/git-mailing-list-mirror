From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [idea] Converting sha1 evaluator into parser/interpreter
Date: Sun, 21 May 2006 10:06:45 +0200
Organization: At home
Message-ID: <e4p71u$t0s$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun May 21 10:06:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fhixa-0005TZ-EV
	for gcvg-git@gmane.org; Sun, 21 May 2006 10:06:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964847AbWEUIGn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 May 2006 04:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751501AbWEUIGm
	(ORCPT <rfc822;git-outgoing>); Sun, 21 May 2006 04:06:42 -0400
Received: from main.gmane.org ([80.91.229.2]:50339 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751503AbWEUIGl (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 May 2006 04:06:41 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FhixQ-0005Sx-4u
	for git@vger.kernel.org; Sun, 21 May 2006 10:06:36 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 21 May 2006 10:06:36 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 21 May 2006 10:06:36 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20435>

Shawn Pearce wrote:

> There was just a short conversation on #git about converting
> the sha1 expression evaluator into a split parser/interpreter
> model.  The idea here would be to convert an expression such as
> 
>   HEAD@{yesterday}~3^{tree}
> 
> into a an expression tree such as (in LISP style):
> 
>   (peel-onion (walk-back 3 (date-spec yesterday (ref HEAD))))

Rather

    (peel-onion 'tree (walk-back 3 (date-spec yesterday (ref HEAD))))
 
> with such a tree it is relatively easy to evaluate the expression,
> but its also easy to determine if a ref name is valid.  Just pass
> it through the parser and see if you get back anything more complex
> then '(ref <input>)'.

Didn't you meant to see if we get correct tree (not a forest), 
and if the root of said tree is '(ref <commit-ish>)' [1]?

Interpreting said parse tree anch checking if it folds to correct object
reference is the task of interpreter, not parser...


[*1*] if I understand currectly that <commit-ish> mean direct sha1,
shortened sha1, or ref (head or tag)? commit-ish is not in 
git glossary...

-- 
Jakub Narebski
Warsaw, Poland
