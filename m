Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 826811F404
	for <e@80x24.org>; Thu, 30 Aug 2018 19:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbeH3XOO convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 30 Aug 2018 19:14:14 -0400
Received: from elephants.elehost.com ([216.66.27.132]:45612 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbeH3XON (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 19:14:13 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w7UJAUW8077052
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 30 Aug 2018 15:10:30 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "=?iso-8859-1?Q?'Torsten_B=F6gershausen'?=" <tboegi@web.de>,
        "'Robert Dailey'" <rcdailey.lists@gmail.com>
Cc:     <jrnieder@gmail.com>, "'Git'" <git@vger.kernel.org>
References: <CAHd499APYCH2r2=+M_AGKUzN0GDmrwDty4wK=Xy-utCdMrd56w@mail.gmail.com> <20180830045407.GB140348@aiede.svl.corp.google.com> <CAHd499BCk4Q4oPY=CXK=YrUbNUbz4J_KoeQngfz=92Qfc6q=eA@mail.gmail.com> <20180830185648.GA10427@tor.lan>
In-Reply-To: <20180830185648.GA10427@tor.lan>
Subject: RE: Automatic core.autocrlf?
Date:   Thu, 30 Aug 2018 15:10:23 -0400
Message-ID: <005c01d44095$1d5288c0$57f79a40$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGf5k4RNUrSErA8PPJ17nKsTt01gQG5m0ftAtjVNywBoDqgoaUPxZXg
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On August 30, 2018 2:57 PM, Torsten Bögershausen wrote:
> On Thu, Aug 30, 2018 at 09:57:52AM -0500, Robert Dailey wrote:
> > On Wed, Aug 29, 2018 at 11:54 PM Jonathan Nieder <jrnieder@gmail.com>
> wrote:
> > >
> > > Hi,
> > >
> > > Robert Dailey wrote:
> > >
> > > > Is there an 'auto' setting for the 'core.autocrlf' config? Reason
> > > > I ask is, I want that setting to be 'input' on linux but 'true' on
> > > > Windows.
> > >
> > > Others are exploring your question about the configuration language,
> > > but I want to emphasize some other ramifications.
> > >
> > > Why do we still have 'core.autocrlf'?  Do 'core.eol' and related
> > > settings take care of that need, or is autocrlf still needed?  If
> > > core.eol etc do not take care of this need, what should we do to get
> > > them to?
> > >
> > > Thanks, after having run into a few too many autocrlf-related
> > > messes, Jonathan
> >
> > From my perspective, the confusion is due to the evolution of the
> > feature. There's multiple ways to control EOL handling but most of it
> > is legacy/backward compatibility, I think. core.autocrlf is a
> > fall-back for repos that do not have a .gitattributes. Because
> > .gitattributes is optional by design, I'm not sure if getting rid of
> > the config options is a good idea.
> 
> Good summary. My original plan was to try to "make obsolete"/retire and
> phase out core.autocrlf completely.
> However, since e.g. egit/jgit uses it
> (they don't have support for .gitattributes at all) I am not sure if this
is a good
> idea either. Opinions are welcome.
> 
> 
> > But your point did make me think
> > about how `core.autocrlf = true` should probably be a system config
> > default for the Git for Windows project. The default for that value
> > should be platform-defined. That would make it automatically work the
> > way I want, and might solve a lot of the issues where people are
> > committing CRLF into repositories on Windows.
> 
> Unless I am wrong, that had been the default a long time ago:
> Git for Windows (at that time msysgit) had core.autocrlf=true by default.
> While this is a good choice for many repos, some people prefer
> core.autocrlf=input.
> Others just commit files for Windows-based repos with CRLF, and the
> advantage is, that "git diff" doesn't show "^M" somewhere.
> 
> I allways encourage people to set up a .gitattributes file.
> Does anybody thinks that we can make core.autocrlf obsolete ?

The last time I checked, EGit does not set this by default. ECLIPSE Oxygen
3A/EGit-JGit 5.0.1, when running on Windows, creates core.filemode=false,
core.logallrefupdates=true, repositoryformatversion=0, symlinks=false. Some
SourceTree versions that predate the newer SourceTreeApp are somewhat stuck
on older embedded versions of git, but that may not be relevant. Personally,
I would seriously like to drop core.autocrlf and just have everyone on LF
EOL characters. I get frequently burnt by this despite knowing better.

Cheers,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.



