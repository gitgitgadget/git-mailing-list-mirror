From: Alex Bennee <kernel-hacker@bennee.com>
Subject: Re: What is the current best bi-directional git<->bzr method?
Date: Tue, 19 May 2009 21:31:44 +0100
Message-ID: <b2cdc9f30905191331t73795005haad00c7840e9e2a1@mail.gmail.com>
References: <b2cdc9f30905190708t1e170106oce3c577933c99247@mail.gmail.com>
	 <03D68F82-503F-47D1-BF65-9D255E16EE00@frim.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Pieter de Bie <pieter@frim.nl>
X-From: git-owner@vger.kernel.org Tue May 19 22:31:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6Vyc-000706-LU
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 22:31:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753006AbZESUbo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 16:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752893AbZESUbo
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 16:31:44 -0400
Received: from mail-gx0-f166.google.com ([209.85.217.166]:53224 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752756AbZESUbn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 16:31:43 -0400
Received: by gxk10 with SMTP id 10so60924gxk.13
        for <git@vger.kernel.org>; Tue, 19 May 2009 13:31:44 -0700 (PDT)
Received: by 10.90.101.17 with SMTP id y17mr333689agb.102.1242765104126; Tue, 
	19 May 2009 13:31:44 -0700 (PDT)
In-Reply-To: <03D68F82-503F-47D1-BF65-9D255E16EE00@frim.nl>
X-Google-Sender-Auth: 507001a62260d4eb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119566>

2009/5/19 Pieter de Bie <pieter@frim.nl>:
> Hi,
>
> On May 19, 2009, at 3:08 PM, Alex Bennee wrote:
>>
>> I found a script[1] which I have hacked a bit[2] to import repo's
>> fine. However going the other way doesn't seem to work. Before I mess
>> around too much further I though I'd check if there are any known
>> working gateways at the moment?
>
> Bidirectional syncing should work, though I've heard there
> may be some problems with multiple branches. I had a discussion
> with someone about the used mapping, and they hacked up something
> in bash, though I've never looked at it. I've lost interest in
> git<->bzr syncing (and bzr in general) some time ago, so I never
> looked at it further. What specific problem do you have?

Erm it spat out a bunch of python errors which didn't make much sense
and I was hoping to avoid digging into:

21:28 alex@danny/x86_64 [gwibber.git] >git bzr push test
bzr: ERROR: exceptions.KeyError: ':465'

Traceback (most recent call last):
  File "//usr/lib64/python2.5/site-packages/bzrlib/commands.py", line
727, in exception_to_return_code
    return the_callable(*args, **kwargs)
  File "//usr/lib64/python2.5/site-packages/bzrlib/commands.py", line
922, in run_bzr
    ret = run(*run_argv)
  File "//usr/lib64/python2.5/site-packages/bzrlib/commands.py", line
559, in run_argv_aliases
    return self.run(**all_cmd_args)
  File "/home/alex/.bazaar/plugins/fastimport/__init__.py", line 221, in run
    params, verbose)
  File "/home/alex/.bazaar/plugins/fastimport/__init__.py", line 75, in _run
    return proc.process(p.iter_commands)
  File "/home/alex/.bazaar/plugins/fastimport/processor.py", line 92, in process
    self._process(command_iter)
  File "/home/alex/.bazaar/plugins/fastimport/processors/generic_processor.py",
line 269, in _process
    processor.ImportProcessor._process(self, command_iter)
  File "/home/alex/.bazaar/plugins/fastimport/processor.py", line 114,
in _process
    handler(self, cmd)
  File "/home/alex/.bazaar/plugins/fastimport/processors/generic_processor.py",
line 459, in commit_handler
    handler.process()
  File "/home/alex/.bazaar/plugins/fastimport/processor.py", line 193,
in process
    self.pre_process_files()
  File "/home/alex/.bazaar/plugins/fastimport/bzr_commit_handler.py",
line 517, in pre_process_files
    super(InventoryDeltaCommitHandler, self).pre_process_files()
  File "/home/alex/.bazaar/plugins/fastimport/bzr_commit_handler.py",
line 64, in pre_process_files
    for p in parents]
KeyError: ':465'

bzr 1.14.1 on python 2.5.4 (linux2)
arguments: ['/usr/bin/bzr', 'fast-import',
'--import-marks=/home/alex/src/gwibber/gwibber.git/.git/bzr-git/test-bzr-map',
'--export-marks=/home/alex/src/gwibber/gwibber.git/.git/bzr-git/test-bzr-map',
'-']
encoding: 'ANSI_X3.4-1968', fsenc: 'ANSI_X3.4-1968', lang: 'en_GB'
plugins:
  bzrtools
/usr/lib64/python2.5/site-packages/bzrlib/plugins/bzrtools [1.14]
  fastimport           /home/alex/.bazaar/plugins/fastimport [0.8dev]
  launchpad
/usr/lib64/python2.5/site-packages/bzrlib/plugins/launchpad [unknown]
  netrc_credential_store
/usr/lib64/python2.5/site-packages/bzrlib/plugins/netrc_credential_store
[unknown]
*** Bazaar has encountered an internal error.
    Please report a bug at https://bugs.launchpad.net/bzr/+filebug
    including this traceback, and a description of what you
    were doing when the error occurred.

*sigh* I suppose it's time to break out those debugging shoes...

-- 
Alex, homepage: http://www.bennee.com/~alex/
CV: http://www.bennee.com/~alex/cv.php
