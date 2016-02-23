From: "Saravanan Shanmugham (sarvi)" <sarvi@cisco.com>
Subject: Git History Rewriting in a public repository - capability to remove
 one or more commits from a public repository
Date: Tue, 23 Feb 2016 21:30:58 +0000
Message-ID: <D2F20E85.A04DB%sarvi@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 23 22:31:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYKXz-0007DP-Gp
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 22:31:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755414AbcBWVbC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2016 16:31:02 -0500
Received: from rcdn-iport-6.cisco.com ([173.37.86.77]:32789 "EHLO
	rcdn-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754895AbcBWVbA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Feb 2016 16:31:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1743; q=dns/txt; s=iport;
  t=1456263060; x=1457472660;
  h=from:to:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=C7iaxSCLu4ZhyNdAzLzeQ8UYS6OQ1QBTmL5VZUPgQgQ=;
  b=QaBKNZdiYWxCSMkxRQfvvYluK46WmkbiLCCGvprfgcw+OQ+HynY8EDjV
   pEdDK+acDwIbxR2+z6LhmOA6q5z3ogafLpsIcozb3KApmwWVh08wwzO+1
   A6fzWXJr/9kvfbj/3pugpSupOo+eRtjq9gZAkW7zUtzT6TS44itJAINFv
   I=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AcAgAQz8xW/49dJa1UCoM6Um0BBUura?=
 =?us-ascii?q?o4xAQ2BZiEQhys4FAEBAQEBAQFkHAuESHQXAUM9JwSIMQ6eZp5BAQEBBwIBHY5?=
 =?us-ascii?q?XhGQFjWKJJQGFVogHjnGOSAEeAQFCgjCBNGqHOH0BAQE?=
X-IronPort-AV: E=Sophos;i="5.22,491,1449532800"; 
   d="scan'208";a="76102220"
Received: from rcdn-core-7.cisco.com ([173.37.93.143])
  by rcdn-iport-6.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Feb 2016 21:30:59 +0000
Received: from XCH-RCD-010.cisco.com (xch-rcd-010.cisco.com [173.37.102.20])
	by rcdn-core-7.cisco.com (8.14.5/8.14.5) with ESMTP id u1NLUxr0024479
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
	for <git@vger.kernel.org>; Tue, 23 Feb 2016 21:30:59 GMT
Received: from xch-rcd-009.cisco.com (173.37.102.19) by XCH-RCD-010.cisco.com
 (173.37.102.20) with Microsoft SMTP Server (TLS) id 15.0.1104.5; Tue, 23 Feb
 2016 15:30:58 -0600
Received: from xch-rcd-009.cisco.com ([173.37.102.19]) by
 XCH-RCD-009.cisco.com ([173.37.102.19]) with mapi id 15.00.1104.009; Tue, 23
 Feb 2016 15:30:58 -0600
Thread-Topic: Git History Rewriting in a public repository - capability to
 remove one or more commits from a public repository
Thread-Index: AQHRboF7S3yrdT5cyk6OOai6CWMbtQ==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/14.6.0.151221
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.154.48.226]
Content-ID: <198B9FDCAF648B48BD50662B49270A21@emea.cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287127>



Hi Git Leads,
      I am looking for git capability/way to be able to remove commits
from a public repository.

Background:
We are looking for a multi-stage commit process where commits get pushe=
d
into a public =B3testing-stage=B2 repository.
Where we do testing of commits before they are pushed to another public
=B3mainline=B2 repository.

When there are failures seen in the public =B3testing-stage=B2 reposito=
ry.
We would like to implement some process to go identify the bad patch an=
d
completely eject it from that public =B3testing-stage=B2 repository, as=
 if it
was not connected.

The plan is to use the Git History Rewriting capability described here
https://git-scm.com/book/en/v2/Git-Tools-Rewriting-History
So I can pull a pull workspace from the public =B3testing-stage=B2 repo=
sitory
use the above mechanism to eject one or more commits from it.

Now I would like to be able push it back to public =B3testing-stage=B2
repository.=20
And allow other people to be able to sync their workspaces to this publ=
ic
=B3testing-stage=B2 repository, correctly.

This as I understand is not supported?/recommended? in GIT.

Mercurial addresses this with the capability to mark commits with a pha=
se
such as =B3Draft=B2 or =B3Experimental=B2 and having a workflow around =
them.
Described here
https://www.mercurial-scm.org/wiki/Phases

http://www.gerg.ca/evolve/user-guide.html#evolve-user-guide



Question:
What are the issues?
What needs to be done in terms of development, to support this
functionality and make it work properly in GIT?
Is there additional development that needs to be done to git core to al=
low
this development process?


Thanks,
Sarvi
-----
Occam's Razor Rules
