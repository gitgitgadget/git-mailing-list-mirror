From: Andreas Krey <a.krey@gmx.de>
Subject: Re: [PATCH 0/3] Fixing volatile HEAD in push.default = current
Date: Thu, 23 May 2013 10:53:59 +0200
Message-ID: <20130523085359.GA23933@inner.h.apk.li>
References: <1369160600-22337-1-git-send-email-artagnon@gmail.com> <7v38tgno2k.fsf@alter.siamese.dyndns.org> <CALkWK0m3QP_eE14y8UoJ+HeFzkKM=1nVKAnYJcTrwQMp+Atphg@mail.gmail.com> <7vppwkm682.fsf@alter.siamese.dyndns.org> <CALkWK0np7o0eH8ZsWQSwk1Cdwnnpj5B==gS8kAE+OkTskASOsQ@mail.gmail.com> <7v7girks4s.fsf@alter.siamese.dyndns.org> <CALkWK0kXonM+J92KHs+dW31A_kZ8h9jNqwYn8AqT_V+GJhe_vg@mail.gmail.com> <7vppwjj5ws.fsf@alter.siamese.dyndns.org> <CALkWK0mfGWA3aBntQQU5fkCJDPx+MUOScvMRJjS+JzjNucFzPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 23 10:54:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfRHs-0002zn-8z
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 10:54:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755694Ab3EWIyK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 04:54:10 -0400
Received: from continuum.iocl.org ([217.140.74.2]:38699 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751336Ab3EWIyI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 04:54:08 -0400
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id r4N8rxu30306;
	Thu, 23 May 2013 10:53:59 +0200
Content-Disposition: inline
In-Reply-To: <CALkWK0mfGWA3aBntQQU5fkCJDPx+MUOScvMRJjS+JzjNucFzPw@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225225>

On Thu, 23 May 2013 13:25:55 +0000, Ramkumar Ramachandra wrote:
> Junio C Hamano wrote:
> >     I have "largedir" I want to get rid of, but there is a directory
> >     I want to save, "largedir/precious", in it, so I do
> >
> >         cp -R largedir/precious precious
> >
> >     and then run 'rm -rf largedir' in another terminal in parallel.

'mv largedir/precious precious; rm -rf largedir'? No race here.

...
> Consider a slightly different example: I rename a file while having an
> active file handle open in a process that's reading the file.  Will
> the rename fail or will the fread() in the process fail?  Nope, both
> work fine.  Replace "rename" with "remove", and we still have the same
> answer.  Ofcourse there are no guarantees: I can start up another
> process to overwrite the sectors corresponding to that file's data
> with zeros; unless the complete file is there in the kernel buffer, a
> read() will eventually end up slurping in the zeros (or fail?), right?

Oh, there are guarantees, they just don't include the case where you
take a shotgun to the disk. (Or do it on an nfs mount and delete the
file from another machine.)

...

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
