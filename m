From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: git_summary - show $project in title
Date: Mon, 12 Nov 2012 16:46:16 -0800
Message-ID: <7v625agwiv.fsf@alter.siamese.dyndns.org>
References: <1352611258-11450-1-git-send-email-xypron.glpk@gmx.de>
 <20121112232513.GF10531@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Henrich Schuchardt <xypron.glpk@gmx.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 13 01:46:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TY4e9-0000y1-2v
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 01:46:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753083Ab2KMAqU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 19:46:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47774 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752930Ab2KMAqT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 19:46:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3383BADA2;
	Mon, 12 Nov 2012 19:46:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NtUx8lQpLGFL3g3oaNWcm+3vbWo=; b=Xdp7pt
	xW2FC016/DuhqGlALHkPIOfO73bsVz1eimDDPbC1kEL/uqixDrSUO/mxl6Mvi6eU
	GZwxWG7ct4qnNvkGuLmQnK1wkE61CpOQYWa2KbiSnv8oEIraSwZUU4TILG0QU96H
	o5y1HsZYMsOMhtf7OEfhPy8xCUf1aWvc0MqoI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U99WHlyboeDvn/fuQ+iDIC93TBbnJ72/
	YOkfeRo4gT9wECpuukdqKfNOWBfWh7XYlxxdlZWCXxyvTEARKURQL8mih7zEd5yP
	MB29dy/0yz5e5QF8NGMoHHJ/LwYF2Hs1TY1/8Jxmo45M1dc8QVAfljGhZf8iCNe7
	O8qGKKF7wfM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 20B43ADA1;
	Mon, 12 Nov 2012 19:46:19 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8F622ADA0; Mon, 12 Nov 2012
 19:46:18 -0500 (EST)
In-Reply-To: <20121112232513.GF10531@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 12 Nov 2012 18:25:14 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 895CF470-2D2B-11E2-A99B-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209554>

Jeff King <peff@peff.net> writes:

> On Sun, Nov 11, 2012 at 06:20:58AM +0100, Henrich Schuchardt wrote:
>
>> Gitweb pages are structured by divs of class title with grey background.
>> The shortlog, and the log page show the project name as the first title.
>> Page summary only shows an empty grey box above the project details.
>> This provides an inconstent user experience.
>> 
>> This patch adds the missing project title.
>> 
>> Signed-off-by: Henrich Schuchardt <xypron.glpk@gmx.de>
>> ---
>>  gitweb/gitweb.perl |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index 10ed9e5..3e1c452 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -6451,7 +6451,7 @@ sub git_summary {
>>  	git_header_html();
>>  	git_print_page_nav('summary','', $head);
>>  
>> -	print "<div class=\"title\">&nbsp;</div>\n";
>> +	print "<div class=\"title\">$project</div>\n";
>
> I do not have any opinion on whether the intent of the change is good or
> not, but shouldn't $project be run through esc_html() here?

I think the answer is yes.  And if $project needs to be escaped, the
git_feed function you fixed today has another codepath that needs to
be fixed.  When git_get_project_description($project) returns undef,
the description is taken from $project without any escaping.
