From: Holger Hellmuth <hellmuth@ira.uka.de>
Subject: Re: wrong handling of text git attribute leading to files incorrectly
 reported as modified
Date: Wed, 16 Apr 2014 19:03:29 +0200
Message-ID: <534EB7E1.7060807@ira.uka.de>
References: <E8A9F28E-FF68-4899-B02C-DB7A2C66F38A@ammeter.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Frank Ammeter <git@ammeter.ch>
X-From: git-owner@vger.kernel.org Wed Apr 16 18:58:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaTAL-0006f7-To
	for gcvg-git-2@plane.gmane.org; Wed, 16 Apr 2014 18:58:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbaDPQ6X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2014 12:58:23 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:54159 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751111AbaDPQ6W (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Apr 2014 12:58:22 -0400
Received: from i20s141.iaks.uni-karlsruhe.de ([141.3.32.141] helo=[172.16.22.120])
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.79 id 1WaT9s-00044R-2m; Wed, 16 Apr 2014 18:58:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <E8A9F28E-FF68-4899-B02C-DB7A2C66F38A@ammeter.ch>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1397667480.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246345>

Am 11.04.2014 22:20, schrieb Frank Ammeter:
> #!/bin/bash
> # creating a git repo "repo"
> rm -rf repo
> mkdir repo
> cd repo
> git init
> # committing gitattributes with text attribute set for all files
> echo "* text" > .gitattributes
> git add .gitattributes
> git commit -m "added .gitattributes"
> # add a file with CRLF line ending with text attribute unset
> echo -e "crlf\r" > crlffile
> echo "* -text" > .gitattributes
> git add crlffile
> git commit -m "added crlffile"
> git checkout .gitattributes
> # now "crlffile" shows as modified, even though it isn't.

It is. In the repository is stored a crlffile with \r in it which would 
be changed when you would do a commit (with your current gitattributes)

> # only way to resolve is to modify .gitattributes

No. This works too:

git add crlffile
git commit -m .    # practically removes the \r inside the repository
git status crlffile
#shows up clean
