From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] build: get rid of the notion of a git library
Date: Sun, 9 Jun 2013 12:45:07 -0500
Message-ID: <CAMP44s2h1Oj=qFkrsH9L4cZ0VZYbRHbo4eqmDxoTe36HiHXsxQ@mail.gmail.com>
References: <CALkWK0mA7MXQv1k5bFpZLARDOHxU5kzKFXzcyUfb6NLZZY-=FA@mail.gmail.com>
	<CAMP44s0cozMsTo7KQAjnqkqmvMwMw9D3SZrVxg48MOXkH9UQJQ@mail.gmail.com>
	<CALkWK0=7PRndNc7XQ-PCPbVCp9vck909bA561JhQG6uXXj1n4g@mail.gmail.com>
	<20130609151235.GA22905@serenity.lan>
	<CAMP44s0L9nQxp5OeK8uT4Ls5WUerCjVpR9uONUcOwvTD6k7Jfg@mail.gmail.com>
	<20130609160225.GB22905@serenity.lan>
	<CAMP44s0Zsejk4Ex6QfzOFOom3cyWv_hziWGkAK-LawSUkT9V3Q@mail.gmail.com>
	<20130609164248.GD22905@serenity.lan>
	<CALkWK0k=39-Cq3vNdrpLPTWa0wgkqLM=7c=cAmL0nvx0MT5mkA@mail.gmail.com>
	<CAMP44s1PENiKMy03_mgZ_myiGP5+qpaE2bvo0LN3X3mZhSvT2g@mail.gmail.com>
	<20130609173257.GE22905@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Jun 09 19:45:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uljg5-0006l1-GJ
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 19:45:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751700Ab3FIRpK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 13:45:10 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:57959 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751580Ab3FIRpJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jun 2013 13:45:09 -0400
Received: by mail-lb0-f172.google.com with SMTP id v20so1149629lbc.3
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 10:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=k715CTErYe8zqA0M+usDfubgrpTq6ysdQo854gBlPDo=;
        b=0hlZKwmtZBJT8FRL9Tpdto0yoUqrtLq041360dWvhE0o61KCWn6xM9K5bY2NDb0ZYn
         ipldpRo0B0Je92Hs0Q08vLohesIwkKdV2m+IocCvG3FxGrOm1i1g0YDntpdyP+CJ276i
         nraKGr0uuJh/3gweGWorjh3EFNuqHJK2QikL4jhmafefHDtudNY+0zrB6dvOAQz9nmzB
         8UntuPLGn9i267NOMcPeFRTDkQ+UaRRfM9r2Qfymoftwtp0Xh9A2hSDF08ynNFY+teDe
         lFVxI4n7I13/H7zhHU27WWpMS6E6w0LaSzl7vsHSnivOOWrbnPao2vtSKsYOwkT+RURA
         RLCA==
X-Received: by 10.152.27.170 with SMTP id u10mr3323569lag.45.1370799907472;
 Sun, 09 Jun 2013 10:45:07 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sun, 9 Jun 2013 10:45:07 -0700 (PDT)
In-Reply-To: <20130609173257.GE22905@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227050>

On Sun, Jun 9, 2013 at 12:32 PM, John Keeping <john@keeping.me.uk> wrot=
e:
> On Sun, Jun 09, 2013 at 12:13:41PM -0500, Felipe Contreras wrote:
>> On Sun, Jun 9, 2013 at 12:03 PM, Ramkumar Ramachandra
>> <artagnon@gmail.com> wrote:
>> > John Keeping wrote:
>> >> Calling across from one builtin/*.c file to another is just as wr=
ong as
>> >> calling into a builtin/*.c file from a top-level file but the bui=
ld
>> >> system happens not to enforce the former.
>> >
>> > So libgit.a is a collection of everything that is shared between
>> > builtins?  Does that correspond to reality?
>
> I think that's *precisely* what libgit.a is.

We don't care what libgit.a is; the important thing is what it *should*=
 be.

> A quick check with "git log -S..." shows that most of these have bare=
ly
> been touched since the builtin/ directory was created.  So the reason
> they're not static is most likely because no one has tidied them up
> since the division between builtins was introduced.
>
> It is a fact of life that as we live and work with a system we realis=
e
> that there may be a better way of doing something.  This doesn't mean
> that someone needs to immediately convert everything to the new way,
> it is often sufficient to do new things in the new way and slowly mov=
e
> existing things across as and when they are touched for other reasons=
=2E

Really?

builtin/ls-files.c:307:13: error: static declaration of
=E2=80=98overlay_tree_on_cache=E2=80=99 follows non-static declaration
 static void overlay_tree_on_cache(const char *tree_name, const char *p=
refix)
             ^
In file included from builtin/ls-files.c:8:0:
=2E/cache.h:1318:6: note: previous declaration of =E2=80=98overlay_tree=
_on_cache=E2=80=99 was here
 void overlay_tree_on_cache(const char *tree_name, const char *prefix);
      ^
builtin/ls-files.c:361:12: error: static declaration of
=E2=80=98report_path_error=E2=80=99 follows non-static declaration
 static int report_path_error(const char *ps_matched, const char
**pathspec, const char *prefix)
            ^
In file included from builtin/ls-files.c:8:0:
=2E/cache.h:1317:5: note: previous declaration of =E2=80=98report_path_=
error=E2=80=99 was here
 int report_path_error(const char *ps_matched, const char **pathspec,
const char *prefix);
     ^
make: *** [builtin/ls-files.o] Error 1
make: *** Waiting for unfinished jobs....
builtin/add.c:184:12: error: static declaration of
=E2=80=98add_files_to_cache=E2=80=99 follows non-static declaration
 static int add_files_to_cache(const char *prefix, const char
**pathspec, int flags)
            ^
In file included from builtin/add.c:6:0:
=2E/cache.h:1283:5: note: previous declaration of =E2=80=98add_files_to=
_cache=E2=80=99 was here
 int add_files_to_cache(const char *prefix, const char **pathspec, int =
flags);
     ^
builtin/add.c:280:12: error: static declaration of
=E2=80=98run_add_interactive=E2=80=99 follows non-static declaration
 static int run_add_interactive(const char *revision, const char *patch=
_mode,
            ^
In file included from ./builtin.h:7:0,
                 from builtin/add.c:7:
=2E/commit.h:187:12: note: previous declaration of =E2=80=98run_add_int=
eractive=E2=80=99 was here
 extern int run_add_interactive(const char *revision, const char *patch=
_mode,
            ^
builtin/add.c:309:12: error: static declaration of =E2=80=98interactive=
_add=E2=80=99
follows non-static declaration
 static int interactive_add(int argc, const char **argv, const char
*prefix, int patch)
            ^
In file included from ./builtin.h:7:0,
                 from builtin/add.c:7:
=2E/commit.h:186:12: note: previous declaration of =E2=80=98interactive=
_add=E2=80=99 was here
 extern int interactive_add(int argc, const char **argv, const char
*prefix, int patch);
            ^
builtin/add.c:184:12: warning: =E2=80=98add_files_to_cache=E2=80=99 def=
ined but not
used [-Wunused-function]
 static int add_files_to_cache(const char *prefix, const char
**pathspec, int flags)
            ^
make: *** [builtin/add.o] Error 1
builtin/fmt-merge-msg.c:19:12: error: static declaration of
=E2=80=98fmt_merge_msg_config=E2=80=99 follows non-static declaration
 static int fmt_merge_msg_config(const char *key, const char *value, vo=
id *cb)
            ^
In file included from builtin/fmt-merge-msg.c:9:0:
=2E/fmt-merge-msg.h:5:12: note: previous declaration of
=E2=80=98fmt_merge_msg_config=E2=80=99 was here
 extern int fmt_merge_msg_config(const char *key, const char *value, vo=
id *cb);
            ^
builtin/fmt-merge-msg.c:592:12: error: static declaration of
=E2=80=98fmt_merge_msg=E2=80=99 follows non-static declaration
 static int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
            ^
In file included from builtin/fmt-merge-msg.c:1:0:
=2E/builtin.h:26:12: note: previous declaration of =E2=80=98fmt_merge_m=
sg=E2=80=99 was here
 extern int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
            ^
make: *** [builtin/fmt-merge-msg.o] Error 1
builtin/init-db.c:316:12: error: static declaration of
=E2=80=98set_git_dir_init=E2=80=99 follows non-static declaration
 static int set_git_dir_init(const char *git_dir, const char *real_git_=
dir,
            ^
In file included from builtin/init-db.c:6:0:
=2E/cache.h:421:12: note: previous declaration of =E2=80=98set_git_dir_=
init=E2=80=99 was here
 extern int set_git_dir_init(const char *git_dir, const char
*real_git_dir, int);
            ^
builtin/init-db.c:368:12: error: static declaration of =E2=80=98init_db=
=E2=80=99
follows non-static declaration
 static int init_db(const char *template_dir, unsigned int flags)
            ^
In file included from builtin/init-db.c:6:0:
=2E/cache.h:422:12: note: previous declaration of =E2=80=98init_db=E2=80=
=99 was here
 extern int init_db(const char *template_dir, unsigned int flags);
            ^
make: *** [builtin/init-db.o] Error 1
builtin/shortlog.c:110:13: error: static declaration of
=E2=80=98shortlog_add_commit=E2=80=99 follows non-static declaration
 static void shortlog_add_commit(struct shortlog *log, struct commit *c=
ommit)
             ^
In file included from builtin/shortlog.c:9:0:
=2E/shortlog.h:24:6: note: previous declaration of =E2=80=98shortlog_ad=
d_commit=E2=80=99 was here
 void shortlog_add_commit(struct shortlog *log, struct commit *commit);
      ^
builtin/shortlog.c:207:13: error: static declaration of
=E2=80=98shortlog_init=E2=80=99 follows non-static declaration
 static void shortlog_init(struct shortlog *log)
             ^
In file included from builtin/shortlog.c:9:0:
=2E/shortlog.h:22:6: note: previous declaration of =E2=80=98shortlog_in=
it=E2=80=99 was here
 void shortlog_init(struct shortlog *log);
      ^
builtin/shortlog.c:287:13: error: static declaration of
=E2=80=98shortlog_output=E2=80=99 follows non-static declaration
 static void shortlog_output(struct shortlog *log)
             ^
In file included from builtin/shortlog.c:9:0:
=2E/shortlog.h:26:6: note: previous declaration of =E2=80=98shortlog_ou=
tput=E2=80=99 was here
 void shortlog_output(struct shortlog *log);
      ^
builtin/shortlog.c:287:13: warning: =E2=80=98shortlog_output=E2=80=99 d=
efined but not
used [-Wunused-function]
 static void shortlog_output(struct shortlog *log)
             ^
make: *** [builtin/shortlog.o] Error 1
builtin/stripspace.c:36:13: error: static declaration of =E2=80=98strip=
space=E2=80=99
follows non-static declaration
 static void stripspace(struct strbuf *sb, int skip_comments)
             ^
In file included from ./builtin.h:5:0,
                 from builtin/stripspace.c:1:
=2E/strbuf.h:165:13: note: previous declaration of =E2=80=98stripspace=E2=
=80=99 was here
 extern void stripspace(struct strbuf *buf, int skip_comments);
             ^
make: *** [builtin/stripspace.o] Error 1
make[2]: `GIT-VERSION-FILE' is up to date.
builtin/prune-packed.c:37:13: error: static declaration of
=E2=80=98prune_packed_objects=E2=80=99 follows non-static declaration
 static void prune_packed_objects(int opts)
             ^
In file included from builtin/prune-packed.c:1:0:
=2E/builtin.h:18:13: note: previous declaration of =E2=80=98prune_packe=
d_objects=E2=80=99 was here
 extern void prune_packed_objects(int);
             ^
make: *** [builtin/prune-packed.o] Error 1
builtin/notes.c:358:34: error: static declaration of
=E2=80=98init_copy_notes_for_rewrite=E2=80=99 follows non-static declar=
ation
 static struct notes_rewrite_cfg *init_copy_notes_for_rewrite(const cha=
r *cmd)
                                  ^
In file included from builtin/notes.c:11:0:
=2E/builtin.h:39:27: note: previous declaration of
=E2=80=98init_copy_notes_for_rewrite=E2=80=99 was here
 struct notes_rewrite_cfg *init_copy_notes_for_rewrite(const char *cmd)=
;
                           ^
builtin/notes.c:396:12: error: static declaration of
=E2=80=98copy_note_for_rewrite=E2=80=99 follows non-static declaration
 static int copy_note_for_rewrite(struct notes_rewrite_cfg *c,
            ^
In file included from builtin/notes.c:11:0:
=2E/builtin.h:40:5: note: previous declaration of =E2=80=98copy_note_fo=
r_rewrite=E2=80=99 was here
 int copy_note_for_rewrite(struct notes_rewrite_cfg *c,
     ^
builtin/notes.c:406:13: error: static declaration of
=E2=80=98finish_copy_notes_for_rewrite=E2=80=99 follows non-static decl=
aration
 static void finish_copy_notes_for_rewrite(struct notes_rewrite_cfg *c)
             ^
In file included from builtin/notes.c:11:0:
=2E/builtin.h:42:6: note: previous declaration of
=E2=80=98finish_copy_notes_for_rewrite=E2=80=99 was here
 void finish_copy_notes_for_rewrite(struct notes_rewrite_cfg *c);
      ^
make: *** [builtin/notes.o] Error 1
builtin/blame.c:112:12: error: static declaration of =E2=80=98textconv_=
object=E2=80=99
follows non-static declaration
 static int textconv_object(const char *path,
            ^
In file included from builtin/blame.c:8:0:
=2E/builtin.h:44:12: note: previous declaration of =E2=80=98textconv_ob=
ject=E2=80=99 was here
 extern int textconv_object(const char *path, unsigned mode, const
unsigned char *sha1, int sha1_valid, char **buf, unsigned long
*buf_size);
            ^
make: *** [builtin/blame.o] Error 1

--=20
=46elipe Contreras
