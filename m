From: Kevin <ikke@ikke.info>
Subject: Re: GIT & Symbolic Links
Date: Tue, 13 Mar 2012 11:06:33 +0100
Message-ID: <CAO54GHDgvoHdF3x8+kZwJ2XfB9Tyk1_xwrbfKux-b6wxS9koGw@mail.gmail.com>
References: <CACHQFzEqe-SwpCgjgGRDdzcUQW_+8-TdLsRV6KbKorvq7dJi+g@mail.gmail.com>
 <CACHQFzEJATc2hiSdAgoGg3vssQ-CShF+89TOkzVwaf_ujYy+3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Sassy Natan <sassyn@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 13 11:08:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7Oec-0005Mx-PM
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 11:08:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760446Ab2CMKGz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Mar 2012 06:06:55 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:33135 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760421Ab2CMKGy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Mar 2012 06:06:54 -0400
Received: by wibhq7 with SMTP id hq7so547975wib.1
        for <git@vger.kernel.org>; Tue, 13 Mar 2012 03:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=+cpbRgmFksN6LZXUAWpzfRQRJYeG31k7UYS5ITt9rng=;
        b=lACpPenh9Eqe3Mu+LgSx31SVEhUseaRReOShvPjLivHOwwvEcw+vY9NYLIbRXoujCh
         tCfpMB/6YLhl7/cbMfvOu43F1/KLtwXTQKU7FpbJW52E0hHthpnQI5Vb0EuY2p8OSGHl
         mqwQvsZhljOnpP8dFjWCjmTEUX5CAILVugVDO89/QitnGDOlh4FlCCa1rnOXf2+H9t7S
         tvwP+sZPOG6WeY1hCCMNkiDTq5H60CZaUL9FLDkTp3McVr4FB7AxxcE0kIDe7chpWV4z
         aBAzBLYEv9jpHT70VKP9QHMp7X7bB1KqyL9QhgssMZehcrAt53Bt4L2U6Bc99rdePdnU
         +Kyw==
Received: by 10.216.131.2 with SMTP id l2mr9195832wei.3.1331633213250; Tue, 13
 Mar 2012 03:06:53 -0700 (PDT)
Received: by 10.227.113.74 with HTTP; Tue, 13 Mar 2012 03:06:33 -0700 (PDT)
In-Reply-To: <CACHQFzEJATc2hiSdAgoGg3vssQ-CShF+89TOkzVwaf_ujYy+3w@mail.gmail.com>
X-Google-Sender-Auth: dCVS094MInYyfD_bBgUiP7TjnZw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192995>

As the IRC channel already concluded, git itself has no option to
'break' symbolic links on write, as git is not the only one editing
these files, but your editor does too.

This is why this is never going to work without the support of your
editor, or with something more low level, like file system support

On Mon, Mar 12, 2012 at 5:44 PM, Sassy Natan <sassyn@gmail.com> wrote:
> Hi Group,
>
> I'm consider myself as a new baby when it come to GiT.
> But I have just migrate my users from SVN to GIT and I have some
> questions in mind I want to share with you.
>
> Is it possible to do the following:
>
> Say I have a really big GiT repo (something around 1GB) name DEV.
> In the SVN days, each of my developers (100 Users) had to clone a
> local copy of the DEV Repo in his home folder, so total of 100GB was
> used in my shared storage (NFS Drive) where something around 85% was
> actually just a copy of the same files.
>
> When I used the De-Duplication function (Under ZFS File System) I
> could easy see how the volume is shrinking, but I more inserting in
> different kind of solution, now when it comes to GIT.
>
> So for the example let's consider that user A clone the DEV GIT Repo
> into his/her home folder (/home/A/DEV)
> User B want to clone the same Repo. But now, I don't want user B to
> clone the all tree and files, but instead to have a symbolic links to
> the /home/A/DEV folder.
> All files and directories in the /home/B/DEV will be a links to the /=
home/A/DEV.
>
> Once user B actually want to change a file, ?somehow? the git brake
> the link, and have a local copy of that specific file.
> When the file is push back the link become back.
>
> While trying to get some feedback in the IRC roon, some users point m=
e
> to git-annex and unionfs.
> Both project seems to be cool, git-annex really have nice options, bu=
t
> I don't see how this going to help me.
>
> Regarding unionfs - well I'm still not sure.
>
> Maybe someone can help here...
>
> Thanks
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
