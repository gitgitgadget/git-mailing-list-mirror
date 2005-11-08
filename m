From: Ben Clifford <benc@hawaga.org.uk>
Subject: Re: Errors cloning over http -- git-clone and cg-clone fail to fetch a reachable object...
Date: Tue, 8 Nov 2005 22:19:53 +1100
Message-ID: <1537CD60-21E4-4F5E-820F-216A4E8C06AC@hawaga.org.uk>
References: <46a038f90511061354k5378a92ckc427841f90ec8b4@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=UTF-8;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Wed Nov 09 01:27:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZdmR-00069g-RL
	for gcvg-git@gmane.org; Wed, 09 Nov 2005 01:25:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030466AbVKIAZd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 8 Nov 2005 19:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030467AbVKIAZd
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 19:25:33 -0500
Received: from mundungus.clifford.ac ([81.187.211.39]:18440 "EHLO
	mundungus.clifford.ac") by vger.kernel.org with ESMTP
	id S1030466AbVKIAZc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Nov 2005 19:25:32 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mundungus.clifford.ac (8.13.3/8.13.3) with ESMTP id jA906YTX002856;
	Wed, 9 Nov 2005 00:06:43 GMT
In-Reply-To: <46a038f90511061354k5378a92ckc427841f90ec8b4@mail.gmail.com>
To: Martin Langhoff <martin.langhoff@gmail.com>,
	Nick Hengeveld <nickh@reactrix.com>,
	Git Mailing List <git@vger.kernel.org>
X-Mailer: Apple Mail (2.734)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11372>

I got similar today; www.hawaga.org.uk is some apache server on =20
linux, and piva.hawaga.org.uk, the client Mac OS X.

=46eel free to hit the URL yourselves -- its a public webserver.


According to system profiler on piva:

   System Version:    Mac OS X 10.4.2 (8D37)
   Kernel Version:    Darwin 8.2.1

and

!582 [1] benc@piva:~/tmp$ curl --version
curl 7.13.1 (powerpc-apple-darwin8.0) libcurl/7.13.1 OpenSSL/0.9.7g =20
zlib/1.2.3
Protocols: ftp gopher telnet dict ldap http file https ftps
=46eatures: IPv6 Largefile NTLM SSL libz
!583 [1] benc@piva:~/tmp$

This is on an unpacked repository, so I would guess that none of the =20
GETs for objects should be failing...

Note that it *doesn't* always error out on the same object:

!549 [0] benc@piva:~/tmp$ cg clone http://www.hawaga.org.uk/=20
gitcompletion.gitdefaulting to local storage area
20:56:33 URL:http://www.hawaga.org.uk/gitcompletion.git/HEAD [41/41] -=20
 > "refs/heads/.origin-fetching" [1]
progress: 11 objects, 2875 bytes
error:  (curl_result =3D 3181280, http_code =3D 200, sha1 =3D =20
c99aa418704f576aad8249d042cd6afecf38afc4)
Getting pack list
error:
Getting alternates list
error: Unable to find c99aa418704f576aad8249d042cd6afecf38afc4 under =20
http://www.hawaga.org.uk/gitcompletion.git/

Cannot obtain needed blob c99aa418704f576aad8249d042cd6afecf38afc4
while processing commit 912eb2baf57b70178c2e1f10df12eae911e1d748.
cg-fetch: objects fetch failed
cg-clone: fetch failed
!550 [0] benc@piva:~/tmp$



!556 [0] benc@piva:~/tmp$ cg clone http://www.hawaga.org.uk/=20
gitcompletion.git
defaulting to local storage area
20:58:48 URL:http://www.hawaga.org.uk/gitcompletion.git/HEAD [41/41] -=20
 > "refs/heads/.origin-fetching" [1]
progress: 12 objects, 4581 bytes
error:  (curl_result =3D 3179088, http_code =3D 200, sha1 =3D =20
682cfbd4d75e204fada2cabe9e0f040e522ce61d)
Getting pack list
Getting alternates list
error: Unable to find 682cfbd4d75e204fada2cabe9e0f040e522ce61d under =20
http://www.hawaga.org.uk/gitcompletion.git/

Cannot obtain needed commit 682cfbd4d75e204fada2cabe9e0f040e522ce61d
while processing commit 912eb2baf57b70178c2e1f10df12eae911e1d748.
Waiting for http://www.hawaga.org.uk/gitcompletion.git/objects/cb/=20
c8285a736142b83894ec412fe413d9ee7363ab
cg-fetch: objects fetch failed
cg-clone: fetch failed
!557 [0] benc@piva:~/tmp$

When I run it lots of times in succession, it gets between 10 and 15 =20
objects in before failing on something.

When I try with plain git:

!580 [1] benc@piva:~/tmp$ git clone http://www.hawaga.org.uk/=20
gitcompletion.git here
defaulting to local storage area
got a108bdc110dad770ec5c092759a8bc511790d21f
walk a108bdc110dad770ec5c092759a8bc511790d21f
got 912eb2baf57b70178c2e1f10df12eae911e1d748
got 261466f44dce8fb3cac4e0d0f1bf5a46fa84e07e
walk 912eb2baf57b70178c2e1f10df12eae911e1d748
got f766b276eff3ec52ac3c0425b13c936d87c607ee
got e05988e4a193f9eac2862ce6e67b19e3785bd8f1
got c99aa418704f576aad8249d042cd6afecf38afc4
got d743b178b82e9a8f10a1bf267d32d070e36c8046
got 96a0d6b6b182d978c04290f7c87049a5d3cc41b7
got 676bd846066cf3794796cadb258a23a76744819c
got 2e04450bdc81b1380a8f75223d8ce8019400dd70
error:  (curl_result =3D 3179232, http_code =3D 200, sha1 =3D =20
682cfbd4d75e204fada2cabe9e0f040e522ce61d)
Getting pack list
error:
Getting alternates list
error: Unable to find 682cfbd4d75e204fada2cabe9e0f040e522ce61d under =20
http://www.hawaga.org.uk/gitcompletion.git/

Cannot obtain needed commit 682cfbd4d75e204fada2cabe9e0f040e522ce61d
while processing commit 912eb2baf57b70178c2e1f10df12eae911e1d748.
!581 [1] benc@piva:~/tmp$


but a curl by hand for one of the object URLs works:

!581 [1] benc@piva:~/tmp$ curl http://www.hawaga.org.uk/=20
gitcompletion.git/objects/68/2cfbd4d75e204fada2cabe9e0f040e522ce61d =20
 > /dev/null
   % Total    % Received % Xferd  Average Speed   Time    Time     =20
Time  Current
                                  Dload  Upload   Total   Spent    =20
Left  Speed
100   250  100   250    0     0    183      0  0:00:01  0:00:01 =20
--:--:--     0
!582 [1] benc@piva:~/tmp$


and works each time when I run it repeatedly.






On 7 Nov 2005, at 08:54, Martin Langhoff wrote:


> Strange!
>
> I'm getting errors when cloning over http
>
> git-clone http://locke.catalyst.net.nz/git/moodle.git mdlfoo
> (...)
> error:  (curl_result =3D 3601440, http_code =3D 200, sha1 =3D
> f04241b142edfbf28fff2babb426cbab5b44e26b)
> Getting pack list
> error:
> Getting alternates list
> error: Unable to find f04241b142edfbf28fff2babb426cbab5b44e26b under
> http://locke.catalyst.net.nz/git/moodle.git/
>
> Cannot obtain needed commit f04241b142edfbf28fff2babb426cbab5b44e26b
> while processing commit 0965f28d4d75f324b86c8f7490830fea471c65c5.
>
> This commit object is easily reachable at
> http://mirrors.catalyst.net.nz/git/moodle.git/objects/=20
> f0/4241b142edfbf28fff2babb426cbab5b44e26b
>
> If I use cg-clone, I get a similar error
>
> cg-clone http://locke.catalyst.net.nz/git/moodle.git#mdl-artena-=20
> tairawhiti
> mdlfooo
> (...)
> Cannot obtain needed object 214e6374d49e6d014f0ba6f159d585a3fe468909
> while processing commit 0000000000000000000000000000000000000000.
> cg-fetch: objects fetch failed
> cg-clone: fetch failed
>
> This commit object seems to be in a pack:
> http://mirrors.catalyst.net.nz/git/moodle.git/objects/pack/=20
> pack-094560c0177ad659a6e172739c4be53da749e5f0.pack
>
> git-cat-file on the server works correctly, and cloning/working over
> git+ssh works too.
>
> cheers,
>
>
> martin
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>

--=20
Ben =E3=83=99=E3=83=B3 =D0=91=D1=8D=D0=BD
http://www.hawaga.org.uk/ben/
