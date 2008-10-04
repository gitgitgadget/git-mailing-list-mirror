From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git apply: git diff header lacks filename information for git diff --no-index patch
Date: Sat, 04 Oct 2008 10:28:19 +0200
Organization: At home
Message-ID: <gc79f4$22m$1@ger.gmane.org>
References: <500f3d130810021127j570bb540p901f6a73f58a6cb1@mail.gmail.com> <20081004041714.GA12413@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 04 10:30:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Km2WQ-0003Vi-7Y
	for gcvg-git-2@gmane.org; Sat, 04 Oct 2008 10:29:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752171AbYJDI2l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Oct 2008 04:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752143AbYJDI2k
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Oct 2008 04:28:40 -0400
Received: from main.gmane.org ([80.91.229.2]:42422 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751831AbYJDI2j (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Oct 2008 04:28:39 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Km2V5-0004K5-M4
	for git@vger.kernel.org; Sat, 04 Oct 2008 08:28:31 +0000
Received: from abwi176.neoplus.adsl.tpnet.pl ([83.8.232.176])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 04 Oct 2008 08:28:31 +0000
Received: from jnareb by abwi176.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 04 Oct 2008 08:28:31 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abwi176.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97468>

[Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, 
 Imre Deak <imre.deak@gmail.com>]

Jeff King wrote:

> On Thu, Oct 02, 2008 at 09:27:36PM +0300, Imre Deak wrote:
> 
>> $ git apply patch
>> fatal: git diff header lacks filename information (line 4)
>> $ cat patch
>> diff --git a/dev/null b/a
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..1f2a4f5ef3df7f7456d91c961da36fc58904f2f1
>> GIT binary patch
> 
> Hmm. The problem is that "git apply" doesn't accept that "a/dev/null"
> and "b/a" are the same, so it rejects them as a name. I

Shouldn't it be "/dev/null", not "a/dev/null"?  

Besides git-diff(1) states:

  1. It is preceded with a "git diff" header, that looks like
     this:

       diff --git a/file1 b/file2

     The `a/` and `b/` filenames are the same unless rename/copy is
     involved.  Especially, even for a creation or a deletion,
     `/dev/null` is _not_ used in place of `a/` or `b/` filenames.

Looks like a bug in patch generation code...
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
