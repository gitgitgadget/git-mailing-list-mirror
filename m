From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] Add details about svn-fe's dumpfile parsing
Date: Mon, 16 Apr 2012 13:06:16 -0700
Message-ID: <7vipgztpaf.fsf@alter.siamese.dyndns.org>
References: <4F8AF306.8070804@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	David Barr <davidbarr@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Mon Apr 16 22:06:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJsBt-0000If-8R
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 22:06:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753747Ab2DPUGU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 16:06:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43954 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752179Ab2DPUGT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 16:06:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8087B76E0;
	Mon, 16 Apr 2012 16:06:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JyRC3TciT0pUpr/kriS0nECA2ak=; b=LdkJv/
	k9pY0TKvM5nMwRvUAoPRzln37XU03acQDmZNl4U1KXV9fL1RTPuKn5ym7g+rIg08
	Wzah0dBjtEf+lpyBX19GKmT0wfDDXsWiDrWFaW+9FOgBtYujqwvDgcygHy0otj1J
	tMbI9VEXeIM41BBclCSj1xbf8hFxv2ZU4bcKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CCXEqBWtV7geHboQVkUMQRyLTObff3iy
	ApPRYnsxmr33otO3J+xdEtPLcUwbYZXoxEhpv2+JvRKbxWLd3P50srlnR8gpO8uk
	H/+QsKNQhjUlGvtTlHoV05Td699EKBjp2PkvTi0CEJCutKwCwKI0ddLiEXiKa4LY
	Hf8BhIwLRaI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 77A0076DF;
	Mon, 16 Apr 2012 16:06:18 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0A36676D9; Mon, 16 Apr 2012
 16:06:17 -0400 (EDT)
In-Reply-To: <4F8AF306.8070804@pileofstuff.org> (Andrew Sayers's message of
 "Sun, 15 Apr 2012 17:10:46 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A0B646DE-87FF-11E1-A7BB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195682>

Andrew Sayers <andrew-git@pileofstuff.org> writes:

> The documentation for the SVN dumpfile format says that "property key/value
> pairs may be interpreted as binary data in any encoding by client tools".
> Documenting svn-fe's interpretation helps authors of related tools, while
> explaining limitations helps ordinary users import their SVN repositories.
>
> The "INPUT FORMAT" section is aimed at authors of tools that interact with
> svn-fe, so it particularly addresses assumptions that authors might make after
> dealing with svn itself.
>
> The "BUGS" section is aimed at ordinary users, so it only explains what readers
> need to know when importing a repository.  In particular, users don't need to
> know that other characters in the range 0x01-0x1F are imported correctly, even
> though they were all disabled in Subversion 1.2.0.  The text in this section is
> based largely on an example sent by Jonathan Nieder, with minor changes to suit
> the surrounding style.
>
> Signed-off-by: Andrew Sayers <andrew-git@pileofstuff.org>
> ---

OK, so is this ready for 'master' already?

>  contrib/svn-fe/svn-fe.txt |   13 +++++++++++++
>  1 files changed, 13 insertions(+), 0 deletions(-)
>
> diff --git a/contrib/svn-fe/svn-fe.txt b/contrib/svn-fe/svn-fe.txt
> index 1128ab2..3872b9d 100644
> --- a/contrib/svn-fe/svn-fe.txt
> +++ b/contrib/svn-fe/svn-fe.txt
> @@ -32,6 +32,13 @@ Subversion's repository dump format is documented in full in
>  Files in this format can be generated using the 'svnadmin dump' or
>  'svk admin dump' command.
>  
> +Unlike Subversion, 'svn-fe' interprets property key/value pairs as
> +null-terminated binary strings.  This means it will accept content
> +that Subversion normally wouldn't produce (such as filenames
> +containing tab characters) or would refuse to parse (such as usernames
> +containing Latin-1 characters).  However, like Subversion it will
> +handle newlines incorrectly in filenames (see BUGS below).
> +

Do the first two sentences in the above paragraph claim that it a bug that
'svn-fe' does not mimick what Subversion does?  I am not sure what lessons
the authors of tools, whose output is meant to feed svn-fe, are expected
to learn here.  For example, is the purpose of the above paragraph to make
tool authors realize that "NUL terminates key and value, so I have to
refrain from using a key or a value that contains a NUL byte?" [*1*]  Even
in that case, it is unclear to me what I (as an author of such a tool that
reads data from somewhere and format it to plesae svn-fe) could do with
that knowledge.

[Footnote]

*1* By the way, NULL is a pointer that does not point anywhere.  The name
of a byte whose value is 0x00 is NUL.
