From: Sam Vilain <sam@vilain.net>
Subject: Re: Identify Commit ID from an Extracted Source Snapshot
Date: Thu, 16 Feb 2012 15:19:27 -0800
Message-ID: <4F3D8EFF.9000806@vilain.net>
References: <BEDA323D25EF6045A68DAB9FD91A0BF123A85B38@DB3PRD0402MB118.eurprd04.prod.outlook.com> <4F3D8A7C.2020400@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: James Walmsley <james@fullfat-fs.co.uk>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Schubert <mschub@elegosoft.com>
X-From: git-owner@vger.kernel.org Fri Feb 17 00:19:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyAbt-0006eA-4P
	for gcvg-git-2@plane.gmane.org; Fri, 17 Feb 2012 00:19:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754330Ab2BPXT3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Feb 2012 18:19:29 -0500
Received: from uk.vilain.net ([92.48.122.123]:59706 "EHLO uk.vilain.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752905Ab2BPXT2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2012 18:19:28 -0500
Received: by uk.vilain.net (Postfix, from userid 1001)
	id BFFC08275; Thu, 16 Feb 2012 23:19:27 +0000 (GMT)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on uk.vilain.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=unavailable version=3.3.1
Received: from [IPv6:::1] (localhost [127.0.0.1])
	by uk.vilain.net (Postfix) with ESMTP id 3CFDC8176;
	Thu, 16 Feb 2012 23:19:26 +0000 (GMT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:10.0.1) Gecko/20120208 Thunderbird/10.0.1
In-Reply-To: <4F3D8A7C.2020400@elegosoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190921>

On 2/16/12 3:00 PM, Michael Schubert wrote:
> On 02/16/2012 11:06 PM, James Walmsley wrote:
>> I couldn't find this on google, and I have no idea if its even
>> possible. I have several zip files from previous versions of my
>> source code. (I imported svn into git). I would like to add TAGS to
>> git which represent the versions based on the files in my zip
>> archives.
>>
>> Does anyone know how to do this?
>
> If it's just about providing the ancient code together with the
> (imported) more recent history from SVN, you could create an extra
> orphan branch for each zip packet, add the files, commit and
> eventually tag.
>
> If your question is more like "how do I tell git to find out where
> this old code fits in my history and eventually place it there",
> the answer is: you cannot do it. No VCS will do this and especially
> not Git.

Once you've got a tree in git which corresponds to the contents of the=20
zip file, you can use git diff --stat TREEID COMMITID

You can get the commitid by obtaining the most recent timestamp for a=20
file within the archive, then just using git rev-list --all --since=3D.=
=2E.=20
--until=3D... to get a window of commit IDs, and hunt around until you=20
find the one with the smallest diff.

It's hardly a straightforward thing, usually because the contents of th=
e=20
zip file never quite match the exact contents of source control=97think=
=20
autoconf and other files generated for distribution but not stored in=20
the history.  So you need to use a fuzzy search.

Sam
