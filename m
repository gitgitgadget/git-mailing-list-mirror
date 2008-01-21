From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] git-commit: add a prepare-commit-msg hook
Date: Mon, 21 Jan 2008 13:59:27 +0100
Message-ID: <4794972F.9000007@gnu.org>
References: <4790BCED.4050207@gnu.org> <7vbq7ibxhh.fsf@gitster.siamese.dyndns.org> <4791C3A8.7000308@gnu.org> <alpine.LSU.1.00.0801191119050.5731@racer.site> <7vd4rw6siv.fsf@gitster.siamese.dyndns.org> <479438D1.2050107@gnu.org> <alpine.LSU.1.00.0801211101450.5731@racer.site> <47948C9B.7030100@gnu.org> <alpine.LSU.1.00.0801211231480.5731@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 21 14:00:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGwFx-0006pq-Ok
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 14:00:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610AbYAUM7d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 07:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751504AbYAUM7d
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 07:59:33 -0500
Received: from fk-out-0910.google.com ([209.85.128.188]:5517 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300AbYAUM7c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 07:59:32 -0500
Received: by fk-out-0910.google.com with SMTP id z23so1350522fkz.5
        for <git@vger.kernel.org>; Mon, 21 Jan 2008 04:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        bh=vg7gCSiPMZxusc1RUCYlGH/S7I8MZxFkrDHjjOJtDws=;
        b=T4GcTsiwgYxrZJB8msqagwBgdSjzwmWfWi/3BlMtbCDNrvlK+S/GSPHfsp/0OB4+gSsIn/NPqwuWDbluwOIaF5GdQ8ohsb1ycrrFBPbWQScbY1cFDdPtlllBnOWG4HlVVTnXpmMf3VNpw0aSI3VlUC/WeT9zDyNP0DHi5xo4xTo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        b=cpDzrz0334EF5Ukrtv6IViHDcXjR7AX9irugOdWy6dABFKPV1ah1i3M+BjexdOY/BjytgGG8Jly7Tp/kGdBmMBjvnZUsgn0aGJtnAsHsvMvlrtNKTNvp1W7F76+YQUf8Wz4er1IeRV1K+ETvrTHII4hM0CKqvRVj+XgPEBcl1lU=
Received: by 10.82.106.14 with SMTP id e14mr12231420buc.38.1200920370832;
        Mon, 21 Jan 2008 04:59:30 -0800 (PST)
Received: from scientist-2.local ( [195.176.178.209])
        by mx.google.com with ESMTPS id 31sm8183347fkt.14.2008.01.21.04.59.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 21 Jan 2008 04:59:30 -0800 (PST)
User-Agent: Thunderbird 2.0.0.9 (Macintosh/20071031)
In-Reply-To: <alpine.LSU.1.00.0801211231480.5731@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71279>


>> Sure it won't break anything, but it won't work either!  The existing 
>> message hook runs after the editing session -- I want the hook to 
>> introduce text that is merely a suggestion that the user can delete, or 
>> a template that the user needs to customize further.
> 
> OMG you're right.  But why didn't you say so in the commit message?  
> Something like "This hook complements the commit-msg hook, in that it runs 
> _before_ the editor is launched".

I can't believe this. ;-)  At least I'm laughing for something nice now!

You're right, I should have said instead of this:

> The prepare-commit-msg hook is run whenever a "fresh" commit message 
> (i.e. not one taken from another commit with -c) is shown in the editor. 

... just before a "fresh" commit message is shown in the editor.
          ^^^^^^

>>> Also, the change would be non-intrusive, easy-to-review
>> Please.  That's ludicrous.
>>
>> My patch is 3 lines of inserted code and 0 modified lines, checking one 
>> variable that is set once in builtin-commit.c (edit_message).
> 
> Actually, after reading the commit message I was in 
> "this-is-not-necessary" mode, and therefore the diffstat looked too large 
> for me.

Yes, but still the diffstat was all .txt files... ;-)

> Actually, reading your patch again I think it also triggers for "-c", as 
> well as for "[-C|-F|-m] ... -e".

Not for "-c", that's the point of the "edit_message" check.  You're 
right about "-e" though.

Points taken, and patch will be resubmitted after 1.5.4.

Paolo
