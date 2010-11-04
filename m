From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: rebase not honoring core.worktree pointing elsewhere
Date: Thu, 4 Nov 2010 21:20:05 +0700
Message-ID: <AANLkTi=DJMLdHD2t2znS4eA57LnTfcPhLUaPbJktE7NB@mail.gmail.com>
References: <loom.20101101T182113-378@post.gmane.org> <AANLkTi=ejRcnz+83zc2Z-6etUGMsBSw1FFUY0JNFRFGB@mail.gmail.com>
 <loom.20101102T165800-486@post.gmane.org> <AANLkTi=T5kHfgNOpOtCDCoq7epEgwUrVayaUCbf35dSU@mail.gmail.com>
 <loom.20101103T162424-483@post.gmane.org> <20101103161311.GA12934@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paul Drews <paul.drews@intel.com>, git@vger.kernel.org,
	Lars Hjemli <hjemli@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 04 15:20:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE0gC-0000S4-LE
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 15:20:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751871Ab0KDOUb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Nov 2010 10:20:31 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:40168 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751854Ab0KDOU3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Nov 2010 10:20:29 -0400
Received: by ywc21 with SMTP id 21so1407382ywc.19
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 07:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Y87ThvW06llS6HH95una3WxJzo5R44WHv1FdkFv3dvo=;
        b=YMxxsBCPYJ1tJK7lm5CF45ZGkFfNMTu9Jc8i3Lz7CP9PnyeRwS895bDjB6hNgiiB7y
         ZEux9oi1HGmel+A8rgBRSJjVNhfvHi3Ys62+9+KmpRIldOSUyf7Yq760mNagT2oaWQHj
         FjTBuXQ8VK1cRvFyiAY7hCSmckpird7JB1tGQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=pW95Op2/ZDWyThzjFUJYfOnGqTxHRfqu2uJUeQo2dNjARoxXtqdRDczRzY5sCF+kAo
         uSdnmnwPuFRPEXJxHgQjmDRjvKasVGV5gy7AMjVu0v2phfMzXOnLLQHVkhp0eObmD0AL
         XM8vT1mXj7UhC2dXvKP0GHaQIEtvhqoMGZhwU=
Received: by 10.216.47.19 with SMTP id s19mr1971157web.56.1288880427819; Thu,
 04 Nov 2010 07:20:27 -0700 (PDT)
Received: by 10.216.172.199 with HTTP; Thu, 4 Nov 2010 07:20:05 -0700 (PDT)
In-Reply-To: <20101103161311.GA12934@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160723>

On Wed, Nov 3, 2010 at 11:13 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Paul Drews wrote:
>> Nguyen Thai Ngoc Duy <pclouds <at> gmail.com> writes:
>
>>> Another one: create a .git file with this line and put it in worktr=
ee's
>>> topdir
>>>
>>> gitdir: /path/to/real/git.dir
>>>
>>> See gitrepository-layout.txt.
>>
>> Ooh! =C2=A0That would be my favorite, since it's a documented legal =
usage.
>
> By the way, .git symlinks have been historically supported and are no=
t
> likely to break, either. =C2=A0Maybe gitrepository-layout should grow=
 to
> include a section on the repository search.
>
>> Unfortunately, although the rebase scenario works that way a local
>> "git clone" doesn't work:
>>
>> # git clone /abs/path/to/proj
>> Cloning into proj...
>> fatal: failed to open '/abs/path/to/proj/objects': No such file or d=
irectory
>
> enter_repo() never learned .git file support, though I see no reason =
it should
> be hard to add.

Also get_repo_path(). By the way if you work on this, please move
enter_repo() to setup.c. Keeping it close to setup_* functions may
increase the chance that it also gets fixed along with setup_*.

Another thing. "git init" should probably learn to create .git file.
Each time I use .git file I have to look at man page^W^Wsource code
again to know its syntax.
--=20
Duy
