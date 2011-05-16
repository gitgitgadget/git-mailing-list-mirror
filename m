From: Martin L Resnick <mresnick@bbn.com>
Subject: Re: ACLs for GIT
Date: Mon, 16 May 2011 09:22:21 -0400
Message-ID: <4DD1250D.50005@bbn.com>
References: <4DD02876.1040404@bbn.com> <20110515201513.GA27758@jpl.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Magnus_B=E4ck?= <magnus.back@sonyericsson.com>
X-From: git-owner@vger.kernel.org Mon May 16 16:05:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLyPu-0003gT-5D
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 16:05:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755356Ab1EPOE5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 May 2011 10:04:57 -0400
Received: from smtp.bbn.com ([128.33.0.80]:62886 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755196Ab1EPOE4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2011 10:04:56 -0400
X-Greylist: delayed 2554 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 May 2011 10:04:56 EDT
Received: from dhcp89-069-009.bbn.com ([128.89.69.9]:60627)
	by smtp.bbn.com with esmtps (TLSv1:CAMELLIA256-SHA:256)
	(Exim 4.74 (FreeBSD))
	(envelope-from <mresnick@bbn.com>)
	id 1QLxkb-00081K-TH; Mon, 16 May 2011 09:22:21 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.17) Gecko/20110424 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <20110515201513.GA27758@jpl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173735>

Thanks Mangus.

You pointed out some hurdles I'll have to think about
(blocked files not matching the SHA and so can't be committed).

As to why I want to do this consider NSA non-export rules.
Our application would be built with NSA encryption
but we have foreign nationals working on the code
and so they are not permitted to see that part.
The makefiles look to see if the NSA encryption code file
is there and link it in. If not a stub is used.


On 05/15/2011 04:15 PM, Magnus B=E4ck wrote:
> On Sunday, May 15, 2011 at 21:24 CEST,
>       Martin L Resnick<mresnick@bbn.com>  wrote:
>
>> Is anyone working on adding access control to GIT ?
>>
>> I'm looking for the Subversion equivalent of mod_authz_svn.
>> I need to restrict read access of ITAR documents that are
>> scattered throughout the source tree.
>> This restriction would need to deny fetch of the ITAR
>> documents yet allow fetch of any other files.
>>
>> Looking through the source code it would seem that
>> putting a hook call in the fetch-pack code would do it.
>
> I doubt it would make sense to put per-file permissions in Git
> as it doesn't version files but the complete state of a workspace.
> Even if you manage to hack the pack code to not include certain
> blobs when certain users ask for them, what would those users
> do when they want to create new commits based on commits where
> blobs are missing? Or would you send the protected blobs but
> replace their contents? Then Git would complain about that.
>
> However, both Gerrit Code Review and Gitolite offer per-branch
> permissions, so if it would be possible to put these files on
> branches of their own these tools would help.
>
