From: Artur Skawina <art.08.09@gmail.com>
Subject: Re: Find out on which branch a commit was originally made
Date: Sat, 18 Sep 2010 18:41:32 +0200
Message-ID: <4C94EBBC.4080201@gmail.com>
References: <1jp0xnn.1gyr9a31jn4r7cM%lists@haller-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnI/IEJqYXJtYXNvbg==?= <avarab@gmail.com>,
	git@vger.kernel.org
To: Stefan Haller <lists@haller-berlin.de>
X-From: git-owner@vger.kernel.org Sat Sep 18 18:41:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ox0U6-0002Zd-8C
	for gcvg-git-2@lo.gmane.org; Sat, 18 Sep 2010 18:41:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753262Ab0IRQlh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 18 Sep 2010 12:41:37 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:52956 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751551Ab0IRQlg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Sep 2010 12:41:36 -0400
Received: by wyf22 with SMTP id 22so3216195wyf.19
        for <git@vger.kernel.org>; Sat, 18 Sep 2010 09:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:openpgp:content-type:content-transfer-encoding;
        bh=bRo/o36LQJZf6mvmYLR+FucPK3gUulfoOfJD0wah2H8=;
        b=KaPAc6KJhFdsr0etmyiI12q2PilSt7oRJFIDooSFbJpU9vZamFmTAYvVKQeyRkU1TC
         HARZ0m3Go3vh9R0C2/zyhVvI8uROEAt/QlCuaDAti63FYqgQjBEioW0kwE/0WPfLMXcW
         5EQVZ949D/KzjWQ2lU3GGM+OhbVMmB4sgTH+A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:openpgp:content-type
         :content-transfer-encoding;
        b=jtNLXiKNhDwxb3nyjNMFovRPnqUOcdifDA1HvUmc6o7DVnXRQofXDeEHWN+0h6VGty
         AiQR6e24aktaMdCZKRrYZK0AZ05uqPKEYL2HULZdipujDbXt2PrqZZaBXnxJfXU/cyLd
         2OOJjwZqUuiIPqadgAYOiZtsaJJD3OsGqDy0I=
Received: by 10.216.181.15 with SMTP id k15mr5846891wem.82.1284828095278;
        Sat, 18 Sep 2010 09:41:35 -0700 (PDT)
Received: from [172.19.43.221] (ip-94-42-31-165.multimo.pl [94.42.31.165])
        by mx.google.com with ESMTPS id v16sm3803692weq.8.2010.09.18.09.41.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 18 Sep 2010 09:41:34 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.9pre) Gecko/20100819 Lightning/1.0b2 Lanikai/3.1.3pre
In-Reply-To: <1jp0xnn.1gyr9a31jn4r7cM%lists@haller-berlin.de>
X-Enigmail-Version: 1.1.1
OpenPGP: id=DDEB1C43
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156463>

On 09/18/10 17:26, Stefan Haller wrote:
> =C3=86var Arnfj=C3=B6r? Bjarmason <avarab@gmail.com> wrote:
>>                      A---B---C topic
>>                     /         \
>>                D---E---F---G---H master

 The question is the same though: if I hit commit B while blaming, how =
do
> I know what topic it was a part of?  For that, I need to find commit =
H
> which will tell me, right?  How do I do that?

git rev-list --ancestry-path --merges --reverse B..master --format=3Don=
eline

> One concern that they are raising is that in Git there doesn't seem t=
o
> be an easy way to find out on which branch a given commit was origina=
lly
> made, after the branch is merged back and deleted. They consider this=
 a
> show-stopper.  In Mercurial, branch information is meta data attached=
 to
> each commit, so you can easily get this information even after a bran=
ch
> is closed.

Don't do that, then.=20
IOW if you know you could still need the old branch info, make an alias
that doesn't actually delete the branch after merging, but moves the re=
f
away, eg 'topic-name' -> "merged/topic-name" or just adds a
"merged/topic-name" tag. Then simply checking from which "merged/*"
branch/tag the offending commit is reachable would be enough.
Deleting a merged branch does not do anything more than removing the
reference (to 'C' in the above example), all the history stays around
forever anyway...

artur
