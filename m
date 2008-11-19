From: Gary Yang <garyyang6@yahoo.com>
Subject: Recommended steps for a "subsystem maintainer" ?
Date: Wed, 19 Nov 2008 12:47:01 -0800 (PST)
Message-ID: <643392.36561.qm@web37903.mail.mud.yahoo.com>
Reply-To: garyyang6@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 19 21:48:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2tyH-00019e-A1
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 21:48:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752844AbYKSUrF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 15:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752589AbYKSUrE
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 15:47:04 -0500
Received: from web37903.mail.mud.yahoo.com ([209.191.91.165]:23117 "HELO
	web37903.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752059AbYKSUrD (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Nov 2008 15:47:03 -0500
Received: (qmail 36883 invoked by uid 60001); 19 Nov 2008 20:47:01 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Message-ID;
  b=AeX8wxlU6As6lSWSJlzqLpaHtRXz8/xfypVyfb0TzWBYXBSjIqjUBBf04ZO5YWeXVYP5KAbWpXd8BSv+P+hvnqt2igkRsXKECMl755oDhv5hgmzDjVHT5Hfj9qLtDTVLyinCRM+yn9P9h7iNLH/hpCUO8UYkAHt5HQ3QMX6tGo8=;
X-YMail-OSG: e.ZKTaIVM1lDRINfZdcKVunY1KO7TEjWYQBtN_H1EmEhDfjsqwVv7zVLoGwLnW7KnD_cZAAIVCa9os9weSitypQ5Ebr59dDN1.8DQGIg6YQTee4LqE78q4Cj41Rxk7NNy.pgSQJd3h1J.d8MdPrY8bdTetTW.rTYeqcqCcxYN8HQpMy5bkhSazylcIRv
Received: from [76.195.33.70] by web37903.mail.mud.yahoo.com via HTTP; Wed, 19 Nov 2008 12:47:01 PST
X-Mailer: YahooMailWebService/0.7.260.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101375>

Hi,

The doc,http://www.kernel.org/pub/software/scm/git/docs/gitcore-tutorial.html at "Working with Others" recommended steps for a "subsystem maintainer".
See below. But, I do not understand the step 3. Copy over the packed files from "project lead" public repository to your public repository.
The step 1 used git-clone. That means, I got the code including histories as well. Why do I need step 3 to get the packed files?
If I really need the packed files, how do I get it? As an example, I need to get the packed files for http://git.denx.de/?p=u-boot.git;a=summary .
How can I get the files something like, pack-d5ef1966072c86ef5108ac57525b802581de5d21.idx and pack-d5ef1966072c86ef5108ac57525b802581de5d21.pack ?
The snapshot dose not have the packed files. They are all text files.


A recommended work cycle for a "subsystem maintainer" who works on that project and has an own "public repository" goes like this:

1. Prepare your work repository, by git-clone the public repository of the "project lead". The URL used for the initial cloning 
   is stored in the remote.origin.url configuration variable. 

2. Prepare a public repository accessible to others, just like the "project lead" person does. 

3. Copy over the packed files from "project lead" public repository to your public repository, unless the "project lead" repository lives on the same machine as yours. In the latter case, you can use objects/info/alternates file to point at the repository you are borrowing from. 

4. Push into the public repository from your primary repository. Run git-repack, and possibly git-prune if the transport used for pulling from your repository supports packed repositories. 

5. Keep working in your primary repository. Your changes include modifications of your own, patches you receive via e-mails, and merges resulting from pulling the "public" repositories of your "project lead" and possibly your "sub-subsystem maintainers". 

   You can repack this private repository whenever you feel like.

6. Push your changes to your public repository, and ask your "project lead" and possibly your "sub-subsystem maintainers" to pull from it. 

7. Every once in a while, git-repack the public repository. Go back to step 5. and continue working. 



Thank you,


Gary





      
