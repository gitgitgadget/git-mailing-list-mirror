From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] remove protocol from gravatar and picon links for clear
 if Gitweb is being called through a secure server
Date: Mon, 28 Jan 2013 14:10:26 -0800
Message-ID: <20130128221026.GE7759@google.com>
References: <1359400490-16449-1-git-send-email-admin@andrej-andb.ru>
 <20130128205834.GC7759@google.com>
 <7vfw1lug6f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrej Andb <admin@andrej-andb.ru>, git@vger.kernel.org,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 23:10:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tzwuk-0003Xn-Jq
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 23:10:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755111Ab3A1WKd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 17:10:33 -0500
Received: from mail-pa0-f45.google.com ([209.85.220.45]:44327 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755008Ab3A1WKc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 17:10:32 -0500
Received: by mail-pa0-f45.google.com with SMTP id bg2so1782042pad.18
        for <git@vger.kernel.org>; Mon, 28 Jan 2013 14:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=YnzMJLuCkpIdK2rqhsJV0VLM4f7Ekeq+QAjbsHr7LQA=;
        b=vzVziqmPxOjwg07ySo6nK+9bNYBPfiLglxqVgVXGktnvYRZbCe/UAHKeKik7TrIpC2
         zBtLcOKUnm28raqB/X5oqL3te68O1PmPqiEhKR1Q8cTAagbIUHIhsipng1SM8B5ZnwR1
         ym2iRYkxsJdnWPHZDJuskJlcjpll6pM+WI4CD9+2T4PQ2/5agK4BNXcYbcg+Hwz6WbkS
         F/Uh1Ah8MnqPit70WLbQLXZNybFp+rx7pLxKtRiavRmUriSZ0wITFWOAcOlIL55m/Oig
         bNpQnpsMj8FP3MwTAwouAxlF3sOX5prG0I5OlXMBhUMrVxuvdCSHalvzE79my5X+3fYr
         7OJA==
X-Received: by 10.68.197.135 with SMTP id iu7mr40951064pbc.71.1359411031564;
        Mon, 28 Jan 2013 14:10:31 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id ay6sm7479480pab.30.2013.01.28.14.10.28
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 28 Jan 2013 14:10:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vfw1lug6f.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214880>

Junio C Hamano wrote:
>> Andrej Andb wrote:

>>> --- a/gitweb/gitweb.perl
>>> +++ b/gitweb/gitweb.perl
>>> @@ -2068,7 +2068,7 @@ sub picon_url {
>>>  	if (!$avatar_cache{$email}) {
>>>  		my ($user, $domain) = split('@', $email);
>>>  		$avatar_cache{$email} =
>>> -			"http://www.cs.indiana.edu/cgi-pub/kinzler/piconsearch.cgi/" .
>>> +			"//www.cs.indiana.edu/cgi-pub/kinzler/piconsearch.cgi/" .
[...]
> Intuitively it feels strange that the above lets the site that gave
> you the base URL dictate over what scheme sites unrelated to it has
> to serve their resources.

The main effect is to slightly improve privacy.  A man in the middle
can still see the size of avatars and when you fetched them, but at
least this way when you are using HTTPS they do not see the names of
authors of commits you are looking at.

It also avoids a mixed content warning.

On the other hand, it hurts caching by proxies.

Jonathan
