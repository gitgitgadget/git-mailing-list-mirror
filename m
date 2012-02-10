From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] gitweb: Option for filling only specified info in
 fill_project_list_info
Date: Fri, 10 Feb 2012 11:49:13 -0800
Message-ID: <7vsjiipiyu.fsf@alter.siamese.dyndns.org>
References: <1328359648-29511-1-git-send-email-jnareb@gmail.com>
 <201202101456.45944.jnareb@gmail.com>
 <7v1uq2shwg.fsf@alter.siamese.dyndns.org>
 <201202101917.52908.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 10 20:49:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvwTB-0004jt-9c
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 20:49:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760007Ab2BJTtQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Feb 2012 14:49:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54835 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759958Ab2BJTtP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 14:49:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4167963D2;
	Fri, 10 Feb 2012 14:49:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7pS1F55LFja6uWI8DJmyj73UwIc=; b=Y5NHSs
	ep6b7/ECKpWYuFHYk91cAoYkuCyGcqEvE5c2AUWlqWYJrg26eTSrtDkW/YoWg2Po
	YN65nbX5o8aw3C+rpKqYmGun8wVTNH68kzYLGasTOmAs6G6MLbxyjAHEr0GsK63B
	9nSjAQmbjMi982Q0uhhlwxm5FLiIrlh5lDSfo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Mz+i0d+S6cNcst7YKU/u2uCtMftoJsDy
	VUWjzd6xF7gqQQU7hwo3EHF47a8jHuW5OXTZB1ALiguNyl0r+gtI2WudDEfz2Cor
	XiUCZf46nI8G9+rm6ZDrbIfS9FVtCrV8Q7KAJR9D0LslTe1rWCZ4teEycqJ8EM2L
	95Mrebwz7G8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 380FA63D1;
	Fri, 10 Feb 2012 14:49:15 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B353E63D0; Fri, 10 Feb 2012
 14:49:14 -0500 (EST)
In-Reply-To: <201202101917.52908.jnareb@gmail.com> (Jakub Narebski's message
 of "Fri, 10 Feb 2012 19:17:52 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4F826BF2-5420-11E1-A63B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190440>

Jakub Narebski <jnareb@gmail.com> writes:

> If @fill_only is empty, it means for fill_project_list_info to fill
> all the data, if it is not empty it means that those fields needs to
> be filled.

That is exactly what I am questioning.  Do you need "I need all these
fields to be present" and "I will fill these other fields" (which is what
@fill_only is about, no?) that is different from the former?

> The code of fill_project_list_info goes like this
>
>   if (do we need to fill 'age' or 'age_string'?) {
>     fill 'age' and 'age_string'
>   }
>   if (do we need to fill 'desc_long' or 'descr'?) {
>     fill 'descr_long' and 'descr'
>   }
>   if (we are interested in 'ctags' &&
>       do we need to fill 'ctags'?) {
>     fill 'ctags'
>   }
>   ...

Exactly.  Why do you need @fill_only at all?  If you are interested in
ctags and you want to make sure ctags is available, the question you want
to ask the helper function is "Does the project structure already have
ctags field?".  Why does the helper function needs to know anything else?
