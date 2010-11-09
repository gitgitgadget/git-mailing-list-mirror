From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Replacing a corrupt blob
Date: Tue, 09 Nov 2010 10:02:08 -0700
Message-ID: <4CD97E90.5010906@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 09 18:02:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFraU-0002xi-DC
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 18:02:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754116Ab0KIRCQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 12:02:16 -0500
Received: from hsmail.qwknetllc.com ([208.71.137.138]:39985 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360Ab0KIRCP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Nov 2010 12:02:15 -0500
Received: (qmail 11409 invoked by uid 399); 9 Nov 2010 10:02:10 -0700
Received: from unknown (HELO ?192.168.1.2?) (jjensen@workspacewhiz.com@75.220.23.231)
  by hsmail.qwknetllc.com with ESMTPAM; 9 Nov 2010 10:02:10 -0700
X-Originating-IP: 75.220.23.231
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.12) Gecko/20101027 Lightning/1.0b3pre Thunderbird/3.1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161059>

I just helped someone fix a repository where a blob became corrupted a 
while back when passing through Dropbox.  No backup of the original blob 
existed.

The user told me the contents of the blob was unimportant.

Thinking I could be clever, I ran 'git replace' to replace the blob with 
something else.  I thought I could run 'git clone' or 'git 
filter-branch' to apply it permanently, but that didn't seem to work.

In the end, I ran 'git fast-export', changed the blob SHA, and then ran 
'git fast-import'.  'git fsck' still told me the blob was corrupt, and I 
couldn't determine the sequence of commands to make it clear out the bad 
blob (expire the reflog, prune, etc).

I was able to 'git clone' to another location, and the bad blob was gone.

Is there another way to permanently replace a corrupt blob?

What is the right way to remove the corrupt blob without running 'git 
clone'?

Thanks!

Josh
