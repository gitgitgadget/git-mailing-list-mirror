From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 0/8] Fix some bugs in abspath.c
Date: Fri,  7 Sep 2012 00:40:56 +0200
Message-ID: <1346971264-23744-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Orgad and Raizel Shaneh <orgads@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 00:41:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9klQ-0007B5-5J
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 00:41:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753588Ab2IFWlZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 18:41:25 -0400
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:55760 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753101Ab2IFWlY (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Sep 2012 18:41:24 -0400
X-AuditID: 12074414-b7f846d0000008b8-c5-504926934e05
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 0F.E5.02232.39629405; Thu,  6 Sep 2012 18:41:23 -0400 (EDT)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q86MfGJS025515
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 6 Sep 2012 18:41:21 -0400
X-Mailer: git-send-email 1.7.11.3
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsUixO6iqDtZzTPAYM1/MYuuK91MFg29V5gt
	nsy9y2xxe8V8Zov1ixpYLbqnvGV0YPP4+/4Dk8fOWXfZPR6+6mL3uHhJ2ePzJrkA1ihum6TE
	krLgzPQ8fbsE7ozvM++wFezmqHi4+QhbA+MDti5GTg4JAROJh7s+M0HYYhIX7q0HinNxCAlc
	ZpQ49eEUM4RzmkniT+MXdpAqNgFdiUU9zWAdIgJqEhPbDrGA2MwC5xkl/twEquHgEBYwkjh4
	PwAkzCKgKjHp5nmwEl4BF4kJ506wQyxTlPjxfQ3zBEbuBYwMqxjlEnNKc3VzEzNzilOTdYuT
	E/PyUot0LfRyM0v0UlNKNzFCgkVkB+ORk3KHGAU4GJV4eCee9wgQYk0sK67MPcQoycGkJMr7
	T8kzQIgvKT+lMiOxOCO+qDQntfgQowQHs5II78RfQOW8KYmVValF+TApaQ4WJXHeb4vV/YQE
	0hNLUrNTUwtSi2CyMhwcShK80apAQwWLUtNTK9Iyc0oQ0kwcnCCCC2QDD9CGAJBC3uKCxNzi
	zHSIolOMilLivEUgCQGQREZpHtwAWFy/YhQH+keYNwikigeYEuC6XwENZgIaLPIM5PTikkSE
	lFQDYyqDpIO791XhV+JW86Xr58/b5d+UsPhGdNLhPam/rj6/PXdCphLj4k9zF0rG/DO2srNc
	UZvZMSM7P3gvM4vuARa5baZJk09d6ndY3czre6AgQFaJM/bHuuAYKbte++r1ny41rd2b75d5
	Llq7IfmFlIKAjs6rtRuOCGTYpj04tv5m+Fqh7pnsSizFGYmGWsxFxYkA1z9jMMYC 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204930>

Second version of patches, incorporating gratefully received advice
from Hannes:

* Moved existing tests of real_path() from t0000 to t0060, and add new
  tests to t0060 instead of t0000.

* Adjusted the regexp used to construct a top-level directory that is
  needed for tests.

* Skip some tests when the POSIX prerequisite is not satisfied.

Michael Haggerty (8):
  t0060: move tests of real_path() from t0000 to here
  t0060: verify that absolute_path() fails if passed the empty string
  absolute_path(): reject the empty string
  t0060: verify that real_path() fails if passed the empty string
  real_path(): reject the empty string
  t0060: verify that real_path() works correctly with absolute paths
  real_path(): properly handle nonexistent top-level paths
  t0060: verify that real_path() removes extra slashes

 abspath.c             |  9 +++++++--
 t/t0000-basic.sh      | 18 -----------------
 t/t0060-path-utils.sh | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+), 20 deletions(-)

-- 
1.7.11.3
