From: HeX <hex.imexil@googlemail.com>
Subject: egit/jgit: Upate Index (refresh) causes NullPointerException for
 "external" projects
Date: Wed, 15 Apr 2009 10:40:23 +0200
Message-ID: <49E59D77.2040303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 15 10:42:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lu0gz-0002sX-2C
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 10:42:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752836AbZDOIk2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2009 04:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752730AbZDOIk2
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 04:40:28 -0400
Received: from fk-out-0910.google.com ([209.85.128.187]:52588 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752600AbZDOIk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2009 04:40:27 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1284074fkq.5
        for <git@vger.kernel.org>; Wed, 15 Apr 2009 01:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:x-enigmail-version:openpgp
         :content-type:content-transfer-encoding;
        bh=Y845UG7vgerJd1wvPKvrbjT06wRs2Zjbh0MS+/iYOQE=;
        b=gBCwaU5cctAFK4s+foct46KWJXqrEtzkhgFr9TTXnPargsFNlAZUISUSpxtNdiip+i
         L6XbDkLWtGXnFcn8ELXmq8Y80g+1ZIT/yK+z1PdQOHR0feenqVwjLAw2w+qcqSSyL7zV
         NZT9uwaqn7PHxrOeK9iz/HnJsYCNpfkJddJbk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :x-enigmail-version:openpgp:content-type:content-transfer-encoding;
        b=Bq7RC0oG3mr2Sv1TF8JDYhSAsFYM/xdrLg6S77VECTDxqRaE4YJhn2v0xJn8AhJzEr
         YRUQdhSidLMwA7k5d+i1YPkKrBuqjIC0blCcWa0Ulvzeba4xLZky6x3AXq2x6fNbhoRT
         JQb6rtgR0jJ2DNplvaa1uV+QDX4G7elndDFvM=
Received: by 10.204.123.136 with SMTP id p8mr2061918bkr.21.1239784825057;
        Wed, 15 Apr 2009 01:40:25 -0700 (PDT)
Received: from ?130.149.48.144? (kallisto.emsp.TU-Berlin.DE [130.149.48.144])
        by mx.google.com with ESMTPS id 8sm4705739fxm.11.2009.04.15.01.40.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 15 Apr 2009 01:40:24 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.21) Gecko/20090318 Thunderbird/2.0.0.21 Mnenhy/0.7.5.0
X-Enigmail-Version: 0.95.7
OpenPGP: id=769F2461
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116599>

Hi,

I think I found a bug in egit/jgit and can pin it down to "external"
projects, i.e., projects which reside in different directories than the
default workspace location.

Steps to reproduce:
 1. In Eclipse create a new project "foo" in an external location
(outside the default workspace location), say ~/bar/
 2. execute "git init" in that dir
 3. share project with git
 4. do a "Update Index (refresh)" operation and you'll get something
similar to


>Counted 168 items to update in 0.0s
java.lang.NullPointerException
	at org.spearce.egit.core.internal.UpdateJob.run(UpdateJob.java:91)
	at org.eclipse.core.internal.jobs.Worker.run(Worker.java:55)

All other git operations will also fail. However it will work if you
create project which is created in the default workspace and which
content is simply symlinked.

/HeX
