From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v4 20/21] refs: add LMDB refs storage backend
Date: Fri, 12 Feb 2016 20:23:43 -0500
Organization: Twitter
Message-ID: <1455326623.10888.3.camel@twopensource.com>
References: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
	 <1454701462-3817-21-git-send-email-dturner@twopensource.com>
	 <56BE0FE1.5030407@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 13 02:24:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUOwa-0005jo-Qh
	for gcvg-git-2@plane.gmane.org; Sat, 13 Feb 2016 02:24:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007AbcBMBXr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2016 20:23:47 -0500
Received: from mail-qg0-f46.google.com ([209.85.192.46]:34092 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751366AbcBMBXq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2016 20:23:46 -0500
Received: by mail-qg0-f46.google.com with SMTP id b67so75623852qgb.1
        for <git@vger.kernel.org>; Fri, 12 Feb 2016 17:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:organization
         :content-type:mime-version:content-transfer-encoding;
        bh=R/jNztrSU6UXDCKWg3avGKwjsNVKKxbRKly82NFTtoY=;
        b=ZVaa820UGXfrglrso10w5DsDMtT+ldqeLe+HbX6cXfiqi3kM1VRTHKPHjchQBTeLL2
         acH0KOFTcD4klbWlgiqMiRsZwgqJ3T6iwHo3/3Ao1e13JK4/pDy8S2Rl7fvh8coAW14F
         H5I97Z91wqzvFUA7NbVm+XtWK/nesfkDg45+8H01jQWJIe01/OzZWSkoEVli5sytDDL0
         xIbxgKrdibMTSD4ZllUc1uzjF6k2tWgTpLwawwJnbDu7zkHlAr13tgM8SSMhLQVh/4Q+
         nwdg+CVzmd5gaGWbkwJjVymYsHQ03EdO1VPgOz2S7nrnXuWtHXIZC/3yXKGuh+rh06jh
         HcJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=R/jNztrSU6UXDCKWg3avGKwjsNVKKxbRKly82NFTtoY=;
        b=kN8Xd6N2ADmtTVmd/se8KRhD0VUGqnWi/uNcHvTjTQb93KSBDbbU56rdVilqwgbd4B
         YAtjqBHSwZITCNYqkc6nv9eS/As+Aui8Qo/gnh/k7yqfrRPr9IXRy9NpC8awSm5xMuaK
         Qqy7+13VnBL46Dyb1VwljEFF4qXJefnwx2zD95MpfVnWdTCcPyZnytoZreGRs5q/BfHa
         5mh5QeRu3e3VS8y9nLzeH6wfFcXH+JTmMAxzK4OtsC/TJBQHoEqMWnAGosxvBnao1IRy
         n7Ax5denIvdkp0IHDOrQlhssvCmOMT5Ot6hh4z+FCiHwizBn4oeAMrvggMP5V92XgSv0
         KNrQ==
X-Gm-Message-State: AG10YOQV2qo7TabFQXqNO720RrGYC4OX6KOazp0sf7A+tKKYrWhby4DSfwM0yh9aemTlzA==
X-Received: by 10.140.16.225 with SMTP id 88mr6031742qgb.96.1455326625882;
        Fri, 12 Feb 2016 17:23:45 -0800 (PST)
Received: from ubuntu ([8.25.196.25])
        by smtp.gmail.com with ESMTPSA id x62sm5573110qhc.42.2016.02.12.17.23.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 12 Feb 2016 17:23:44 -0800 (PST)
In-Reply-To: <56BE0FE1.5030407@alum.mit.edu>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286103>

On Fri, 2016-02-12 at 18:01 +0100, Michael Haggerty wrote:
> On 02/05/2016 08:44 PM, David Turner wrote:
> > Add a database backend for refs using LMDB.  This backend runs git
> > for-each-ref about 30% faster than the files backend with fully
> > -packed
> > refs on a repo with ~120k refs.  It's also about 4x faster than
> > using
> > fully-unpacked refs.  In addition, and perhaps more importantly, it
> > avoids case-conflict issues on OS X.
> > 
> > LMDB has a few features that make it suitable for usage in git:
> > 
> 
> 0. It is licensed under the OpenLDAP Public License, which is
> apparently
> GPL compatible [1].
> 
> [1] http://www.gnu.org/licenses/license-list.en.html#newOpenLDAP

Oh, yeah, I checked that before choosing it and then forgot all about
it. 

> > 1. It is relatively lightweight; it requires only one header file,
> > and
> > the library code takes under 64k at runtime.
> > 
> > 2. It is well-tested: it's been used in OpenLDAP for years.
> > 
> > 3. It's very fast.  LMDB's benchmarks show that it is among
> > the fastest key-value stores.
> > 
> > 4. It has a relatively simple concurrency story; readers don't
> > block writers and writers don't block readers.
> > 
> > Ronnie Sahlberg's original version of this patchset used tdb.  The
> > major disadvantage of tdb is that tdb is hard to build on OS X. 
> >  It's
> > also not in homebrew.  So lmdb seemed simpler.
> > 
> > To test this backend's correctness, I hacked test-lib.sh and
> > test-lib-functions.sh to run all tests under the refs backend.
> > Dozens
> > of tests use manual ref/reflog reading/writing, or create
> > submodules
> > without passing --ref-storage to git init.  If those tests are
> > changed to use the update-ref machinery or test-refs-lmdb-backend
> > (or,
> > in the case of packed-refs, corrupt refs, and dumb fetch tests, are
> > skipped), the only remaining failing tests are the git-new-workdir
> > tests and the gitweb tests.
> 
> Would it possible to build your "hack" into the test suite? For
> example,
> perhaps one could implement an option that requests tests to use LMDB
> wherever possible and skip the tests that are not LMDB-compatible.
> Over
> time, we could try to increase the fraction of tests that are
> LMDB-compatible by (for example) using `git update-ref` and `git
> rev-parse` rather than reading/writing reference files via the
> filesystem directly.
> 
> Otherwise, I'm worried that LMDB support will bitrot quickly because
> it
> will be too much of a nuisance to exercise the code.

I can add that.  It requires minor changes to a large number of tests,
but that's OK.

> > Signed-off-by: David Turner <dturner@twopensource.com>
> > ---
> >  .gitignore                                     |    1 +
> >  Documentation/config.txt                       |    7 +
> >  Documentation/git-clone.txt                    |    3 +-
> >  Documentation/git-init.txt                     |    2 +-
> >  Documentation/technical/refs-lmdb-backend.txt  |   52 +
> >  Documentation/technical/repository-version.txt |    5 +
> >  Makefile                                       |   12 +
> >  configure.ac                                   |   33 +
> >  contrib/workdir/git-new-workdir                |    3 +
> >  refs.c                                         |    3 +
> >  refs.h                                         |    2 +
> >  refs/lmdb-backend.c                            | 2052
> > ++++++++++++++++++++++++
> >  setup.c                                        |   11 +-
> >  test-refs-lmdb-backend.c                       |   64 +
> >  transport.c                                    |    7 +-
> >  15 files changed, 2250 insertions(+), 7 deletions(-)
> >  create mode 100644 Documentation/technical/refs-lmdb-backend.txt
> >  create mode 100644 refs/lmdb-backend.c
> >  create mode 100644 test-refs-lmdb-backend.c
> > 
> > diff --git a/.gitignore b/.gitignore
> > index 1c2f832..87d45a2 100644
> > --- a/.gitignore
> > +++ b/.gitignore
> > @@ -199,6 +199,7 @@
> >  /test-path-utils
> >  /test-prio-queue
> >  /test-read-cache
> > +/test-refs-lmdb-backend
> >  /test-regex
> >  /test-revision-walking
> >  /test-run-command
> > diff --git a/Documentation/config.txt b/Documentation/config.txt
> > index 06d3659..bc222c9 100644
> > --- a/Documentation/config.txt
> > +++ b/Documentation/config.txt
> > @@ -1153,6 +1153,13 @@ difftool.<tool>.cmd::
> >  difftool.prompt::
> >  	Prompt before each invocation of the diff tool.
> >  
> > +extensions.refsStorage::
> > +	Type of refs storage backend. Default is to use the
> > original
> > +	files based ref storage.  When set to "lmdb", refs are
> > stored in
> > +	the lmdb database backend.  This setting reflects the refs
> > +	backend that is currently in use; it is not possible to
> > change
> > +	the backend by changing this setting.
> > +
> 
> Let's give the users a pointer to how they *can* change this setting.
> Maybe
> 
> 	Type of refs storage backend. Default is to use the original
> 	files based ref storage.  When set to "lmdb", refs are stored
> in
> 	an LMDB database.  This setting reflects the refs storage
> 	backend that was chosen via the --ref-storage option when the
> 	repository was originally created. It is currently
> 	not possible to change the refs storage backend of an
> 	existing repository.

OK.

> >  fetch.recurseSubmodules::
> >  	This option can be either set to a boolean value or to 'on
> > -demand'.
> >  	Setting it to a boolean changes the behavior of fetch and
> > pull to
> > diff --git a/Documentation/git-clone.txt b/Documentation/git
> > -clone.txt
> > index 68f56a7..b9c52ce 100644
> > --- a/Documentation/git-clone.txt
> > +++ b/Documentation/git-clone.txt
> > @@ -227,7 +227,8 @@ objects from the source repository into a pack
> > in the cloned repository.
> >  
> >  --ref-storage=<name>::
> >  	Type of ref storage backend. Default is to use the
> > original files
> > -	based ref storage.
> > +	based ref storage. Set to "lmdb" to store refs in the lmdb
> > database
> > +	backend.
> 
> Should the second "lmdb" be upper-case? Maybe also in other places
> where
> the LMDB database is being referred to?

OK, I think I got most of them.

> >  <repository>::
> >  	The (possibly remote) repository to clone from.  See the
> > [...]
> 
> I still haven't reviewed the actual lmdb-backend code. I guess I'm
> going
> to have to make myself an LMDB expert one of these days...

I highly recommend it!  The API is pretty reasonable, and it does seem
to be fast.  The error messages could use some work, but that's my only
complaint.
