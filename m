From: demerphq <demerphq@gmail.com>
Subject: Re: Rebase triggers "git diff header lacks filename information" on
 very large patch with binary files
Date: Tue, 14 Jan 2014 13:15:25 +0100
Message-ID: <CANgJU+UJaj3z0E2LvFXrnOGyuBBBits=9hUQoaHe5cCbXVPyjg@mail.gmail.com>
References: <CANgJU+V93Vu--hqikX0+dfZf4MnbcmVeE3OFW5J1THNkYiCL6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 14 13:15:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W32u3-0001fj-1P
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jan 2014 13:15:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbaANMP2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jan 2014 07:15:28 -0500
Received: from mail-pd0-f174.google.com ([209.85.192.174]:52314 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375AbaANMP0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jan 2014 07:15:26 -0500
Received: by mail-pd0-f174.google.com with SMTP id w10so4077732pde.33
        for <git@vger.kernel.org>; Tue, 14 Jan 2014 04:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=/qIyTQELr2+8mHpsyFwWgm90efjvPop2SEw2rwkmYL8=;
        b=Iy8De/BVSXTFxrJR75mqH1UxVrJAT0QxJYHnCdGOBqDzD2dI/vlkuE8YKQleaGkJbF
         kPcly+sApsKycCbO3MMIMDf3vsmJKXEpnYBqC7BXwnTdhR43WdgLXSvgX4CDw5wJa4+R
         +UK3vjqQEGFg4TKpOfa95lOEJfb4/yPYSfZGPfEB2dsdMrGwW/p5S8HwhBHokJ9Q1CEy
         EM0GtJYcr2EmBYiN63/l00cmwKV0CrmWoCc+xa6AOVyvRldXmUK6e8WI/u2e6sliqhxH
         D03+bLnfmaEHo19Snh7p/Eon72aeMV+YZ+LTiuQSg7y4U44lIOezT08uwBt6W6RjVD+B
         c6kw==
X-Received: by 10.66.227.104 with SMTP id rz8mr1406039pac.74.1389701725938;
 Tue, 14 Jan 2014 04:15:25 -0800 (PST)
Received: by 10.70.1.162 with HTTP; Tue, 14 Jan 2014 04:15:25 -0800 (PST)
In-Reply-To: <CANgJU+V93Vu--hqikX0+dfZf4MnbcmVeE3OFW5J1THNkYiCL6w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240397>

On 14 January 2014 12:48, demerphq <demerphq@gmail.com> wrote:
> Hi,
>
> I just did a rebase, and it throws an error like this:
>
> Applying: comment1
> Applying: comment2
> Applying: comment3
> Applying: comment4
> Applying: patch_with_binary_files
> fatal: git diff header lacks filename information when removing 1
> leading pathname component (line 7330213)
> Repository lacks necessary blobs to fall back on 3-way merge.
> Cannot fall back to three-way merge.
> Patch failed at 0005 patch_with_binary_files
> The copy of the patch that failed is found in:
>    /usr/local/git_tree/affiliate_data/.git/rebase-apply/patch
>
> When you have resolved this problem, run "git rebase --continue".
> If you prefer to skip this patch, run "git rebase --skip" instead.
> To check out the original branch and stop rebasing, run "git rebase --abort".
>
> The patch is very large, 882453899 bytes.
>
> The patch also includes many binary files.
>
> Extracting the content around and before line 7330213 and up to the
> next diff header in the patch I see this:
>
> perl -lne'print "$.\t$_" if 7330169 .. 7330213' .git/rebase-apply/patch
> 7330169 diff --git a/dir1/dir2/file.png b/dir1/dir2/file.png
> 7330170 new file mode 100644
> 7330171 index 0000000000000000000000000000000000000000..8a3219cb6545f23e3f7c61f058d82fc2c1bd9aac
> 7330172 GIT binary patch
> 7330173 literal 11301
> 7330174 zcmXYX1ymeO)Ai!+PH-nk@Zb{MHE3{$;O=gVh2Rd06MPp4?hxD|K!5<jEd=*(p7;Ov
> [more lines of binary removed]
> 7330213 zznckDs-GVJg-A0uD|ONvCQWVX;j!JNnkQI9^=+zJ^SvLe1p-~c&7bmY5wu4C=(8F0
> [more lines of binary removed]
> 7330393 literal 0
> 7330394 HcmV?d00001
> 7330395
> 7330396 diff --git a/dir1/dir2/file.css b/dir1/dir2/file.css
> 7330397 new file mode 100644
> 7330398 index 0000000000000000000000000000000000000000..75c8afc558424ea185c62b5a1c61ad6c32cddc21
>
> I have munged the filenames.
>
> It looks to me like git can't apply patches over a certain size.
>
> Any suggestions on how to proceed here?

I aborted and then did a merge instead and it seemed to work out.

Still, seems like something git should detect BEFORE it tries to do the rebase.

cheers,
Yves



-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
