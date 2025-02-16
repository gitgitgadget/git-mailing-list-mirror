Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4FB148318
	for <git@vger.kernel.org>; Sun, 16 Feb 2025 21:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739740399; cv=none; b=ZFB1iuFMWJzBYlLomUlmHcNjx5LlFMiq8W8NKbTseyklldKryur7LnehiK6WL4kBIt6eXCyYTgQ5KUSOzpj2G+3LWjNRVtSbzg3NDq3F83JRtPP+b2mH2t27cX3SwIY+AmA5sBWRJaE8jrP5W80FBwJFyiyDWW1QdLoPa+AGfAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739740399; c=relaxed/simple;
	bh=uyQ0tMNqjYTehgs30We+ucA9LP/WSJnHl7H+BR+HZsA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BAvN7OKNPW/UqPgBY5O0iVN1qkj61WJYVKgfcR64vhN0ElA7V/ZGKiWxty1MSQ6AyQedIAB72PmdMKDXypdXaOpcqit8inZHuGJAMqMNDHdlPpVI3Eq9bm9/ma8haLKcSsyNRmeJt/NY4mh6wLGrREoKLCVCD7TbNun28xZ2h18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L7yrvta8; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7yrvta8"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4395a06cf43so22759985e9.2
        for <git@vger.kernel.org>; Sun, 16 Feb 2025 13:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739740396; x=1740345196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rSGH1vSOjHPLQWylDcF29pwpJbulxwX+idDzK3dqFhY=;
        b=L7yrvta8HBqukqXnVr5BZ7XQtxFTUyQfSYNl+gxqURYqUozNniT54zI2poylnxXuje
         wUf1XDurDUA2Fg2d1ttx7E8mGqylsIFwIRrvzKKdVomBo5uoe/enzOXOOqJZxohqq6/2
         i6cL3FD+yB7Hm5qNB2HtbqJQ1NUd175x2RjsCiA19AdkpnIH0mtOAAW5i19jJ9PIBHU/
         nu0hc9wSYqF7MGBkl4xXKNJk4NMfJJTqw4Gcis8eo4FZbX1Yw1JllPHYo9/v49JpbsPm
         rJtPB2oFA2Rj8eJmw+ghHa/exitaBUeN7IrPdxbTttk7krf2LD8bTB2pbDml12jelBSC
         o5wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739740396; x=1740345196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rSGH1vSOjHPLQWylDcF29pwpJbulxwX+idDzK3dqFhY=;
        b=nRXM2Wa8NNM/GYKqyZJpCReU0FY49eWdv0BWIJwLGHBHKSK0KnBUKmeSNZTqdnczAK
         mZTV1IgV2OKgfNGXHAcnDkmQlYvtmRMbjXh7XICR7FEVUp4qa2z5p+coO6huvFvtGezC
         fzg2ojKjd14+s2denU8FfuC2OLZWHHhv/uNn45tKriGGScbrkdtoQ8IDmqKF7MALmVJx
         y0NXRqToc+vJhL9R57x/E2SD4EK/Hyv0z3WD++T/bTFyLopnp6hibluuWsnMQh0CKoLf
         4vZc0gjgPn1rVJmKF5vSBF5eS0QjFFALEQKB3ZpHqxWKk4RbiCyKR4BIh7gloiYck7nD
         oWqw==
X-Gm-Message-State: AOJu0Ywclv66/ZVwX8H6Z9d94bR87VlSINtsqyacFGkpXU4eTCryCpmZ
	ukvIKUwCrvFH/auqmkYtlSQf//mwOwwkNaVuhFVocRTYB0+AoOyU6t/sLVT8RzWrewN+oAfwo7w
	hmtuS2MnRoSBhCnDq9YODiwp9+quUN+Dj778=
X-Gm-Gg: ASbGncsdzJfPmrrRbcicZi2RNpc+9N8UFFrIGMTzrZamjjj5xt5XQcPeaJmNs6WUSvC
	ZUTk1bH9A9DGX82p7W1PzChkCRu7UEMYcw5GgCkupuFUcqQ8ahizdOiJaQ0Vtc8MWI+DhhJ9A
X-Google-Smtp-Source: AGHT+IGKUtP5zHthypGOZJ+Mk8RmTA/ApKUPyOtki6wk0na+ui6mxsQZP08CNyTDr4Jw/9X+k5sqm+5D8y3Nw9geCfk=
X-Received: by 2002:a5d:4684:0:b0:38d:d8c0:1f8c with SMTP id
 ffacd0b85a97d-38f3406cb07mr7304345f8f.38.1739740395691; Sun, 16 Feb 2025
 13:13:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO0eup=KqHe68OkHqYWtDgsTx0cAwg5Y5HSqK4s_BNbZhr8hVw@mail.gmail.com>
 <xmqqzfu7s5qg.fsf@gitster.g>
In-Reply-To: <xmqqzfu7s5qg.fsf@gitster.g>
From: Aleks Todorov <aleks.todorov.1337@gmail.com>
Date: Sun, 16 Feb 2025 21:13:04 +0000
X-Gm-Features: AWEUYZlY8H4JYy-H671NzAzyCK5iTm867nfstRweQ-jzHvMtzbEYtvMfpkx0VLI
Message-ID: <CAO0eup=6NcCdBASxvAxB8moku74zpxAr+MFiV-kkXVfjY1UF=w@mail.gmail.com>
Subject: Re: Add Commit Summary in blame?
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I know it's been a while, but thank you for your reply! I was quite interes=
ted
in this format option and have wanted to implement it since. I finally have
some free time.

I've written a barebones implementation just to play around with the code a=
nd
see it work.

Before I continue, I wanted to know, should we re-implement the git log
implementation or refactor it to make it reusable? I lean into the latter,
however if the implementation is shared, that means we need a way to saniti=
ze
user input to ensure they are not using flags which are not allowed, and we
will also need to pollute the implementation with length specifiers everywh=
ere
since each field in the blame output needs to be width-aligned.

So far, this is what I've been able to output:

  > ./git-blame builtin/blame.c -F '%h fname (%an %ad line) '

  d48be35ca6f fname (Elijah Newren Tue Mar 21 06:26:07 2023 +0000
line) #include "write-or-die.h"
  cee7f245dca fname (Junio C Hamano Thu Oct 19 16:00:04 2006 -0700 line)
  ce41720cad7 fname (Alex Henrie Thu Apr 2 15:26:56 2015 -0600 line)
static char blame_usage[] =3D N_("git blame [<options>] [<rev-opts>]
[<rev>] [--] <file>");
  df8738116f7 fname (=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason Thu Oct 13 17:3=
9:20 2022
+0200 line) static char annotate_usage[] =3D N_("git annotate
[<options>] [<rev-opts>] [<rev>] [--] <file>");
  5817da01434 fname (Pierre Habouzit Tue Jul 8 15:19:34 2008 +0200 line)
  5817da01434 fname (Pierre Habouzit Tue Jul 8 15:19:34 2008 +0200
line) static const char *blame_opt_usage[] =3D {
  5817da01434 fname (Pierre Habouzit Tue Jul 8 15:19:34 2008 +0200
line)  blame_usage,
  5817da01434 fname (Pierre Habouzit Tue Jul 8 15:19:34 2008 +0200 line)  "=
",
  9c9b4f2f8b7 fname (Alex Henrie Tue Jan 13 00:44:47 2015 -0700 line)
   N_("<rev-opts> are documented in git-rev-list(1)"),
  5817da01434 fname (Pierre Habouzit Tue Jul 8 15:19:34 2008 +0200 line)  N=
ULL
  5817da01434 fname (Pierre Habouzit Tue Jul 8 15:19:34 2008 +0200 line) };
  cee7f245dca fname (Junio C Hamano Thu Oct 19 16:00:04 2006 -0700 line)

This is the code I have, reusing the log impl (avoided formatting existing =
code
for brevity):

  diff --git a/builtin/blame.c b/builtin/blame.c
  index c470654c7e..7a7be7b36d 100644
  --- a/builtin/blame.c
  +++ b/builtin/blame.c
  @@ -66,6 +66,7 @@ static int xdl_opts;
   static int abbrev =3D -1;
   static int no_whole_file_rename;
   static int show_progress;
  +static char *user_format =3D NULL;
   static char repeated_meta_color[COLOR_MAXLEN];
   static int coloring_mode;
   static struct string_list ignore_revs_file_list =3D STRING_LIST_INIT_DUP=
;
  @@ -506,6 +507,17 @@ static void emit_other(struct blame_scoreboard
*sb, struct blame_entry *ent, int
                          putchar('?');
                  }

  +               if (user_format) {
  +                       struct strbuf sb =3D STRBUF_INIT;
  +                       struct pretty_print_context context =3D {
  +                               .fmt =3D CMIT_FMT_USERFORMAT,
  +                               .abbrev =3D abbrev,
  +                       };
  +                       repo_format_commit_message(the_repository,
  +                                                  suspect->commit,
user_format,
  +                                                  &sb, &context);
  +                       printf("%s", sb.buf);
  +               } else {
                  printf("%.*s", (int)(length < GIT_MAX_HEXSZ ? length
: GIT_MAX_HEXSZ), hex);
                  if (opt & OUTPUT_ANNOTATE_COMPAT) {
                          const char *name;
  @@ -546,6 +558,7 @@ static void emit_other(struct blame_scoreboard
*sb, struct blame_entry *ent, int
                          printf(" %*d) ",
                                 max_digits, ent->lno + 1 + cnt);
                  }
  +               }
                  if (reset)
                          fputs(reset, stdout);
                  do {
  @@ -905,6 +918,7 @@ int cmd_blame(int argc,
                  OPT_BIT('t', NULL, &output_option, N_("show raw
timestamp (Default: off)"), OUTPUT_RAW_TIMESTAMP),
                  OPT_BIT('l', NULL, &output_option, N_("show long
commit SHA1 (Default: off)"), OUTPUT_LONG_OBJECT_NAME),
                  OPT_BIT('s', NULL, &output_option, N_("suppress
author name and timestamp (Default: off)"), OUTPUT_NO_AUTHOR),
  +               OPT_STRING('F', "format", &user_format,
N_("format"), N_("print blame entries in the given <format>")),
                  OPT_BIT('e', "show-email", &output_option, N_("show
author email instead of name (Default: off)"), OUTPUT_SHOW_EMAIL),
                  OPT_BIT('w', NULL, &xdl_opts, N_("ignore whitespace
differences"), XDF_IGNORE_WHITESPACE),
                  OPT_STRING_LIST(0, "ignore-rev", &ignore_rev_list,
N_("rev"), N_("ignore <rev> when blaming")),
