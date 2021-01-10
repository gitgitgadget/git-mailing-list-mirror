Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B9ABC43333
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 19:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 048DD22AAE
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 19:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbhAJTGg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jan 2021 14:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbhAJTGf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jan 2021 14:06:35 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E18FC061786
        for <git@vger.kernel.org>; Sun, 10 Jan 2021 11:05:55 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id e22so14982563iom.5
        for <git@vger.kernel.org>; Sun, 10 Jan 2021 11:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=WlJT0aL65Z1V2Kw2G1ii9u87246/Rurj4aIYVpvE0LY=;
        b=ThRLm6zlYihAyNsF6mrcBxxbOMrDrqL+UcqNM/DmvEVGFXutrebhPQ+7/13TsSgbS5
         adrUyOWjrDwzg40AM66R+5S1upfzZbKXiEi492DHVz3DfGsFARCZjehmdgSmAq8SIWd0
         fWfLOgjrUlSTZ8Os8UPoi2bJ0e38g8upGwfJyIvxQHMUM7iaAoIe1jrZuTqlp3p7M3Pn
         e7kS9zkNbEKDOllLo7UD9npRhNfwafsXA+K3KVhqzi5G+A6ihhT3xSseXhvx7IfnpMF8
         lgR4ix7uJswTTokNOSQ6oaijbOGB2Q97FnQwjbqUp8z5WF/YGVHzmaGZvcJi1n2Gx1Xi
         C30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=WlJT0aL65Z1V2Kw2G1ii9u87246/Rurj4aIYVpvE0LY=;
        b=e2M0aRBLbsty6DBXMZagwiNvkt6jNHXuceU12SCdRm6F63fqR45Y/c3eE9x46oOcSv
         S1gVo9LIivQ8k476cRFLDl5w3/Nq0mLiPQf/sPUmtRto4YZDwLoZaoCJxbKUBpmZLMYB
         ZcI5id3IGSc+M5Pliz/6csaUDJwBc25okN54kPtWC35x51oZvAf9M5lBKN9k4g6TAYIL
         Xm8KdZv3lwMZDK47/+LuKGmP9Bq6mamw7BvLXY10/NAGlfSQQnfpQW02ZzflM6XlEFb/
         Hq45Zp1wkuIgw74mqrbRVME60mdJtOHo5XIlDCIQmrqPdmSkHIXVQEs9OuWmHZaw2rF1
         +p5A==
X-Gm-Message-State: AOAM533NrEbuDdpwIbfcxa23UlKKem7Krk0SPPrIA3YkaBbxDbph8lPF
        o69zMNWIH3tv0Vik9Rp8gvloqUfNnL2Vo7Ks1pL9OF96eiA=
X-Google-Smtp-Source: ABdhPJyQ/Vl1lybkRG5DBhLLdo1kUNUaAAqmO9lxElJ14LQUz38l9TuGRV7tmdsPXmswmYO9C5K440iGaqEelhEY0Vg=
X-Received: by 2002:a5e:dd0d:: with SMTP id t13mr12765833iop.132.1610305554445;
 Sun, 10 Jan 2021 11:05:54 -0800 (PST)
MIME-Version: 1.0
References: <CAH8yC8km6mHsrCD6sW+Z2ERpyO_X8Xp6fJbYKV+JF2gaqYakgQ@mail.gmail.com>
 <4d81f0f1-66eb-2aac-4eab-dc5508d161b1@mail.de>
In-Reply-To: <4d81f0f1-66eb-2aac-4eab-dc5508d161b1@mail.de>
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Sun, 10 Jan 2021 14:05:43 -0500
Message-ID: <CAH8yC8mVxNrd-j3=7OWz-vnKvvjHmp8izSow9XK0G71XqcP1tw@mail.gmail.com>
Subject: Re: Git 2.30.0 and failed self tests
To:     Stefan Moch <stefanmoch@mail.de>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 10, 2021 at 12:09 PM Stefan Moch <stefanmoch@mail.de> wrote:
>
> Jeffrey Walton wrote:
> > I'm seeing some failed self tests with 2.30.0 on Fedora 33 x86_64
> > fully patched. They seem to be centered around email.
>
> I cannot confirm this on the same git version and platform:
>
>     # passed all 174 test(s)
>     1..174
>
> Christian's suggestion from your other thread about running the test
> with the options -i -v -x should also help here to give more
> detailed error messages:
>
> https://lore.kernel.org/git/CAP8UFD30et-kL8dFoWvh7aPf4AKbzGxSzTuA=B3YNHZL_1axFA@mail.gmail.com/
>
> >     *** t9001-send-email.sh ***
> >     ok 1 - prepare reference tree
> >     ok 2 - Setup helper tool
> >     ok 3 - Extract patches
> >     not ok 4 - No confirm with --suppress-cc
>
> Since the tests 1-3 do not call git send-email, but test 4 and most
> of the following do, I suspect the system is missing some dependency
> packages needed for git send-email, probably mail-related Perl modules.
>
> Installing Fedora's git-email package is probably enough to fix this:
>
>     dnf install git-email

It looks like a Perl problem.

I've got a Perl recipe for OpenSSL. The OpenSSL devs don't realize the
trouble they create with that dependency. Old systems need a newer
Perl for OpenSSL. The F33 machine is a test machine, so Perl gets
tested on it, too.

t$ ./t9001-send-email.sh -i -v -x
Initialized empty Git repository in
/home/jwalton/Build-Scripts/git-2.30.0/t/trash
directory.t9001-send-email/.git/
expecting success of 9001.1 'prepare reference tree':
    echo "1A quick brown fox jumps over the" >file &&
    echo "lazy dog" >>file &&
    git add file &&
    GIT_AUTHOR_NAME="A" git commit -a -m "Initial."

++ echo '1A quick brown fox jumps over the'
++ echo 'lazy dog'
++ git add file
++ GIT_AUTHOR_NAME=A
++ git commit -a -m Initial.
[master (root-commit) fbff2ba] Initial.
 Author: A <author@example.com>
 1 file changed, 2 insertions(+)
 create mode 100644 file
ok 1 - prepare reference tree

expecting success of 9001.2 'Setup helper tool':
    write_script fake.sendmail <<-\EOF &&
    shift
    output=1
    while test -f commandline$output
    do
        output=$(($output+1))
    done
    for a
    do
        echo "!$a!"
    done >commandline$output
    cat >"msgtxt$output"
    EOF
    git add fake.sendmail &&
    GIT_AUTHOR_NAME="A" git commit -a -m "Second."

++ write_script fake.sendmail
++ echo '#!/bin/sh'
++ cat
++ chmod +x fake.sendmail
++ git add fake.sendmail
++ GIT_AUTHOR_NAME=A
++ git commit -a -m Second.
[master 60cacbf] Second.
 Author: A <author@example.com>
 1 file changed, 12 insertions(+)
 create mode 100755 fake.sendmail
ok 2 - Setup helper tool

expecting success of 9001.3 'Extract patches':
    patches=$(git format-patch -s --cc="One <one@example.com>"
--cc=two@example.com -n HEAD^1) &&
    threaded_patches=$(git format-patch -o threaded -s
--in-reply-to="format" HEAD^1)

+++ git format-patch -s '--cc=One <one@example.com>'
--cc=two@example.com -n 'HEAD^1'
++ patches=0001-Second.patch
+++ git format-patch -o threaded -s --in-reply-to=format 'HEAD^1'
++ threaded_patches=threaded/0001-Second.patch
ok 3 - Extract patches

expecting success of 9001.4 'No confirm with --suppress-cc':
    test_no_confirm --suppress-cc=sob &&
    check_no_confirm

++ test_no_confirm --suppress-cc=sob
++ rm -f no_confirm_okay
++ echo n
+++ pwd
++ GIT_SEND_EMAIL_NOTTY=1
++ git send-email '--from=Example <from@example.com>'
--to=nobody@example.com
'--smtp-server=/home/jwalton/Build-Scripts/git-2.30.0/t/trash
directory.t9001-send-email/fake.sendmail' --suppress-cc=sob
0001-Second.patch
Can't locate Term/ReadLine.pm in @INC (you may need to install the
Term::ReadLine module) (@INC contains:
/home/jwalton/Build-Scripts/git-2.30.0/perl/build/lib
/home/jwalton/Build-Scripts/git-2.30.0/t/../perl/build/lib
/usr/local/lib64/perl5/5.32 /usr/local/share/perl5/5.32
/usr/lib64/perl5/vendor_perl /usr/share/perl5/vendor_perl
/usr/lib64/perl5 /usr/share/perl5) at
/home/jwalton/Build-Scripts/git-2.30.0/git-send-email line 25.
BEGIN failed--compilation aborted at
/home/jwalton/Build-Scripts/git-2.30.0/git-send-email line 25.
error: last command exited with $?=2
not ok 4 - No confirm with --suppress-cc
#
#        test_no_confirm --suppress-cc=sob &&
#        check_no_confirm

Jeff
