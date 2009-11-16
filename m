From: Ian Hobson <ian@ianhobson.co.uk>
Subject: Advice/help needed
Date: Mon, 16 Nov 2009 16:27:35 +0000
Message-ID: <4B017D77.6060505@ianhobson.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 16 17:27:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NA4Qf-0005rU-Su
	for gcvg-git-2@lo.gmane.org; Mon, 16 Nov 2009 17:27:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752524AbZKPQ1i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2009 11:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752285AbZKPQ1i
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 11:27:38 -0500
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:19069 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751827AbZKPQ1h (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Nov 2009 11:27:37 -0500
Received: from aamtaout02-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout03-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20091116162734.NKJP17277.mtaout03-winn.ispmail.ntl.com@aamtaout02-winn.ispmail.ntl.com>
          for <git@vger.kernel.org>; Mon, 16 Nov 2009 16:27:34 +0000
Received: from jupiter.ianhobson.co.uk ([86.12.69.89])
          by aamtaout02-winn.ispmail.ntl.com
          (InterMail vG.2.02.00.01 201-2161-120-102-20060912) with ESMTP
          id <20091116162734.QNNM21638.aamtaout02-winn.ispmail.ntl.com@jupiter.ianhobson.co.uk>
          for <git@vger.kernel.org>; Mon, 16 Nov 2009 16:27:34 +0000
Received: (qmail 8947 invoked by uid 453); 16 Nov 2009 16:27:32 -0000
X-Virus-Checked: Checked by ClamAV on ianhobson.co.uk
Received: from bobgriffiths.leda.hcs (HELO [192.168.0.12]) (192.168.0.12)
    by ianhobson.co.uk (qpsmtpd/0.40) with ESMTP; Mon, 16 Nov 2009 16:27:32 +0000
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
X-Cloudmark-Analysis: v=1.0 c=1 a=RSyqUlKGgLE1rDCvk3MA:9 a=6aQn318UP8BW6rACUIYA:7 a=BTgng9JRT6wIwVoYLXUjdqS2CgYA:4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133015>

Hi all,

I am trying to switch to GIT (from SVN), and have become sorely 
confused. I am not sure of the best way to solve the problem I have, 
(nor how to actually implement a solution when one is chosen).

I am building a web application in php. There are  2 (soon to be four) 
versions each slightly different for different customers. Each needs 
testing when installed in "/" and "/dir" on the web site.

So far I have one system that in installed in a git repo on a Linux VM 
with a share. This way I can develop in windows where I am familiar, 
serve the files under linux (to match the production environment) and 
run unit tests using phpUnit. The test files are all in a sub-directory 
of the main directory. The application is served from a directory in the 
website, so I could have different directories for different purposes, 
but I have not had to use this yet.

Before release, I fetch and merge the files into a second installation 
under windows, where I can serve it from the root. This forms a second 
level of test. I release by copying the files with FTP (so that test 
files and the GIT repo don't go on the production server).

This arrangement only works because I have been able to set up the 
configuration files, database users and similar so they are all the same 
on each installation. With 4 similar versions this will no longer be 
possible.

What I want to be able to do is control all 4 versions in the same 
manner, keep all file - common, different and test - in git, and have 
checkout worry about changing versions.

My thoughts are to have 4 branches, one for each customer. 99% of all 
changes will be needed by all (or at least most)
of the customers (P,W,S and E). How can I make a change to master and 
then use git to apply those changes to the four branches, without losing 
the differences between branches?

For example (if this is the best way) go from this
O-----O-----A-----B-----C  (master)
  \----P
   \---W
    \--S
     \-E

to first this, where D is the net effect of A B and C  (this is for ease 
of reading logs, and commit messages),
O-----O-----D  (head) 
  \----P
   \---W
    \--S
     \-E

and then to this, (without editing all the files four times?)
O-----O-----D  (head)
  \----P-----D'
   \---W----D''
    \--S-----D'''
     \-E-----D''''

Or would I be better having 4 repositories, one for each customer? Then 
I need to pull changes and cherry pick the changes I want for each 
customer?

I am the only developer, so the processes need to be simple so I am not 
faced with sorting out my own errors! :)

Regards

Ian
