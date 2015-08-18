From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [bug] 2.5.0 build with NO_PERL is broken
Date: Tue, 18 Aug 2015 12:42:47 -0400
Message-ID: <CAPig+cTvNQ74G4T3McNd2JUXLvxe-yX+ApFrevXDi4GXsFQ_3g@mail.gmail.com>
References: <loom.20150814T171757-901@post.gmane.org>
	<loom.20150814T184447-932@post.gmane.org>
	<xmqq7foxiqu6.fsf@gitster.dls.corp.google.com>
	<CAPig+cR77oFo6D3f8BjAB_yM-xPt+3EUGK4vZr3eYWJGTtksAQ@mail.gmail.com>
	<xmqqoai9h9co.fsf@gitster.dls.corp.google.com>
	<CAPig+cR6iT=AC8zq-vHHTkXMzRmDA-o9JLi0h8gbR1tzbqNyKA@mail.gmail.com>
	<xmqqzj1tfr2g.fsf@gitster.dls.corp.google.com>
	<CAPig+cQkApWfZ6N159F-XFZk+nnzY-gAgLRfZXNitdd0CHpm2g@mail.gmail.com>
	<loom.20150818T130309-687@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Renato Botelho <garga@freebsd.org>
X-From: git-owner@vger.kernel.org Tue Aug 18 18:43:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRjyj-0005BP-6P
	for gcvg-git-2@plane.gmane.org; Tue, 18 Aug 2015 18:43:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753325AbbHRQnG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2015 12:43:06 -0400
Received: from mail-yk0-f175.google.com ([209.85.160.175]:34459 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753893AbbHRQms (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2015 12:42:48 -0400
Received: by ykdt205 with SMTP id t205so164474358ykd.1
        for <git@vger.kernel.org>; Tue, 18 Aug 2015 09:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=+qN6Qhjr5S2IupocVyO0RBSfc37x6qqZVG+TZb3juT0=;
        b=Shn+8lpOTN6Q6i7wAU7esn5bFs4Wi5P3xCLrIgM5ssAVlOmEZVBT9j81+D27jbOLQK
         xrH9MTb6OOpK/0CqM+XZ9xT84RHubZ3wjAaWLSaOYV9JdLf4RWD9fG/PldmPt8PWurPZ
         hHfMiFO0lsbxgo+dX2/ifnQST/7COEnYlRNhYqgWf3A0C6gbIVGSZB1FUoQqGT8I3uO0
         DlPRCqZCityjFsgNgJMr0+aAU9/mMKNiGMjW190qU6S1IPPC4D3z2R3xG5x8c9RqBZNw
         gA3UF/Did0nwekBFpPauHNahlbIxbv96y43PXAgEiyxcCFnp6x6a0euENgFli83vdtv3
         CPkA==
X-Received: by 10.170.97.9 with SMTP id o9mr8301694yka.84.1439916167921; Tue,
 18 Aug 2015 09:42:47 -0700 (PDT)
Received: by 10.37.208.78 with HTTP; Tue, 18 Aug 2015 09:42:47 -0700 (PDT)
In-Reply-To: <loom.20150818T130309-687@post.gmane.org>
X-Google-Sender-Auth: KqEP_9aqCH65uWt0uHPKZ3Jr6EE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276130>

On Tue, Aug 18, 2015 at 7:05 AM, Renato Botelho <garga@freebsd.org> wrote:
> Eric Sunshine <sunshine <at> sunshineco.com> writes:
>> On Fri, Aug 14, 2015 at 6:22 PM, Junio C Hamano <gitster <at> pobox.com>
> wrote:
>> > Eric Sunshine <sunshine <at> sunshineco.com> writes:
>> >> On Fri, Aug 14, 2015 at 5:02 PM, Junio C Hamano <gitster <at>
> pobox.com> wrote:
>> >>> Eric Sunshine <sunshine <at> sunshineco.com> writes:
>> >>> I do not think that is anything new.  We always have assumed "some"
>> >>> version of Perl available in order to run t/ scripts.
>> >>
>> >> True, but prior to 527ec39, without Perl available, git itself could
>> >> at least be built and used (with some commands unavailable), even if
>> >> it couldn't be fully tested. As of 527ec39, however, git won't even
>> >> build because common-cmds.h can't be generated.
>> >
>> > I wouldn't bother digging in the history myself, but I am reasonably
>> > sure that the current genereate-common-cmds is not the sole instance
>> > that we relied on Perl to build (not test) in the past, and that is
>> > another reason why I do not think this is anything new.
>>
>> Hmm. In my tests by setting PERL_PATH to a bogus (non-existent)
>> command, prior to 527ec39, git builds successfully, whereas, following
>> 527ec39, it does not build. But, perhaps I overlooked something...(?)
>
> It builds but there will be at least 3 commands that won't work:

Hmm, I was under the impression from your initial mail[1] that Git
wouldn't even build without Perl available:

    /bin/sh: /usr/bin/perl: not found
    Makefile:1701: recipe for target 'common-cmds.h' failed
    gmake[2]: *** [common-cmds.h] Error 127

Doesn't this failure prevent generation of the 'git' executable altogether?

> git-submodule
> git-request-pull
> git-am

Also...

git-add--interactive
git-archimport
git-cvsexportcommit
git-cvsimport
git-cvsserver
git-difftool
git-instaweb
git-relink
git-send-email
git-svn

A C rewrite of git-am has recently graduated to 'master'.

> I'm considering to add perl dependency as mandatory on FreeBSD ports tree,
> and maybe this NO_PERL option doesn't make more sense nowadays...

That might make sense. Although some of the above commands may not be
used widely, others, such as git-send-email, probably are used
regularly.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/275905
