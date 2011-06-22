From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Migration from CVS to GIT - Multiple directories in CVS repo
 to a single Git repo
Date: Wed, 22 Jun 2011 12:58:29 +0200
Message-ID: <4E01CAD5.8080808@alum.mit.edu>
References: <1308733591425-6503493.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: sandy2010 <sandeeptt@yahoo.com>
X-From: git-owner@vger.kernel.org Wed Jun 22 12:58:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZL8n-0004Bg-CW
	for gcvg-git-2@lo.gmane.org; Wed, 22 Jun 2011 12:58:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753924Ab1FVK6c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jun 2011 06:58:32 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:45849 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752552Ab1FVK6b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2011 06:58:31 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p5MAwTnj019212
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 22 Jun 2011 12:58:29 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.17) Gecko/20110424 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <1308733591425-6503493.post@n2.nabble.com>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176235>

On 06/22/2011 11:06 AM, sandy2010 wrote:
> I'm aware of cvs2git and git fast-import utilities to do this. My
> requirement is little different.
> My CVS Repo is:
> /cvs/BFARM
> 
> This consists of following directories:
> Misc/suite1
> Misc/suite2
> Misc/suite3
> 
> Now, I want to Migrate the suite1 and suite2 into a single Git repo
> "/git/Testsuites" and it should look like this:
> /git/Testsuites/suite1
> /git/Testsuites/suite2
> 
> How can I do this? I do not want to make suite1 and suite2 as separate git
> repos.

Since CVS works filewise, you can simply move the suite1 and suite2
directories from within the CVS repository into a pseudo CVS repository,
then convert that:

$ mkdir /tmp/fake-cvs-repo /tmp/fake-cvs-repo/Misc
$ cp -pr /cvs/BFARM/CVSROOT /tmp/fake-cvs-repo
$ cp -pr /cvs/BFARM/Misc/suite1 /tmp/fake-cvs-repo/Misc
$ cp -pr /cvs/BFARM/Misc/suite2 /tmp/fake-cvs-repo/Misc

and then convert the pseudo-repository "/tmp/fake-cvs-repo/Misc".
Depending on the tools and filesystems involved, you might be able to
use hardlinks or symlinks instead of full copies when building up the
pseudorepo.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
