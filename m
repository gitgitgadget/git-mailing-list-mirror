From: =?utf-8?Q?David_K=C3=A5gedal?= <david@kagedal.org>
Subject: Re: [PATCH - stgit] Patch to allow import of compressed files
Date: Thu, 19 Jun 2008 16:17:57 +0200
Message-ID: <878wx14iga.fsf@lysator.liu.se>
References: <484D78BF.6030504@gmail.com>
	<20080610063328.GB26965@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 23:37:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9RoX-0003NE-Cq
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 23:37:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755482AbYFSVfL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Jun 2008 17:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757069AbYFSVfK
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 17:35:10 -0400
Received: from main.gmane.org ([80.91.229.2]:55067 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755297AbYFSVfI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 17:35:08 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1K9RmY-0003ph-90
	for git@vger.kernel.org; Thu, 19 Jun 2008 21:35:02 +0000
Received: from 87.96.142.66 ([87.96.142.66])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Jun 2008 21:35:02 +0000
Received: from david by 87.96.142.66 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Jun 2008 21:35:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 87.96.142.66
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Cancel-Lock: sha1:4+5+Zt4XYi/8AuDfQulX94Kw5Gw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85537>

Karl Hasselstr=C3=B6m <kha@treskal.com> writes:

> On 2008-06-09 13:38:55 -0500, Clark Williams wrote:
>
>> This patch allows StGit to directly import compressed (.gz and .bz2)
>> files with reasonable patch names.
>>
>> I do a lot of work on modified kernel trees and usually the first
>> two things imported are a stable update patch followed immediately
>> by an -rt patch, both of which are compressed. With this patch I can
>> just copy the files down directly from kernel.org and import them,
>> rather than having to keep uncompressed copies around.
>>
>> Hey, I'm lazy... :)
>
> Lazy is good. Thanks for the patch!
>
>> +        if filename.endswith(".gz"):
>> +            import gzip
>> +            f =3D gzip.open(filename)
>> +            pname =3D filename.replace(".gz", "")
>> +        elif filename.endswith(".bz2"):
>> +            import bz2
>> +            f =3D bz2.BZ2File(filename, 'r')
>> +            pname =3D filename.replace(".bz2", "")
>
> Some comments here:
>
>   * By my reading of the docs, the second argument to BZ2File default=
s
>     to 'r' anyway, so you could omit it.
>
>   * We try to use single quotes wherever possible (except when triple
>     quoting). You're using a mix ...
>
>   * .replace() will happily replace anywhere in the string. Please
>     consider using stgit.util.strip_suffix() instead.

Or use os.path.splitext(filename) which will save you a couple of
endswith calls as well.

> And last but not least, it'd be terrific if you'd let me bully you
> into adding .gz and .bz2 test cases for t1800-import. :-)

--=20
David K=C3=A5gedal <david@kagedal.org>
