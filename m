Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17A391F62D
	for <e@80x24.org>; Sat,  7 Jul 2018 23:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754397AbeGGXQ4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Jul 2018 19:16:56 -0400
Received: from mxin.vub.ac.be ([134.184.129.114]:1260 "EHLO mxin.vub.ac.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754249AbeGGXQ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jul 2018 19:16:56 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2HOAQBnSUFb/wsxuIZbGgEBAQEBAgEBA?=
 =?us-ascii?q?QEIAQEBAYNtPm0SKIMziEtfjVx1h0GMfBSBKzsLIwgBAoECgzwCgk80GAECAQE?=
 =?us-ascii?q?CAQECAgJpHAyCZARLOi8BAQEBAQEBAQEBAQEBAQEBGgINJj4BBScLAUYQCxgJJ?=
 =?us-ascii?q?Q8FDRshE4MhgWcDFQ+qdzOHCw2BLoE6ikQ/gQ+CWjWCVkICAoE2EINKggQgApk?=
 =?us-ascii?q?kKwmGCIYRgwCIEoVWiioOT4N8AYMMgUE5gVJNIBiDJAkKghEXg0WFFIE9hAM9M?=
 =?us-ascii?q?AF5AQGMZ4I5AQE?=
X-IPAS-Result: =?us-ascii?q?A2HOAQBnSUFb/wsxuIZbGgEBAQEBAgEBAQEIAQEBAYNtPm0?=
 =?us-ascii?q?SKIMziEtfjVx1h0GMfBSBKzsLIwgBAoECgzwCgk80GAECAQECAQECAgJpHAyCZ?=
 =?us-ascii?q?ARLOi8BAQEBAQEBAQEBAQEBAQEBGgINJj4BBScLAUYQCxgJJQ8FDRshE4MhgWc?=
 =?us-ascii?q?DFQ+qdzOHCw2BLoE6ikQ/gQ+CWjWCVkICAoE2EINKggQgApkkKwmGCIYRgwCIE?=
 =?us-ascii?q?oVWiioOT4N8AYMMgUE5gVJNIBiDJAkKghEXg0WFFIE9hAM9MAF5AQGMZ4I5AQE?=
Received: from igwe11.vub.ac.be (HELO igwe.rave.org) ([134.184.49.11])
  by smtp.vub.ac.be with ESMTP/TLS/AES128-GCM-SHA256; 08 Jul 2018 01:16:52 +0200
Received: from kgybels by igwe.rave.org with local (Exim 4.84_2)
        (envelope-from <kgybels@infogroep.be>)
        id 1fbwRf-0000F4-MA; Sun, 08 Jul 2018 01:16:51 +0200
Date:   Sun, 8 Jul 2018 01:16:51 +0200
From:   Kim Gybels <kgybels@infogroep.be>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Git mailing list <git@vger.kernel.org>, kilobyte@angband.pl,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Michael J Gruber <git@grubix.eu>, Jeff King <peff@peff.net>,
        tboegi@web.de
Subject: Re: [PATCH] gc --auto: release pack files before auto packing
Message-ID: <20180707231651.GB6152@infogroep.be>
References: <20180630133822.4580-1-kgybels@infogroep.be>
 <20180630145849.GA9416@duynguyen.home>
 <xmqqpo00mi7q.fsf@gitster-ct.c.googlers.com>
 <CAM0VKj=u0OVad3QDRFOc+NWZ9TfwqAwmZ47s=5e5jGZaPQRH6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0VKj=u0OVad3QDRFOc+NWZ9TfwqAwmZ47s=5e5jGZaPQRH6g@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On (07/07/18 11:40), SZEDER Gábor wrote:
> 
> On Fri, Jul 6, 2018 at 6:39 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Duy Nguyen <pclouds@gmail.com> writes:
> >
> > > On Sat, Jun 30, 2018 at 03:38:21PM +0200, Kim Gybels wrote:
> > >> Teach gc --auto to release pack files before auto packing the repository
> > >> to prevent failures when removing them.
> > >>
> > >> Also teach the test 'fetching with auto-gc does not lock up' to complain
> > >> when it is no longer triggering an auto packing of the repository.
> > >>
> > >> Fixes https://github.com/git-for-windows/git/issues/500
> > >>
> > >> Signed-off-by: Kim Gybels <kgybels@infogroep.be>
> > >> ---
> > >>
> > >> Patch based on master, since problem doesn't reproduce on maint,
> > >> however, the improvement to the test might be valuable on maint.
> > >>
> > >>  builtin/gc.c     | 1 +
> > >>  t/t5510-fetch.sh | 2 ++
> > >>  2 files changed, 3 insertions(+)
> > >>
> > >> diff --git a/builtin/gc.c b/builtin/gc.c
> > >> index ccfb1ceaeb..63b62ab57c 100644
> > >> --- a/builtin/gc.c
> > >> +++ b/builtin/gc.c
> > >> @@ -612,6 +612,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
> > >>              return -1;
> > >>
> > >>      if (!repository_format_precious_objects) {
> > >> +            close_all_packs(the_repository->objects);
> > >
> > > We have repo_clear() which does this and potentially closing file
> > > descriptors on other things as well. I suggest we use it, and before
> > > any external command is run. Something like
> > >
> > > diff --git a/builtin/gc.c b/builtin/gc.c
> > > index ccfb1ceaeb..a852c71da6 100644
> > > --- a/builtin/gc.c
> > > +++ b/builtin/gc.c
> > > @@ -473,6 +473,13 @@ static int report_last_gc_error(void)
> > >
> > >  static int gc_before_repack(void)
> > >  {
> > > +     /*
> > > +      * Shut down everything, we should have all the info we need
> > > +      * at this point. Leaving some file descriptors open may
> > > +      * prevent them from being removed on Windows.
> > > +      */
> > > +     repo_clear(the_repository);
> > > +
> > >       if (pack_refs && run_command_v_opt(pack_refs_cmd.argv, RUN_GIT_CMD))
> > >               return error(FAILED_RUN, pack_refs_cmd.argv[0]);
> >
> > With
> >
> >   https://public-inbox.org/git/20180509170409.13666-1-pclouds@gmail.com/
> >
> > the call to repo_clear() on the_repository itself may be safe [*1*],
> > but if command line parsing code etc. has pointers to in-core object
> > etc. obtained before this function was called, the codeflow after
> > this function returns will be quite disturbed.  Has anybody in this
> > review thread audited the codeflow _after_ this function is run to
> > make sure that invalidating in-core repository here does not cause
> > us problems?
> 
> It does create us problems, unfortunately.
> 
> Among other things, a call to repo_clear(the_repository) does this:
> 
>   raw_object_store_clear(repo->objects);
>   FREE_AND_NULL(repo->objects);
> 
> Later on cmd_gc() calls reprepare_packed_git(the_repository), which
> then attempts to:
> 
>   r->objects->approximate_object_count_valid = 0;
>   r->objects->packed_git_initialized = 0;
> 
> but with r->objects being NULL at this point that won't work, and in
> turn causes failures in several test scripts.
> 
> 
> FWIW, the original patch appears to be working fine, at least the test
> suite passes.

Should I post a v3 that goes back to the original fix, but uses
test_i18ngrep instead of grep?

In addition to not breaking any tests, close_all_packs is already used
in a similar way in am and fetch just before running "gc --auto".

-Kim
