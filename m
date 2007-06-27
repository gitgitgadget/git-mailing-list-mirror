From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Add test script for git-stripspace.
Date: Tue, 26 Jun 2007 19:32:03 -0700
Message-ID: <7v8xa6ruu4.fsf@assigned-by-dhcp.pobox.com>
References: <46801665.4050708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de, krh@redhat.com
To: Carlos Rica <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 27 04:32:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3NKN-0003BV-Jb
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 04:32:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754819AbXF0CcJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 22:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754385AbXF0CcI
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 22:32:08 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:62875 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754118AbXF0CcH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2007 22:32:07 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070627023205.JZHY17635.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Tue, 26 Jun 2007 22:32:05 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id GSY41X00H1kojtg0000000; Tue, 26 Jun 2007 22:32:05 -0400
In-Reply-To: <46801665.4050708@gmail.com> (Carlos Rica's message of "Mon, 25
	Jun 2007 21:24:21 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51014>

Carlos Rica <jasampler@gmail.com> writes:

> These tests check some features that git-stripspace already has
> and those that it should manage well: Removing trailing spaces
> from lines, removing blank lines at the beginning and end,
> unifying multiple lines between paragraphs, doing the correct
> when there is no newline at the last line, etc.
>
> It seems that the implementation needs to save the whole line
> in memory to be able to manage correctly long lines with
> text and spaces conveniently distribuited on them.
>
> Signed-off-by: Carlos Rica <jasampler@gmail.com>

Thanks.  That's extensive set of tests for a little utility.

> t/t0030-stripspace.sh |  355
> +++++++++++++++++++++++++++++++++++++++++++++++++
> 1 files changed, 355 insertions(+), 0 deletions(-)
> create mode 100644 t/t0030-stripspace.sh
>
> diff --git a/t/t0030-stripspace.sh b/t/t0030-stripspace.sh
> new file mode 100644
> index 0000000..abd82d7
> --- /dev/null
> +++ b/t/t0030-stripspace.sh

100755?

> @@ -0,0 +1,355 @@
> ...
> +test_expect_success \
> +    'long lines without spaces should be unchanged' '
> +    echo "$ttt" >expect &&
> +    cat expect | git-stripspace >actual &&
> +    git diff expect actual &&

Please don't cat a single file into a pipeline.

	git-stripspace <actual >expect
