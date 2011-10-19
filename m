From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: [IGNORETHIS/PATCH] Choosing the sha1 prefix of your commits
Date: Wed, 19 Oct 2011 20:03:24 +0200
Message-ID: <CACBZZX5PqYa0uWiGgs952rk2cy+QRCU95kF63qzSi3fKK-YrCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 19 20:03:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGaUK-0005Ay-BD
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 20:03:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169Ab1JSSD0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Oct 2011 14:03:26 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:32952 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750855Ab1JSSD0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Oct 2011 14:03:26 -0400
Received: by bkbzt19 with SMTP id zt19so2419030bkb.19
        for <git@vger.kernel.org>; Wed, 19 Oct 2011 11:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=rgsw39S5PpEknw3WbrxPO1jlQy9/1Qn+BSHBxzhOVGU=;
        b=AdYHMnpfLn2B5Lv3L8dBVbGwgRwuJHzSxGJJKid2rxT8hjqVUxDVvVkymM44sIDg02
         2Xl4J/9nh9RmkTTDGsR001c/Pt/eRdNpActRZyZ7GDQ6+T4bnquPTJorXgf/FRBYyCWY
         +xXxJfI2emP9rkguKbXVAuOg+5dHyzdjd5fEE=
Received: by 10.204.140.201 with SMTP id j9mr5875942bku.13.1319047404325; Wed,
 19 Oct 2011 11:03:24 -0700 (PDT)
Received: by 10.204.129.133 with HTTP; Wed, 19 Oct 2011 11:03:24 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183939>

You do not need to read this. Really, stop now.

This is quick hack I wrote just before leaving work to show that I
could indeed push patches to our main repository starting with
31337. Names hidden to protect the innocent.

With a quick call to getenv() i'll be easy to supply a prefix with an
environment variable, so you can have d00dbabe, deadbeef, b00b
etc. commits as time allows.

    < cow-orker-1> avar: what do I have to do to have all my
                            commit ids begin with 31337?
    < cow-orker-2> cow-orker-1: just figure out SHA1 collision
    < cow-orker-2> well with MD5 it is "easy" to have
                   same-prefix collisions, so you can
                   append junk that will be ignored or
                   have no effect, and have the same MD5
                   as the shorter version
    <@avar> It actually wouldn't be too hard to make all your commits
begin with 31337
    <@avar> I might patch my git client to do that
    <@avar> Basically the sha1 is a function of the commit object /
message / top-level tree
    <@avar> and any compliant git client ignores headers it doesn't kno=
w about
    <@avar> so you can just add a header "lulz %d"
    <@avar> where %d is a number you keep incrementing until your
resulting sha1 happens to begin with 31337
    <@avar> 31337 is a 5 character hex string, and 16^5/2 =3D 524288
    <@avar> so you'd on average have to generate half a million
commits before you'd get the desired results
    <@avar> which would slow down git somewhat at commit time, but not
much more than using svn :)
    < cow-orker-2> enjoy your 3MB commits
    < cow-orker-2> ah you can do that on the same header
    <@avar> yes
    < cow-orker-2> thanks, you just ruined my evening
    [...]
    <@avar> Also you don't have to waste your evening, I've implemented=
 this
    < cow-orker-1> \o/
    < cow-orker-3> hurry up and make a commit, already
    < cow-orker-3> [img-mj-popcorn.gif]
    <@avar> victory is mine: 313375d995e6f8b7773c6ed1ee165e5a9e15690b !

This is how you use it:

    $ time ~/g/git/git-commit -F /tmp/commit-message
    Try 0/4000000 to get a 1337 commit =3D
33d86a5a13ce07914a38ead3a517e391df0cc8c2
    Try 100000/4000000 to get a 1337 commit =3D
058e7663f54a3dd85e2c5a88cebf221ff7c25889
    Try 200000/4000000 to get a 1337 commit =3D
78839302cf449d088db1df5eb81f9116cbce55d0
    Try 300000/4000000 to get a 1337 commit =3D
f0af0cbe91d0ba8903085e2f867246095e6fb957
    Try 400000/4000000 to get a 1337 commit =3D
2068605f90321558e97ae5a083f63475ae2075ea
    Try 500000/4000000 to get a 1337 commit =3D
f8b4e2acd14ab111fd7957956368d181596bc6ef
    Try 600000/4000000 to get a 1337 commit =3D
3a479ab83d969f9b5638481445506036d1e1db46
    Try 700000/4000000 to get a 1337 commit =3D
29b98585b44c02e59240c1d8a1956ae434b3543f
    Try 800000/4000000 to get a 1337 commit =3D
8749e31c40200554b3758313cada1a3f596b0230
    Try 900000/4000000 to get a 1337 commit =3D
3fb2e617db95db8c027fba686c3f75eaa1b7f880
    commit id =3D 313375d995e6f8b7773c6ed1ee165e5a9e15690b
    [trunk 313375d] <censored>
     <censored>

    real    1m15.389s
    user    0m45.969s
    sys     0m29.368s

Which in just over a minute will generate, in my case:

    $ git show --pretty=3Draw 313375d995e6f8b7773c6ed1ee165e5a9e15690b =
| head -n 7
    commit 313375d995e6f8b7773c6ed1ee165e5a9e15690b
    tree c9bebc99c05dfe61cccf02ebdf442945c8ff8b3c
    parent 0dce2d45a79d26a593f0e12301cdfeb7eb23c17a
    author =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar@example.com> <c=
ensored> <censored>
    committer =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar@example.com>=
 <censored> <censored>
    lulz 697889

And this is the evil one-off code for this:

    diff --git a/commit.c b/commit.c
    index 73b7e00..71d1605 100644
    --- a/commit.c
    +++ b/commit.c
    @@ -853,2 +853,4 @@ int commit_tree(const char *msg, unsigned char =
*tree,
            int encoding_is_utf8;
    +       int try;
    +       int tries =3D 4000000;
            struct strbuf buffer;
    @@ -857,2 +859,5 @@ int commit_tree(const char *msg, unsigned char =
*tree,

    +       struct commit_list *parents_ptr =3D parents;
    +
    +       for (try =3D 0; try < tries; try++) {
            /* Not having i18n.commitencoding is the same as having utf=
-8 */
    @@ -872,3 +877,2 @@ int commit_tree(const char *msg, unsigned char =
*tree,
                            sha1_to_hex(parents->item->object.sha1));
    -               free(parents);
                    parents =3D next;
    @@ -876,2 +880,4 @@ int commit_tree(const char *msg, unsigned char =
*tree,

    +               parents =3D parents_ptr;
    +
            /* Person/date information */
    @@ -883,2 +889,4 @@ int commit_tree(const char *msg, unsigned char =
*tree,
                    strbuf_addf(&buffer, "encoding %s\n", git_commit_en=
coding);
    +
    +               strbuf_addf(&buffer, "lulz %d\n", try);
            strbuf_addch(&buffer, '\n');
    @@ -893,3 +901,21 @@ int commit_tree(const char *msg, unsigned char=
 *tree,
            result =3D write_sha1_file(buffer.buf, buffer.len, commit_t=
ype, ret);
    +
    +               if (result) {
    +                       die("failed to write commit object");
    +               } else {
    +                       if (strncmp(sha1_to_hex(ret), "31337", 5) =3D=
=3D 0) {
    +                               printf("commit id =3D %s\n",
sha1_to_hex(ret));
    +                               goto done;
    +                       } else {
    +                               if (try % 100000 =3D=3D 0) {
    +                                       fprintf(stderr, "Try %d/%d
to get a 1337 commit =3D %s\n", try, tries, sha1_to_hex(ret));
    +                               }
    +                               unlink_or_warn(sha1_file_name(ret))=
;
    +                       }
            strbuf_release(&buffer);
    +               }
    +       }
    +       done:
    +       strbuf_release(&buffer);
    +
            return result;

There's nothing new or novel about this. I just thought it would be
nice to share it. Someone asked me if having a "lulz" header wouldn't
break things, but since we introduced the "encoding" header a while
back clients have learned to ignore unknown headers, so it doesn't.

Which is why we can discuss e.g. adding GPG headers without worrying
about breaking everything.

I also think it's interesting that we seemingly don't have (in my
brief search, maybe I missed it) an API for writing a complete commit
object into a strbuf, so I had to write a lot of commit objects to
disk, and keep unlinking the unacceptable candidates so the repository
wouldn't balloon in size.
