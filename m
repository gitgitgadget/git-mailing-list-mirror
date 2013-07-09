From: Matt Kraai <kraai@ftbfs.org>
Subject: Re: [PATCH] remote-http: use argv-array
Date: Tue, 9 Jul 2013 22:27:29 +0000 (UTC)
Message-ID: <loom.20130710T002441-147@post.gmane.org>
References: <7vfvvoxqdw.fsf@alter.siamese.dyndns.org> <CAKPyHN0DG0c2vxWtybYtDmFKMo369PZcbqCfDJaXeiRV+PP8pQ@mail.gmail.com> <20130709063840.GA8015@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 10 00:27:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwgO3-0003tQ-39
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jul 2013 00:27:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752150Ab3GIW1v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 18:27:51 -0400
Received: from plane.gmane.org ([80.91.229.3]:42676 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751850Ab3GIW1u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 18:27:50 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1UwgNu-0003lm-3m
	for git@vger.kernel.org; Wed, 10 Jul 2013 00:27:48 +0200
Received: from 130.36.62.225 ([130.36.62.225])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 10 Jul 2013 00:27:46 +0200
Received: from kraai by 130.36.62.225 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 10 Jul 2013 00:27:46 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 130.36.62.225 (Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20130709 Firefox/24.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230012>

Jeff King <peff@peff.net> writes:
> On Tue, Jul 09, 2013 at 08:05:19AM +0200, Bert Wesarg wrote:
> > > +       argv_array_pushl(&args, "send-pack", "--stateless-rpc",
"--helper-status");
> > 
> > missing NULL sentinel. GCC has the 'sentinel' [1] attribute to catch
> > such errors. Or use macro magic:
> > 
> > void argv_array_pushl_(struct argv_array *array, ...);
> > #define argv_array_pushl(array, ...) argv_array_pushl_(array,
__VA_ARGS__, NULL)
> 
> Nice catch. We cannot use variadic macros, because we support pre-C99
> compilers that do not have them. But the sentinel attribute is a good
> idea. Here's a patch.

This attribute could also be used for
builtin/revert.c:verify_opt_compatible,
builtin/revert.c:verify_opt_mutually_compatible, exec_cmd.h:execl_git_cmd,
and run-command.h:run_hook.

-- 
Matt
