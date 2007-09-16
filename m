From: =?ISO-8859-1?Q?David_K=E5gedal?= <davidk@lysator.liu.se>
Subject: Re: [StGit PATCH 13/13] Remove the 'top' field
Date: Sun, 16 Sep 2007 12:22:28 +0200
Message-ID: <CD668999-4CD3-416C-9205-CEB46FFA2398@lysator.liu.se>
References: <20070914222819.7001.55921.stgit@morpheus.local> <20070914223215.7001.80066.stgit@morpheus.local> <20070915233632.GC25507@diana.vm.bytemark.co.uk>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, catalin.marinas@gmail.com
To: =?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Sun Sep 16 12:22:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWrGy-0005AZ-CC
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 12:22:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751917AbXIPKWg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Sep 2007 06:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751842AbXIPKWg
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 06:22:36 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:47022 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293AbXIPKWf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Sep 2007 06:22:35 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 6E037200A1FE;
	Sun, 16 Sep 2007 12:22:34 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 01306-01-15; Sun, 16 Sep 2007 12:22:33 +0200 (CEST)
Received: from [192.168.1.198] (c83-253-242-75.bredband.comhem.se [83.253.242.75])
	by mail.lysator.liu.se (Postfix) with ESMTP id C14FB200A1FD;
	Sun, 16 Sep 2007 12:22:32 +0200 (CEST)
In-Reply-To: <20070915233632.GC25507@diana.vm.bytemark.co.uk>
X-Mailer: Apple Mail (2.752.3)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58309>


16 sep 2007 kl. 01.36 skrev Karl Hasselstr=F6m:

> On 2007-09-15 00:32:15 +0200, David K=E5gedal wrote:
>
>> @@ -436,7 +422,13 @@ class Series(PatchSet):
>>                  patch =3D patch.strip()
>>                  os.rename(os.path.join(branch_dir, patch),
>>                            os.path.join(patch_dir, patch))
>> -                Patch(patch, patch_dir, refs_base).update_top_ref()
>> +                topfield =3D os.path.join(patch_dir, patch, 'top')
>> +                if os.path.isfile(topfield):
>> +                    top =3D read_string(topfield, False)
>> +                else:
>> +                    top =3D None
>> +                if top:
>> +                    git.set_ref(refs_base + '/' + patch, top)
>>              set_format_version(1)
>>
>>          # Update 1 -> 2.
>
> And remove the top file, maybe? (Or I may be mistaken; I don't have a
> copy of the surrounding code handy.)

No, this is the code that updates from version 0 to version 1. The =20
problem was that the update functionality used the update_top_ref() =20
function in the Patch class which I changed. So I had to inline the =20
code instead.
--=20
David K=E5gedal
davidk@lysator.liu.se
