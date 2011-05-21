From: =?UTF-8?B?RnLDqWTDqXJpYyBIZWl0em1hbm4=?= 
	<frederic.heitzmann@gmail.com>
Subject: Re: git difftool does does not respect current working directory
Date: Sat, 21 May 2011 11:35:06 +0200
Message-ID: <4DD7874A.2050604@gmail.com>
References: <loom.20110514T160931-46@post.gmane.org> <7v1uzznr09.fsf@alter.siamese.dyndns.org> <20110520035856.GA13582@gmail.com> <20110520041045.GB13582@gmail.com> <7vwrhm3scl.fsf@alter.siamese.dyndns.org> <20110520044851.GD13582@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 21 11:35:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNiab-0000eZ-0Q
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 11:35:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753247Ab1EUJfM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 May 2011 05:35:12 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:59420 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195Ab1EUJfK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 05:35:10 -0400
Received: by wwa36 with SMTP id 36so4729528wwa.1
        for <git@vger.kernel.org>; Sat, 21 May 2011 02:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=yWpq5HxhLcdXg1h4B7k50RuMGNuOZIfMo2QjNY/2bys=;
        b=gUqe5/A+bWvg9hlNVS49ORc1mqVCgUKivpLppTSGC7y5Ee5EGVq6sUmoq3/UR1zTyi
         /+AcYyJPTozZSVlGjuvt7sjcONou0KgKJTC8qSDbhl/z4MwKTHzhVRVhi6Vs8KBJvnDq
         hAnKvOQHlkFwRY10obPb6eZhMzIiJr/Hpg+Cw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=YomrS+P+Gbok4HHEqbKVvd9tXE0T4JBVZeftyCYhBXQsKACYJKwNnvwUDIdBIyvkXm
         8AfdxhTht9u93iUJrYgroJpdz7KcxCELq63W+EuLmLjgFWiZcnQ5PeOG3dhnFtGtbZ4F
         uFRi9mDcX8lNzJvEfk/nPOZZbYqFf5ktSopew=
Received: by 10.216.30.206 with SMTP id k56mr509002wea.29.1305970508704;
        Sat, 21 May 2011 02:35:08 -0700 (PDT)
Received: from [192.168.0.10] (dra38-7-88-179-84-80.fbx.proxad.net [88.179.84.80])
        by mx.google.com with ESMTPS id bi13sm2783421wbb.42.2011.05.21.02.35.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 21 May 2011 02:35:07 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.17) Gecko/20110424 Thunderbird/3.1.10
In-Reply-To: <20110520044851.GD13582@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174114>

Reading your replies, my understanding is :
- difftool is consistent with diff, and chdir to root directory. It is=20
seems indeed very common to have diffs showing from the root directory.
- on the overhand, openning gvimdiff via difftool and having a new cwd=20
is for sure not consistent with usual gvim text editing.

I am afraid I am going to need some gvim trick like :
$ git difftool -x "gvimdiff -f -d -c 'wincmd l' -c 'cd $PWD' " my_file

Not sure that it is less messy though ;-)
If there is no stronger need to adapt git-difftool, for gvimdiff or any=
=20
other difftool, we could probably settle for it.

Thanks for you help.
--
=46red

Le 20/05/2011 06:48, David Aguilar a =C3=A9crit :
> On Thu, May 19, 2011 at 09:31:54PM -0700, Junio C Hamano wrote:
>> David Aguilar<davvid@gmail.com>  writes:
>>
>>> We would have to change the way $GIT_EXTERNAL_DIFF works so
>>> that it preserves the current directory and constructs
>>> paths relative to it.  Patches welcome :-)
>> I am afraild that would break a lot more than difftool.
>>
>> If we really wanted to change the behaviour, the external diff inter=
face
>> needs to export the value of prefix (i.e. what the original subdirec=
tory
>> was), and the script that is spawned as $GIT_EXTERNAL_DIFF (optional=
ly
>> optionally) take it into account, perhaps by cd'ing back to that
>> subdirectory and possibly moving or renaming the temporary files to =
suit
>> its needs (I think recently we also saw a request to rename the temp=
orary
>> files).
>>
>> Or something like that.
> Yup, yup.  That's a lot of machinery for a relatively small
> gain.  Simple is simple, simple is good.  Thanks for
> outlining how someone could implement it, though.
>
> I won't do it myself but if someone is motivated enough then
> your email at least gives an idea about how to go about doing
> it.  git-difftool--helper could chdir to $prefix and diff each
> file with $(git rev-parse --show-cdup)/$path as the path since
> it may no longer be at the root.
>
> This seems very messy so I don't really want to sound too
> encouraging about going down this route.  I probably
> shouldn't have encouraged looking at the temporary files
> thing in the other thread either.
>
> Thanks,
