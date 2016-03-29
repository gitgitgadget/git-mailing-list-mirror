From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v1 6/7] correct blame for files commited with CRLF
Date: Tue, 29 Mar 2016 21:51:07 +0200
Message-ID: <56FADCAB.1010201@web.de>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
 <1459257938-17389-1-git-send-email-tboegi@web.de>
 <xmqqa8lhyzbq.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, tboegi@web.de
X-From: git-owner@vger.kernel.org Tue Mar 29 21:53:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akzfs-0004y5-Ur
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 21:51:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754059AbcC2Tvc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2016 15:51:32 -0400
Received: from mout.web.de ([212.227.15.4]:51617 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753251AbcC2Tvb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 15:51:31 -0400
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0MGRMG-1aXoNL1N3Y-00DEhb; Tue, 29 Mar 2016 21:51:19
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.6.0
In-Reply-To: <xmqqa8lhyzbq.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:qBfWcTyySGThh8wMFBp9R8vUQdbB5DUDR/f9QQkGyf9PUZUj8gP
 ywZ+83AwzrKGGmX8Ffvee4k7IDxiQfqPr/i8ULqKrO9erq5f09SOJflZcE+VedlBvk5eJwf
 dhp9ybnMIoIZ4+BmiCPFXVLmDXq5FrK/naYnbuXr7kAlqmgrwlT2r2GrIYwTrk/ij6veq36
 WrkKF67PYw0ILTiTINi3w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WH6CoW+UvZU=:q+JW9dbR5D4v+GrslYCmDR
 SdW0atnFTVymYxvIETfJ27d7rff6c6UuxPt8Sah0LgVDUgu9Zj3FEzLqNEIKVEFg/Y2YDHEeJ
 GPt9koJzyF5soGOvPTqizy4MgkSre0yvRwCsR9py7vKW7s0oP/R+hxA/Oslfx6iwB2JLm+eGN
 9Uaulk/Hg4qwOIdP9/pPBohF9B9KXV0nG8Smi+Ri+BcHxNl4yxzx+KBVRiChXfUlS0XFZ8dYp
 XFhu907bjUU3790eseLjC+340bXxqSmAN/8WElwlxSFt0A1eu16EMhE0oCB0QAceYwfcWtvum
 GfQdNfzCeyWj0FOFKr3qJLJvOqJ4QYY1oCpZsDIQOHib5FJO1k79FVwrf/6ZruOSYGn85ecOT
 NmFqUNq/eBaizdcitfQhUjWcUp3Xe0uU1jd/OKslObC4mNyCcKkaX9b/GB4vwn5/dey8VA3g8
 O8ruhDKX1l4b9LcBmY4Ts9QkPrO3GWs4ZV5UqZZlLqsXi8EF7SvJBUHF0lphvoP9AIJoYFUlb
 DBjiuwlmeKWW9TT6C43l9s+MgQSigxukUByBwWLzIsRkT7DMfkxhRpHQNVcXNGCQLYn/evbio
 LfAALhzSUNXRL+Gh9XkAY2gqeh46Ox58dLk+q3x9GN9t4jiis8JMtkFfL/3mywIWfe5jrNZh9
 aRFSyvQusizTDQzRiPwWioyk/17WliQAAU9qkmm5WXGvTZ5TMkrHYFzWKJBN5q12djXq7govv
 5HqeB35HBtA3fczohz+3hbTFPLD8ZwIYEGAcFcZQVtjEAMOdiDLE1P9GEwCCwxvxx5m7jxwP 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290177>

On 29.03.16 19:21, Junio C Hamano wrote:
> tboegi@web.de writes:
>=20
>> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>>
>> git blame reports lines as not "Not Committed Yet" when they have
>> CRLF in the index, CRLF in the worktree and e.g. core.autocrlf is tr=
ue.
>>
>> Since commit c48053 "new safer autocrlf handling", files that have C=
RLF
>> in the index are not normalized at commit when e.g. core.autocrl is =
set.
>>
>> Whenever a CLRF conversion is needed (or any filter us set), load th=
e
>> index temporally, before calling convert_to_git()
>=20
> Sorry, but I do not understand what problem you are trying to
> address here.
>=20
> Under the same condition described in the first paragraph, what
> would "git diff" and "git diff HEAD" say?  They should show that you
> would be making a commit that corrects the line ending of the blob
> recorded in the history.
>=20
Let's make an experiment, Git v2.8.0


$ printf "Line1\r\nLine2\r\n" >test_CRLF.txt
$ git add test_CRLF.txt=20
$ git commit -m "add test_CRLF.txt"
 [detached HEAD 719c166] add test_CRLF.txt
 1 file changed, 2 insertions(+)
 create mode 100644 test_CRLF.txt

$ git ls-files --eol test_CRLF.txt=20
i/crlf  w/crlf  attr/                   test_CRLF.txt
# So far, so good.

git config core.autocrlf true

# Now lets patch Git to debug the safer CRLF handling
diff --git a/convert.c b/convert.c
index f524b8d..fcf7653 100644
--- a/convert.c
+++ b/convert.c
@@ -260,8 +260,11 @@ static int crlf_to_git(const char *path, const cha=
r *src, size_t len,
                         * If the file in the index has any CR in it, d=
o not convert.
                         * This is the new safer autocrlf handling.
                         */
-                       if (has_cr_in_index(path))
+                       if (has_cr_in_index(path)) {
+                               fprintf(stderr, "%s/%s:%d has_cr_in_ind=
ex(%s)\n",
+                                       __FILE__, __FUNCTION__, __LINE_=
_, path);
                                return 0;
+                       }

# Of course, run make
$ make
#
printf "Line3\r\n" >>test_CRLF.txt

# Lets see what diff says:
=2E/git diff test_CRLF.txt | od -c
convert.c/crlf_to_git:265 has_cr_in_index(test_CRLF.txt)
convert.c/crlf_to_git:265 has_cr_in_index(test_CRLF.txt)
0000000    d   i   f   f       -   -   g   i   t       a   /   t   e   =
s
0000020    t   _   C   R   L   F   .   t   x   t       b   /   t   e   =
s
0000040    t   _   C   R   L   F   .   t   x   t  \n   i   n   d   e   =
x
0000060        4   a   a   5   5   1   d   .   .   d   0   f   a   f   =
1
0000100    d       1   0   0   6   4   4  \n   -   -   -       a   /   =
t
0000120    e   s   t   _   C   R   L   F   .   t   x   t  \n   +   +   =
+
0000140        b   /   t   e   s   t   _   C   R   L   F   .   t   x   =
t
0000160   \n   @   @       -   1   ,   2       +   1   ,   3       @   =
@
0000200   \n       L   i   n   e   1  \r  \n       L   i   n   e   2  \=
r
0000220   \n   +   l   i   n   e   3  \r  \n                           =
=20
0000231
# Here the lines are not going to be normalized at the next commit.
# They stay CRLF.
# But git blame doesn't know that, because has_cr_in_index doesn't work
# without an index.

$ ./git blame test_CRLF.txt=20
00000000 (Not Committed Yet 2016-03-29 21:44:48 +0200 1) Line1
00000000 (Not Committed Yet 2016-03-29 21:44:48 +0200 2) Line2
00000000 (Not Committed Yet 2016-03-29 21:44:48 +0200 3) line3



$ git commit -m "Add line3" test_CRLF.txt

> The "Not Committed Yet" output from "git blame" is the same thing.
> It is telling you that the commit you would be making by adding
> that path from the working tree in its current state will become
> the one that is responsible for the final state of the line.
>=20
> So it is absolutely the right thing that these lines are shown as
> "Not Commited Yet".  You will be making the line-ending correction
> for the entire blob, and you should be made aware of it.
If we had made the CRLF -> LF conversion, yes. But we don't do that.
crlf_to_git() returns without touching the line endings.
