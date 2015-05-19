From: "McHenry, Matt" <mmchenry@carnegielearning.com>
Subject: recovering from "unordered stage entries in index" error
Date: Tue, 19 May 2015 09:48:05 -0400
Message-ID: <D377A9280DB18546A2471214D5CBB0E908599428C7@exchdb01>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 19 16:07:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuiAv-0003me-8m
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 16:07:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932818AbbESOHK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 10:07:10 -0400
Received: from mail3.carnegielearning.com ([204.80.87.3]:11025 "EHLO
	mail3.carnegielearning.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932738AbbESOHJ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 10:07:09 -0400
X-Greylist: delayed 1142 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 May 2015 10:07:09 EDT
X-ASG-Debug-ID: 1432043286-0424f512db3c5e2e0001-QuoKaX
Received: from webmail.carnegielearning.com ([10.1.10.4]) by mail3.carnegielearning.com with ESMTP id vT6J7huBpV9MgwW2 (version=TLSv1 cipher=AES128-SHA bits=128 verify=NO) for <git@vger.kernel.org>; Tue, 19 May 2015 09:48:06 -0400 (EDT)
X-Barracuda-Envelope-From: mmchenry@carnegielearning.com
X-Barracuda-RBL-Trusted-Forwarder: 10.1.10.4
Received: from exchdb01.carnegielearning.com ([127.0.0.1]) by exchdb01
 ([127.0.0.1]) with mapi; Tue, 19 May 2015 09:48:05 -0400
Thread-Topic: recovering from "unordered stage entries in index" error
X-ASG-Orig-Subj: recovering from "unordered stage entries in index" error
Thread-Index: AdCSOVpyjBFcwbfxR/KszY10sFsDQw==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
x-exclaimer-md-config: 4a2a7f2a-5ce0-45d8-a978-59e527d0c9d2
X-Barracuda-Connect: UNKNOWN[10.1.10.4]
X-Barracuda-Start-Time: 1432043286
X-Barracuda-Encrypted: AES128-SHA
X-Barracuda-URL: https://10.1.10.29:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at carnegielearning.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5000 1.0000 0.0100
X-Barracuda-Spam-Score: 0.51
X-Barracuda-Spam-Status: No, SCORE=0.51 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=BSF_RULE7568M
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.19089
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.50 BSF_RULE7568M          Custom Rule 7568M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269359>


	I've just upgraded my git from 2.0.5 to 2.3.6, and I'm now unable to run 'git svn fetch' in one of my repositories:

$ git svn fetch
fatal: unordered stage entries in index
write-tree: command returned error: 128

	'git status' shows a few untracked files but is otherwise clean.

	It looks like this check was introduced in 15999d0be8179fb7a2e6eafb931d25ed65df50aa, with the summary "read_index_from(): catch out of order entries when reading an index file" (first appearing in 2.2.0).

	Mailing list discussion looked like it implicated third-party tools.  I don't recall running any other tools on this repo; it doesn't do much day-to-day other than a long series of 'git svn fetch'es.  (But it's been around for a couple of years, so who knows.)

	At any rate, what can I do to recover from this situation?  I tried to locate a path with multiple index entries like this, but got no results:

$ git ls-files -s | cut -f 2-100 | sort | uniq -c | grep -v '^[ \t]*1 '

	(I originally posted on SO at http://stackoverflow.com/questions/30264826/; I'll update that with any solutions that come up here, to ease future googling.)
