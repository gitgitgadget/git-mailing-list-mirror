From: "Dana How" <danahow@gmail.com>
Subject: [RFC] Default options
Date: Wed, 9 May 2007 15:15:15 -0700
Message-ID: <56b7f5510705091515l7c7090b9rd5599e8746642ef9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <junkio@cox.net>, danahow@gmail.com
X-From: git-owner@vger.kernel.org Thu May 10 00:15:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HluRO-0000qx-Vo
	for gcvg-git@gmane.org; Thu, 10 May 2007 00:15:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755124AbXEIWPR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 18:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754117AbXEIWPR
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 18:15:17 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:61370 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755931AbXEIWPQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 18:15:16 -0400
Received: by wr-out-0506.google.com with SMTP id 76so402995wra
        for <git@vger.kernel.org>; Wed, 09 May 2007 15:15:15 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=istqT1fSwOgIeqmhsuSPziBIvm4TobEZfPGRbwP5n3j2DVWT/N9pGwcHn/HbC1QbFJRUKmgcKA2E/CGSKdAz+cX1pCRcJ/hxoJ+A90GyN8zDkSbI4qiue34hmog2dzvo1T1LhXgAYHNk7/dm72qh/G+PqQjhYZpBxbzvwrrt22A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=BqtiXUxxcN+7/iNvH7f4DD/2DIKVIaFw3rG6U+w8nMrnWMKUCiaCB211DqBsHr/C5Bx+Qsu2gRrItkYYyDDj4RY4ZC69tTiKaDsPPhe5vh3LJR2lnSjuqmOOKbiNohIQJMZB4uQaUCsJjujyqC/ySgc4MUUxyvWqNFseimi6z+U=
Received: by 10.114.95.1 with SMTP id s1mr288477wab.1178748915323;
        Wed, 09 May 2007 15:15:15 -0700 (PDT)
Received: by 10.115.58.7 with HTTP; Wed, 9 May 2007 15:15:14 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46798>

Reading the exchange about new options to e.g.
git gc and git pack-objects over the last few days,
a pattern seemed to emerge.  A new option would be
proposed,  but then we didn't always want to type it,
so a corresponding config variable would be added as well.

I notice git supports "alias.*" config variables.
Would it be useful to also support "options.*" variables?
When you type
    git gc <args>
this is interpreted as
    git gc $(git config options.gc) <args>
so anything in options.gc could be overridden
by later appearing on the command line.
The names might have dashes:
pack-objects would use options.pack-objects .

If a command is recognized using alias.*,
options.* would not be consulted (to keep things simple).
In other words, options.* only work for built-ins.
options.* would interpret quoting etc in its
value the same way alias.* does.

Thus,  you can add a new --option to a program,
and get a corresponding config variable automatically,
and without cluttering up the documentation.

I've not yet looked at the git driver code.
Is there any interest in this feature?

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
