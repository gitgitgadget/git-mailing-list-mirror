From: greened@obbligato.org
Subject: Re: git subtree error (just how do you expect me to merge 0 trees?)
Date: Mon, 31 Dec 2012 22:04:41 -0600
Message-ID: <87d2xpwnty.fsf@waller.obbligato.org>
References: <FBE22FDC-5800-40C8-9778-82DFD27579F6@drewcrawfordapps.com>
	<87licd3b7w.fsf@waller.obbligato.org>
	<7v7gnxd24h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Drew Crawford <drew@drewcrawfordapps.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 01 05:05:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tpt6i-0005WR-6S
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 05:05:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496Ab3AAEFV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2012 23:05:21 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:48353 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751324Ab3AAEFT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2012 23:05:19 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <greened@obbligato.org>)
	id 1TptDQ-0005pr-S0; Mon, 31 Dec 2012 22:12:37 -0600
In-Reply-To: <7v7gnxd24h.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 31 Dec 2012 19:16:14 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  Junio C Hamano <gitster@pobox.com> writes: >> With one positional
    option, git-subtree add simply assumes >> it's a refspec. Is there an easy
    way to check whether a string is a >> proper refspec? Even better would be
    a way to check if a string is a >> path to a git repository. > > Do you literally
    mean "a path to a repository" in the above, or do > you mean "a remote that
    is like what is accepted by 'git fetch'"? [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- - 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212411>

Junio C Hamano <gitster@pobox.com> writes:

>> With one positional option, git-subtree add simply assumes
>> it's a refspec.  Is there an easy way to check whether a string is a
>> proper refspec?  Even better would be a way to check if a string is a
>> path to a git repository.
>
> Do you literally mean "a path to a repository" in the above, or do
> you mean "a remote that is like what is accepted by 'git fetch'"?

It's the latter as git-subtree calls git-fetch to do the work of
getting revisions.

> On the other hand, if you mean the command takes a remote and an
> optional list of refspecs just like "git fetch" does, then I am not
> sure it is a good design in the first place to allow "refspecs
> only", if only to keep the interface similar to "git fetch" (you
> cannot omit remote and give refspecs, as you cannot interpret
> refspecs without knowing in the context of which remote they are to
> be interpreted).

If just a refspec is given, git-subtree does a rev-parse in the current
directory and that seems to work fine.  It's what I as a user would
expect to happen.

> I would imagine you could disambiguate and default to "origin" or
> something when you guessed that remote was omitted if you really
> wanted to, with a syntacitical heuristics, such as "a refspec will
> never have two colons in it", "a URL tends to begin with a short
> alphabet word, a colon and double-slash", etc.

Hmm...I haven't added code to verify the repository/remote argument if
given.  I suppose a rev-parse --verify would suffice?

                        -David
