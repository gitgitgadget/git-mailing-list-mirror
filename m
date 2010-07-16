From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] grep: Don't pass a TODO test if REG_STARTEND is supported
Date: Fri, 16 Jul 2010 20:51:24 +0000
Message-ID: <AANLkTikDwJaBN8Y0814m6JaVab9BAXPx_VKE7Z_Q6hq7@mail.gmail.com>
References: <1278549735-19278-1-git-send-email-avarab@gmail.com>
	<7viq4ppxt9.fsf@alter.siamese.dyndns.org>
	<AANLkTikuGY4LVrCB6UoGFhxthoI8MgvAXCwCbiXhwq_d@mail.gmail.com>
	<7vtyo0vdpz.fsf@alter.siamese.dyndns.org>
	<AANLkTim-4I5Sdu653yJOmnVYDqI8bb71839Vqfd3FKCi@mail.gmail.com>
	<AANLkTimZ3f550HQwx3OEpO6n1b037He6hJ6rAXP8vfIk@mail.gmail.com>
	<20100716195007.GC16371@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 16 22:51:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZrsZ-0003lR-Do
	for gcvg-git-2@lo.gmane.org; Fri, 16 Jul 2010 22:51:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759312Ab0GPUv0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Jul 2010 16:51:26 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56085 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758829Ab0GPUvZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Jul 2010 16:51:25 -0400
Received: by iwn7 with SMTP id 7so2518888iwn.19
        for <git@vger.kernel.org>; Fri, 16 Jul 2010 13:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9cAmdILHaZhjZCAHZeckPD7HUgyRp5PNX7r71bp1Nkk=;
        b=sblOkGISyu2RwLymHUSRIvhTHdWIvnSjUh22oiOSEks5/HgWrdcmJaBAif7BfQoFI9
         adMyH+ip6F25/GapGguwc6rnKhByIXbhM0dD4Xc/L8CTxUfb7g/km0r2vlvzcKYv7nVc
         F10Q+RfKQvaXawElWzuxWKQz/qMclAxoZhZmQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=uD7NWYHuwkNCa0fjiWZ1+ifhoyHPjIKAp2RMFz78JQb3Z+0E1zA5JZ+VO5n5rbEf/6
         PggqKgRB1a+fVvvILe0lUPWP+a0wjwMymZmQt9QG9X/DAhA8SkUgzPgocyOyHGE0m5iu
         icZwK8mNoQL41RX8rZpLAS+a9DAEfXEiqpQw8=
Received: by 10.231.191.6 with SMTP id dk6mr1473521ibb.51.1279313484922; Fri, 
	16 Jul 2010 13:51:24 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Fri, 16 Jul 2010 13:51:24 -0700 (PDT)
In-Reply-To: <20100716195007.GC16371@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151170>

On Fri, Jul 16, 2010 at 19:50, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> Well to clarify: The TAP is arguably right, although semantically
>> these sort of tests should probably be a SKIP on unsupported
>> platforms, not a passing TODO.
>
> No, we support all platforms people are willing to fix without
> uglifying the code too much. =C2=A0So a bug is a bug. =C2=A0Test
> prerequisites get used for behavior that is either out of scope
> (Posix-style permissions on Windows) or hard to test (signal
> delivery to child process in t7502-commit).
>
> The semantic problem you are describing here is that we have no
> separate way to mark bugs that are not consistently reproducible.
> A =E2=80=9Cfixed=E2=80=9D test_expect_failure is sometimes a fluke, l=
ike in this
> example.
>
> If lucky, you can find an appropriate condition and use
> test_expect_success or test_expect_failure as appropriate. =C2=A0In
> the general case, that is not always easy. =C2=A0Better to eliminate =
the
> unreproducible bugs.

The failure is totally predicated on whether or not REG_STARTEND is
available on the system, so in a perfect world (where we couldn't
provide a compat regex library) we should detect whether REG_STARTEND
is defined in regex.h, and then stick it in GIT-BUILD-OPTIONS.

Then you could do:

    test_expect_success REG_STARTEND 'git grep ile a' '
        git grep ile a
    '

But it's much easier to just fix the replacement regex library so the
test works everywhere instead of detecting for REG_STARTEND
(e.g. using a helper).

>> On Thu, Jul 15, 2010 at 18:44, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmaso=
n <avarab@gmail.com> wrote:
>
>>> We should also just upgrade the GNU regex library in compat/regex t=
o
>>> the version that supports REG_STARTEND.
> [...]
>> This is what we should be focusing on
>
> By the way, I have no preference for choice of regex library here. =C2=
=A0If
> something else is easier to get working correctly, that would be grea=
t.

The glibc one is probably pretty good as far as minimal POSIX DFA
engines go. Hopefully you can patch it up to get it to compile on
non-GNU systems.

More generally, the regex use in Git is something I've wanted to look
at more closely. Right now a bunch of Git tools use regexes in one
form or another, but they don't do so consistently:

    config.c:847:		  !regexec(store.value_regex, value, 0, NULL, 0)));
    config.c:1155:			if (regcomp(store.value_regex, value_regex,
    builtin/remote.c:1432:	if (regcomp(&old_regex, oldurl, REG_EXTENDED=
))
    builtin/remote.c:1436:		if (!regexec(&old_regex, urlset[i], 0, NULL=
, 0))
    builtin/blame.c:1963:	if (!(reg_error =3D regcomp(&regexp, spec + 1=
,
REG_NEWLINE)) &&
    builtin/blame.c:1964:	    !(reg_error =3D regexec(&regexp, line, 1,
match, 0))) {
    builtin/config.c:104:	if (use_key_regexp && regexec(key_regexp,
key_, 0, NULL, 0))
    builtin/config.c:107:	    (do_not_match ^ !!regexec(regexp,
(value_?value_:""), 0, NULL, 0)))
    builtin/config.c:177:		if (regcomp(key_regexp, key, REG_EXTENDED)) =
{
    builtin/config.c:190:		if (regcomp(regexp, regex_, REG_EXTENDED)) {
    builtin/apply.c:579:		if (regcomp(stamp, stamp_regexp, REG_EXTENDED=
)) {
    builtin/apply.c:586:	status =3D regexec(stamp, timestamp,
ARRAY_SIZE(m), m, 0);
    sha1_name.c:703:	if (regcomp(&regex, prefix, REG_EXTENDED))
    sha1_name.c:729:		if (!regexec(&regex, p + 2, 0, NULL, 0)) {
    diff.c:779:		if (!regexec(word_regex, buffer->ptr + *begin, 1, matc=
h, 0)) {
    diff.c:2011:				if (regcomp(ecbdata.diff_words->word_regex,
    xdiff-interface.c:276:		if (!regexec(&reg->re, line_buffer, 2, pmat=
ch, 0)) {
    xdiff-interface.c:323:		if (regcomp(&reg->re, expression, cflags))
    diffcore-pickaxe.c:29:		while (*data && !regexec(regexp, data, 1,
&regmatch, flags)) {
    diffcore-pickaxe.c:62:		err =3D regcomp(&regex, needle, REG_EXTENDE=
D
| REG_NEWLINE);
    grep.c:73:	err =3D regcomp(&p->regexp, p->pattern, opt->regflags);
    grep.c:375:	return regexec(preg, line, 1, match, eflags);
    http-backend.c:567:		if (regcomp(&re, c->pattern, REG_EXTENDED))
    http-backend.c:569:		if (!regexec(&re, dir, 1, out, 0)) {

Some of these are supplying REG_EXTENDED, some (like git-grep) allow
for passing REG_ICASE, some don't.

There's no way to do e.g. do a case insensitive git blame -L'/start/',
other than -L'/[sS][tT][aA][rR][tT]/' that is. It would be nice if we
could consistently pass regex flags, like -L'/start/i' in this
case. This also applies to features like the new ':/string' feature
added by Linus, maybe that should optionally be ':/string/i' (or
within the scope of the current implementation, ':!i/string' or
':!/string/i').

Regarding regular expression implementations. We might want to look
into bundling one implementation and using it everywhere, but I
haven't tested that to see if there are significant wins to be had.

There are regex implementations (notably GNU awk and GNU grep) that
are probably better fits for what Git does, a GNU grep backend for
git-log would probably search through revisions with a regex faster,
but I haven't tested it so I don't know if it's fast enough to bother
with it.

Using NFA engines like that also gives you some performance guarantees
(see [1][2]). Although that mostly matters in pathological
situations. But having Git make that guarantee might be useful,
e.g. so Gitweb can offer an interface to git-grep without having the
CPU on the host burned up by a pattern like (a*|a*)*.

The NFA engines we could use to get those features include Google's
RE2 (it's in C++, but we might fall back on e.g. the Plan9 engine),
GNU awk/grep, TRE, and probably some others.

But maybe this isn't something that's wanted or needed. Does anyone
else want a more unified regex interface in Git, or a determanistic
regex engine built-in?

1. http://swtch.com/~rsc/regexp/regexp1.html
2. http://stackoverflow.com/questions/1178173/regex-implementation-that=
-can-handle-machine-generated-regexs-non-backtracking
