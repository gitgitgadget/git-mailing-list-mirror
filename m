From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 24 Jun 2008 00:59:51 -0700
Message-ID: <7vwskfclfs.fsf@gitster.siamese.dyndns.org>
References: <7vr6crj0jk.fsf@gitster.siamese.dyndns.org>
 <7vmyn4hr8f.fsf@gitster.siamese.dyndns.org>
 <7vmymsjz6x.fsf@gitster.siamese.dyndns.org>
 <7vabijxhk4.fsf@gitster.siamese.dyndns.org>
 <7vwslhg8qe.fsf@gitster.siamese.dyndns.org>
 <7vhccfiksy.fsf@gitster.siamese.dyndns.org>
 <7vod6k6zg4.fsf@gitster.siamese.dyndns.org>
 <7v4p7xwsfp.fsf@gitster.siamese.dyndns.org>
 <7v3anb19n7.fsf@gitster.siamese.dyndns.org>
 <7vwskjazql.fsf@gitster.siamese.dyndns.org>
 <20080621121429.GI29404@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Jun 24 10:01:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB3Se-0007hl-Kw
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 10:01:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751950AbYFXIAF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 04:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752073AbYFXIAE
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 04:00:04 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33679 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751132AbYFXIAA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 04:00:00 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AD43712EF0;
	Tue, 24 Jun 2008 03:59:59 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id BE49012EEF; Tue, 24 Jun 2008 03:59:55 -0400 (EDT)
In-Reply-To: <20080621121429.GI29404@genesis.frugalware.org> (Miklos Vajna's
 message of "Sat, 21 Jun 2008 14:14:29 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8AF89FEE-41C3-11DD-A108-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86006>

Miklos Vajna <vmiklos@frugalware.org> writes:

> On Sat, Jun 21, 2008 at 02:44:50AM -0700, Junio C Hamano <gitster@pobox.com> wrote:
>> * nd/dashless (Wed Nov 28 23:21:57 2007 +0700) 1 commit
>>  + Move all dashed-form commands to libexecdir
>> 
>> Scheduled for 1.6.0.
>> 
>> * jc/dashless (Sat Dec 1 22:09:22 2007 -0800) 2 commits
>>  - Prepare execv_git_cmd() for removal of builtins from the
>>    filesystem
>>  - git-shell: accept "git foo" form
>> 
>> We do not plan to remove git-foo form completely from the filesystem at
>> this point, but git-shell may need to be updated.
>
> I may be wrong, but given that git-upload-pack/receive-pack is now not
> in PATH, I think it will be problematic to do a pull/push in case the
> server runs next, the client is 1.5.6 and the user has git-shell as
> shell, for example.

The idea of the "shell: accept 'git foo' form" patch is that as long as
the server end consistently use the same version (i.e. git-shell is from
'next' and it knows where the rest of git is installed), things should
work fine.  I've merged them to 'next' and pushed it out so that you can
try it.

I do not use git-shell in production setting (I do have one user account
whose login shell is git-shell from 'next' I use purely for testing), and
I do not know how much use it has seen in the real world.  My cursory
sanity-check ("cvs -d :ext:thatuser@myhost:/path/ co --help", and "git
ls-remote ssh://thatuser@myhost/path/")  seems to be Ok with $(bindir)
that has only git, gitk and nothing else.
