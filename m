From: greened@obbligato.org
Subject: Re: [PATCH] Add --unannotate option to git-subtree
Date: Mon, 31 Dec 2012 19:15:23 -0600
Message-ID: <87a9st4sb8.fsf@waller.obbligato.org>
References: <CABVa4NinSighUn7GKbzMx9qZj3Ao2dCtEZxUqCPwO9TocZ8Kkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: James Nylen <jnylen@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 01 02:16:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TpqSq-0007X0-QH
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 02:16:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256Ab3AABQC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2012 20:16:02 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:48226 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750876Ab3AABQB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2012 20:16:01 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <greened@obbligato.org>)
	id 1TpqZa-0005KO-Ra; Mon, 31 Dec 2012 19:23:19 -0600
In-Reply-To: <CABVa4NinSighUn7GKbzMx9qZj3Ao2dCtEZxUqCPwO9TocZ8Kkg@mail.gmail.com>
	(James Nylen's message of "Tue, 9 Oct 2012 16:26:50 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  James Nylen <jnylen@gmail.com> writes: > Rather than adding
    a marker to each commit when splitting out the > commits back to the subproject,
    --unannotate removes the specified > string (or bash glob pattern) from the
    beginning of the first line of > the commit message. This enables the following
    workflow: [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed thro 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212375>

James Nylen <jnylen@gmail.com> writes:

> Rather than adding a marker to each commit when splitting out the
> commits back to the subproject, --unannotate removes the specified
> string (or bash glob pattern) from the beginning of the first line of
> the commit message.  This enables the following workflow:

I applied the patch to my working copy but it doesn't seem to do
what I'd expect.  The test script does something like this:

- create project A
- add file to project A with message "subproj: add F1"
- add file to project A with message "subproj: add F2"
- add project A as a subtree of project B under directory subdir
- add a file to subdir with message "subproj: add F3"
- do a split --unannotate="subproj:"

I expected to see a log with no mention of "subproj" anywhere.  Instead
I get:

add F3
subproj: add F2
subproj: add F1

Is this as you intend?  Is --unannotate only supposed to strip the
string for commits added when A was a subtree of B?

I guess this behavior makes sense in that the user would want to
see the same commits that existed before A became a subproject.

                   -David
