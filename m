From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH] post-receive-email: allow customizing of subject/intro/footer
Date: Thu, 21 Jan 2010 13:18:47 -0500
Message-ID: <4B589A87.2090808@xiplink.com>
References: <1263877931-26047-1-git-send-email-vapier@gentoo.org> <4B5888C2.60508@xiplink.com> <201001211259.30704.vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Mike Frysinger <vapier@gentoo.org>
X-From: git-owner@vger.kernel.org Thu Jan 21 19:18:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NY1bo-00020T-BR
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 19:18:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754749Ab0AUSSQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 13:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753075Ab0AUSSQ
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 13:18:16 -0500
Received: from smtp202.dfw.emailsrvr.com ([67.192.241.202]:38671 "EHLO
	smtp202.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752538Ab0AUSSQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 13:18:16 -0500
Received: from relay20.relay.dfw.mlsrvr.com (localhost [127.0.0.1])
	by relay20.relay.dfw.mlsrvr.com (SMTP Server) with ESMTP id 7F0C221282CF;
	Thu, 21 Jan 2010 13:18:15 -0500 (EST)
Received: by relay20.relay.dfw.mlsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 40EA42128210;
	Thu, 21 Jan 2010 13:18:15 -0500 (EST)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <201001211259.30704.vapier@gentoo.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137682>

Mike Frysinger wrote:
> On Thursday 21 January 2010 12:02:58 Marc Branchaud wrote:
>> 
>> So, overall, why not make generate_email_header() be simply:
>>
>> generate_email_header()
>> {
>> 	# --- Email (all stdout will be the email)
>> 	# Generate header
>> 	subst_vars <<-EOF
>> 	To: $recipients
>> 	Subject: ${emailprefix}${emailsubject}
>> 	X-Git-Refname: @refname@
>> 	X-Git-Reftype: @refname_type@
>> 	X-Git-Oldrev: @oldrev@
>> 	X-Git-Newrev: @newrev@
>>
>> 	${emailbodyintro}
>>
>> 	EOF
>> }
>>
>> This would also let you simply subst_vars() so that it needn't support
>>  piped invocations, no?  (Not a very drastic simplification, but still...)
> 
> if emailbodyintro is empty, this adds two useless newlines.  otherwise, this 
> would be fine i think.

Personally, I can live with that limitation.  I think it's unlikely that
anyone will want to get rid of the intro entirely, though maybe that's just me.

One alternative is to remove the newline after ${emailbodyintro}, but I think
most users will want the newline after the intro and that it's too easy to
forget to put it there when editing the setting.

Anyway, I don't have a strong opinion on the newline question.  The main
change I'd like to see is including that last intro line in emailbodyintro
instead of hardwiring it into the code.

		M.
