From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH] git bisect old/new
Date: Tue, 12 Jun 2012 15:41:02 -0400
Message-ID: <CABURp0rWu0GtmSrLV+qEQJVYOt8p=B4bQtG3fzKh2f0fTGHwOQ@mail.gmail.com>
References: <1339466625-17461-1-git-send-email-Valentin.Duperray@ensimag.imag.fr>
 <CAP8UFD1mgKNQRZpuqYgyL__DGpoZ3cOGJC0amoqWT+1Bn_0iTg@mail.gmail.com> <7v1ull5bld.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <christian.couder@gmail.com>,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	git@vger.kernel.org, Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 12 21:41:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeWy6-0007zb-7p
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 21:41:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752052Ab2FLTl3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Jun 2012 15:41:29 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:49883 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612Ab2FLTl2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jun 2012 15:41:28 -0400
Received: by yhmm54 with SMTP id m54so3784282yhm.19
        for <git@vger.kernel.org>; Tue, 12 Jun 2012 12:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=6NKiv7L5nLxv3OrvZp4PlOOtQX8HW7ExY1++5wrRfh4=;
        b=ifK9SVuGRxN/TYhuCwF8LMub16LeeLXHqltrlArHSCi5SS/dhPTqca1LxEfY0DDymu
         j3P+r4nXwsIYeOlCk5k+w3RCX9J8ssQqunXEr6MxWUDbfldLe93wxWQIyM4G11Hq44ps
         6/UHhQ5ioK2w52pkgPMTN+0z5haDwC8XGQYz1EA4E9gqEhVPLqfpczSxn0/iwMoB6/ps
         qOryi403ZulW4lwnaIIXZKxtPZcxx0i4WN3fJwUfDD0SKS24NynnISFFkBWk0vdo99fm
         5mecbJFURimFiU63c+8N/n7DQcBBnaZrI9czil72OcY9kgzttCWa2EXyZ5yifyTNmX9N
         QY0A==
Received: by 10.236.46.74 with SMTP id q50mr29560526yhb.30.1339530082919; Tue,
 12 Jun 2012 12:41:22 -0700 (PDT)
Received: by 10.146.150.18 with HTTP; Tue, 12 Jun 2012 12:41:02 -0700 (PDT)
In-Reply-To: <7v1ull5bld.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199843>

On Tue, Jun 12, 2012 at 1:43 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> Thanks for comments.
>
> > If you used some design that was discussed on the mailing list or i=
f
> > there have been relevant discussions on the mailing list, it would =
be
> > nice to have links to the email thread in the commit message.
>
> Perhaps.
>
> >> + git bisect new [<rev>]
> >> + git bisect old [<rev>...]
> >
> > maybe:
> >
> > git bisect (bad|new) [<rev>]
> > git bisect (good|old) [<rev>...]
>
> Definitely.
>
> >> @@ -104,6 +106,44 @@ For example, `git bisect reset HEAD` will lea=
ve
> >> you on the current
> >> =A0bisection commit and avoid switching commits at all, while `git=
 bisect
> >> =A0reset bisect/bad` will check out the first bad revision.
> >>
> >> +Alternative research: bisect new and bisect old
> >> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> +
> >> +If you are not looking for a regression but for a change of a giv=
en
> >> +property, you can use:
> >
> > I would rather say:
> > ...
>
> Good.
>
> >> @@ -403,9 +406,10 @@ struct commit_list *find_bisection(struct
> >> commit_list *list,
> >> =A0static int register_ref(const char *refname, const unsigned cha=
r
> >> *sha1,
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int flags, void *cb=
_data)
> >> =A0{
> >> - =A0 =A0 =A0 if (!strcmp(refname, "bad")) {
> >> + =A0 =A0 =A0 if (!strcmp(refname, bisect_term_bad)) {
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0current_bad_sha1 =3D sha1;
> >> - =A0 =A0 =A0 } else if (!prefixcmp(refname, "good-")) {
> >> + =A0 =A0 =A0 } else if (!prefixcmp(refname, "good-") ||
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !prefixcmp(refname, =
"old-")) {
> >
> > I don't like very much "good" and "old" to be hardcoded here.
>
> Really?

I tend to agree.  But I like more generic code and less hard-coded in
almost all cases.


> >> @@ -731,18 +735,25 @@ static void handle_bad_merge_base(void)
> >> =A0 =A0 =A0 =A0if (is_expected_rev(current_bad_sha1)) {
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0char *bad_hex =3D sha1_to_hex(curre=
nt_bad_sha1);
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0char *good_hex =3D join_sha1_array_=
hex(&good_revs, ' ');
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!strcmp(bisect_term_bad,"bad")) =
{
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fprintf(stderr, "The=
 merge base %s is bad.\n"
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Thi=
s means the bug has been fixed "
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "bet=
ween %s and [%s].\n",
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bad_=
hex, bad_hex, good_hex);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fprintf(stderr, "The=
 merge base %s is new.\n"
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "The=
 property has changed "
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "bet=
ween %s and [%s].\n",
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bad_=
hex, bad_hex, good_hex);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >
> > I don't like very much "new" to be harcoded here too.
>
> Why not? =A0It is not like we will be adding any more synonym pair
> beyond good/bad, so...

Previously we discussed using yes/no, among others.
http://permalink.gmane.org/gmane.comp.version-control.git/182496

>
> >>
> >> =A0/*
> >> - * "check_merge_bases" checks that merge bases are not "bad".
> >> + * "check_merge_bases" checks that merge bases are not "bad" (res=
p.
> >> "new").
> >> =A0*
> >> - * - If one is "bad", it means the user assumed something wrong
> >> + * - If one is "bad" (resp. "new"), it means the user assumed
> >> something wrong
> >> =A0* and we must exit with a non 0 error code.
> >> - * - If one is "good", that's good, we have nothing to do.
> >> + * - If one is "good" (resp. "old"), that's good, we have nothing=
 to
> >> do.
> >> =A0* - If one is "skipped", we can't know but we should warn.
> >> =A0* - If we don't know, we should check it out and ask the user t=
o test.
> >> =A0*/
> >
> > I am not sure changing the comments is worth it...
>
> I think it is probably a good idea to cast in stone that we support
> two pairs, i.e. good/bad or old/new. =A0I would have said "or" instea=
d
> of "resp." above, though.
>
> >> @@ -889,6 +901,30 @@ static void show_diff_tree(const char *prefix=
,
> >> struct commit *commit)
> >> =A0}
> >>
> >> =A0/*
> >> + * The terms used for this bisect session are stocked in
> >> + * BISECT_TERMS: it can be bad/good or new/old.
> >
> > I am not sure saying "it can be bad/good or new/old" adds anything.
>
> It makes it clear that we are not allowing arbitrary pair of words
> to substitute the good/bad pair, which is a plus.
>
> >> +void read_bisect_terms(void)
> >> +{
> >> + =A0 =A0 =A0 struct strbuf str =3D STRBUF_INIT;
> >> + =A0 =A0 =A0 const char *filename =3D git_path("BISECT_TERMS");
> >> + =A0 =A0 =A0 FILE *fp =3D fopen(filename, "r");
> >> +
> >> + =A0 =A0 =A0 if (!fp)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 die_errno("Could not open file '%s'"=
, filename);
> >
> > This is not very compatible with older git versions.
> > I know that it's kind of strange to upgrade git in the middle of a
> > bisection but why not just use "bad"/"good" if there is no file?
>
> Good thinking.
>
> >> @@ -898,6 +934,8 @@ static void show_diff_tree(const char *prefix,
> >> struct commit *commit)
> >> =A0*/
> >> =A0int bisect_next_all(const char *prefix, int no_checkout)
> >> =A0{
> >> + =A0 =A0 =A0 read_bisect_terms();
> >> +
> >> =A0 =A0 =A0 =A0struct rev_info revs;
> >> =A0 =A0 =A0 =A0struct commit_list *tried;
> >> =A0 =A0 =A0 =A0int reaches =3D 0, all =3D 0, nr, steps;
> >
> > We put all declarations at the beginning of functions.
>
> Good eyes.
>
> >> @@ -22,7 +22,15 @@ git bisect replay <logfile>
> >> =A0git bisect log
> >> =A0 =A0 =A0 =A0show bisect log.
> >> =A0git bisect run <cmd>...
> >> - =A0 =A0 =A0 use <cmd>... to automatically bisect.
> >> + =A0 =A0 =A0 use <cmd>... to automatically bisect
> >
> > Why this change?
>
> To end a sentence with a full-stop?

I think you read this backwards.  This change removes the full-stop.

Phil
