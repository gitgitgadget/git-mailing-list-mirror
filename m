From: Marc Strapetz <marc.strapetz@syntevo.com>
Subject: Applying .gitattributes text/eol changes
Date: Mon, 03 Jan 2011 18:18:56 +0100
Message-ID: <4D220500.2000104@syntevo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 03 18:29:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZoE2-0004Xj-UE
	for gcvg-git-2@lo.gmane.org; Mon, 03 Jan 2011 18:29:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258Ab1ACR3h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jan 2011 12:29:37 -0500
Received: from syntevo.com ([85.214.39.145]:59719 "EHLO syntevo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755551Ab1ACR3h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jan 2011 12:29:37 -0500
X-Greylist: delayed 637 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Jan 2011 12:29:36 EST
Received: from [127.0.0.1] (localhost [127.0.0.1]) with ESMTPSA id C12EC174006
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.13) Gecko/20101207 Lightning/1.0b2 Thunderbird/3.1.7
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164451>

I'm looking for an unobtrusive way to apply (committed) changes for
text/eol attributes to the working tree. For instance, after having
changed "*.txt eol=crlf" to "*.txt eol=lf", all *.txt files should be
converted from CRLF to LF endings. The only advice I found so far is to
remove .git/index and do a reset --hard. The disadvantage of this
approach is that every file will be touched:

- although the content does not change, timestamps will be changed. This
makes tools like IDEs assume that the file content has been changed.
(Even if the timestamps would be properly reset, the replacement of the
files would have triggered system file change notifications and I'd
expect various tools to still reload these files)

- there will be warnings for files which are locked by other processes
(at least on Windows). I'm usually seeing this for JAR files which are
not affected by eol-attribute changes at all.

One solution I could think of which might be helpful in other situations
as well would be to have an "--unobtrusive" option for reset which would
only replace a file if the content has actually been changed.

Marc.
