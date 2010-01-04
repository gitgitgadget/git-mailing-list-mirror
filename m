From: Bill Lear <rael@zopyra.com>
Subject: RE: Beginner's question on how to use git for multiple parallel versions
Date: Mon, 4 Jan 2010 09:44:13 -0600
Message-ID: <19266.3277.221519.791489@blake.zopyra.com>
References: <F8CC469C9CCA415696101414EA997C0.MAI@sohosted19.com>
	<19265.60728.17437.665860@blake.zopyra.com>
	<22D57EF90F8E4A2799F739FC14F8BA63@Duthler.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "Christian C. Schouten" <info@zark3.net>
X-From: git-owner@vger.kernel.org Mon Jan 04 16:44:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRp6W-0002iA-CC
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jan 2010 16:44:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753371Ab0ADPoV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2010 10:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753466Ab0ADPoV
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 10:44:21 -0500
Received: from 75-27-130-60.lightspeed.austtx.sbcglobal.net ([75.27.130.60]:33496
	"HELO blake.zopyra.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1752524Ab0ADPoT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2010 10:44:19 -0500
Received: (qmail 8915 invoked by uid 500); 4 Jan 2010 15:44:18 -0000
In-Reply-To: <22D57EF90F8E4A2799F739FC14F8BA63@Duthler.local>
X-Mailer: VM 8.1.0-beta under 23.1.1 (i386-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136117>

On Monday, January 4, 2010 at 14:35:25 (+0100) Christian C. Schouten writes:
>Dear Bill,
>
>Thanks for your prompt reply. It may very well be exactly what I need, but
>I'm afraid that I don't understand the syntax just yet (am still in the
>phase orienting on what version management is and how it should be set up).
>
>Could you please add to your answer whether I am using branches or another
>git technique (terminology?) and whether these are instructions that I can
>use to commit a change once the system has already been set up or if these
>actually are the instructions for defining the multiplicity of my project
>versions?

In my example, I used branches, but did not show how to set them up.
Here is the complete example, complete with repository and branch
creation; you would start your project here:

# Set up repo and add first file to main branch:
% mkdir my_project
% cd my_project
% git init
% echo "main line process stuff" > process.bpel
% git add process.bpel
% echo "<non-version-specific table info>" > table.xml
% git add table.xml
% git commit -a -m "First commit on master branch"

# Create branch A and branch B:
% git branch A
% git branch B

# Modify file on branch A:
% git checkout A
% echo "<table A>" > table.xml
% git commit -a -m "Modify table on Branch A"

# Modify file on branch B:
% git checkout B
% echo "<table B>" > table.xml
% git commit -a -m "Modify table on Branch B"

# Now go back to master and make some changes on common file:
% git checkout master
% cat process.bpel
main line process stuff
% echo "add more process stuff" >> process.bpel
% git commit -a -m "fix process stuff on master"

# Now go to branch A and pull in the common file:
% git checkout A
% git merge master
% cat process.bpel
main line process stuff
add more process stuff

# Now go to branch B and pull in the common file:
% git checkout B
% git merge master
% cat process.bpel
main line process stuff
add more process stuff

That should be just about all you need.


Bill
