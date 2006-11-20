X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Documentation tutorial.txt: Teach the reader about git commit -a -s
Date: Mon, 20 Nov 2006 15:03:16 -0800
Message-ID: <7vd57hzpor.fsf@assigned-by-dhcp.cox.net>
References: <4d8e3fd30611201430l6135814yc89f4abdb9044340@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 20 Nov 2006 23:03:21 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <4d8e3fd30611201430l6135814yc89f4abdb9044340@mail.gmail.com>
	(Paolo Ciarrocchi's message of "Mon, 20 Nov 2006 23:30:56 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31954>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmIAa-0004n5-V5 for gcvg-git@gmane.org; Tue, 21 Nov
 2006 00:03:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030393AbWKTXDS (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 18:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030375AbWKTXDS
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 18:03:18 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:29829 "EHLO
 fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP id S966883AbWKTXDR
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 18:03:17 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061120230317.WPZO21630.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>; Mon, 20
 Nov 2006 18:03:17 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id pB2n1V00A1kojtg0000000; Mon, 20 Nov 2006
 18:02:48 -0500
To: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Sender: git-owner@vger.kernel.org

"Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com> writes:

> I think it's important to mention, in the collaboration section,
> that is possible to use the -s option to add the Signed-off-by
> line
>
> Signed-off-by: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>

S-O-B is a project convention that follows the patch acceptance
policy similar to the kernel, and I am a bit reluctant to tell
people to use -s before making it clear what the legal intent of
that line is.  And git tutorial is not the place to talk about
the patch acceptance policy of the git project.

So instead, my preference is to suggest people to use "commit
-s" in "Documentation/SubmittingPatches" section.  That _is_
about the git project, and I think it helps the users that the
same rule/tip applies to the kernel by making it clear that the
convention and legal intent of S-O-B were borrowed from them.

I am slightly disturbed by 

> ------------------------------------------------
> (edit files)
> +$ git commit -a (add -s to add Signed-off-by line at the end of the
> commit message)
> (repeat as necessary)
> ------------------------------------------------

this formatting.  The examples that begin with '$' are meant to
be "copy-me" examples, and we do "# comment" elsewhere for
exactly that reason.

If your MUA corrupts patches, then working it around by using
attachment is tolerated, but please do try to see if you can
make your MUA behave first.  Attachments are hard to comment on
inline.

If you need to do an attachment, please do not include the patch
twice.  That is a lot worse than having your patch only in the
attachment.  I need to detach only the attachment part, compare
it with what were discussed on the list based on the patch that
was in the non-attachment part of your message to make sure
there is no inconsistency between the two, and then apply the
one from the attachment separately.

Instead, make the first "text" part of the multipart to contain
the proposed commit log message, and make sure that the rest of
the message (if multipart, then mailinfo will unwrap them for me
and concatenate them together after the first '---' in the cover
text) does not have the same patch twice.

Your message has the first text part in "format=flawed", which
included a corrupted patch, and then the attachment contained a
full format-patch output.  As a result, taken as a whole the
message includes the patch twice (once corrupted and then
uncorrupted).  Please don't.
