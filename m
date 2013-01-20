From: Per Cederqvist <cederp@opera.com>
Subject: Re: [PATCH 0/7] guilt patches, including git 1.8 support
Date: Sun, 20 Jan 2013 22:19:39 +0100
Message-ID: <50FC5F6B.6070103@opera.com>
References: <20130116022606.GI12524@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Josef 'Jeff' Sipek" <jeffpc@josefsipek.net>, git@vger.kernel.org,
	"Theodore Ts'o" <tytso@mit.edu>, Iulian Udrea <iulian@linux.com>,
	Axel Beckert <abe@deuxchevaux.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 20 22:29:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tx2S3-0001Dy-JE
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jan 2013 22:29:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752579Ab3ATV2y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 16:28:54 -0500
Received: from smtp.opera.com ([213.236.208.81]:48264 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752503Ab3ATV2x (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 16:28:53 -0500
X-Greylist: delayed 538 seconds by postgrey-1.27 at vger.kernel.org; Sun, 20 Jan 2013 16:28:53 EST
Received: from [192.168.10.90] (c-1404e353.1012-4-64736c15.cust.bredbandsbolaget.se [83.227.4.20])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id r0KLJeQY023963
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 20 Jan 2013 21:19:41 GMT
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <20130116022606.GI12524@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214054>

On 01/16/13 03:26, Jonathan Nieder wrote:
> Hi Jeff and other guilty parties,
>
> I collected all the guilt patches I could find on-list and added one
> of my own.  Completely untested, except for running the regression
> tests.  These are also available via git protocol from
>
>    git://repo.or.cz/guilt/mob.git mob
>
> Thoughts?

Regarding the "Change git branch when patches are applied" feature,
it has saved me a number of times since I implemented it. I've been
using it extensively, and have not had any problems with it.

Nevertheless, for backwards compatibility with the currently
released guilt version I think it should be conditional, and
disabled per default for one full release cycle.  I've implemented
this. My code is available from git://repo.or.cz/guilt/ceder.git

The following commits are not included in your list:

a194375 Added guilt.reusebranch configuration option.
1dd97bd Minor testsuite fix.
640caee The tests should not fail if guilt.diffstat is set.

I don't want Guilt to fork. Jeff, it would be really great if
you could set up a public repo again!

     /ceder

> Jonathan Nieder (1):
>    Drop unneeded git version check.
>
> Per Cederqvist (6):
>    get rid of "cat: write error: Broken pipe" error message
>    The tests should not fail if log.date or log.decorate are set.
>    Testsuite: get rid of "Broken pipe" errors from yes.
>    Handle empty patches and patches with only a header.
>    Fix fatal "guilt graph" error in sha1sum invocation.
>    Change git branch when patches are applied.
>
>   Documentation/guilt.7 |   4 +
>   guilt                 |  73 +++++---
>   guilt-branch          |  12 +-
>   guilt-commit          |   7 +
>   guilt-import-commit   |   4 +-
>   guilt-repair          |   7 +-
>   os.Darwin             |   7 +-
>   os.Linux              |   7 +-
>   os.SunOS              |   7 +-
>   regression/scaffold   |   7 +-
>   regression/t-029.sh   |   6 +-
>   regression/t-052.out  |  24 +--
>   regression/t-052.sh   |   7 +-
>   regression/t-061.out  | 468 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   regression/t-061.sh   | 148 ++++++++++++++++
>   15 files changed, 743 insertions(+), 45 deletions(-)
>   create mode 100644 regression/t-061.out
>   create mode 100755 regression/t-061.sh
>
