From: Holger Hellmuth <hellmuth@ira.uka.de>
Subject: Re: Merge-friendly text-based data storage
Date: Tue, 27 Mar 2012 11:12:54 +0200
Message-ID: <4F718496.4030808@ira.uka.de>
References: <CAD77+gRTv4Aq_4FLAQcD9E0p7VBD7h6hQq3CJ9Wo5DU9Zjt+Hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Richard Hartmann <richih.mailinglist@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 27 11:12:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCSSA-0002QP-11
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 11:12:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757829Ab2C0JM3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 05:12:29 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:35947 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757611Ab2C0JM2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Mar 2012 05:12:28 -0400
Received: from irams1.ira.uni-karlsruhe.de ([141.3.10.5])
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	id 1SCSRb-0004f3-Ey; Tue, 27 Mar 2012 11:12:27 +0200
Received: from i20s141.iaks.uni-karlsruhe.de ([141.3.32.141] helo=[172.16.22.120])
	by irams1.ira.uni-karlsruhe.de with esmtpsa port 25 
	id 1SCSRa-0004FE-TN; Tue, 27 Mar 2012 11:11:59 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.24) Gecko/20111101 SUSE/3.1.16 Thunderbird/3.1.16
In-Reply-To: <CAD77+gRTv4Aq_4FLAQcD9E0p7VBD7h6hQq3CJ9Wo5DU9Zjt+Hg@mail.gmail.com>
X-ATIS-AV: ClamAV (irams1.ira.uni-karlsruhe.de)
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1332839547.574854000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194033>

On 26.03.2012 16:19, Richard Hartmann wrote:
> Hi all,
>
> I am looking for information on how to design a merge-friendly data
> layout. Oddly enough, there does not seem to be much online other than
> the obvious "use text-based lines, one per data point".
>
> My current plan looks like:
>
>    metamonger\tversion: 0
>    filename\towner_name\tgroup_name\tetc\tpp
>    ##########
>    file1\trichih\trichih\tfoo\tbar
>    relative/path/to/file2\troot\troot\tfoo\tbar
>
> the two upper lines are designed to fail a merge if the version of the
> file layout changes. Anything starting with a hash-pound is a comment
> and will be ignored.

I may be misunderstanding something, but lets assume you want to merge a 
file that has "version: 0" with one that has "version: 1" and their last 
common ancestor would have "version: 0" naturally. So the merge would 
not fail even though the file layout changes.

And there would be random merge failures with lines added at the same 
line number even if different.

The normal merging in git isn't suited for this task, it has different 
objectives. Without a custom merge driver as Junio suggested the only 
way would be to store each data line in its own file. As you store file 
paths that would even fit, but I doubt it is what you had in mind
