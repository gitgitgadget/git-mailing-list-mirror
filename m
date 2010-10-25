From: Mike Herrick <mike.herrick@gmail.com>
Subject: Re: fsck errors on newly cloned, newly imported git repository
Date: Mon, 25 Oct 2010 10:02:31 -0400
Message-ID: <AANLkTinfDh5_-u6nJc=MMs_vPQGuBPhOT-TqgVOvAMPo@mail.gmail.com>
References: <AANLkTimxXXNxUOMQyDDoW9+vT9aKL5C5m+VD51jk0zL9@mail.gmail.com>
	<1288004282.819.26.camel@drew-northup.unet.maine.edu>
	<AANLkTi=7mg-1Q1hHPA52MiHa3BXF95SGTTTTLFR9+VZ3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Mon Oct 25 16:02:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PANdH-0000YZ-BP
	for gcvg-git-2@lo.gmane.org; Mon, 25 Oct 2010 16:02:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755285Ab0JYOCd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Oct 2010 10:02:33 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:41956 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130Ab0JYOCc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Oct 2010 10:02:32 -0400
Received: by wwe15 with SMTP id 15so829867wwe.1
        for <git@vger.kernel.org>; Mon, 25 Oct 2010 07:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=S/pPNqGgnIc34LERG64cdWGR61EKhRZPWZwMIMH63Gk=;
        b=fdU/JQG5+863VXyHSrZjXEP3aDzQnPuMrXnyRm6SMjZf/agbXe+LG+TPs9lXSL2uBP
         0ciyy8ZYIY/CenVpCqqcMiMWcE1yGlr2VYdeYUbeOLOrFa4EnNE7qrBf2Sbj4MaBYVTj
         FWen5oxvMrdeGlJHjEDuChW6H1IsmmSnpN1rI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mMLbNrtX3/eUFBDw65KYi47T7FBQzOGL/2xWLDqm4usr1LhBR2iWjZ4+tbVSWn09cL
         wNxs6C5eXZCjo4KhG/TmWL2aPA6oQ3zcz7hdKS7nH1amE+ZsR/dw10y3I2XCEvrvy3Rq
         HppmoGGZ/TZP72XQM76kUuJeFmZss/8/BRjIg=
Received: by 10.216.45.205 with SMTP id p55mr367090web.107.1288015351119; Mon,
 25 Oct 2010 07:02:31 -0700 (PDT)
Received: by 10.216.255.143 with HTTP; Mon, 25 Oct 2010 07:02:31 -0700 (PDT)
In-Reply-To: <AANLkTi=7mg-1Q1hHPA52MiHa3BXF95SGTTTTLFR9+VZ3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159950>

On Mon, Oct 25, 2010 at 8:25 AM, Mike Herrick <mike.herrick@gmail.com> =
wrote:
> On Mon, Oct 25, 2010 at 6:58 AM, Drew Northup <drew.northup@maine.edu=
> wrote:
>>
>> On Sun, 2010-10-24 at 11:54 -0400, Mike Herrick wrote:
>>> This weekend we're cutting over to use git for our source code cont=
rol
>>> system. =A0I've imported about 20 years worth of previous history u=
sing
>>> "git cvsimport" (takes about four hours). =A0I then cloned the resu=
lting
>>> repository onto five different machines (four Linux, one Solaris).
>>> I've set up a cron job to do a nightly "git fsck" on each of the fi=
ve
>>> machines, and last night, two of the machines reported fsck errors =
on
>>> their initial run.
>> <snip>
>>
>>> The errors reported on these two machines were different, but what'=
s
>>> interesting is that all of the missing blobs refer to various
>>> revisions of the same file, namely our "Changes" file (which is
>>> updated with each change). =A0It's also the largest file in our
>>> repository (3.3M). =A0I immediately started looking at logs to see =
if
>>> there was any indication of disk corruption and found none (no SMAR=
T
>>> errors either). =A0Both of these machines have been stable over a
>>> multi-year period of time (no unexplained crashes). =A0They're also
>>> older Linux machines (running =A02.6.5-1.358 and =A02.6.1-1.65, wit=
h
>>> relatively little memory: 1GB and .5GB), but with newly installed
>>> version of git (1.7.3.1). =A0I initially used git-daemon for the cl=
one
>>> process, but even using ssh, I still see fsck errors on the resulti=
ng
>>> clones on these two machines.
>>
>> Did you "git fsck" BEFORE you attempted to clone? Is it ONLY clones
>> showing errors? Alas, no blatant evidence of disk corruption is not
>> evidence of no disk corruption as well.
>
> Thanks for your reply.
>
> Only two of the five clones exhibit fsck errors and the server
> repository has no fsck errors.
>
> The two machines report different sets of missing blobs, but always i=
n
> the "Changes" file (which has the somewhat unique characteristics tha=
t
> it is the "most changed" file in the repository, the largest, and one
> which is almost always only added to).
>
> I've since created two more clones on one of the machines (one using
> git-daemon and the other ssh) and both of these clones have the exact
> same set of missing blobs! =A0For me this rules out disk corruption.
>
> The good(?) news is that the process is repeatable on one machine:
> cloning from a known good repository results in different (but
> repeatable) errors. =A0Performing a second clone on the other "bad"
> machine also results in missing blobs, but different ones than the
> first (although all in the Changes file).
>
> My current thought is that somehow it's related to very old kernels?
> Apparently these machines are FC2 vintage.

We've backed out of our git cutover due to these errors.

I should also point out that on the machine where the errors are
repeatable, two of the clones were made to a local disk and one to an
NFS disk, and all three showed the same missing blobs (another
indication that it is unlikely to be a disk problem).

It's also interesting that the missing blobs seem to be in the same
general timeframe, 2001-2002 on one machine and 2008-2009 on the other
machine (as evidenced by the file sizes of the missing blobs):

[mikeh@mac5 src]$ for i in `cat /tmp/lin4`; do git cat-file -s $i ; don=
e
1494474
1667992
1496198
1643008
1666070
1724686
1494201
1643297
1665137
1640569
1726140
[mikeh@mac5 src]$ for i in `cat /tmp/toulouse`; do git cat-file -s $i ;=
 done
3055178
2858902
3060252
2887177
3038051
3033691
3008232
2981567
3000575
3081501
2995707
3070232
3076036
3059223
3075351
3070343
3054573
3033120
3028284
3078443
2896078
2895094
2973070
2859356

I was hoping that these would be on some type of boundary (and hence
powers of two), but that doesn't seem to be the case.

Mike.
