From: Jakub Narebski <jnareb@gmail.com>
Subject: Gitweb CSS cleanup: container divs
Date: Fri, 27 Apr 2007 16:48:24 +0200
Message-ID: <200704271648.24963.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 27 16:46:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhRil-0003rt-Az
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 16:46:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755904AbXD0Oqh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 10:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755914AbXD0Oqg
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 10:46:36 -0400
Received: from wx-out-0506.google.com ([66.249.82.224]:5937 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755915AbXD0Oqe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 10:46:34 -0400
Received: by wx-out-0506.google.com with SMTP id h31so924476wxd
        for <git@vger.kernel.org>; Fri, 27 Apr 2007 07:46:29 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=QThPwMiowJkrU791B4R4ylzt25CwBKUx+dtrKmx85ra0HfwJ2i2frCE/73PGmYYkJcZnbbOa4RT+X4a4/C03p/0DXDZCDl3mX/4fGyHOzWFqIjzaeZYKRDIf24Kqe1nfZVt7wAaDGKVa94oI9dQX5N1BHdqxe+NbJeHHT35XGJY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=CJkZ33HEMLtEukokUIQ3vdJ5yE04l7lb8DXFcbuK1uaNIU+MJJKVuy4QnHiAqAkzr7O+IsqaiF6Lfvl5Q2rLd34wHpnAoR7Ui6JyMRkfAWa12XA4AhjGUxNCGtoJFWhwXmC4nIDjug+aoYCZJ34pX4OTxeIhDgOUe8TtNV5AMj0=
Received: by 10.90.25.3 with SMTP id 3mr3462757agy.1177685189050;
        Fri, 27 Apr 2007 07:46:29 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id x26sm5589638ugc.2007.04.27.07.46.27;
        Fri, 27 Apr 2007 07:46:27 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45720>

Current gitweb style is that bottom-level elements (elements which 
contain some contents) have 8px padding, and each of element has 
"padding: 8px" in CSS separately.

There exists few container divs, i.e. divs which have only other divs
as contents, and no unwrapped text element. Examples incude "page_body", 
"patchset", "patch" divs.

Because container divs (usually) should not have any padding, it is not 
possible to simplify CSS by using 8px for all divs, with some 
exceptions.

This situation causes that sometimes padding is not added, like for 
projects README on project summary page ("summary" view), and sometimes 
unnecessary padding is added causing excessive spacing or wrong style, 
like for "commitdiff" view. It would be nice to have CSS streamlined 
(cleaned up / refactored) to avoid such errors in gitweb styling, minor 
they are.

There are few possible solutions:

1. Get rid of all container divs, or all except toplevel container divs,
   and make "padding: 4px" default style for all divs. This migh make
   styling harder, and make us to add unnecessary classes for styling,
   where the fact that some element is in some (container) div would be
   enough otherwise for selecting element for styling (class-itis).

2. Current solution, i.e. add "padding: 4px" for each 'contents' div,
   and set "padding: 0px" for each 'container' div if needed.  Error
   prone.

3. Set either "contents" class for each 'contents' div (similar to
   current solution, error prone when adding new contents), or
   "container" class for each 'container' div (bit less error prone,
   as adding containers should be more rare than adding contents divs)

4. Enumerate 'container' div in CSS, set default padding as for
   'contents' div.

I opt for solution 4., together with perhaps restucturing gitweb.css
-- 
Jakub Narebski
Poland
