From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 1/3] format-patch: create patch filename in one
 function
Date: Sat, 21 Mar 2009 23:53:07 -0700
Message-ID: <7veiwq82wc.fsf@gitster.siamese.dyndns.org>
References: <1237696363-6819-1-git-send-email-bebarino@gmail.com>
 <1237696363-6819-2-git-send-email-bebarino@gmail.com>
 <7vwsai86nw.fsf@gitster.siamese.dyndns.org> <49C5D3BC.3030100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 07:54:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlHa0-0000E4-Nt
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 07:54:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752034AbZCVGxP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 02:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751873AbZCVGxP
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 02:53:15 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51381 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447AbZCVGxP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 02:53:15 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 90997A3A9D;
	Sun, 22 Mar 2009 02:53:12 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A41EBA3A9C; Sun,
 22 Mar 2009 02:53:09 -0400 (EDT)
In-Reply-To: <49C5D3BC.3030100@gmail.com> (Stephen Boyd's message of "Sat, 21
 Mar 2009 22:59:24 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1C7BD1B0-16AE-11DE-A51D-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114125>

Stephen Boyd <bebarino@gmail.com> writes:

> Junio C Hamano wrote:
> ...
>> IOW, you can introduce a new format specifier (say, "%f") to
>> format_commit_message() and the implemention of get_patch_filename() would
>> just prepare a strbuf and call format_commit_message() on it, no?
>
> This sounds great! I'm new so I don't know where to look for something
> like this.

I suspect you may not even have to pass the generated string around if you
did so.  Instead, you could pass the commit to log_write_email_headers()
instead of sha1_to_hex(commit->object.sha1) from show_log(), and use the
sha-1on the unix "From " line, and inside "if (opt->mime_boundar)", you
can ask format_commit_message("%f") to come up with a filename.
