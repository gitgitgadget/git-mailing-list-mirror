From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH v3 23/23] Added the test class AddCommandIterationTest.
Date: Fri, 6 Jun 2008 02:23:12 +0200
Message-ID: <200806060223.13052.robin.rosenberg.lists@dewire.com>
References: <1211574872-23676-1-git-send-email-florianskarten@web.de> <1211574872-23676-24-git-send-email-florianskarten@web.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Florian Koeberle <florianskarten@web.de>
X-From: git-owner@vger.kernel.org Fri Jun 06 02:27:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4PnV-0001g6-MG
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 02:27:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754688AbYFFA0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 20:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754618AbYFFA0K
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 20:26:10 -0400
Received: from [83.140.172.130] ([83.140.172.130]:18882 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754436AbYFFA0D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 20:26:03 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 8B48A1434DD6;
	Fri,  6 Jun 2008 02:26:01 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VrnCBOv8-l4r; Fri,  6 Jun 2008 02:26:00 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id CF62C1434DCE;
	Fri,  6 Jun 2008 02:26:00 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1211574872-23676-24-git-send-email-florianskarten@web.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84008>

> diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/rules/AddCommandIterationTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/rules/AddCommandIterationTest.java
> +	@Override
> +	protected void setUp() throws Exception {
> +		final File projectDirectory = File.createTempFile("test", "");
> +		projectDirectory.delete();
> +		projectDirectory.mkdir();
> +		projectDirectory.deleteOnExit();
> +		this.workTree = Repository.createWorkTree(projectDirectory);
> +		this.factory = new AddRulesFactory();
> +	}

I've had some problems with this pattern, especially on Windows. We need
some support class, like the RepositoryTestCase to handle the not so nice
parts of getting tests to run, rerun and cleam up after themselves. Eclipse
sometims adds an extra twist becuase File may be lefte open between test
runs, which is the reason RepositoryTestCase uses a new directories every time.

Does this work at all? delete() requires directories to be empty in order to delete.

-- robin
