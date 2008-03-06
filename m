From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH v3 2/4] git-submodule: New subcommand 'summary' (2) - show commit summary
Date: Thu, 6 Mar 2008 10:16:23 +0800
Message-ID: <46dff0320803051816x5b957da0m6396d31cad8b4116@mail.gmail.com>
References: <1204481710-29791-1-git-send-email-pkufranky@gmail.com>
	 <1204481710-29791-2-git-send-email-pkufranky@gmail.com>
	 <7vk5kgiv0v.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 03:17:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX5fM-0007h7-Py
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 03:17:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752696AbYCFCQ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 21:16:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753127AbYCFCQ0
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 21:16:26 -0500
Received: from wx-out-0506.google.com ([66.249.82.226]:14802 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752336AbYCFCQZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 21:16:25 -0500
Received: by wx-out-0506.google.com with SMTP id h31so2351029wxd.4
        for <git@vger.kernel.org>; Wed, 05 Mar 2008 18:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=criiGrY0bktkXLHmc+uKR51wLui9PU2GlG5f87zRR/o=;
        b=rnzdsKdU3b5SlerY/yuhcKWaYOkTFLhcTEhrxACvHIqT7BMzcp81OADHimndCQAt6TEjV5zYJVCjJVQMXo7AMvXAPjJYr7XEN957uWASeVv5c1I9HlKaePa0QenHdLHz0UWLN6f+UUqWzUIVQjbqPqslk8IStwV0ZOHFc3uWiEc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OFB2u7hD+fsweLDlq4jhtj9vAp5Aav72UZQCVTecATttyeQBCW8koeZaKzDNH2zRFFpkMHhmZ/10h9aiOEMh7j8yi9QV0Fp7Hx2DKBNVACciH031MmZE/wXd3dqjbkjNhbuMQNORCS7kn/HeeVTOE+q5gLmP1q3SoJNwgHXkjrc=
Received: by 10.100.241.17 with SMTP id o17mr8599725anh.43.1204769784031;
        Wed, 05 Mar 2008 18:16:24 -0800 (PST)
Received: by 10.100.5.18 with HTTP; Wed, 5 Mar 2008 18:16:23 -0800 (PST)
In-Reply-To: <7vk5kgiv0v.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76308>

On Thu, Mar 6, 2008 at 7:57 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Ping Yin <pkufranky@gmail.com> writes:
>
>  > Example: commit summary for modified submodules sm1-sm5.
> >       --A-->B-->C (in src:354cd45)
>  >         \
>  >          -->D-->E (in dst:3f751e5)
>
>  The ordering of the commits in the above list is (1) unnatural and (2)
>  does not match what you would see with "log --left-right --topo-order
>  C...E".
>
>  I do not think "it shows the path to move from C to E" justifies it.  If
>  you are showing them as a linear list (which you cannot avoid if you are
>  doing a sequence of one-line description), you cannot represent such a
>  "path" anyway (think "merge").  If an appliance project rebinds kernel/
>  path from a project based on linux-2.4 to linux-2.6 while upgrading, such
>  a "path" may not even exist.
>
Good point to show 'log --left-right --topo-order' is better

>  I think I've already said the above to your initial round.  It is a bit
>  dissapointing to see none of the comments were addressed and makes me
>  wonder if I have wasted my time reviewing them again.

Sorry i lost your comments. Maybe it's a long time ago, i will revisit them.

>
>  It also is unnerving that newly added and deleted submodule results in the
>  full history display.  It would be assuring to be able to see and verify
>  what the top commit is (or was in "deleted" case) while you are commiting,
>  but I do not see a reason to show more than that.
>
>  I do not think "then set the limit to 1" is a valid answer to that
>  concern.  Wanting to see a dozen top commits in each for a modified
>  submodule would be sensible (and 3/4 may implement such a limit) but even
>  then showing dozen top commits for new/deleted at the same time would be
>  just an added noise.  Is it really necessary to show more than the top for
>  new/deleted case?
>
Actually, not make much sense to show many commits in delete or add
case. I think showing 2 (the head and tail one) should make more sense
since the head one would be "Initial add ..." in many cases which
doesn't make much sense for the user.

I will resend my patches after taking considering all of your
suggestion today or tommorow.



-- 
Ping Yin
