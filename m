From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] add: add --chmod=+x / --chmod=-x options
Date: Wed, 25 May 2016 14:19:35 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605251406020.4449@virtualbox>
References: <20160525020609.GA20123@zoidberg> <xmqqh9dm37xk.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Edward Thomson <ethomson@edwardthomson.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 25 14:20:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5Xn9-00050L-5l
	for gcvg-git-2@plane.gmane.org; Wed, 25 May 2016 14:20:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754676AbcEYMTq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2016 08:19:46 -0400
Received: from mout.gmx.net ([212.227.17.22]:51069 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752329AbcEYMTo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 08:19:44 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LyzW8-1baI5Q2x4S-014CJw; Wed, 25 May 2016 14:19:36
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqh9dm37xk.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:cezIoYt5U/SHlyi/2Tzb5K/TJBtfbR97zdf6iNxf/YrdOTHpV2Y
 PE1U8VSNCm41OqIRFDYWJkT7qJQQLwUH0mUSD5xiXJb5D2d/io0KPuopBuPkqG4pnlDsCTI
 8WkN3VM7qM/fnhZGsdxnYaChXq8VEEUW4YBB0+z2dHjLmzpBTJ/AdRDzA+jRDuqaYI6VEWt
 k1RR95TBW8Jizt+miJGVg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2oshOpZeNeQ=:G7JYLszsyKNQdjaQUGT7YU
 CGJvXoDaG1DKsip1x7Kv335/HszejsRh+x7gWOJaaXM9scAd/v/e9j8ukebEe3HRT7+cpRIRi
 Mbth5lt7pp6jeSGLDkZZ7T2t9keV1+/pKPjtMPIEl/r1oUotbfuAy2zoIMcgYYMM/43K3Pdtm
 9qqyNXG9gbqtQAhejtxmV6HegOOFE3jVdtkJAAO1tkIyXsgN6gz1VcuyYWMqprTDbEHvxtBE2
 UaNAWiNTU+l/ZpduoK6zedfGyAba4YrKXe3iPZRThXSQjTdUQvjOjX3vbD1smT6w1qWhaa6y/
 sK7o8hR7E4h8TF2L0xt/1znFKVvYx0cK5RLrKRdEZc+aSXYkcfkCmUn1RXhyCrDbDnFV1zJ9j
 x97jP++e82nnXX2g5JXcV9z60DApBd7kUYIkGtZ2aXaiDkE6YU4UCc2n/IGn8r2fk630duqld
 IacijiUdbrkdy5JaDkL2DUESjNb3f6ybBAYOh6P7J6SdaQNfHqGL37leIRT/6aAafB5tOCr3p
 advgRBRUigYPbhx0UdTnJ9b09VWJNJec0lhnQnTpl8TkD9BnptoqEQCPC001zGuPCG9SUrQVj
 7LQlYuOpdaJiWmN2YRZLk8cqUMT12YvHFSC0p8uyFj0NMAj90JkwX6lhRBo38ayT0i25U7U5n
 H2ok55Npm0jp8x6sg6EAa16RB4ngLygnKGLWIuA+3Nz7DCLl5jLXeuszHjQGimpaBlkegUcf+
 6UOt7ojyrvVLs2qqXQYlQZpe56UXqhD2r/Im7ZeT/Zkp/f1NtU03d5rlo41cabjxbreb48Az 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295572>

Hi Junio,

On Wed, 25 May 2016, Junio C Hamano wrote:

>  * I am not familiar with life on filesystems with core.filemode=0;
>    do files people would want to be able to "add --chmod=+x" share
>    common trait that can be expressed with .gitattributes mechanism?

I think it is safe to say that the biggest example of core.filemode == 0
is Windows. On that platform, there simply is no executable bit in the
sense of POSIX permissions. There are Access Control Lists that let you
permit or deny certain users from executing certain files (and it is files
only, directories are a never "executable" as in POSIX' scheme).

And on Windows, you certainly do not mark a file explicitly as executable
when creating it. The file extension determines whether it is executable
or not, and that's it.

In a sense, it is cleaner than POSIX' permission system: it separates
between the permissions and the classification "is it executable"?

Side note: shell scripts in Git for Windows are a special type of animal.
They *cannot* be made executable by Windows because there is just no
concept of free-form scripts that can choose whatever interpreter they
want to run in. In Git Bash, we have a special hack that is inherited
transitively from Cygwin, where scripts are automatically marked as
executable if their contents start with a shebang. This stops working as
soon as you leave the Bash, of course. Due to Git's heavy dependence on
shell scripting, we had to imitate that same concept in compat/mingw.c. It
is ugly, it is slow, and we have to live with it.

As a consequence of this very different concept of an "executable bit",
you will actually see quite a few Windows-only repositories that *never*
mark their executables with 0755. In Git for Windows' own repositories,
there are a couple of examples where scripts were introduced and only much
later did I realize that they were not marked executable (and then I ran
`git update-index --chmod=+x` on them).

All that means that the `--chmod` option is really useful only to
cross-platform projects, and only with careful developers. (And those
developers could use update-index, as you pointed out.)

I still like Ed's idea and would love to have it: it is murky waters to
require users to call plumbing only because our porcelain isn't up to par.

Ciao,
Dscho
