From: Nicolas Adenis-Lamarre <nicolas.adenis.lamarre@gmail.com>
Subject: Re: Locking files / git
Date: Wed, 18 Sep 2013 12:12:50 +0200
Message-ID: <CACPGbcv+w=p+Zk_+djL8ONEWN4LfDNbeVbxcpk-TJX=B3To=gg@mail.gmail.com>
References: <CACPGbcsB-ieZnS5maQgtnRTifFON9fEFpCGGdHtQ2ZjySdxDYA@mail.gmail.com>
	<20130917213619.GM28675@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Wed Sep 18 12:13:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMEkn-00069s-6r
	for gcvg-git-2@plane.gmane.org; Wed, 18 Sep 2013 12:13:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751666Ab3IRKMw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Sep 2013 06:12:52 -0400
Received: from mail-vb0-f43.google.com ([209.85.212.43]:59039 "EHLO
	mail-vb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751556Ab3IRKMv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Sep 2013 06:12:51 -0400
Received: by mail-vb0-f43.google.com with SMTP id h11so4939701vbh.2
        for <git@vger.kernel.org>; Wed, 18 Sep 2013 03:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=OBwMp2D+0LslU7IOjenRsSX8VFbfl0zyB+hyRBJ8slo=;
        b=J/tFvG22q8gLNLlWXNOExF/X2KttPNWxBYw9tpc+C8BugeSG/9rIyhwWfMSyNOVump
         jniXJ7rMt8j3ngQYpk2pQFWHRX4/g3MCYvF9j99yiOqGyPPTHWqAFYcnasMqEjD8m0cn
         Xx5TS654xw4BZ2LXrx1tvDZzY0S8dXzfBX5vJ44UO6Y8OpGHOqvrRF4CbEWbsTBDzdBU
         0FBCRadG+IB+6MrDw/M4Y/2U3WBKIU3c9n36HLwa4srw98+udukvW2c5IS89iV7IlLhU
         8ycpzSafcrP4r5UE544vf9WWIArpyaNmtdeFVCAdw2kDZYfMfWUYKWLJz78pFqXNR7kY
         A9rw==
X-Received: by 10.52.161.231 with SMTP id xv7mr4407873vdb.1.1379499170803;
 Wed, 18 Sep 2013 03:12:50 -0700 (PDT)
Received: by 10.220.194.132 with HTTP; Wed, 18 Sep 2013 03:12:50 -0700 (PDT)
In-Reply-To: <20130917213619.GM28675@paksenarrion.iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234960>

Thanks a lot for your answer.
That's really good arguments that i was waiting for and that i have
not get until now.

My comprehension now :
- it's not easy to maintain several versions of a binary file in parall=
el.
So basically, it's not recommanded to have complex workflow for binary =
files.
In case the project has a low number of binary files, it can be handle
by simple communication,
In case the project has a lot of binary files, a simple workflow with
a centralized workflow is recommanded
- git doesn't hate locks, it's just that it's not the layer to
implement it because git is workflow independant. Locks depend on a
centralized server which is directly linked to the workflow.

I'm not trying to implement a such workflow. I'm just curious, reading
a lot of things about git, and trying to understand what is sometimes
called a limitation of git.
A simple line in the documentation to say that locking should be
handled in the upper layer (and it's done for example in gitolite)
because it's dependant of the workflow could help some people looking
about that point.

Thanks a lot for git.

2013/9/17 Fredrik Gustafsson <iveqy@iveqy.com>:
> On Tue, Sep 17, 2013 at 09:45:26PM +0200, Nicolas Adenis-Lamarre wrot=
e:
>> Ooops. It seems that each time somebody says these two words togethe=
r,
>> people hate him, and he is scorned by friends and family.
>>
>> For the moment, i want a first feedback, an intermediate between
>> "locking is bad" and "ok", but i would prefer in the negativ answer
>> something with arguments ("Take CVS as an example of what not to do;
>> if in doubt, make the exact opposite decision." is one), and in the
>> positiv answer, good remarks about problems with my implementation
>> that could make it better.
>
> So working with locks and text-files is generally stupid to do with g=
it
> since you don't use git merging capabilities. Working with binary fil=
es
> in git is stupid because git doesn't handle them very well because th=
ey
> the deltas can't be calculated very good.
>
> It seems to me that if you need to do locking one of the above scenar=
ios
> is true for you and you should not use git at all.
>
> However, there's always the case when you've a mixed project with bot=
h
> binary and text-files. In that case I believe Jeff gave an excellent =
answer.
>
> But think twice, are you using git in a sane way? Even a small binary
> file will result in a huge git repo if it's updated often and the
> project has a long history.
>
> --
> Med v=E4nliga h=E4lsningar
> Fredrik Gustafsson
>
> tel: 0733-608274
> e-post: iveqy@iveqy.com
